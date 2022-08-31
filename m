Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652655A806D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiHaOkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHaOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14096E8B0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA0161BD9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FFFC43470
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661956813;
        bh=7jiGa1vBE/j5RxUt8dEuAHBImCYY5aG0SR6VMryy7RA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sywG8ky5a1E6nzoaTfZ7won2Dl0eGn49RgyuvDlqn+YnIOEXoYugOxf50smACuyqe
         kum0gXmFppTJZ1hvnD5v7oNn89ohNBsHbovxOIlXp/yitXUDsYMmTonFMpv0Vkr1qx
         1lFk5NG0LJjqSQq3FtKkF3xdme77i/2vXaKECME4Ce8CMwseLs56So6itrdTHP5SjD
         HwH4cz/eaMmpLDFOYufrcs2PgfmLEUk+1OcpEapSA3wRoUT1aSvuYucQMNGNaileDC
         xwaSbmGgUPU+LOlZIioWI6lbyAJYe0xGC2v42dpQpHyt34NTZvcLRTTtJR+zZ6rU9+
         FqxLzKwLKjEjg==
Received: by mail-vs1-f51.google.com with SMTP id c3so14785959vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:40:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo03dd6VDwDm1M2V33+zfpE0t4HBJcdZx20uRGjEQdJcoHxWPTix
        torqe054uG9K3m5oa4bNjgOHlzF39+rcd3kt5AY=
X-Google-Smtp-Source: AA6agR6mIs5k1530qHJ6X9j9riGYENv1FmtGBR9gVZ7pjCtirFBWFE7zhnRTsMvY/P7nFTzqY8XSnjG5YJ7vu9sznlg=
X-Received: by 2002:a05:6102:30bc:b0:390:da09:3a8c with SMTP id
 y28-20020a05610230bc00b00390da093a8cmr5302064vsd.84.1661956812672; Wed, 31
 Aug 2022 07:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
In-Reply-To: <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 31 Aug 2022 22:40:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
Message-ID: <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 4:09 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Wed, 2022-08-31 at 14:58 +0800, Jinyang He wrote:
> > That's right. Also I am wondering why new toolchain produce .got* in
> > kernel. It's unneeded. In the past, gcc create la.global and parsed
> > to la.pcrel by gas, and kernel works well. Now it seems we lost this
> > feature in gcc. I checked the x86 asm code just now. And some info
> > follows,
> >
> > LoongArch64, ./net/ipv4/udp_diag.s, *have reloc hint*
> >          pcalau12i       $r4,%got_pc_hi20(udplite_table)
> >          ld.d    $r4,$r4,%got_pc_lo12(udplite_table)
> >          b       udp_dump
> >
> > x86_64, ./net/ipv4/udp_diag.s
> >          movq    $udplite_table, %rdi
> >          jmp     udp_dump
> >
> > It seems related to -fno-PIE and -cmodel=kernel on x86_64.
> > Hope new gcc with this feature now.
>
> On x86_64 -mcmodel=kernel means "all code and data are located in [-
> 2GiB, 0) range.  We actually don't strictly require a "high" range as
> we're mostly a PIC-friendly architecture: note that we use a
> pcalau12i/addi.d pair for PIC addressing in [PC-2GiB, PC+2GiB, and a
> lu12i.w/addi.d pair for "non-PIC" addressing in [-2GiB, 2GiB), both are
> 2-insn sequence.
>
> If we can put the main kernel image and the modules in one 2GiB VA
> range, we can avoid GOT completely.  But it's not possible for now
> because main kernel image is loaded in XKPRANGE but the modules are in
> XKVRANGE.  So the best we can achieve before implementing
> CONFIG_RELOCATION is using GOT in modules, and avoid GOT in the main
> kernel image (with a new code model in GCC, which will benefit both the
> kernel and statically linked executables).
Emmm, can you implement this new code model in the near future?

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>
