Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C14652C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbhLAQfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:35:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52774 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhLAQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:35:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B1B5CE1F9C;
        Wed,  1 Dec 2021 16:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F197C53FCC;
        Wed,  1 Dec 2021 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638376310;
        bh=Nl8xsA63Pl3JE4OwnDZ/uydP5Lv+ULSoJu3HOWozOuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hnDZwCUUVaAyCAlb/7R8LygL3rozgv27yOHEsIhcb/+RH/cznUJ4kZdxahpkxKFsk
         4O2POZHg9xSlhA4RsePcl3wcqrRLfUErENZUjr7g0Btl/S+AIqOYdsPZ7mQVHmT9Ca
         lKgdsyPFCHsPXoDevsfqbEa+smKKfoc1YtJm/7WM3XEptTUmEgcuccCTXIXdTF+ODb
         Ei/f56ejxc7dt/FBmDPILjaoCjdSzvhz0zN2GvApqFV+qNauAtt+60XOfcdi2idfj3
         fYFaug4bgTQ5hOR38bNXjy5LhcAKm0fAX2Q9TMMhU9jYZgTu3l4rjbDL0dwK9Ai8T0
         iNTZysG/XHHEQ==
Received: by mail-ed1-f45.google.com with SMTP id t5so104504051edd.0;
        Wed, 01 Dec 2021 08:31:50 -0800 (PST)
X-Gm-Message-State: AOAM530WDS4UGocReVmplloY/E4ViaqMmksQjGh0LVGgA3JSM0L6VsCt
        FmUmzy8RNuhAqaB0PaZ960dsJySH4BgAfnOONQ==
X-Google-Smtp-Source: ABdhPJxs7mmflqrjPUTnrKBdlpa9sZ//JWvcOO4xlGckVQ14oEjFAFvEgThWSczrpUb+3WW96Ge7GzChNdODP7NIr4I=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr8303951ejc.390.1638376305005;
 Wed, 01 Dec 2021 08:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20211123134425.3875656-1-michael@walle.cc> <YaZ5JNCFeKcdIfu8@robh.at.kernel.org>
 <bc05fb3483cef4869ae390096bb95985@walle.cc>
In-Reply-To: <bc05fb3483cef4869ae390096bb95985@walle.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 10:31:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL55mZJ6jUyQACer2pKMNDV08-FgwBREsJVgitnuF18Cg@mail.gmail.com>
Message-ID: <CAL_JsqL55mZJ6jUyQACer2pKMNDV08-FgwBREsJVgitnuF18Cg@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 8:30 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Rob,
>
> Am 2021-11-30 20:19, schrieb Rob Herring:
> > On Tue, Nov 23, 2021 at 02:44:25PM +0100, Michael Walle wrote:
> ..
>
> >> Introduce a transformation property. This is intended to be just an
> >> enumeration of operations. If there will be a new operation, support
> >> for
> >> it has to be added to the nvmem core.
> >>
> >> A transformation might have multiple output values, like in the base
> >> mac
> >> address case. It reads the mac address from the nvmem storage and
> >> generates multiple individual addresses, i.e. on our board we reserve
> >> 8
> >> consecutive addresses. These addresses then can be assigned to
> >> different
> >> network interfaces. To make it possible to reference different values
> >> we
> >> need to introduce an argument to the phandle. This additional argument
> >> is then an index into a list of values.
> >
> > I still don't think trying to encode transformations of data into the
> > DT
> > is right approach.
> >
> >>
> >> Example:
> >>   mac_addresses: base-mac-address@10 {
> >>     #nvmem-cell-cells = <1>;
> >>     reg = <10 6>;
> >>     transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
> >>   }
> >>
> >>   &eth0 {
> >>     nvmem-cells = <&mac_addresses 0>;
> >>     nvmem-cell-names = "mac-address";
> >>   };
> >>
> >>   &eth1 {
> >>     nvmem-cells = <&mac_addresses 2>;
> >>     nvmem-cell-names = "mac-address";
> >>   };
> >>
> >> The NVMEM_T_ETH_OFFSET transformation takes N additional (dt) cells
> >> and
> >> will generate N values. In this example BASE_MAC+0, BASE_MAC+1,
> >> BASE_MAC+7.
> >> An nvmem consumer can then reference the nvmem cell with an index. So
> >> eth0
> >> will get BASE_MAC+0 and eth1 will get BASE_MAC+7.
> >>
> >> This should be sufficient flexible for many different transformations
> >> without having to touch the bindings except for adding documentation
> >> and
> >> checks for new transformations.
> >
> > The content and number of cells is supposed to be opaque to the client
> > and interpreted by the provider. That's sort of true here, but not
> > really because the interpretation is tied to 'transformation'. So I'm
> > okay with adding cells, but not fixing the interpretation of them. A
> > compatible should determine how the cells are interpreted.
>
> What do you mean by "adding cells"? The additional argument to the
> phandle?

Yes.

>
> So an example would be:
>
> ethernet_base_mac: base-mac-address@100 {
>      #nvmem-cell-cells = <1>;
>      compatible = "nvmem-ethernet-address";
>      reg = <0x100 0x6>;
> };
>
> &eth0 {
>      nvmem-cells = <&ethernet_base_mac 0>;
>      nvmem-cell-names = "mac-address";
> };
>
> &eth1 {
>      nvmem-cells = <&ethernet_base_mac 7>;
>      nvmem-cell-names = "mac-address";
> };
>
> Right? Any suggestions for a better compatible name?

I think the compatible should be something platform specific (or
specific to whatever entity defined the format (SoC vendor, OEM, s/w
platform (e.g. OpenWRT, u-boot, etc.)) and perhaps up a level defining
the whole nvmem region. Then the handler for that compatible can
select whatever 'generic' mac address transformation it wants or
implement its own custom one. IOW, specific compatibles can use
generic implementations rather than generic compatibles using a
generic implementation.

Rob
