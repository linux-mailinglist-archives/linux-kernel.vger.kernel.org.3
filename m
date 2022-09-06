Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275235AE250
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIFIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbiIFIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:20:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F345C949
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F41EB8164A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EF6C43470
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662452430;
        bh=ZbibMUNAjjoNAAvz1ql7CXchqgAEAiETKd4gTDwr06c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OiBttTdW0feoadUUVSeiY5YxgLI/IG9xVMRfe9L5VClNiIfpRYyEChQTzNLjvw6u5
         r+HOcj9DkQKkY816b7iApBE9j/4t+K98zV1JUnxrwJ4Tg1cvl4qfHJ4f+XfHXvF1yF
         i2JEyxniYVFUG5ZXMV/B5XEozrAjIuzu6lRL6kFfQMyujo6fqofRhDYoIQWgrbUtlZ
         6AwByAUS+AEShSrHmeXWCCoVk8ZgCcpvX860dwJq/fjz3s8LZ3bvs9TLHydkvNIOT0
         cRHMk/WNxPqlh5Wi60Ry8HN8QdfNZI7EGrgODibw2/mAIwTbBqgqdDev/6gEp1AmHp
         QyVbSowLp0vjg==
Received: by mail-ua1-f46.google.com with SMTP id z26so387637uaq.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:20:30 -0700 (PDT)
X-Gm-Message-State: ACgBeo1vwAknmZD91P9koMr7+t2aPJ5yTYb18yINFNZhN9RST/8sRhRi
        /tRn9r/RuoN2CoqJ1RSP1Z2R/M6QBe87BMSirmA=
X-Google-Smtp-Source: AA6agR7UVZ0Tj0zsxXqzRKUKDPugPMJ4MIAV237ApqkIFDn2SD4HuTsX5zoXyqCjRLDWNMpSokz/nMB5lSirOHJ+XeA=
X-Received: by 2002:ab0:2ea9:0:b0:395:b672:508 with SMTP id
 y9-20020ab02ea9000000b00395b6720508mr3564505uay.63.1662452429281; Tue, 06 Sep
 2022 01:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
 <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
 <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
 <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
 <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
 <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com>
 <8d0f96e2977c5c78f17bb410087f2aad986ef5a4.camel@xry111.site>
 <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com> <CAMj1kXE6YHCVj9DDbxLEZnS-ceZT__xe1XAcUcpXcd6eYb=UEw@mail.gmail.com>
In-Reply-To: <CAMj1kXE6YHCVj9DDbxLEZnS-ceZT__xe1XAcUcpXcd6eYb=UEw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Sep 2022 16:20:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5NT-bq2jb3Kh-5wyCwVeG6t6pkLkPSRRC5XKrC33j1Nw@mail.gmail.com>
Message-ID: <CAAhV-H5NT-bq2jb3Kh-5wyCwVeG6t6pkLkPSRRC5XKrC33j1Nw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
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

On Tue, Sep 6, 2022 at 3:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 6 Sept 2022 at 06:43, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ruoyao,
> >
> > On Tue, Sep 6, 2022 at 12:27 PM Xi Ruoyao <xry111@xry111.site> wrote:
> > >
> > > On Tue, 2022-09-06 at 09:52 +0800, Huacai Chen wrote:
> > > > >   cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > > -                                  -fpic
> > > > > +                                  -fpie
> > > > >
> > > > >   cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > > >
> > > > > (Some explanation: -fpic does not only mean "generate position-
> > > > > independent code", but "generate position-independent code *suitable for
> > > > > use in a shared library*".  On LoongArch -mdirect-extern-access cannot
> > > > > work for a shared library so the "-fpic -mdirect-extern-access"
> > > > > combination is rejected deliberately.)
> > > > >
> > > > > Not sure how to submit these changes properly...  Do you prefer me to
> > > > > send V8 of this series or a single patch on top of your tree on GitHub?
> > >
> > > > Don't need V8, I will squash it into the previous patch myself. But
> > > > can we keep efistub as is?
> > >
> > > No, we can't allow -mdirect-extern-access -fpic on LoongArch because
> > > without copy relocation such a combination just does not make sense (i.
> > > e. we cannot find a sensible way to handle such a combination in GCC).
> > > So such a combination will cause GCC refuse to run.
> > >
> > > Note that -fpic/-fPIC is "position-independent code *suitable for
> > > use in a shared library*", while -fpie/-fPIE is more like just
> > > "position-independent code".  The names of those options are confusing.
> > > (When -fpic was invented first time, people mostly believed "PIC had
> > > been only for shared libraries", so it's named -fpic instead of -shlib
> > > or something.)  IMO in the EFI stub for other ports, -fpie should be
> > > used instead of -fpic as well because the EFI stub is not similar to a
> > > shared library in any means.
> > You are right, but I guess that Ard doesn't want to squash the efistub
> > change into the LoongArch efistub support patch. :)
> >
>
> I don't mind changing the stable tag at this point - I don't have
> anything queued up on top of it at the moment.
>
> But I don't see the actual patch: please send me the delta patch that
> you want to apply, and I will update it. Then, you can rebase your
> v6.1 tree on top of it.
OK, Ruoyao, please send a patch to change the efistub cflags. Thank you.

Huacai
