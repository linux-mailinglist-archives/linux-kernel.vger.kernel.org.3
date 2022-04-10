Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFF4FAEDD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiDJQ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243575AbiDJQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:26:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869FDB77;
        Sun, 10 Apr 2022 09:24:08 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndaLz-0006WK-1f; Sun, 10 Apr 2022 18:23:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: fix backwards compat with rockchip devices
Date:   Sun, 10 Apr 2022 18:23:54 +0200
Message-ID: <12992587.uLZWGnKmhe@phil>
In-Reply-To: <20220409152116.3834354-1-pgwipeout@gmail.com>
References: <20220409152116.3834354-1-pgwipeout@gmail.com>
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

Am Samstag, 9. April 2022, 17:21:15 CEST schrieb Peter Geis:
> Commit 33fb697ec7e5 ("usb: dwc3: Get clocks individually") moved from
> the clk_bulk api to individual clocks, following the snps,dwc3.yaml
> dt-binding for clock names.
> Unfortunately the rk3328 (and upcoming rk356x support) use the
> rockchip,dwc3.yaml which has different clock names, which are common on
> devices using the glue layer.
> The rk3328 does not use a glue layer, but attaches directly to the dwc3
> core driver.
> The offending patch series failed to account for this, thus dwc3 was
> broken on rk3328.
> 
> To retain backwards compatibility with rk3328 device trees we must also
> check for the alternate clock names.
> 
> Fixes: 33fb697ec7e5 ("usb: dwc3: Get clocks individually")
> 
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> This patch is standalone to fix the backwards compatibility, and is
> necessary no matter if we decide to retain the clock names in
> rockchip,dwc3.yaml as is or align with snps,dwc3.yaml.
> 
>  drivers/usb/dwc3/core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1170b800acdc..5bfd3e88af35 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1690,21 +1690,44 @@ static int dwc3_probe(struct platform_device *pdev)
>  		/*
>  		 * Clocks are optional, but new DT platforms should support all
>  		 * clocks as required by the DT-binding.
> +		 * Some devices have different clock names in legacy device trees,
> +		 * check for them to retain backwards compatibility.
>  		 */
>  		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
>  		if (IS_ERR(dwc->bus_clk))
>  			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
>  					     "could not get bus clock\n");
>  
> +		if (dwc->bus_clk == NULL) {
> +			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
> +			if (IS_ERR(dwc->bus_clk))
> +				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
> +						     "could not get bus clock\n");
> +		}
> +
>  		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
>  		if (IS_ERR(dwc->ref_clk))
>  			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
>  					     "could not get ref clock\n");
>  
> +		if (dwc->ref_clk == NULL) {
> +			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
> +			if (IS_ERR(dwc->ref_clk))
> +				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
> +						     "could not get ref clock\n");
> +		}
> +
>  		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
>  		if (IS_ERR(dwc->susp_clk))
>  			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
>  					     "could not get suspend clock\n");
> +
> +		if (dwc->susp_clk == NULL) {
> +			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
> +			if (IS_ERR(dwc->susp_clk))
> +				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
> +						     "could not get suspend clock\n");
> +		}
>  	}
>  
>  	ret = reset_control_deassert(dwc->reset);
> 




