Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908CB5A372C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiH0LHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiH0LHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:07:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23CD9F8FC;
        Sat, 27 Aug 2022 04:07:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 2so4872234edx.2;
        Sat, 27 Aug 2022 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KkLBgHjqLVMK1fwCBUUK4kuHMU4tLcffN+IAMJpgXe8=;
        b=iZpl5NHEwzGcgFJBKmhpTHZLBNZEpO8w0BHof64cEERIZrF6+Bd+Vxx8nYg++2wVaV
         j8IoizILxnTbZt1KfTHo3mX2j42E70ofeASh58y3f16tcyPprgEI6gtRtqkRF4rq3Woj
         lJks/rDU+GKqtjkdhZ6favIWbiBado7MbQyunsRHc6vvnIAbk123KY9MxiDkS2OoaTnQ
         5yewCscX4Bhy1hXUkWmd335icJFNuX4pJ5aBqFrfaCdgKGRq2gd+hO/BX2qY2byewzu0
         qiRSDPIfzv5b2lM4bxd9NTpwBV866P8HQqprxDsrYNp2WNxg7JZ3rlj1ppoAvcE530yW
         hp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KkLBgHjqLVMK1fwCBUUK4kuHMU4tLcffN+IAMJpgXe8=;
        b=kdzuATtlY7CufwfycyV9am/Rd1/L7/Uxn5x4MYhXNhwbXJsra2rgPn0aH87hw3s8Q8
         6zcLJyA5w6JOmXrr32/OPZAmcqzStta3naI2xuDB1ThLZ8VcAYn9G9BveFwbaJI6xteT
         AXC+pqSde6x7PZYiW5mbt9PtN+KSO3uDF8RK5aH5+9GmxyOo7I+HxZz1U1I1krj1NP5g
         +lre9uYeMSh7YQfnGNhoIm6rNo928Yb78t/aP5UmuvWqc2V7ipQsJCIZKqa16jz4TrEN
         T04CYjeqBxyQUDd1L7zDG1/yJo5qWHLTSA2D2HDPlZudXPhn2zhnAXEED3bTgfTUxuJ1
         AqPg==
X-Gm-Message-State: ACgBeo3P3EKUupt+hEmQc0h483JjN3POje9fZsYpb/wAJSDc2r6nQCJT
        95+c+4uUyO2091wOJViOLFYMLBHu/ijncA==
X-Google-Smtp-Source: AA6agR79JkqEXhoYIuRUBbhwrFqT1EXnC+yp4Avh6kLZcgbJbvYbPwfxQgOUH7aOk4HPN/63R0no5w==
X-Received: by 2002:aa7:d5da:0:b0:448:ec:7b31 with SMTP id d26-20020aa7d5da000000b0044800ec7b31mr4228814eds.193.1661598459413;
        Sat, 27 Aug 2022 04:07:39 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id uo39-20020a170907cc2700b0073da32b7db0sm1918147ejc.199.2022.08.27.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 04:07:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wens@csie.org
Subject: Re: [PATCH -next 3/3] clk: sunxi-ng: ccu-sun9i-a80-usb: Use dev_err_probe() helper
Date:   Sat, 27 Aug 2022 13:07:38 +0200
Message-ID: <4742528.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20220827094151.3323450-3-yangyingliang@huawei.com>
References: <20220827094151.3323450-1-yangyingliang@huawei.com> <20220827094151.3323450-3-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 27. avgust 2022 ob 11:41:51 CEST je Yang Yingliang napisal(a):
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
> b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c index 575ae4ccc65f..a0fb0da8f356
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
> @@ -101,12 +101,9 @@ static int sun9i_a80_usb_clk_probe(struct
> platform_device *pdev) return PTR_ERR(reg);
> 
>  	bus_clk = devm_clk_get(&pdev->dev, "bus");
> -	if (IS_ERR(bus_clk)) {
> -		ret = PTR_ERR(bus_clk);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Couldn't get bus clk: 
%d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(bus_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(bus_clk),
> +				     "Couldn't get bus clk\n");
> 
>  	/* The bus clock needs to be enabled for us to access the 
registers */
>  	ret = clk_prepare_enable(bus_clk);




