Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE0E48CC02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbiALTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbiALTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:31:13 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3DC061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:31:12 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id l13so2559224qvz.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KPUZPC7mXCjPccDHGkZXT/St+JP8rkpXgLzmJC/vgmw=;
        b=S8Jxp6bnUFN1BWPzxUiK5ka/41HWamlWdabBFBawIBZ789+Pkoy6jRmhTQbgDPRW0L
         X79mLKs3wSwdqzRu5EIcPr1+zg/J750tdo2KfMF/6xYjxOs8KBgr5lhcOeNTz/ia+XSh
         YTrtbeTffff8WEtlm7s5bhDzfXuCELxJzmKEL+JZjO3wh2quZjJXYrkUGGk0lYv2PMQW
         DYotx9DXwm8tv/mwSA36chwFIxOaEtlOjmLP9Iwro2+zceNwH5pf1nYvbYvP4FoOAO2W
         80Fx/cG48QddDt3LCKYH9/RsORwCss33ojxuQyULPhaU+EcO60fuIdtrS9ClQ/wZEuGr
         PRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPUZPC7mXCjPccDHGkZXT/St+JP8rkpXgLzmJC/vgmw=;
        b=Sx+4745ryYa8dTa43vCeaqwX0O8Nlez+pqUZkF2ZOeYpIV7eInaUgyyfMdOsvfMBto
         n4/isEVhujK3GaeGdT0sAgwjl2ejrcGVfEX1y3OLj3bNChPkVq86uMKLODIBqoJee9hl
         cUZhhjcoKmWpMpZVLPy7CP+lDT8oFN2cB5TIDd/Vdb71WFLCFvkN0AUrM408O29zbDlt
         JyWHXWsIKml41Je41a2kviubv5zehA4C4YPYUnwv1XORNZpo1KmZ6XU+78O2U1lWNxlA
         oetjiTp0bPVtfAoI+6qM9AWkY42GlOmkvuSg4Z/MHchJqQkMr8DjGTqXxTeX+0hlaFYc
         GYYQ==
X-Gm-Message-State: AOAM533DbcwmghasvI4/KERC2984/MMiLG83gx050GCx4kzO0n3gBoH5
        jrU1mO7syHrqM4BG7H+mvw==
X-Google-Smtp-Source: ABdhPJxPoEb6FawqYUheCv1D9WhofObClNu7d3NLeJ0x/+cf95VgiON48fDy1oGwWTnVAptcmSEliQ==
X-Received: by 2002:ad4:5ded:: with SMTP id jn13mr1122262qvb.112.1642015871965;
        Wed, 12 Jan 2022 11:31:11 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id x9sm530599qta.10.2022.01.12.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:31:11 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:31:08 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     wens@kernel.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, tsbogend@alpha.franken.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>, ito-yuichi@fujitsu.com,
        mpe@ellerman.id.au, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        julien.thierry.kdev@gmail.com,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/7] arm64: Add framework to turn an IPI as NMI
Message-ID: <Yd8sfP0IXN4KiLuP@gabell>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <CAGb2v66mVoWiCibjq25d3Z8OvbWNO9p+vMo761RJLiD-BqVbqw@mail.gmail.com>
 <CAFA6WYN-wpQ86ik5FeAhimCcCoRAs9_g3BGL8CiSUmHxfeCSbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYN-wpQ86ik5FeAhimCcCoRAs9_g3BGL8CiSUmHxfeCSbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 11:29:29AM +0530, Sumit Garg wrote:
