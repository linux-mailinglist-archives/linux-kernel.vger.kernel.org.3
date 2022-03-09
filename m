Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB1F4D3859
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiCIRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiCIRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:51:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FB12E9DB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D972614EE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A8AC340E8;
        Wed,  9 Mar 2022 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646848240;
        bh=aV8HvlaK03F1JqH8FZ5kAKtPL9ZlQkIr+U5+kyN3JTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WHqs8Lmd57dO5boy0fDzcMAEltLHxWw4qfn4uSWbMswtbqh5Oe5nN23B0Cc2hfpuA
         pSsBv8ivRtrGdE1xpqrfua4RK8s0flEDrFRRTJBfbUixv7iPWCecjodyjDVjxpgnEh
         q192hPGY0tDXvzj1GRlK03OFmWyieCqy9wTInLSoTxulKVXSBGDOWmgBGCcZXnLS1K
         VahWO0y470wI4rWlolYjY90KR92sVlZFXHDXGcYhLmiLHJj9lzhhPRq7gJn5fGvl70
         qK2hvMkj1DYs4xfA8YENB+B4U73IZxuYf8BB3Ok+/pEEF6ehpTPw9E92uZai6UvCXM
         mOwCAtWvBwdow==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nS0SL-00DOyR-Nx; Wed, 09 Mar 2022 17:50:37 +0000
MIME-Version: 1.0
Date:   Wed, 09 Mar 2022 17:50:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>, will@kernel.org
Cc:     Linu Cherian <lcherian@marvell.com>, tglx@linutronix.de,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuc.decode@gmail.com
Subject: Re: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when
 reading IAR
In-Reply-To: <YijmkXp1VG7e8lDx@qian>
References: <20220307143014.22758-1-lcherian@marvell.com>
 <YijmkXp1VG7e8lDx@qian>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e5fb49280d86fea78f6985659ea829e3@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_qiancai@quicinc.com, will@kernel.org, lcherian@marvell.com, tglx@linutronix.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuc.decode@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-09 17:40, Qian Cai wrote:
> On Mon, Mar 07, 2022 at 08:00:14PM +0530, Linu Cherian wrote:
>> When a IAR register read races with a GIC interrupt RELEASE event,
>> GIC-CPU interface could wrongly return a valid INTID to the CPU
>> for an interrupt that is already released(non activated) instead of 
>> 0x3ff.
>> 
>> As a side effect, an interrupt handler could run twice, once with
>> interrupt priority and then with idle priority.
>> 
>> As a workaround, gic_read_iar is updated so that it will return a
>> valid interrupt ID only if there is a change in the active priority 
>> list
>> after the IAR read on all the affected Silicons.
>> 
>> Since there are silicon variants where both 23154 and 38545 are 
>> applicable,
>> workaround for erratum 23154 has been extended to address both of 
>> them.
>> 
>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> 
> Reverting this commit from today's linux-next fixed 
> global-out-of-bounds
> accesses running CPU hotplug workloads on a non-ThunderX server.
> 
>  psci: CPU88 killed (polled 0 ms)
>  ==================================================================
>  BUG: KASAN: global-out-of-bounds in is_affected_midr_range_list
>  Read of size 4 at addr ffffa0ec80ddcc6c by task swapper/88/0
> 
>  CPU: 88 PID: 0 Comm: swapper/88 Not tainted 
> 5.17.0-rc7-next-20220309-dirty #25
>  Call trace:
>   dump_backtrace
>   show_stack
>   dump_stack_lvl
>   print_address_description.constprop.0
>   print_report
>   kasan_report
>   __asan_report_load4_noabort
>   is_affected_midr_range_list
>   is_midr_in_range_list at ./arch/arm64/include/asm/cputype.h:221
>   (inlined by) is_affected_midr_range_list at 
> arch/arm64/kernel/cpu_errata.c:41
>   verify_local_cpu_caps
>   verify_local_cpu_caps at arch/arm64/kernel/cpufeature.c:2787
>   check_local_cpu_capabilities
>   verify_local_elf_hwcaps at arch/arm64/kernel/cpufeature.c:2852
>   (inlined by) verify_local_cpu_capabilities at
> arch/arm64/kernel/cpufeature.c:2922
>   (inlined by) check_local_cpu_capabilities at
> arch/arm64/kernel/cpufeature.c:2948
>   secondary_start_kernel
>   __secondary_switched
> 
>  The buggy address belongs to the variable:
>   cavium_erratum_23154_cpus
> 
>  The buggy address belongs to the virtual mapping at
>   [ffffa0ec80dd0000, ffffa0ec82140000) created by:
>   map_kernel

Urgh... Thanks for reporting this.

Will, can you either drop this patch, or squash the following
diff in?

Thanks,

         M.

diff --git a/arch/arm64/kernel/cpu_errata.c 
b/arch/arm64/kernel/cpu_errata.c
index 1d9d4f910de7..400a1c9cac90 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -225,6 +225,7 @@ const struct midr_range cavium_erratum_23154_cpus[] 
= {
  	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXN),
  	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXMM),
  	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXO),
+	{},
  };
  #endif


-- 
Jazz is not dead. It just smells funny...
