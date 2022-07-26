Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC109580AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiGZFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 01:53:27 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98E275FC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:53:26 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id c185so4822716iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9NqP8zb13cEgKtZZvdVuc+bb8giuTenSXo8OvwSJLpc=;
        b=TGYN7fdgHROPKhTokOlKbDXQsF3DrUWRscdFhO4StXlgImpnjc+ST+m5zQ2mDI5JY5
         oLc0+lzu61o5iTTW6v6CUQERKYP0HeLhXsCOqSWoGidrFECb+qFvWSMhWgtz5zWOJmKN
         B1Rx9tkp22OEJEhu5ZXANe4PcZkbHFe6jFoqdVA8RFQbx62sZ/LWZafa29FDud4j7YqZ
         +WEmM93hNeShSdCI5Z3Gvk4jK9jfSHYQhLJe3uZNgFxH0kBUeOnAuj7hqqOkmLrZtAHf
         QiOMZwOBh+CSVBUYt+CqEuWcL96yoIRySBl0yzvWgRzhMrFiAokfvP+ic8GVPdkxnLs8
         QpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9NqP8zb13cEgKtZZvdVuc+bb8giuTenSXo8OvwSJLpc=;
        b=2ywZ723mSPzVe+wmDARu8079AyaBhqX+qj6zT6C58SYzD6EmBAbUcfMw+kvqLPzdj3
         aDImr/lf7LgguD9zN2lT95KDdPD2/gbHa7z+1UN99wOpWpWrI91G2zT+eZ48wgu/LtZj
         h6LVJhTOXddNruJP425H7oKEWHZI3v5ir3Prno72V9dr120Hzfbm1i57rBzUBqmtA8+H
         jeE/0JOL748mUwff3paWkc8uE9xui4KAmFj4BYPMm8nucF1fPIni7LH8mDxeRPG+XtIC
         R1Q0fWCLBNVhV9sL36EUSloq4bsZXJ1UqBWLm0eKyTw9FgNPumIdJqhv2zFLaPmHwyou
         peWA==
X-Gm-Message-State: AJIora8IJ+i87Ad0D8HPySGc0FhrOl3eeOMF0tjODGz0hXWi2oilaj80
        E8bR0cZEHfh6pErLpfLNR584pch5s4MP66e/x7OOsg==
X-Google-Smtp-Source: AGRyM1uV3p3HFDDQtbSh8ayK0mb85b+LYxf4LJzrYTfZLwrZCur97v0IGP8j7Jfd7EJ0OiLrkutbcVdgUOweXJ5+oOY=
X-Received: by 2002:a5e:a618:0:b0:67c:27b4:1f93 with SMTP id
 q24-20020a5ea618000000b0067c27b41f93mr5476177ioi.75.1658814805551; Mon, 25
 Jul 2022 22:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com> <8735epf7j5.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <8735epf7j5.fsf@email.froward.int.ebiederm.org>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 26 Jul 2022 13:53:13 +0800
Message-ID: <CABKxMyOwHC9ZhL9Gxt-MVg-sy3d1kqzPviQOH845rers7inX3Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/4] faster kexec reboot
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Eric W. Biederman
Thank you for your advice and opinion, I am very honored

Eric W. Biederman <ebiederm@xmission.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=882=
6=E6=97=A5=E5=91=A8=E4=BA=8C 01:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Albert Huang <huangjie.albert@bytedance.com> writes:
>
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > In many time-sensitive scenarios, we need a shorter time to restart
> > the kernel. However, in the current kexec fast restart code, there
> > are many places in the memory copy operation, verification operation
> > and decompression operation, which take more time than 500ms. Through
> > the following patch series. machine_kexec-->start_kernel only takes
> > 15ms
>
> Is this a tiny embedded device you are taking the timings of?
>
> How are you handling driver shutdown and restart?  I would expect those
> to be a larger piece of the puzzle than memory.

There is no way to make the code universal in the time optimization here,
and various devices need to be customized, but we have some solutions to
achieve the maintenance and recovery of these devices,
especially the scanning and initialization of pci devices

>
> My desktop can do something like 128GiB/s.  Which would suggest that
> copying 128MiB of kernel+initrd would take perhaps 10ms.  The SHA256
> implementation may not be tuned so that could be part of the performance
> issue.  The SHA256 hash has a reputation for having fast
> implementations.  I chose SHA256 originally simply because it has more
> bits so it makes the odds of detecting an error higher.
>

