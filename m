Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82E259E566
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiHWOxX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Aug 2022 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiHWOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:51:58 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10FB2F6531;
        Tue, 23 Aug 2022 05:15:21 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-334dc616f86so373537967b3.8;
        Tue, 23 Aug 2022 05:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=3sJI0e88Gdga53n7WRzAKoSv8TehdpeQCz7sliezLF8=;
        b=zJOOPn7n1sk6cMmXpMlzvADYQt3q9xwWE/vX0aODG3VPugauZRo4A9hDVuszsq4gEA
         7qm7mHcAyEehaVCvuFT09cC2nkB2SLhk2H5+0qxVlcLzTRiSr9GkGlqjyxXP+Vx2eulX
         XK5gbVQnzu9+1sSLBN1Z3/3Twko66t9MVmM8YLXi2t+4y0MKzLGK1Mbs6/NTH1DhE48h
         Fn1yJ9ujisekeR/lVEf88OCwDJW4RgsO2Y94fFlDsEqG965Inb6VuuK0l8FIihR3AxiC
         Xaw0biXrtvd60nIp96a7aplDpQ/pFGV8rt6txMny7Oc+/enD485W6quDYDCQHLY3XTB6
         v+Rg==
X-Gm-Message-State: ACgBeo1lm+tUOEiCTQ5aKMCyP+eMYTiiJbzb8svrEO8HnTOtbUAZJnBl
        PFXMago+juoZCEEorOUaE4qetC8xnYcQZJvcRGU=
X-Google-Smtp-Source: AA6agR4kXWqD4dZieplfuZs3m9Y4A0afC7hYgsa7pnUUs9JQWPRAbdjqUcyHzJ9Xt27P8GBPq4S6yCUCFS5XkbWACms=
X-Received: by 2002:a0d:e701:0:b0:336:90d7:c67a with SMTP id
 q1-20020a0de701000000b0033690d7c67amr25342695ywe.7.1661256829971; Tue, 23 Aug
 2022 05:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <6e61d429-9020-53f3-458e-bb265d47b8f4@arm.com> <TYWP286MB26016A8EF8040BE37DE9A27BB1719@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <CAJZ5v0gx+eY-wOHmVip4VTCwjco=_yeSX5t76q39dUKyB7vBiw@mail.gmail.com>
 <TYWP286MB2601BBED3F396FD334CE3266B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <TYWP286MB2601932308C37E9ABC224FB0B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYWP286MB2601932308C37E9ABC224FB0B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 14:13:39 +0200
