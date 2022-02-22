Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2A4C0148
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiBVSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBVSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:30:11 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2304ECC77;
        Tue, 22 Feb 2022 10:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qkGHyX6TNDjlbVB7d5eaKcj0U8aCNFw/rknClXhOZv8=; b=xTFfPj0RkJFnKZXycTQP//C5VS
        asDJJN41cH7rvFQqlz6qkifAEeCznhUK25JyYMzbAeHsPIZL2uu+ZQPQi2pEMAcGeEtXOgcMU0nnj
        xr+Z8js4sZRnCZBO9YdTwvC6myKOWFJxJ2A+1dTEQ3RUQ+xuWGofvErOUyGsN6GVo1HAVcHw0oIJT
        QDuGtC2iEvIrcBRgSeu2g8vW78Ru1E4/vs7LU9jpN7wFvDU08YRi4B6ubCmFzD868DeUUVXGPh+0B
        d+twOtE/0ypxjLTKrncN3Vpza6/O6pTsvInbQng5tO+RHa1ZiG2LirEoGUY+zrg1aT5tt5e59tmbh
        uCd6wjGA==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nMZuv-00CNdU-75; Tue, 22 Feb 2022 18:29:41 +0000
Date:   Tue, 22 Feb 2022 18:29:41 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] ARM: dts: qcom: remove redundant binding from
 ipq8064 rb3011 dts
Message-ID: <YhUrlY022B1cbwqu@earth.li>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-17-ansuelsmth@gmail.com>
 <Yg+pL44ogVscn9Kw@earth.li>
 <YhJT5gD2TuwucnQX@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhJT5gD2TuwucnQX@Ansuel-xps.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 03:44:54PM +0100, Ansuel Smith wrote:
> On Fri, Feb 18, 2022 at 02:11:59PM +0000, Jonathan McDowell wrote:
> > On Fri, Feb 18, 2022 at 01:29:54AM +0100, Ansuel Smith wrote:
> > > Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
> > > default.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
> > >  1 file changed, 17 deletions(-)
...
> > > -	mdio0_pins: mdio0_pins {
> > > -		mux {
> > > -			pins = "gpio0", "gpio1";
> > > -			function = "gpio";
> > > -			drive-strength = <8>;
> > > -			bias-disable;
> > > -		};
> > > -	};
> > > -
> > 
> > This sets the pins to "gpio". Your earlier patch sets them to "mdio", so
> > removing this will break MDIO0 on the RB3011. It's likely that your
> > fixes for MDIO/QCA8K mean that the RB3011 can be switch to use the MDIO
> > driver rather than mdio-gpio, but that will need tested and this change
> > alone will definitely break things.
> > 
> I could be wrong but I remember that before the mdio driver we used the
> mdio-gpio driver with the pins set to mdio function without problems.

It seems like that's the case; I've just tried it out and switch0 seems
to be working fine.

J.

-- 
Revd Jonathan McDowell, ULC | Purrrrrrr.