Yes, sha256 is a better choice, but if there is no memory copy between
kexec load
and kexec -e, and this part of the memory is reserved. Don't think
this part of memory will be changed.
Especially in virtual machine scenarios

>
> If all you care about is booting a kernel as fast as possible it make
> make sense to have a large reserved region of memory like we have for
> the kexec on panic kernel.  If that really makes sense I recommend
> adding a second kernel command line option and a reserving second region
> of reserved memory.  That makes telling if the are any conflicts simple.
>

I initially implemented re-adding a parameter and region, but I
figured out later
that it doesn't really make sense and would waste extra memory.

>
> I am having a hard time seeing how anyone else would want these options.
> Losing megabytes of memory simply because you might reboot using kexec
> seems like the wrong side of a trade-off.

Reuse the memory reserved by the crash kernel? Why does it increase
memory consumption?

>
> The CONFIG_KEXEC_PURGATORY_SKIP_SIG option is very misnamed.  It is not
> signature verification that is happening it is a hash verification.
> There are not encrypted bits at play.  Instead there is a check to
> ensure that the kernel has not been corrupted by in-flight DMA that some
> driver forgot to shut down.
>
Thanks for pointing that out.
but Even if the data is detected to have been changed, there is
currently no way to recover it.
I don't have a good understanding of this place yet. maybe for security rea=
sons=EF=BC=9F


> So you are building a version of kexec that if something goes wrong it
> could very easily eat your data, or otherwise do some very bad things
> that are absolutely non-trivial to debug.
>
> That the decision to skip the sha256 hash that prevents corruption is
> happening at compile time, instead of at run-time, will guarantee the
> option is simply not available on any general purpose kernel
> configuration.  Given how dangerous it is to skip the hash verification
> it is probably not a bad thing overall, but it is most definitely
> something that will make maintenance more difficult.
>

Maybe parameters will be a better choice. What do you think ?

>
> If done well I don't see why anyone would mind a uncompressed kernel
> but I don't see what the advantage of what you are doing is over using
> vmlinux is the build directory.  It isn't a bzImage but it is the
> uncompressed kernel.
>


> As I proof of concept I think what you are doing goes a way to showing
> that things can be improved.  My overall sense is that improving things
> the way you are proposing does not help the general case and simply adds
> to the maintenance burden.

I don't think so. The kernel startup time of some lightweight virtual
machines maybe
100-200ms (start_kernel->init). But this kexec->start_kernel took more
than 500ms.
This is still valuable, and the overall code size is also very small.

> Eric
>
> >
> > How to measure time:
> >
> > c code:
> > uint64_t current_cycles(void)
> > {
> >     uint32_t low, high;
> >     asm volatile("rdtsc" : "=3Da"(low), "=3Dd"(high));
> >     return ((uint64_t)low) | ((uint64_t)high << 32);
> > }
> > assembly code:
> >        pushq %rax
> >        pushq %rdx
> >        rdtsc
> >        mov   %eax,%eax
> >        shl   $0x20,%rdx
> >        or    %rax,%rdx
> >        movq  %rdx,0x840(%r14)
> >        popq  %rdx
> >        popq  %rax
> > the timestamp may store in boot_params or kexec control page, so we can
> > get the all timestamp after kernel boot up.
> >
> > huangjie.albert (4):
> >   kexec: reuse crash kernel reserved memory for normal kexec
> >   kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
> >   x86: Support the uncompressed kernel to speed up booting
> >   x86: boot: avoid memory copy if kernel is uncompressed
> >
> >  arch/x86/Kconfig                   | 10 +++++++++
> >  arch/x86/boot/compressed/Makefile  |  5 ++++-
> >  arch/x86/boot/compressed/head_64.S |  8 +++++--
> >  arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++-----
> >  arch/x86/purgatory/purgatory.c     |  7 ++++++
> >  include/linux/kexec.h              |  9 ++++----
> >  include/uapi/linux/kexec.h         |  2 ++
> >  kernel/kexec.c                     | 19 +++++++++++++++-
> >  kernel/kexec_core.c                | 16 ++++++++------
> >  kernel/kexec_file.c                | 20 +++++++++++++++--
> >  scripts/Makefile.lib               |  5 +++++
> >  11 files changed, 114 insertions(+), 22 deletions(-)
