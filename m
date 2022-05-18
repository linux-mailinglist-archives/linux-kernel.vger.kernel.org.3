Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3D52C4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbiERUq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiERUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3815AB30;
        Wed, 18 May 2022 13:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C902F61A2D;
        Wed, 18 May 2022 20:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E23C34115;
        Wed, 18 May 2022 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652906815;
        bh=wxBHX72sHl+LEUlCxgMe6qdSdNWO4yWjzaf8BXQa58w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SwMVC5PK9op5GgVoA7nvGZ9qVDqF+kJPD369O70gwrGGpJZwm6bUZwjt37KfBRfOx
         v2HNpNI4F7I1EuskoPhlwV0gFBwvAWXIAlWDoVkBqcuQdC4J4iq2CNujo1K4Y7Z3zw
         82KntzB9E8o+4P6vLhDkfZdWtfJxLWrLfFc9oVMRdIJPTrspMdmZf0JDEzvUcKQ2ZA
         +YtWwVXGfG48rIFCuWFI/BvqJDU9rsxXrrOKSgqAFxO8wG6hu02Ou16vvrGtP9hikV
         s1x+5/4cRA081Ln+Xf3mC36LRIzLUPhzNPgi7BxL7YK4svN52JT/7XOqnCnlbkcXLv
         JJiSmZn7czQXg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f189b07f57so4314543fac.1;
        Wed, 18 May 2022 13:46:55 -0700 (PDT)
X-Gm-Message-State: AOAM531HupqGY2XpyFku3doqhsptbDjIfFTSzUlpxIaH6n6BLgizG47c
        2MWer0C8ln71+PL2WD0RM8Xk9jDHY7t/39FODz4=
X-Google-Smtp-Source: ABdhPJz2MYP+He80fkGa5Pjiu8XRsth/Yff4J4ZSPDZpZ55pGzX2uFy2pYwk6SLJOp71WzV/bU0wb1D2q2f7Dl3ipaA=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1230174oap.228.1652906814349; Wed, 18
 May 2022 13:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220517101410.3493781-1-andre.przywara@arm.com>
 <20220517153444.GA1057027-robh@kernel.org> <CAFEAcA8sE8Rj0GmF71ox4BdDr0UcaS4QwiLUVUUFH5oj+hDhfA@mail.gmail.com>
 <CAL_JsqLRvEn2E7cpTzQJRCJ=aeLjUtKhDimWat=nPtm3QP+cfA@mail.gmail.com>
 <CAFEAcA_DRoJmnFdyEEcSvCxtPYignZFqQFnHyWkcpyijCBSrCg@mail.gmail.com>
 <20220518165421.GF3302100-robh@kernel.org> <CAFEAcA80B2aGdaxK2pm7AK84KK_UqwD-KCMKtK6b8fF41MeKRg@mail.gmail.com>
In-Reply-To: <CAFEAcA80B2aGdaxK2pm7AK84KK_UqwD-KCMKtK6b8fF41MeKRg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 May 2022 22:46:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFgyg7CFNoPomeucN4BCCo-PMO8w8smjmxFWKRvOY0ePg@mail.gmail.com>
Message-ID: <CAMj1kXFgyg7CFNoPomeucN4BCCo-PMO8w8smjmxFWKRvOY0ePg@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Ignore disabled memory nodes
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ross Burton <ross.burton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 19:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 18 May 2022 at 17:54, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 17, 2022 at 08:19:47PM +0100, Peter Maydell wrote:
> > > We generate the DTB with libfdt, so source-only information
> > > isn't something we can put in, I think. (The quoted DT fragment
> > > in this patch's commit message is the result of decompiling
> > > the runtime generated DT binary blob with dtc.)
> >
> > Given the runtime aspect with overlays, it's conceivable that libfdt
> > could support setting labels some day and then dts output maintaining
> > them.
> >
> > We could also consider a standard node name such as 'secure-memory'.
> > It's a whole can of worms though on how secure vs. non-secure memory
> > (and other things) are represented.
>
> Mmm. We put in the very basic parts years ago in
> Documentation/devicetree/bindings/arm/secure.txt
> which is (and has remained) generally sufficient for the QEMU->Trusted
> Firmware-> maybe uboot->Linux stack, which is pretty much the only use
> case I think. (My intention when we wrote that up was that memory
> that's S-only would be indicated the same way as S-only devices,
> with the secure-status and status properties.)
>
> > > Are we just stuck with what we have for historical reasons ?
> >
> > Yes. If we were designing this, we'd probably have 'compatible =
> > "memory"'. We're likely just stuck with things how they are. Mostly node
> > names haven't been an ABI and we're just trying to be consistent in
> > naming and use of unit-addresses.
>
> So, do you think it's worthwhile/a good idea for me to rename
> the DT node that QEMU is currently calling "secmem" to be
> "memory" ? My default is "leave it as it is", for economy of
> effort reasons :-) -- but it's an easy enough change to make.
> Though EDK2's dtb reading code just looks for the first
> "memory" node and assumes it's the big one, so changing the node
> name would make us reliant on the order of the two nodes in the
> DTB unless we fixed EDK2 (which we should probably do anyway, tbh).
>

Agreed. The referenced code is only one of two implementations (one
for the firmware version that executes in place from NOR flash, and
one for the version that executes from DRAM), which don't follow the
same strategy (the other one enumerates all device_type="memory" nodes
in the tree, and picks the one with the lowest starting address, but
also ignores status properties or node names). The PrePi version
linked here should simply choose the node that covers its own image in
memory. The XIP version uses a stack in DRAM, so it could do something
similar.
