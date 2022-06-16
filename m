Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458BC54D83A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbiFPCWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350614AbiFPCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:22:04 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160D5A150;
        Wed, 15 Jun 2022 19:22:02 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 25G2LlwO019455;
        Thu, 16 Jun 2022 11:21:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25G2LlwO019455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655346109;
        bh=P7NLUpsWOkVk/+cmwAKzWiFyiQWv1lSs0T4trUb3nx0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rV6F1BKehrtbboii9bGfc7PAItcM1JRxcakHoPibvcz16pqgXEKPtS5lhd/QAW7MH
         VdQ2G3UnutrazDWxlY7mEjXlm/GCl3h2Q1MEt2mCfZasHcl67bHNhuWL0QE0sT2scG
         68VHXVOedtew2aTYFWpfsEAXkgRuBnvfYvszpnzKhM7S5aArwlDqfFas9/1Mheu3aD
         DamRSMKHBNkA+Mp3tk6TV5JFpSZQtMsx908r4DuIv3AKciYj3MzmXvGe0MwUVKrWaf
         YAyPSn1wcmkCnANq+7Cm+xN45il259kWvc3zbYCI7CdLiBk03JmXurZCqVfb+WNk/e
         M+V83j6ULODmA==
X-Nifty-SrcIP: [209.85.221.45]
Received: by mail-wr1-f45.google.com with SMTP id o16so10787wra.4;
        Wed, 15 Jun 2022 19:21:48 -0700 (PDT)
X-Gm-Message-State: AJIora+dPVRskwgyn4ZsQKZj74Qj1oQH+buG7HuDbJP/a2Et/gOXo8Ff
        E8PIUdRA4elOxMqJhPtv9Ys0D9APlttiWKxySZQ=
X-Google-Smtp-Source: AGRyM1vh+O9ugtHtQ+c7oRD5FHR6rGy3PRlgDlAyzYbAL4spdxQtsbMvFR1LyFHVQy8P/pdwh5hNfav2zmKoYRTWEVg=
X-Received: by 2002:a05:6000:1f09:b0:21a:5f3:316a with SMTP id
 bv9-20020a0560001f0900b0021a05f3316amr2466296wrb.682.1655346106940; Wed, 15
 Jun 2022 19:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070204.26882-1-lizhengyu3@huawei.com> <e507585a-574e-a217-479b-cb677d2df443@infradead.org>
In-Reply-To: <e507585a-574e-a217-479b-cb677d2df443@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Jun 2022 11:21:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHC2nrszDgHzYE6WSAh0OD2f-6GpXTdMmc959vShF+JQ@mail.gmail.com>
Message-ID: <CAK7LNASHC2nrszDgHzYE6WSAh0OD2f-6GpXTdMmc959vShF+JQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: kexec: Fix build error without CONFIG_KEXEC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Li Zhengyu <lizhengyu3@huawei.com>, palmer@rivosinc.com,
        mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, liaochang1@huawei.com,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 1:00 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/1/22 00:02, Li Zhengyu wrote:
> > When CONFIG_KEXEC_FILE=y but CONFIG_KEXEC is not set:
> >
> > kernel/kexec_core.o: In function `kimage_free':
> > kexec_core.c:(.text+0xa0c): undefined reference to `machine_kexec_cleanup'
> > kernel/kexec_core.o: In function `.L0 ':
> > kexec_core.c:(.text+0xde8): undefined reference to `machine_crash_shutdown'
> > kexec_core.c:(.text+0xdf4): undefined reference to `machine_kexec'
> > kernel/kexec_core.o: In function `.L231':
> > kexec_core.c:(.text+0xe1c): undefined reference to `riscv_crash_save_regs'
> > kernel/kexec_core.o: In function `.L0 ':
> > kexec_core.c:(.text+0x119e): undefined reference to `machine_shutdown'
> > kernel/kexec_core.o: In function `.L312':
> > kexec_core.c:(.text+0x11b2): undefined reference to `machine_kexec'
> > kernel/kexec_file.o: In function `.L0 ':
> > kexec_file.c:(.text+0xb84): undefined reference to `machine_kexec_prepare'
> > kernel/kexec_file.o: In function `.L177':
> > kexec_file.c:(.text+0xc5a): undefined reference to `machine_kexec_prepare'
> > Makefile:1160: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> >
> > These symbols should depend on CONFIG_KEXEC_CORE rather than CONFIG_KEXEC
> > when kexec_file has been implemented on RISC-V, like the other archs have
> > done.
> >
> > Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> thanks.
>
> > ---
> >  arch/riscv/kernel/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index c71d6591d539..33bb60a354cd 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> >  endif
> >  obj-$(CONFIG_HOTPLUG_CPU)    += cpu-hotplug.o
> >  obj-$(CONFIG_KGDB)           += kgdb.o
> > -obj-$(CONFIG_KEXEC)          += kexec_relocate.o crash_save_regs.o machine_kexec.o
> > +obj-$(CONFIG_KEXEC_CORE)     += kexec_relocate.o crash_save_regs.o machine_kexec.o
> >  obj-$(CONFIG_KEXEC_FILE)     += elf_kexec.o machine_kexec_file.o
> >  obj-$(CONFIG_CRASH_DUMP)     += crash_dump.o
> >
>
> --
> ~Randy


Perhaps, worth this:

Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


-- 
Best Regards
Masahiro Yamada