> On Fri, 25 Jun 2021 at 20:26, Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > On Mon, Nov 2, 2020 at 7:46 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > With pseudo NMIs support available its possible to configure SGIs to be
> > > triggered as pseudo NMIs running in NMI context. And kernel features
> > > such as:
> > > - NMI backtrace can leverage IPI turned as NMI to get a backtrace of CPU
> > >   stuck in hard lockup using magic SYSRQ.
> > > - kgdb relies on NMI support to round up CPUs which are stuck in hard
> > >   lockup state with interrupts disabled.
> > >
> > > This patch-set adds framework to turn an IPI as NMI which can be triggered
> > > as a pseudo NMI which in turn invokes registered NMI handlers.
> > >
> > > After this patch-set we should be able to get a backtrace for a CPU
> > > stuck in HARDLOCKUP. Have a look at an examples below from a hard lockup
> > > testcase run on Developerbox:
> > >
> > > $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> > >
> > > NMI backtrace:
> > > ==============
> > >
> > > # Issue Magic SysRq to dump backtrace
> > >
> > > [  376.894502] NMI backtrace for cpu 8
> > > [  376.894506] CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
> > > [  376.894510] Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
> > > [  376.894514] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
> > > [  376.894517] pc : lkdtm_HARDLOCKUP+0x8/0x18
> > > [  376.894520] lr : lkdtm_do_action+0x24/0x30
> > > [  376.894524] sp : ffff800012cebd20
> > > [  376.894527] pmr_save: 00000060
> > > [  376.894530] x29: ffff800012cebd20 x28: ffff000875ae8000
> > > [  376.894540] x27: 0000000000000000 x26: 0000000000000000
> > > [  376.894550] x25: 000000000000001a x24: ffff800012cebe40
> > > [  376.894560] x23: 000000000000000b x22: ffff800010fc5040
> > > [  376.894569] x21: ffff000878b61000 x20: ffff8000113b2870
> > > [  376.894579] x19: 000000000000001b x18: 0000000000000010
> > > [  376.894588] x17: 0000000000000000 x16: 0000000000000000
> > > [  376.894598] x15: ffff000875ae8470 x14: 00000000000002ad
> > > [  376.894613] x13: 0000000000000000 x12: 0000000000000000
> > > [  376.894622] x11: 0000000000000007 x10: 00000000000009c0
> > > [  376.894631] x9 : ffff800012ceba80 x8 : ffff000875ae8a20
> > > [  376.894641] x7 : ffff00087f6b3280 x6 : ffff00087f6b3200
> > > [  376.894651] x5 : 0000000000000000 x4 : ffff00087f6a91f8
> > > [  376.894660] x3 : ffff00087f6b0120 x2 : 1aa310cec69eb500
> > > [  376.894670] x1 : 0000000000000000 x0 : 0000000000000060
> > > [  376.894679] Call trace:
> > > [  376.894683]  lkdtm_HARDLOCKUP+0x8/0x18
> > > [  376.894686]  direct_entry+0x124/0x1c0
> > > [  376.894689]  full_proxy_write+0x60/0xb0
> > > [  376.894693]  vfs_write+0xf0/0x230
> > > [  376.894696]  ksys_write+0x6c/0xf8
> > > [  376.894699]  __arm64_sys_write+0x1c/0x28
> > > [  376.894703]  el0_svc_common.constprop.0+0x74/0x1f0
> > > [  376.894707]  do_el0_svc+0x24/0x90
> > > [  376.894710]  el0_sync_handler+0x180/0x2f8
> > > [  376.894713]  el0_sync+0x158/0x180
> > >
> > > KGDB:
> > > =====
> > >
> > > # Enter kdb via Magic SysRq
> > >
> > > [6]kdb> btc
> > > btc: cpu status: Currently on cpu 6
> > > Available cpus: 0-5(I), 6, 7(I), 8, 9-23(I)
> > > <snip>
> > > Stack traceback for pid 555
> > > 0xffff000875ae8000      555      554  1    8   R  0xffff000875ae89c0  bash
> > > CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
> > > Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
> > > Call trace:
> > >  dump_backtrace+0x0/0x1a0
> > >  show_stack+0x18/0x28
> > >  dump_stack+0xc0/0x11c
> > >  kgdb_cpu_enter+0x648/0x660
> > >  kgdb_nmicallback+0xa0/0xa8
> > >  ipi_kgdb_nmicallback+0x24/0x30
> > >  ipi_nmi_handler+0x48/0x60
> > >  handle_percpu_devid_fasteoi_ipi+0x74/0x88
> > >  generic_handle_irq+0x30/0x48
> > >  handle_domain_nmi+0x48/0x80
> > >  gic_handle_irq+0x18c/0x34c
> > >  el1_irq+0xcc/0x180
> > >  lkdtm_HARDLOCKUP+0x8/0x18
> > >  direct_entry+0x124/0x1c0
> > >  full_proxy_write+0x60/0xb0
> > >  vfs_write+0xf0/0x230
> > >  ksys_write+0x6c/0xf8
> > >  __arm64_sys_write+0x1c/0x28
> > >  el0_svc_common.constprop.0+0x74/0x1f0
> > >  do_el0_svc+0x24/0x90
> > >  el0_sync_handler+0x180/0x2f8
> > >  el0_sync+0x158/0x180
> > > <snip>
> > >
> > > Changes in v7:
> > > - Add a new library function: kgdb_smp_call_nmi_hook() to expose fallback
> > >   mechanism to arch specific code.
> > > - Addressed other misc comments from Daniel.
> > >
> > > Changes in v6:
> > > - Two new patches: #4 and #6 which adds runtime fallback framework for
> > >   sysrq backtrace and kgdb roundup features.
> > > - Reversed order of NMI backtrace and kgdb roundup feaure patches.
> > > - Addressed other misc. comments from Marc.
> > > - I haven't picked any tags from v5 since I think there is major rework
> > >   involved. Masayoshi, could you please confirm if these features still
> > >   work for you?
> > >
> > > Changes in v5:
> > > - Rebased to head of upstream master.
> > > - Remove redundant invocation of ipi_nmi_setup().
> > > - Addressed misc. comments.
> > >
> > > Changes in v4:
> > > - Move IPI NMI framework to a separate file.
> > > - Get rid of hard-coded IPI_CALL_NMI_FUNC allocation.
> > > - Add NMI backtrace support leveraged via magic SYSRQ.
> > >
> > > Changes in v3:
> > > - Rebased to Marc's latest IPIs patch-set [1].
> > >
> > > [1] https://lkml.org/lkml/2020/9/1/603
> > >
> > > Changes since RFC version [1]:
> > > - Switch to use generic interrupt framework to turn an IPI as NMI.
> > > - Dependent on Marc's patch-set [2] which turns IPIs into normal
> > >   interrupts.
> > > - Addressed misc. comments from Doug on patch #4.
> > > - Posted kgdb NMI printk() fixup separately which has evolved since
> > >   to be solved using different approach via changing kgdb interception
> > >   of printk() in common printk() code (see patch [3]).
> > >
> > > [1] https://lkml.org/lkml/2020/4/24/328
> > > [2] https://lkml.org/lkml/2020/5/19/710
> > > [3] https://lkml.org/lkml/2020/5/20/418
> > >
> > > Sumit Garg (7):
> > >   arm64: Add framework to turn IPI as NMI
> > >   irqchip/gic-v3: Enable support for SGIs to act as NMIs
> > >   arm64: smp: Assign and setup an IPI as NMI
> > >   nmi: backtrace: Allow runtime arch specific override
> > >   arm64: ipi_nmi: Add support for NMI backtrace
> > >   kgdb: Expose default CPUs roundup fallback mechanism
> > >   arm64: kgdb: Roundup cpus using IPI as NMI
> >
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> >
> > on an ROC-RK3399-PC.
> 
> Thanks for testing this feature.
> 
> -Sumit

Hello Sumit,

How is this patch series going?

- Masa