Message-ID: <CAJZ5v0iV_J1=R0Dwku-MCcMiFu3VLTeSGO0djbqVsNZ41EmJ1Q@mail.gmail.com>
Subject: Re: Bug: Re: [PATCH v3] ACPI: Split out processor thermal register
 from ACPI PSS
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Riwen Lu <luriwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 6:33 AM Riwen Lu <luriwen@hotmail.com> wrote:
>
> 在 2022/8/23 09:15, Riwen Lu 写道:
> > 在 2022/8/22 20:25, Rafael J. Wysocki 写道:
> >> On Mon, Aug 22, 2022 at 10:19 AM Riwen Lu <luriwen@hotmail.com> wrote:
> >>>
> >>> 在 2022/8/19 04:23, Jeremy Linton 写道:
> >>>> Hi,
> >>>>
> >>>> On 6/16/22 21:51, Riwen Lu wrote:
> >>>>> From: Riwen Lu <luriwen@kylinos.cn>
> >>>>>
> >>>>> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
> >>>>> driver"), moves processor thermal registration to
> >>>>> acpi_pss_perf_init(),
> >>>>> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
> >>>>>
> >>>>> As ARM64 supports P-states using CPPC, it should be possible to also
> >>>>> support processor passive cooling even if PSS is not enabled. Split
> >>>>> out the processor thermal cooling register from ACPI PSS to support
> >>>>> this, and move it into a separate function in processor_thermal.c.
> >>>>
> >>>> It appears this commit 7fdc74da940d ACPI: processor: Split out thermal
> >>>> initialization from ACPI PSS
> >>>>
> >>>> Is causing the following:
> >>>>      41.341659] ------------[ cut here ]------------
> >>>> [   41.346280] freq_qos_remove_request() called for unknown object
> >>>> [   41.352251] WARNING: CPU: 3 PID: 1089 at kernel/power/qos.c:597
> >>>> freq_qos_remove_request+0xa4/0xc4
> >>>> [   41.361152] Modules linked in: nf_nat_tftp nft_objref
> >>>> nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> >>>> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> >>>> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> >>>> nf_tables nfnetlink qrtr bnep sunrpc vfat fat btsdio brcmfmac hci_uart
> >>>> btqca cfg80211 bs
> >>>> [   41.413245] CPU: 3 PID: 1089 Comm: rmmod Not tainted
> >>>> 6.0.0-rc1MINI+ #237
> >>>> [   41.419951] Hardware name: Raspberry Pi Foundation Raspberry Pi 4
> >>>> Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 07/18/2022
> >>>> [   41.430990] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
> >>>> BTYPE=--)
> >>>> [   41.437955] pc : freq_qos_remove_request+0xa4/0xc4
> >>>> [   41.442752] lr : freq_qos_remove_request+0xa4/0xc4
> >>>> [   41.447550] sp : ffff80000a4bbb60
> >>>> [   41.450862] x29: ffff80000a4bbb60 x28: ffff07858798a1c0 x27:
> >>>> 0000000000000000
> >>>> [   41.458012] x26: 0000000000000000 x25: ffffdf6ade80f850 x24:
> >>>> ffff07858b07d200
> >>>> [   41.465158] x23: ffffdf6ade812cb0 x22: ffff07858b07d000 x21:
> >>>> ffffdf6ade80f850
> >>>> [   41.472303] x20: ffffdf6ade26b998 x19: ffff0785809ba5a8 x18:
> >>>> ffffffffffffffff
> >>>> [   41.479447] x17: 0000000000000000 x16: ffffdf6adcc25320 x15:
> >>>> 0000000000000006
> >>>> [   41.486592] x14: 0000000000000000 x13: 7463656a626f206e x12:
> >>>> 776f6e6b6e752072
> >>>> [   41.493736] x11: 00000000ffffdfff x10: ffffdf6ade8fd520 x9 :
> >>>> ffffdf6adcae53ac
> >>>> [   41.500881] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 :
> >>>> 0000000000000001
> >>>> [   41.508026] x5 : 0000000000000000 x4 : ffff07863b7ac450 x3 :
> >>>> ffff07863b7b8bb0
> >>>> [   41.515170] x2 : 0000000000000001 x1 : ffff281b5d54f000 x0 :
> >>>> 0000000000000033
> >>>> [   41.522315] Call trace:
> >>>> [   41.524759]  freq_qos_remove_request+0xa4/0xc4
> >>>> [   41.529210]  acpi_thermal_cpufreq_exit+0x90/0xb0
> >>>> [   41.533834]  acpi_processor_notifier+0x74/0x90
> >>>> [   41.538281]  blocking_notifier_call_chain+0x78/0xb0
> >>>> [   41.543161]  cpufreq_policy_free+0x154/0x1e0
> >>>> [   41.547438]  cpufreq_remove_dev+0xc0/0x10c
> >>>> [   41.551538]  subsys_interface_unregister+0xf0/0xfc
> >>>> [   41.556335]  cpufreq_unregister_driver+0x54/0x120
> >>>> [   41.561043]  cppc_cpufreq_exit+0x28/0xd2c [cppc_cpufreq]
> >>>> [   41.566370]  __do_sys_delete_module.constprop.0+0x150/0x2bc
> >>>> [   41.571947]  __arm64_sys_delete_module+0x20/0x30
> >>>> [   41.576567]  invoke_syscall+0x50/0x120
> >>>> [   41.580318]  el0_svc_common.constprop.0+0x4c/0xf4
> >>>> [   41.585023]  do_el0_svc+0x38/0x4c
> >>>> [   41.588338]  el0_svc+0x34/0xdc
> >>>> [   41.591394]  el0t_64_sync_handler+0x11c/0x150
> >>>> [   41.595752]  el0t_64_sync+0x190/0x194
> >>>> [   41.599416] ---[ end trace 0000000000000000 ]---
> >>>>
> >>>> When the cppc_cpufreq driver is rmmod'ed from a running machine that
> >>>> has
> >>>> both CPPC and a thermal zone. I reverted and bisected it, and in both
> >>>> cases the splat above goes away.
> >>>
> >>> Did you enable the option ACPI_CPU_FREQ_PSS ? When I reverted the commit
> >>> 7fdc74da940d and enable ACPI_CPU_FREQ_PSS, the warning above also
> >>> appears.
> >>
> >> AFAICS, this option is enabled automatically on all architectures
> >> other than ARM64 when the ACPI processor driver is enabled, so I'm not
> >> sure what you mean.
> >
> > I mean the commit 7fdc74da940d is not the real cause of the warning
> > reported by Jeremy Linton. And Jeremy Linton‘s hardware is Raspberry Pi
> > 4, arm platform.
> >
> > I've debugged it in arm64 machine that has both CPPC and a thermal zone:
> > If the processor thermal registered, and rmmod the cppc_cpufreq driver,
> > the warning Jeremy Linton reported appears. Otherwise, there is no warning.
> >
> > I'll continue to debug why it cause warnings.
> >
> > Thanks.
>
> Hi,
>      I've figured out why it happens.
>
>      In func acpi_thermal_cpufreq_exit, it get struct acpi_processor *pr
> through policy->cpu, then the qos of it would be removed multi times if
> the policy has related to multi cpus.
>      It seems commit a1bb46c36ce3 ("ACPI: processor: Add QoS requests
> for all CPUs") forgot to change the code from policy->cpu to each cpu.

Right.

> Apply the diff below, the warning disappears.
> diff --git a/drivers/acpi/processor_thermal.c
> b/drivers/acpi/processor_thermal.c
> index db6ac540e924..e534fd49a67e 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -151,7 +151,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy
> *policy)
>          unsigned int cpu;
>
>          for_each_cpu(cpu, policy->related_cpus) {
> -               struct acpi_processor *pr = per_cpu(processors,
> policy->cpu);
> +               struct acpi_processor *pr = per_cpu(processors, cpu);
>
>                  if (pr)
>                          freq_qos_remove_request(&pr->thermal_req);
>

Yeah, good catch!
