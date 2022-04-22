Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5750B68D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388608AbiDVLyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiDVLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:54:20 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9156427;
        Fri, 22 Apr 2022 04:51:27 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id w187so4646782ybe.2;
        Fri, 22 Apr 2022 04:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CcqFQYmVriw9ZTHQHVW3NcnOq+hx+/K4O4vbvQn0tM=;
        b=e28eaE7xCVn2IQMBoab1kxvb7dv2Ri7i3xsslAag0KXx+x0BA9SPH7cd86YU/FQ5ZT
         E+2Ukr8fbRQeBaeZOitSvnRUS5+Zy23a/DzEvu0aFeqg+k1N49kHBWg9Jk7keFnILk+G
         pt2BtfoM3e2sM5B4ODrMwv8XpU7oZ7PYyCClEK7mMkhi0Ic1EjVEejfcJHNPlbM735ZT
         N6MIcVwNw+s9GehY5wxpSu8VERRdccegv72S+kM9Lpm2ExzHdRxaLRkNQF6e9Mp3q7um
         nsWKqoCf59pz7+57oc15R49SEVM6VzapzCIH/+A3JaFoTqEBw+oARHBDSopSmwIoljuB
         JSkw==
X-Gm-Message-State: AOAM531QBoK2/eREnmskaFgffGt7J4JK6OFvtkVOI+edOzGzruQ1iu/a
        fqae5scDKt4LTikxrG7CoA+R3ToMyJnKQzZKsTI=
X-Google-Smtp-Source: ABdhPJwixhbxeOu9BsE1Bz7IcUAeBFCNc+QS50hYJxGrSWQWvzT5zio8sFM8zW+WAYj2zjLl6kBBRIOQiS/0UKBLvS0=
X-Received: by 2002:a25:3747:0:b0:645:8d0d:9352 with SMTP id
 e68-20020a253747000000b006458d0d9352mr2410299yba.137.1650628286910; Fri, 22
 Apr 2022 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220421161520.401946-1-matthieu.baerts@tessares.net> <99ac4b6-bea7-325e-1ca-cbf78982f5c1@linux.intel.com>
