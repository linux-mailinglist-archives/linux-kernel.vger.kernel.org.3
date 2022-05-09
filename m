Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759651FF1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiEIOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiEIOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:07:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC72701BE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:03:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652105019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GqbJqls16FNy0vugLmt3uGKWWGVnEjYiGmRysMH1yNs=;
        b=tvslSlziDv2t2phpzE4lNj+wrzJgX67KxhCt1FuyD1ceg6sJFkBlxDhpRcOusXD3vCH1GO
        rrwBIOqwLBE/09DZS1RWIEpRUyzO4Ylxq9wypMWnCjV9KtGMgRRbEooy5Av5VpyEFRGz5A
        ZhYHIWm3yehXFdD4iBjXd6R7PU5v8T6fgojfu0Xj9/TcO08hmV7QXMv6URnVkVzfzFLPYQ
        nCVwI6uHnWtOiluEEbY/QZ0aJobXPwV6uKRnLdA5YA8RqQpeGlC+MXbMXss77eJLujwtT7
        ZzQK/ggooLf32/huA0pdmI4dXrznLN0honUiqbA/ZsXU29EKPlPPYg33zHC8PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652105019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GqbJqls16FNy0vugLmt3uGKWWGVnEjYiGmRysMH1yNs=;
        b=B+umBlaN/4/EfvGP0sahg2ByBcjgBKcjCmDqM6xwlN4Jeh/lEDpTcEWCOSnSQddUEZRznA
        Ju1piRkbSamhYbAA==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v6 22/29] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
In-Reply-To: <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
Date:   Mon, 09 May 2022 16:03:39 +0200
Message-ID: <877d6uref8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> +	if (is_hpet_hld_interrupt(hdata)) {
> +		/*
> +		 * Kick the timer first. If the HPET channel is periodic, it
> +		 * helps to reduce the delta between the expected TSC value and
> +		 * its actual value the next time the HPET channel fires.
> +		 */
> +		kick_timer(hdata, !(hdata->has_periodic));
> +
> +		if (cpumask_weight(hld_data->monitored_cpumask) > 1) {
> +			/*
> +			 * Since we cannot know the source of an NMI, the best
> +			 * we can do is to use a flag to indicate to all online
> +			 * CPUs that they will get an NMI and that the source of
> +			 * that NMI is the hardlockup detector. Offline CPUs
> +			 * also receive the NMI but they ignore it.
> +			 *
> +			 * Even though we are in NMI context, we have concluded
> +			 * that the NMI came from the HPET channel assigned to
> +			 * the detector, an event that is infrequent and only
> +			 * occurs in the handling CPU. There should not be races
> +			 * with other NMIs.
> +			 */
> +			cpumask_copy(hld_data->inspect_cpumask,
> +				     cpu_online_mask);
> +
> +			/* If we are here, IPI shorthands are enabled. */
> +			apic->send_IPI_allbutself(NMI_VECTOR);

So if the monitored cpumask is a subset of online CPUs, which is the
case when isolation features are enabled, then you still send NMIs to
those isolated CPUs. I'm sure the isolation folks will be enthused.

Thanks,

        tglx
