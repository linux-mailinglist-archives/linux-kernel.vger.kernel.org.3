Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5D49C870
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiAZLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiAZLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:17:35 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64BC06161C;
        Wed, 26 Jan 2022 03:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=h/+jy8zONBbPEtv/A67VifATmxWwSbkDPnarJPgcQS0=; b=73Bzu
        gCJwQRhve2wwkOJRFfsB910Q1T+oS6L/8BpFXtIIj1AQkTxBcl/D0RZYqe6Y+UgbN8mbepUtvTxq8
        j8tI2WJFug3+gBW3G499kTkoLn/fbO/3gLMR5ITONbIfKV8uThHhtHz1Z+JJy4T88eZVd+VnuHqvO
        wkAZE+NfSLlvE4dXWvVPU5s+7HudhIt5srcsZU8ZsjP8u1+MngfYLDE08tFLuFR+9OeoOk8qFuNUW
        0rk/rsN6HzW6HaghRg0pXlRQNhIwyG45qgB7i7I7dNdx5uD5M44B8YJUQji/H9wJOXJP9Db4s+XB8
        5kjey2nPc/Qt5g+QmcGLd0eaPk/zw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nCgIn-0002fy-3t; Wed, 26 Jan 2022 11:17:25 +0000
Date:   Wed, 26 Jan 2022 11:17:19 +0000
From:   John Keeping <john@metanate.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix MMC compatibles for rk3288
Message-ID: <YfEtv+UIT7Y+d2lx@donbot>
References: <20220125115007.3138311-1-john@metanate.com>
 <7e935740-66a3-da07-a196-0584dab310b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e935740-66a3-da07-a196-0584dab310b9@gmail.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Tue, Jan 25, 2022 at 01:14:21PM +0100, Johan Jonker wrote:
> MMC aliases should go in the dts board files.
> Sort on reg address, based on availability and without number gab.
> (For rk3288 a lot of boards to change. That's why it wasn't done
> yet...Could someone pick that up?)

Since there aren't any mmc aliases for rk3288 at the moment, I'll drop
this and send a patch adding them for the one board I have access to.

At some point the nonstandard mshc aliases should be removed, but it
may be best to keep them around for a while given that 5.17 will be the
first kernel that doesn't use these as a weird mechanism for per-port
settings.

> On 1/25/22 12:50, John Keeping wrote:
> > Prior to commit 4bac670aa5cb ("mmc: dw_mmc: rockchip: use common_caps")
> > the mshcN aliases were used in an unusual way by the dw_mmc driver and
> > affected behaviour.  Now that this has been fixed, rename the mmc
> > aliases to use the standard form.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >  arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> > index aaaa61875701..50fa0a4652b5 100644
> > --- a/arch/arm/boot/dts/rk3288.dtsi
> > +++ b/arch/arm/boot/dts/rk3288.dtsi
> > @@ -25,10 +25,10 @@ aliases {
> >  		i2c3 = &i2c3;
> >  		i2c4 = &i2c4;
> >  		i2c5 = &i2c5;
> > -		mshc0 = &emmc;
> > -		mshc1 = &sdmmc;
> > -		mshc2 = &sdio0;
> > -		mshc3 = &sdio1;
> > +		mmc0 = &emmc;
> > +		mmc1 = &sdmmc;
> > +		mmc2 = &sdio0;
> > +		mmc3 = &sdio1;
> >  		serial0 = &uart0;
> >  		serial1 = &uart1;
> >  		serial2 = &uart2;
