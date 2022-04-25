Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3923750E135
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbiDYNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiDYNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:13:53 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8D36150;
        Mon, 25 Apr 2022 06:10:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f16645872fso147339497b3.4;
        Mon, 25 Apr 2022 06:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7c2v7QR8oXgGlZvD0BmKxXARsR8kLJUPUUmnl0AnKQ=;
        b=ulz94szbdz1I+5MSS8TbfBzLubnZN+UXGjYz3sXuuBQdDtA8YRb8v++eD1dkKDq5dK
         ary5jRkwplNPwdLEqwS0DP6g9Nd1uy8CGeawm2j4UKwF+FwXj6f707qkC+Lapf+7oKjA
         Iif4oLU1F7E5KzK7Nm5RmBcXZf2OpMbTZUU0vK1I96dnr1UpUSiRoiTvZcZYICgNU0Dz
         uHO1Cn/XTE7GZfGlTMbd0Wf6ChVP8D5KzlT9MNVLqxtHK1rFmdvosGrhLHCzh6JCNtId
         QuAXUokHQQVqmAR59x5vDqkjtgKl0zItBGeOFiEUEQC34sGS1QAVN+oyleLfsqFqIQh2
         CHuw==
X-Gm-Message-State: AOAM532Js7khIC4G/SWE/aAVpRw/1Gh6LXDgna0kP8Uh88fKFSfajdCS
        5mbX9ozcA7EdrBdhvYYVLS2hjGkcN9N8R4aOGvA=
X-Google-Smtp-Source: ABdhPJzsxLOP2iOHQgzmaNGQJ4i3z8UrQRDVythXRgq2c7oCq8OfkYAOoBruduWV8gK7jPJqYVVhITVm+n/+AaJlPOk=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr16189906ywb.326.1650892248584; Mon, 25
 Apr 2022 06:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <4350dfbf785cd482d3fafa72b2b49c83102df3ce.1650386317.git.pawan.kumar.gupta@linux.intel.com>
 <CAJZ5v0gQCzmnMX_1_6TCiexARJ99rtLKg58Ewi-xwUKUrGOQzg@mail.gmail.com> <20220422215132.3lmmgzkzhw36iabu@guptapa-desk>
In-Reply-To: <20220422215132.3lmmgzkzhw36iabu@guptapa-desk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Apr 2022 15:10:33 +0200
Message-ID: <CAJZ5v0jXUpGRh-NBLZa=Cvj=mN7vOV30A_WcQyMJW+w0yjOyeg@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Load microcode during restore_processor_state()
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pelton, Kyle D" <kyle.d.pelton@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:51 PM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 22, 2022 at 04:09:57PM +0200, Rafael J. Wysocki wrote:
> >On Tue, Apr 19, 2022 at 6:52 PM Pawan Gupta
> ><pawan.kumar.gupta@linux.intel.com> wrote:
> >>
> >> From: Borislav Petkov <bp@suse.de>
> >>
> >> When resuming from system sleep state, restore_processor_state()
> >> restores the boot CPU MSRs. These MSRs could be emulated by the
> >> microcode. If microcode is not loaded yet, writing to emulated MSRs
> >> leads to unchecked MSR access error:
> >>
> >>   [   28.702947] PM: Calling lapic_suspend+0x0/0x210
> >>   [   28.703345] unchecked MSR access error: WRMSR to 0x10f (tried to write 0=x0000000000000000) at rIP: 0xffffffff9b2819e4 (native_write_msr+0x4/0x20)
> >>   [   28.703357] Call Trace:
> >>   [   28.703359]  <TASK>
> >>   [   28.703361]  ? restore_processor_state+0x255/0x2d0
> >>   [   28.703369]  x86_acpi_suspend_lowlevel+0x11f/0x170
> >>   [   28.703374]  acpi_suspend_enter+0x4f/0x1f0
> >>   [   28.703379]  suspend_devices_and_enter+0x6e0/0x7d0
> >>   [   28.703384]  pm_suspend.cold+0x35c/0x3a7
> >>   [   28.703388]  state_store+0x81/0xe0
> >>   [   28.703392]  kobj_attr_store+0x12/0x20
> >>   [   28.703396]  sysfs_kf_write+0x3f/0x50
> >>   [   28.703399]  kernfs_fop_write_iter+0x13b/0x1d0
> >>   [   28.703403]  new_sync_write+0x101/0x180
> >>   [   28.703408]  vfs_write+0x217/0x2a0
> >>   [   28.703413]  ksys_write+0x67/0xe0
> >>   [   28.703417]  __x64_sys_write+0x1a/0x20
> >>   [   28.703421]  do_syscall_64+0x3b/0x90
> >>   [   28.703426]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>   [   28.703429] RIP: 0033:0x7fda13c260a7
> >>   [   28.703434] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 =
> >>   00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> >>   > 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> >>   [   28.703437] RSP: 002b:00007fffa4060268 EFLAGS: 00000246 ORIG_RAX: 000000=0000000001
> >>   [   28.703441] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fda13c=260a7
> >>   [   28.703443] RDX: 0000000000000004 RSI: 000055a41f65a570 RDI: 00000000000=00004
> >>   [   28.703444] RBP: 000055a41f65a570 R08: 0000000000000000 R09: 00000000000=00004
> >>   [   28.703446] R10: 000055a41f0cc2a6 R11: 0000000000000246 R12: 00000000000=00004
> >>   [   28.703447] R13: 000055a41f657510 R14: 00007fda13d014a0 R15: 00007fda13d=008a0
> >
> >__restore_processor_state() is used during resume from both
> >suspend-to-RAM and hibernation, but I don't think that the latter is
> >affected by the issue at hand, because microcode should be loaded by
> >the restore kernel in that case.  However, loading the boot processor
> >microcode in __restore_processor_state() during resume from
> >hibernation still works, although it is redundant in that case.
> >
> >It would be good to acknowledge the above in the changelog and also
> >mention in it that the issue is specific to suspend-to-RAM (ACPI S3 on
> >x86 PC systems).
>
> Yes, it will be good to add this.
>
> [...]
> >> @@ -262,11 +263,18 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
> >>         x86_platform.restore_sched_clock_state();
> >>         mtrr_bp_restore();
> >>         perf_restore_debug_store();
> >> -       msr_restore_context(ctxt);
> >>
> >>         c = &cpu_data(smp_processor_id());
> >>         if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
> >>                 init_ia32_feat_ctl(c);
> >
> >The change of the ordering between the above and msr_restore_context()
> >needs to be explained in the changelog too.
>
> This patch is already queued in tip tree. I am not sure if we can update
> the commit message in tip tree?

That depends on the maintainer who has applied the patch.
