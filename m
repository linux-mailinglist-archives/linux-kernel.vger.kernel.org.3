Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875945ADF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIFF5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIFF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:57:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D080659CA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A808DB81627
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBE9C433D6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662443863;
        bh=hQca5NtX2FBlPGk+GSQpzGG+VRJ3Z904jrv6Nzdt/3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SFtooTkiyMSeuxJ7f1gN9skE0ZcbsMoAdEObqRVlAgE+qqRi8+Y7L0MkEdLz7yImw
         DPpisMT4vQUEgLG3x7UMXLspTdF07jST7y2Q+YdRl9WmK5tEa/MtkH+ta9IKcA4Ufg
         W+UdliA3eRypOxqgRsfxVSUhgjl5jLmVXNw6fsptfMbgUdYS/p484p7gwivWNQn9dX
         RYqjSNNEQ89o6JQ9w06jSUhUHv7qwIca/JJAz4mSaUZGC4tN31EJrFuZXf/NTADuCT
         muNViFtcn93xCWQ86S9Ixuzo0nofaDg1rWHwkY8GBuIK+dMHWHYflVChAbqxlf6Vih
         3N5uKlAFWLm1g==
Received: by mail-ua1-f42.google.com with SMTP id e3so3973535uax.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:57:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo3KR+7AY5h8oLZzXeMa4YMRPh1jFDgCfBeZTCkPzezMoYs5PZI4
        nvBu/+UUncaL5gSE2F50Huc2eW4egXSVuCUHQek=
X-Google-Smtp-Source: AA6agR7Qo1zXs+K6mR1O8A31AAZ4nJZysXhwJLbVHgukToP4OsQw3zKXMyPs74Vq8WWlLFPb/sc7svi8F6oSnwLSXzI=
X-Received: by 2002:ab0:d82:0:b0:39e:db4c:c80c with SMTP id
 i2-20020ab00d82000000b0039edb4cc80cmr15008458uak.22.1662443862305; Mon, 05
 Sep 2022 22:57:42 -0700 (PDT)
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
 <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com> <6a3e185eaaac4a1397abe43026004548d47ee305.camel@xry111.site>
In-Reply-To: <6a3e185eaaac4a1397abe43026004548d47ee305.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Sep 2022 13:57:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7wpyxeSDtBhxwRSJ+cenFkSRkvCLvajCXh6jwBB7JaQQ@mail.gmail.com>
Message-ID: <CAAhV-H7wpyxeSDtBhxwRSJ+cenFkSRkvCLvajCXh6jwBB7JaQQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>,
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

Hi, Ruoyao,

On Tue, Sep 6, 2022 at 1:01 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Tue, 2022-09-06 at 12:43 +0800, Huacai Chen wrote:
> > > Note that -fpic/-fPIC is "position-independent code *suitable for
> > > use in a shared library*", while -fpie/-fPIE is more like just
> > > "position-independent code".  The names of those options are confusing.
> > > (When -fpic was invented first time, people mostly believed "PIC had
> > > been only for shared libraries", so it's named -fpic instead of -shlib
> > > or something.)  IMO in the EFI stub for other ports, -fpie should be
> > > used instead of -fpic as well because the EFI stub is not similar to a
> > > shared library in any means.
>
> > You are right, but I guess that Ard doesn't want to squash the efistub
> > change into the LoongArch efistub support patch. :)
>
> It only changes cflags-$(CONFIG_LOONGARCH), which is LoongArch specific.
> And arm64 is also using -fpie.
>
> Should I send the one-line EFI stub change to linux-efi first?
I know that should be changed. I just don't like the one-line patch
and hope it can be squashed to the original patch. Of course Ard is
free to decide how to handle it.

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
