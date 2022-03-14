Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95374D8564
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiCNMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbiCNMsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:48:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909DE084;
        Mon, 14 Mar 2022 05:46:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dr20so33281489ejc.6;
        Mon, 14 Mar 2022 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AfEfhobctAMGnNXoz9DFMeE1Ezn5+I06/IwgfEiFWno=;
        b=NaViX/Ob7EurjojWFVkHCuVX5/dyO3EnUFQ8RfPzSUgNxDNUBgF7cCtrIr+DDwJ7ms
         KSJFtMOMjj0vCxvc23rmNzyQO5bzAwO/zG64GgfcCFZMrAm9jGERgMocY4x9XvQjZskh
         yGn2L2k+mxg6yxLVvRC21Nk+nEN2xfZ7gS3VMFlHS+FSBz9y0k179x0luSQ+RPhBTaKF
         IbR7Rn1rAJlbsruiXG9LhDEqT4xf2wrW0QF0jzr8gnf5r8f3O1eIhrxxZT1AgigVfbgI
         mZFv4UZ2zwE6p8NjNsO4HHoTOMTT+cbnrIM0WR4sjA+Y5gpuUwUHIvvNhrk1mAaRn1S6
         ZWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AfEfhobctAMGnNXoz9DFMeE1Ezn5+I06/IwgfEiFWno=;
        b=jk0IrdbSlxlXk3zIvYJ7+KwMh6NTByyR4F/LTWOL0GKLX2cNkccCkmfwavOpQGzlya
         PeDBJ+7RedilrF7sH3k+xhtvgpeuscgOKyFiA4LoiowDBQjz2XOn6GugZA+e0j5hhTNN
         pWiJ9Uiz/OjdeJr+x2FczId9FnSTEWpS5/Opm1ezBEHY/6/eNYyoxaEY4BEonxj+5rro
         nirhIzflCxX7me1a9yLyVPBIagvJCmv99zPlnpU7iSkWjBX74S7zjP9ArRAXNY+Fl7Ao
         Pu3X4x9bMdKgzNKErPK5hDUXuPLpAqytj3uxfllylY6XSNvxsDJvc267VR2M4AL1g9/K
         /F5w==
X-Gm-Message-State: AOAM532RINSz3IDWHjXlSUsGqn7WxmDEv0xDxYAU1kFoa6N2S240ii/r
        u2Qh8M74qnRi9bwGhlq4hr8=
X-Google-Smtp-Source: ABdhPJwQGEMNdKZIXZb8s4Ify5Z34Z/odEvJCAh4X2AaHEDVr1X24opAoevxRgsgAviJFEl3gvNV3Q==
X-Received: by 2002:a17:907:1c0b:b0:6db:b756:4267 with SMTP id nc11-20020a1709071c0b00b006dbb7564267mr9181812ejc.147.1647261963250;
        Mon, 14 Mar 2022 05:46:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm6759106ejb.182.2022.03.14.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 05:46:02 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:46:01 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/15] ARM: dts: qcom: add syscon and cxo/pxo clock to
 gcc node for ipq8064
Message-ID: <Yi85CWQdY08GLxzp@Ansuel-xps.localdomain>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
 <20220226135235.10051-16-ansuelsmth@gmail.com>
 <Yi8SrZkjYdU3W8aj@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi8SrZkjYdU3W8aj@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:02:21AM +0000, Jonathan McDowell wrote:
> AFAICT the rest of the series has been picked up in clk-for-5.18, but I
> don't see this there or in dts-for-5.18. It's required for a
> functioning tsens driver on IPQ8064 so it would be nice to see it landed.
>

I think we just have to wait, they said that it was expected a delay
between the clk and the dts merge. (one of the reason I couldn't drop
the pxo/cxo fixed clock)

> On Sat, Feb 26, 2022 at 02:52:35PM +0100, Ansuel Smith wrote:
> > Add syscon compatible required for tsens driver to correctly probe driver
> > and access the reg. Also add cxo and pxo tag and declare them as gcc clock
> > now requires them for the ipq8064 gcc driver that has now been modernized.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 11481313bdb6..5524a68cf3d1 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -298,13 +298,13 @@ smem: smem@41000000 {
> >  	};
> >  
> >  	clocks {
> > -		cxo_board {
> > +		cxo_board: cxo_board {
> >  			compatible = "fixed-clock";
> >  			#clock-cells = <0>;
> >  			clock-frequency = <25000000>;
> >  		};
> >  
> > -		pxo_board {
> > +		pxo_board: pxo_board {
> >  			compatible = "fixed-clock";
> >  			#clock-cells = <0>;
> >  			clock-frequency = <25000000>;
> > @@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
> >  		};
> >  
> >  		gcc: clock-controller@900000 {
> > -			compatible = "qcom,gcc-ipq8064";
> > +			compatible = "qcom,gcc-ipq8064", "syscon";
> > +			clocks = <&pxo_board>, <&cxo_board>;
> > +			clock-names = "pxo", "cxo";
> >  			reg = <0x00900000 0x4000>;
> >  			#clock-cells = <1>;
> >  			#reset-cells = <1>;
> > -- 
> > 2.34.1
> > 
> 
> J.
> 
> -- 
>     I program, therefore I am.     |  .''`.  Debian GNU/Linux Developer
>                                    | : :' :  Happy to accept PGP signed
>                                    | `. `'   or encrypted mail - RSA
>                                    |   `-    key on the keyservers.

-- 
	Ansuel