In-Reply-To: <99ac4b6-bea7-325e-1ca-cbf78982f5c1@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 13:51:15 +0200
Message-ID: <CAJZ5v0i-67mJe2eAVr2XS=POY33FbXD44fMfD3F84yGZq+wx3A@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] x86/pm: fix false positive kmemleak report in msr_build_context()
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 1:21 AM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Thu, 21 Apr 2022, Matthieu Baerts wrote:
>
> > Since commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume"),
> > kmemleak reports this issue:
> >
> >  unreferenced object 0xffff888009cedc00 (size 256):
> >    comm "swapper/0", pid 1, jiffies 4294693823 (age 73.764s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 48 00 00 00 00 00 00 00  ........H.......
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      msr_build_context (include/linux/slab.h:621)
> >      pm_check_save_msr (arch/x86/power/cpu.c:520)
> >      do_one_initcall (init/main.c:1298)
> >      kernel_init_freeable (init/main.c:1370)
> >      kernel_init (init/main.c:1504)
> >      ret_from_fork (arch/x86/entry/entry_64.S:304)
> >
> > It is easy to reproduce it on my side:
> >
> >  - boot the VM with a debug kernel config [1]
> >  - wait ~1 minute
> >  - start a kmemleak scan
> >
> > It seems kmemleak has an issue with the array allocated in
> > msr_build_context() and assigned to a pointer in a static structure
> > (saved_context.saved_msrs->array): there is no leak then.
> >
> > It looks like this is a limitation from kmemleak but that's alright,
> > kmemleak_no_leak() can be used to avoid complaining about that.
> >
> > Please note that it looks like this issue is not new, e.g.
> >
> >  https://lore.kernel.org/all/9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net/
> >  https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/
> >
> > But on my side, msr_build_context() is only used since:
> >
> >  commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume").
> >
> > Depending on their CPUs, others have probably the same issue since:
> >
> >  commit 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume"),
> >
> > hence the 'Fixes' tag here below to help with the backports. But I
> > understand if someone says the origin of this issue is more on
> > kmemleak's side. What is unclear to me is why this issue was not seen by
> > other people and CIs. Maybe the kernel config [1]?
> >
> > [1] https://github.com/multipath-tcp/mptcp_net-next/files/8531660/kmemleak-cpu-sched-bisect.kconfig.txt
> >
>
> Hi Matthieu -
>
> It looks like the root cause here is alignment within the packed struct
> saved_context (from suspend_64.h). Kmemleak only searches for pointers
> that are aligned, but pahole shows that the saved_msrs struct member and
> all members after it in the structure are unaligned:
>
> (gcc 11.2.1, x86_64)
>
> struct saved_context {
>         struct pt_regs             regs;                 /*     0   168 */
>         /* --- cacheline 2 boundary (128 bytes) was 40 bytes ago --- */
>         u16                        ds;                   /*   168     2 */
>         u16                        es;                   /*   170     2 */
>         u16                        fs;                   /*   172     2 */
>         u16                        gs;                   /*   174     2 */
>         long unsigned int          kernelmode_gs_base;   /*   176     8 */
>         long unsigned int          usermode_gs_base;     /*   184     8 */
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         long unsigned int          fs_base;              /*   192     8 */
>         long unsigned int          cr0;                  /*   200     8 */
>         long unsigned int          cr2;                  /*   208     8 */
>         long unsigned int          cr3;                  /*   216     8 */
>         long unsigned int          cr4;                  /*   224     8 */
>         u64                        misc_enable;          /*   232     8 */
>         bool                       misc_enable_saved;    /*   240     1 */
>
> /* Note odd offset values for the remainder of this struct    vvv       */
>
>         struct saved_msrs          saved_msrs;           /*   241    16 */
>         /* --- cacheline 4 boundary (256 bytes) was 1 bytes ago --- */
>         long unsigned int          efer;                 /*   257     8 */
>         u16                        gdt_pad;              /*   265     2 */
>         struct desc_ptr            gdt_desc;             /*   267    10 */
>         u16                        idt_pad;              /*   277     2 */
>         struct desc_ptr            idt;                  /*   279    10 */
>         u16                        ldt;                  /*   289     2 */
>         u16                        tss;                  /*   291     2 */
>         long unsigned int          tr;                   /*   293     8 */
>         long unsigned int          safety;               /*   301     8 */
>         long unsigned int          return_address;       /*   309     8 */
>
>         /* size: 317, cachelines: 5, members: 25 */
>         /* last cacheline: 61 bytes */
> } __attribute__((__packed__));
>
> If I move misc_enable_saved to the end of the struct declaration,
> saved_msrs fits in before the cacheline 4 boundary and the kmemleak
> warning goes away. The comment above the saved_context declaration says to
> check wakeup_64.S and __save/__restore_processor_state() if the struct is
> modified - looks like it's the members before misc_enable that must be
> carefully placed.

Yes, you can move misc_enable_saved to the end of it safely AFAICS.

> So far I've only tried this on my local machine, I'll work on getting more
> thorough validation.
>
> Looks like struct saved_context in suspend_32.h has similar odd alignment.

Right, and it can be changed too AFAICS.

> > Fixes: 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/268
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> > arch/x86/power/cpu.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > index 3822666fb73d..1467c6d1a966 100644
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -14,6 +14,7 @@
> > #include <linux/tboot.h>
> > #include <linux/dmi.h>
> > #include <linux/pgtable.h>
> > +#include <linux/kmemleak.h>
> >
> > #include <asm/proto.h>
> > #include <asm/mtrr.h>
> > @@ -413,6 +414,9 @@ static int msr_build_context(const u32 *msr_id, const int num)
> >               return -ENOMEM;
> >       }
> >
> > +     /* The pointer is going to be stored in static struct (saved_context) */
> > +     kmemleak_not_leak(msr_array);
> > +
> >       if (saved_msrs->array) {
> >               /*
> >                * Multiple callbacks can invoke this function, so copy any
> > --
> > 2.34.1
> >
> >
>
> --
> Mat Martineau
> Intel
