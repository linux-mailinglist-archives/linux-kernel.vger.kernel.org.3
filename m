Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFA5A9E54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiIARmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiIARmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:42:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689E1E3D6;
        Thu,  1 Sep 2022 10:40:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 966B332009CB;
        Thu,  1 Sep 2022 13:39:15 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Thu, 01 Sep 2022 13:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1662053955; x=1662140355; bh=K0
        PySzeYRj1ESNvfGlD4cjnNfqWN52DtgIAV14TgWck=; b=uYBYecRB/4RUS4pgH2
        kjGUEnaWa0SBVmhZry7Vm/2RtraTn/+/ZFWrNwozvIQXIyZ7IGndDvybY0SZ4aXd
        T+LCGDB0timXorhMuDM8gmo8yjl23NVAed86hk2oq6olqGwllZE9v6AE7Gm/npnu
        kqjfNmiJpc/z0dV3+tKmbWYC82oe6WPXlDvI3ysSwQacffH1Fd+cumxiK1bptUj8
        NJBUkSp1NzrXbOH+3fQY+y0IrxloR7UUV5+7pnNxq8zMhewSOWdeMG6niDfDGVAG
        VrlGr9rhrCsciGy3Yox+2VwsiKTkaYoD0aB63FS/QGZRgWo1VTlB9yZfBnFe0/Yh
        MCew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662053955; x=1662140355; bh=K0PySzeYRj1ESNvfGlD4cjnNfqWN
        52DtgIAV14TgWck=; b=x6METu9GZD6tP+qGai7qs12DJ/3C7y92eKLbDUXqiDyP
        PErmImk4lZWiqHYJCR2ZBZm7qq62Bj5C+U0eBt8hlkhpjyXSCCclcLsUPEMVM9Sp
        EqiQPxi6LVo0EuioHPsDuBU1jxr39ZJiONXiuEKofS2Mql8zmDr2dRF/CPJRarzt
        KXLF/B5rNtQCFjVso2ROVjHXzhwqJbfXYt/xgTbyRex/TyFmeYSo33+RIYEoFja0
        UOjQkUL7m4fsxfFr+A5ugASwjDssWMnxEgHlifjyWMLmxJ82n/PisT4MTF7XkvV9
        O986EjnI4H8cRh1M91QTFBGi8wfJR1oxfsS6XorYbw==
X-ME-Sender: <xms:Qu4QY3BiXX6MF2jzzvaqiY6kPh0GQnHL58ex1PMIBmuUjTx2ORPyEw>
    <xme:Qu4QY9iladtoMG7GxIA84Rrz5FO4DfBFXCRyaXZwKfj8YR-sTJwy-DmFpotSeW-97
    7eDy1guGatxqWgxMbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefg
    hfeiveeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Qu4QYykFfIGCsFHPqJyGh514Buv-oPTW_1o3JIH04IizaYn3qiuHcQ>
    <xmx:Qu4QY5x0ICNZeqZuo67dXOOFG3cXqwrwWIuGsfD-aHhUfbTWf90Dvg>
    <xmx:Qu4QY8SSqSEpIzvk6XvD59e6_8PdmgP868H-Om65d7SJOc44rGFSTg>
    <xmx:Q-4QYxKDrLNwPxA2TgRO7i2Smuq-zWqP4j0iK8YTsP08KUFEibirtw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8BD49A6007C; Thu,  1 Sep 2022 13:39:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <8fc4eb4b-25c4-4d4c-8203-1e5c314436b3@www.fastmail.com>
In-Reply-To: <20220901083446.3799754-1-william.wu@rock-chips.com>
References: <20220901083446.3799754-1-william.wu@rock-chips.com>
Date:   Thu, 01 Sep 2022 19:38:53 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "William Wu" <william.wu@rock-chips.com>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Fabio Aiuto" <fabioaiuto83@gmail.com>, frank.wang@rock-chips.com,
        jianwei.zheng@rock-chips.com
Subject: Re: [PATCH] usb: dwc3: core: leave default DMA if the controller does not
 support 64-bit DMA
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Sep 1, 2022, at 10:34, William Wu wrote:
> On some DWC3 controllers (e.g. Rockchip SoCs), the DWC3 core
> doesn't support 64-bit DMA address width. In this case, this
> driver should use the default 32-bit mask. Otherwise, the DWC3
> controller will break if it runs on above 4GB physical memory
> environment.
>
> This patch reads the DWC_USB3_AWIDTH bits of GHWPARAMS0 which
> used for the DMA address width, and only configure 64-bit DMA
> mask if the DWC_USB3_AWIDTH is 64.
>
> Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
> Signed-off-by: William Wu <william.wu@rock-chips.com>

Reviewed-by: Sven Peter <sven@svenpeter.dev>

> ---
>  drivers/usb/dwc3/core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index c5c238ab3083..2fcbd05b2af1 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1751,12 +1751,6 @@ static int dwc3_probe(struct platform_device *pdev)
> 
>  	dwc3_get_properties(dwc);
> 
> -	if (!dwc->sysdev_is_parent) {
> -		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> -		if (ret)
> -			return ret;
> -	}
> -
>  	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>  	if (IS_ERR(dwc->reset))
>  		return PTR_ERR(dwc->reset);
> @@ -1823,6 +1817,13 @@ static int dwc3_probe(struct platform_device 
> *pdev)
>  	dwc3_cache_hwparams(dwc);
>  	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, 
> "wakeup-source"));
> 
> +	if (!dwc->sysdev_is_parent &&
> +	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
> +		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> +		if (ret)
> +			goto disable_clks;
> +	}

I guess you could also create the mask from DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0)
directly instead of hardcoding it to 64bit here. Probably doesn't matter though unless
there are some weird systems where dwc3 can only do 48bit DMA but there's actually memory
above that.



Sven


