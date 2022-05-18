Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C679C52C010
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiERQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiERQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:54:25 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DC201339;
        Wed, 18 May 2022 09:54:24 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id q73-20020a4a334c000000b0035eb110dd0dso516595ooq.10;
        Wed, 18 May 2022 09:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtkWw6fSMloB5/PDUQGj9Fdz71VUuBNVm04fOD0zRWU=;
        b=xe+cpXTDIB/gVIQhZlok/rYgQg8PjyTp/BewG14AMf1EoVX+t3dL2fBC9MfNeKqYm/
         lZItObf+r686lf4JSbKQhTtlY+Y4Cc2YbU2VEI2wiy2OB5Luf4GzpKsE2kziUx1mjSU3
         5bvBDe/OXTQLAiKlHn9nQ+oNZvgFFoMVSK3ASPq/JUETfue6NsFBsjz5mkEy4OzYpkAg
         T21JK+sttSTAVxHSmyBl6Luc8upg6IQwOUbqk5W+/QA8yEnpSdroYeNH4TK9xXgK9+bH
         5h8+kCFl8WYzqJ6NrtsKotnMYmmXQO24Wd281UIXG2imS78b5IfIaJSwZihPjGjbk6XP
         J5uA==
X-Gm-Message-State: AOAM533WFvZpcci9S4nrEvwEMpIwY2OKFuS5HP7X5MnCLB30newKYJBh
        WOWA2V2lDCWkcfDmc07aig==
X-Google-Smtp-Source: ABdhPJywLKeAaJqcZXkFmnZxmhvPb8KJmZF/4AP/8kXOBXaQ9XEpghDsect82HnXuwtczswZegMMkQ==
X-Received: by 2002:a4a:a50d:0:b0:35e:d7d1:c7dc with SMTP id v13-20020a4aa50d000000b0035ed7d1c7dcmr252191ook.27.1652892863324;
        Wed, 18 May 2022 09:54:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o82-20020aca4155000000b00326e2284976sm950613oia.15.2022.05.18.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 09:54:22 -0700 (PDT)
Received: (nullmailer pid 3489723 invoked by uid 1000);
        Wed, 18 May 2022 16:54:21 -0000
Date:   Wed, 18 May 2022 11:54:21 -0500
From:   Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH] of/fdt: Ignore disabled memory nodes
Message-ID: <20220518165421.GF3302100-robh@kernel.org>
References: <20220517101410.3493781-1-andre.przywara@arm.com>
 <20220517153444.GA1057027-robh@kernel.org>
 <CAFEAcA8sE8Rj0GmF71ox4BdDr0UcaS4QwiLUVUUFH5oj+hDhfA@mail.gmail.com>
 <CAL_JsqLRvEn2E7cpTzQJRCJ=aeLjUtKhDimWat=nPtm3QP+cfA@mail.gmail.com>
 <CAFEAcA_DRoJmnFdyEEcSvCxtPYignZFqQFnHyWkcpyijCBSrCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_DRoJmnFdyEEcSvCxtPYignZFqQFnHyWkcpyijCBSrCg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:19:47PM +0100, Peter Maydell wrote:
> On Tue, 17 May 2022 at 18:48, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 17, 2022 at 11:54 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 17 May 2022 at 16:34, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Tue, May 17, 2022 at 11:14:10AM +0100, Andre Przywara wrote:
> > > > > When we boot a machine using a devicetree, the generic DT code goes
> > > > > through all nodes with a 'device_type = "memory"' property, and collects
> > > > > all memory banks mentioned there. However it does not check for the
> > > > > status property, so any nodes which are explicitly "disabled" will still
> > > > > be added as a memblock.
> > > > > This ends up badly for QEMU, when booting with secure firmware on
> > > > > arm/arm64 machines, because QEMU adds a node describing secure-only
> > > > > memory:
> > > > > ===================
> > > > >       secram@e000000 {
> > > >
> > > > BTW, 'memory' is the correct node name.
> > >
> > > We already have a 'memory' node, which is for the NS
> > > memory. This one's for the secure-only RAM block,
> > > which is why I gave it a name that hopefully helps in
> > > spotting that when a human is reading the DT.
> >
> > You can do: secram: memory@e000000 {
> >
> > Where 'secram' is only a source level label until overlays come into
> > the picture.
> 
> We generate the DTB with libfdt, so source-only information
> isn't something we can put in, I think. (The quoted DT fragment
> in this patch's commit message is the result of decompiling
> the runtime generated DT binary blob with dtc.)

Given the runtime aspect with overlays, it's conceivable that libfdt 
could support setting labels some day and then dts output maintaining 
them.

We could also consider a standard node name such as 'secure-memory'. 
It's a whole can of worms though on how secure vs. non-secure memory 
(and other things) are represented.

> > > I'm not really sure to what extent node names in device trees are
> > > "this is just an identifying textual label" and to what extent
> > > they are "this is really ABI and you need to follow the standard",
> > > though -- nothing in practice seems to care what they are,
> > > suggesting the "textual label" theory, but some bits of tooling
> > > complain if you do things like forget the address value or use the
> > > same address for two different nodes, suggesting the "really ABI"
> > > theory.
> >
> > Node names are supposed to follow the class of device and there's a
> > list of established names in the spec.
> >
> > Sometimes it's ABI and sometimes not. Much of it is just good hygiene.
> > memory nodes are also special because 'device_type' is used to
> > identify them, but device_type is generally deprecated for FDT as its
> > meaning in OpenFirmware doesn't apply (it defines what callable
> > methods exist). We could use the nodename (without unit address)
> > instead, but that would fail in some cases as other names have been
> > used.
> 
> This seems kind of odd to me as a design, compared to

Design? I wish. Evolution.

> "have the node have a property that says what it is
> and let the name of the node just be, well, its name"
> (especially since 'device_type' and 'compatible' look an
> awful lot like "this is the property that tells you what this
> node actually is".)
> Are we just stuck with what we have for historical reasons ?

Yes. If we were designing this, we'd probably have 'compatible = 
"memory"'. We're likely just stuck with things how they are. Mostly node 
names haven't been an ABI and we're just trying to be consistent in 
naming and use of unit-addresses.

Rob
