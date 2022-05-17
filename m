Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449652A991
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351602AbiEQRss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:48:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E250062;
        Tue, 17 May 2022 10:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E704B81B3D;
        Tue, 17 May 2022 17:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42A8C34118;
        Tue, 17 May 2022 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652809720;
        bh=mM7kmRtxEsXSLuyxUuHv0ZboSh0tiiMRcwstNFbsFfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rwmjG7N6M9pmFM6sv9uM5k60fZXFmKSJEqEAZL2qV27Dke+ZPfNpoRsUgXEpfbBkZ
         p6nLZvdZt8sN6otbQXIds2h2FSc8F9r5lO/tatI5hryulEoR60yFkZ+xqT9Dc3NkHm
         +2LGKNa2E/ngwE4Zo4zf6WGGOKjA8g19iP4VE4gS7pBWfaMLDbcS0Eh6WeWi2uKbaK
         MKJYfm0UHYXo/P6o+ttI0JjAC9jvwcxLnFNeq1YOM57obP8DDmK6wRt68z4x+kkPYe
         3W1/yFXucBkXrfe6EjWZAbm7oXLSi0+16shE6pGOqj1stBfErgwbrpd7RXmz3HSh67
         txqwuR0q+D9XA==
Received: by mail-ej1-f45.google.com with SMTP id f9so947354ejc.0;
        Tue, 17 May 2022 10:48:40 -0700 (PDT)
X-Gm-Message-State: AOAM530tUggls+wu4yGqi5TAR72ZNLv+iKCJEsX6JhDCk9qYwQR1cGE/
        ltE1t4cmi4eEbwlFLeqxcXhwFQjBxPEE4/0sWA==
X-Google-Smtp-Source: ABdhPJzxvy1jWZewAshPUDKVWL4AiAPe3dQ/qVit9zTnsxZHVyTylHq9WyaWMfwaDU9yHzEz5gFVkxzypkFwDhwX0XE=
X-Received: by 2002:a17:906:a888:b0:6f3:e990:e554 with SMTP id
 ha8-20020a170906a88800b006f3e990e554mr20800497ejb.19.1652809719089; Tue, 17
 May 2022 10:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220517101410.3493781-1-andre.przywara@arm.com>
 <20220517153444.GA1057027-robh@kernel.org> <CAFEAcA8sE8Rj0GmF71ox4BdDr0UcaS4QwiLUVUUFH5oj+hDhfA@mail.gmail.com>
In-Reply-To: <CAFEAcA8sE8Rj0GmF71ox4BdDr0UcaS4QwiLUVUUFH5oj+hDhfA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 17 May 2022 12:47:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLRvEn2E7cpTzQJRCJ=aeLjUtKhDimWat=nPtm3QP+cfA@mail.gmail.com>
Message-ID: <CAL_JsqLRvEn2E7cpTzQJRCJ=aeLjUtKhDimWat=nPtm3QP+cfA@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Ignore disabled memory nodes
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ross Burton <ross.burton@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:54 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 17 May 2022 at 16:34, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 17, 2022 at 11:14:10AM +0100, Andre Przywara wrote:
> > > When we boot a machine using a devicetree, the generic DT code goes
> > > through all nodes with a 'device_type = "memory"' property, and collects
> > > all memory banks mentioned there. However it does not check for the
> > > status property, so any nodes which are explicitly "disabled" will still
> > > be added as a memblock.
> > > This ends up badly for QEMU, when booting with secure firmware on
> > > arm/arm64 machines, because QEMU adds a node describing secure-only
> > > memory:
> > > ===================
> > >       secram@e000000 {
> >
> > BTW, 'memory' is the correct node name.
>
> We already have a 'memory' node, which is for the NS
> memory. This one's for the secure-only RAM block,
> which is why I gave it a name that hopefully helps in
> spotting that when a human is reading the DT.

You can do: secram: memory@e000000 {

Where 'secram' is only a source level label until overlays come into
the picture.

> I'm not really sure to what extent node names in device trees are
> "this is just an identifying textual label" and to what extent
> they are "this is really ABI and you need to follow the standard",
> though -- nothing in practice seems to care what they are,
> suggesting the "textual label" theory, but some bits of tooling
> complain if you do things like forget the address value or use the
> same address for two different nodes, suggesting the "really ABI"
> theory.

Node names are supposed to follow the class of device and there's a
list of established names in the spec.

Sometimes it's ABI and sometimes not. Much of it is just good hygiene.
memory nodes are also special because 'device_type' is used to
identify them, but device_type is generally deprecated for FDT as its
meaning in OpenFirmware doesn't apply (it defines what callable
methods exist). We could use the nodename (without unit address)
instead, but that would fail in some cases as other names have been
used.

Rob
