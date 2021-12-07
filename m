Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B620F46AF97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbhLGBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:20:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54296 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhLGBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:20:30 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 82D4220E6F2E;
        Mon,  6 Dec 2021 17:17:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82D4220E6F2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638839820;
        bh=CYPxi5vIPfuggRjKKykNGEaoJ39IkkwcoXKxCFCxujU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUDXryCdm5Imi8FO/ImHtP5FJxlELi5oJtpagC5+skj4p72uKXH4gvqNlBvh7rR9G
         Pod6STqt5+d+w8h66MYZzOl7W6Tbnp6IyK+bMp7fZjkklI1rhEYzwnKyVkkNcykMCo
         fDrjMkIJq5gmohUhB22u2DZ5hdTip3h0gac1SD14=
Date:   Mon, 6 Dec 2021 17:16:59 -0800
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: sm8350: fix tlmm base address
Message-ID: <20211207011659.GA26711@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20211122190552.74073-1-kaperez@linux.microsoft.com>
 <20211122190552.74073-3-kaperez@linux.microsoft.com>
 <YZxoGp33Seaa2WEG@matsya>
 <Yabo0fGXC1rITmsM@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yabo0fGXC1rITmsM@builder.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:15:29PM -0600, Bjorn Andersson wrote:
> On Mon 22 Nov 22:03 CST 2021, Vinod Koul wrote:
> 
> > On 22-11-21, 11:05, Katherine Perez wrote:
> > > TLMM controller base address is incorrect and will hang on some platforms.
> > > Fix by giving the correct address.
> > 
> > Thanks, recheck the spec this looks correct. We should have tlmm reg
> > space here and not tlmm base which also contains xpu region (thus hang)
> > 
> 
> Aren't you reading the patch backwards?
> 
> Afaict downstream the driver carries an offset of 0x100000, which we
> dropped as we upstreamed the driver. As such changing reg to 0x0f000000
> should cause most gpio register accesses to fall outside the actual
> register window.
> 
> Or perhaps I'm missing something here?
> 
> Regards,
> Bjorn

Hi Vinod,

Gentle reminder about the response above. Without the change to the TLMM
base address, my platform hangs. I have ensured that the pinctrl driver
contains the patch that Bjorn has previously submitted here:
https://lore.kernel.org/all/20211104170835.1993686-1-bjorn.andersson@linaro.org/

Best,
Katherine

> 
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > Fixes: b7e8f433a673 ("arm64: dts: qcom: Add basic devicetree support for SM8350 SoC")
> > 
> > > 
> > > Signed-off-by: Katherine Perez <kaperez@linux.microsoft.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > > index d134280e2939..624d294612d8 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > > @@ -960,9 +960,9 @@ spmi_bus: spmi@c440000 {
> > >  			#interrupt-cells = <4>;
> > >  		};
> > >  
> > > -		tlmm: pinctrl@f100000 {
> > > +		tlmm: pinctrl@f000000 {
> > >  			compatible = "qcom,sm8350-tlmm";
> > > -			reg = <0 0x0f100000 0 0x300000>;
> > > +			reg = <0 0x0f000000 0 0x300000>;
> > >  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> > >  			gpio-controller;
> > >  			#gpio-cells = <2>;
> > > -- 
> > > 2.31.1
> > 
> > -- 
> > ~Vinod
