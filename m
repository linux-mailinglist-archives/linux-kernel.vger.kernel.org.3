Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA659F3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiHXGtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHXGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:49:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8A285FA3;
        Tue, 23 Aug 2022 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fcsY3Qh6TepPJ/4fx7/kuX9sdRrqVQM7ufFixq4/Q+E=; b=kxy9aSUz9kdXYUN5Ynyv0t2iIt
        ibpo4uc1JSMGQnjJJrpLwO94fmA83Qo5rs0NKIKXlIDt8xSznFk+dSiyhigynBdCZxbnojbFjTSnM
        o3fiHR6jwULnEf02P2pw2mlEG2gcBWbGLgUbwBYsioEejnchueJ1YMdjaqTUnBB2gYXL6qm8HTg61
        12IzadzuCA7drwHrIAEeRhUBQdgsoWaAZ8mTNxHMNRb9lBQ2VTxT+mU2vowFXkqVXyI/6+MD1JYy5
        rZFXoccGQK9rzs9ceIYt+VRuj56IeNgX1TMxXlNPrg5JgCseS7yBUZctydRoycXiHOgzRRUXJ4wF1
        vnEeqVKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQkBm-005cJK-Ma; Wed, 24 Aug 2022 06:48:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FF42980403; Wed, 24 Aug 2022 08:48:33 +0200 (CEST)
Date:   Wed, 24 Aug 2022 08:48:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     FirstName LastName <pshier@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] x86/msr: add idle version of wrmsr trace
Message-ID: <YwXJwTOFWRFPilOy@worktop.programming.kicks-ass.net>
References: <20220823234353.937002-1-pshier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823234353.937002-1-pshier@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear FirstName LastName, pleae fix your MUA.

On Tue, Aug 23, 2022 at 04:43:53PM -0700, FirstName LastName wrote:
> From: Peter Shier <pshier@google.com>
> 
> With commit bf5835bcdb963 ("intel_idle: Disable IBRS during long idle"),
> enabling wrmsr trace with CONFIG_LOCKDEP causes "suspicious
> rcu_dereference_check() usage" warning because do_trace_write_msr does not
> use trace_write_msr_rcuidle.
> 

No, the right thing here is to not do tracing at all.

*sigh* I should go finish this series:

  https://lore.kernel.org/lkml/20220608142723.103523089@infradead.org/

---
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3e101719689a..6e82b2df29cb 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -187,12 +187,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		__native_wrmsr(MSR_IA32_SPEC_CTRL, 0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		__native_wrmsr(MSR_IA32_SPEC_CTRL, spec_ctrl);
 
 	return ret;
 }
