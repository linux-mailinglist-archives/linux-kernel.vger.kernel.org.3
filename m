Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B94C01AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiBVSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiBVSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:21 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F11160CE;
        Tue, 22 Feb 2022 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qpS9nGyFPO790yWv4rcOp/sHSPx2uX3RHvqYO9OH0vU=; b=SUDzqoUJBTmv3cNN9LvobX2bAe
        pXwV7+if7oaCtrdEsVPFwRnNiNUpTguFJh94HOEVUCbgK6YfFN3mFuVPg+/MOy0MZJ86ZOUzJLpyv
        GCVEBtCwTWvlkICsYCEhE9Gh0ZgjZVSogEbrrfH6U77F2DW6wrnoGv0nARapvtPkwnLuIv0F/K+Nw
        PzisRB+VREHjMApdfHFXv17DiUztRR60MMs2DTgzwNStUfNvkJN1ms52UQCCBpqeMWDZEG18KHXCC
        JA5UODqjPAfeEmiB+RBl0+bn6P+ez4kvofVzf+SkArM4A72X4P0fmKJznWYOyjhChZi2LinvOHvkd
        nGmcwLGQ==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nMaII-00COUO-NI; Tue, 22 Feb 2022 18:53:50 +0000
Date:   Tue, 22 Feb 2022 18:53:50 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/18] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
Message-ID: <YhUxPigWzLOffcZM@earth.li>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218002956.6590-5-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:29:42AM +0100, Ansuel Smith wrote:
> Mikrotik RB3011 have a special configuration where the regulators are
> not the common smb208 controlled by RPM but they use a TPS563900
> controlled via i2c. Disable the smb208 for this specific device.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> index 596d129d4a95..0982b6214fb7 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> @@ -216,6 +216,10 @@ led@7 {
>  	};
>  };
>  
> +&smb208_regulators {
> +	status = "disabled";
> +}

Missing ; after the }, but with that:

Reviewed-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Jonathan McDowell <noodles@earth.li>

> +
>  &adm_dma {
>  	status = "okay";
>  };
> -- 
> 2.34.1
> 

J.

-- 
/-\                             |  Design a system any fool can use,
|@/  Debian GNU/Linux Developer |  and only a fool will want to use
\-                              |                 it.
