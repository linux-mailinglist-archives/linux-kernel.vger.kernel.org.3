Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23E95448AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbiFIKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiFIKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:23:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29834838C;
        Thu,  9 Jun 2022 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vdnmsD6W54WojvbIoqoa8hdXCumYn6AqBOHiv7DMgfw=; b=H+wJ1ZydkyC3RMRDSPXLOfbj8b
        AJdRQy0TYqTmU6GVmZNgl3jRqGfGwH1A+G468h5SwROwfWSWQ+PpM33X5smM7miiSKD0oCtIA3Ybr
        0wkzxhTCw7KsmreB/oiF2LFBq6v+3bRxqirMJcrk0r1xovLFuJHDdkNZ87byFERGrnDcuyGvtcDaZ
        9D+06ivELXdFRce3IGs9G5FvbvXqsyayeRpD9Px1dZpTXad2nDLoi0vLWJdGKlkmQ+waLTcnAZaMV
        i6fGjkDG7+DirhEHk+EJCKN+ao4CLkT+5+7CrCIRhiKIw8BLwiToUd2QQrK+q9DzVbZ+/7T9c8/VW
        RSZufhQQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzFKF-006Lcy-6e; Thu, 09 Jun 2022 10:23:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D104981287; Thu,  9 Jun 2022 12:23:37 +0200 (CEST)
Date:   Thu, 9 Jun 2022 12:23:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org
Subject: Re: [tip: x86/fpu] intel_idle: Add a new flag to initialize the AMX
 state
Message-ID: <YqHKKa/yamRS06tC@worktop.programming.kicks-ass.net>
References: <20220608164748.11864-3-chang.seok.bae@intel.com>
 <165471675715.4207.17983340888752028780.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165471675715.4207.17983340888752028780.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 07:32:37PM -0000, tip-bot2 for Chang S. Bae wrote:
> @@ -134,6 +140,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>  	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
>  		local_irq_enable();
>  
> +	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
> +		fpu_idle_fpregs();
> +
>  	mwait_idle_with_hints(eax, ecx);
>  
>  	return index;

This will conflict with an intel_idle patch Rafael took from me; the
resolution would be something along these lines:

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -166,6 +166,13 @@ static __cpuidle int intel_idle_irq(stru
 	return ret;
 }
 
+static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index)
+{
+	fpu_idle_fpregs();
+	return __intel_idle(dev, drv, index);
+}
+
 /**
  * intel_idle_s2idle - Ask the processor to enter the given idle state.
  * @dev: cpuidle device of the target CPU.
@@ -1831,6 +1838,9 @@ static void __init intel_idle_init_cstat
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
 			drv->states[drv->state_count].enter = intel_idle_irq;
 
+		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_INIT_XSTATE)
+			drv->states[drv->state_count].enter = intel_idle_xstate;
+
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
