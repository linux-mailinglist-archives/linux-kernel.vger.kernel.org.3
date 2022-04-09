Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B04FA74F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbiDILiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiDILiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:38:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8963CFF4;
        Sat,  9 Apr 2022 04:36:00 -0700 (PDT)
Received: from p508fd313.dip0.t-ipconnect.de ([80.143.211.19] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nd9Nh-00011A-Gp; Sat, 09 Apr 2022 13:35:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aw: Re: Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Date:   Sat, 09 Apr 2022 13:35:52 +0200
Message-ID: <4232341.5fSG56mABF@phil>
In-Reply-To: <CAMdYzYqaGe9_GbRCvG3kvLpNsVfVqGNkg=YYgbVR90Qtcs9YSA@mail.gmail.com>
References: <20220409075147.136187-1-linux@fw-web.de> <CAMdYzYqx1iUuEe9FPpUTgL0L2i=Q5Sq2+0oiSYzqkV6noQ8BFw@mail.gmail.com> <CAMdYzYqaGe9_GbRCvG3kvLpNsVfVqGNkg=YYgbVR90Qtcs9YSA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. April 2022, 13:30:44 CEST schrieb Peter Geis:
> On Sat, Apr 9, 2022 at 7:14 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Sat, Apr 9, 2022 at 7:01 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > Am Samstag, 9. April 2022, 12:57:39 CEST schrieb Frank Wunderlich:
> > > > Hi
> > > > > Gesendet: Samstag, 09. April 2022 um 12:40 Uhr
> > > > > Von: "Dan Johansen" <strit@manjaro.org>
> > > >
> > > > > So the issue is only with usb 3 ports, not usb 2 ports?
> > > >
> > > > my board has no standalone usb2-ports. usb2 is integrated into the usb3 ports (dual phy). here both were not working.
> > > >
> > > > afaik rk3566 has standalone usb2 ports that may not be broken, but i have no such board for testing.
> >
> > Good Morning,
> >
> > >
> > > As far as I understand the issue now after checking the code, this
> > > patch actually fixes the usb3 series from Peter, right?
> > >
> > > I.e. the usb-nodes that are fixed in this patch are not yet present
> > > in the main rk356x dtsi and only get added in
> > > "arm64: dts: rockchip: add rk356x dwc3 usb3 nodes" [0]
> > >
> > > As we don't want to add broken changes, this fix should squashed
> > > into a next version of the patch adding the nodes.
> >
> > Thank you for reporting this, I will squash this fix in and add your signed-off.
> >
> > However the offending patch is in fact the clock separation patch, and
> > it breaks backwards compatibility with the rk3328 dtsi which is why my
> > series also is broken.
> >
> > The rockchip,dwc3.yaml needs to be fixed to align with the
> > snps,dwc3.yaml, and both the rk3328 and rk3399 clock names updated.
> > Also the offending clock separation patch needs a fix to grab the old
> > clock names for rk3328 backwards compatibility to be retained.
> >
> > This might also be a good time to look into moving rk3399 to the core
> > dwc3 driver?
> >
> > This is a delightful mess.
> 
> In the idea of getting this series to land, if all parties agree, I'll
> submit a patch that fixes the clock separation patch with this series
> and leave the naming as is for now.
> The renaming of clocks and alignment of everything can be addressed in
> a future series once discussion on how best to handle it has happened.
> 
> Do you concur with this?

I'm not sure about that ... i.e. adding known-broken changes
(for the rk356x) feels somewhat wrong to me.

Heiko


