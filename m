Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7BD4E2A60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiCUOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352011AbiCUOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:22:06 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81518382E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:15:19 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id q1-20020a4a7d41000000b003211b63eb7bso19232346ooe.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46puAl5qyMfNEvffHuQs4+W1rB2fRN97vtq4kHR41Uk=;
        b=SmwG+razLK9p905oAy6zpQYaPAD2BucmHC65BaOcMrcAsd0ewBaGYDh4iQm7qY1V4m
         xS9xA3VF18bq2VjWSisAkttaqMMMUC0oXM23iBGEJ3dihdpZlqYVzuY+KUvbyVAhRbRC
         KXDwIq48221J/PnyKG52urGNjuKgTkLmFEVkl5lHO1U/9GHzeUB9Kmfrfkq/s77tiLfy
         0TjbDt66d/PANvj98iOa4063lS1ey5Ln6TCeTFzLqizm0fxUECw/rsxR9v3janY0qrjv
         iNw+5H/0G+JHs5mG6MCMTAB4YyTmfvNO1wwnLrMo5xTfXofEspY7TYoOrvWAOq0lcsGV
         qZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46puAl5qyMfNEvffHuQs4+W1rB2fRN97vtq4kHR41Uk=;
        b=ON8FaZh8g+YcvveBdGNUvOE9Dse0zrCFLn2NbEFuQH2twd31Ihojoef+Mdt9juRQWO
         DCguhgksAP/ZRjJ/ieICekR2ODeJKYdiSzerA79u1KWz7YgDzG0nyZEaFSGJsdhXn8Gt
         CQyvCiq6zm2IotkZd+GDOTcp8OQVChOQ6dP+08BXFUVZxNATHkNjZ+ozH+AIst7qzyl1
         MVUCpV1NnjQZDw7oiQN4mw1CNq4enLLY3b47tO4KwiDocHdOiq6hXImgoJqUN2M437e5
         Mc7anCx2MLpWMudgnozvEh/o3TBZrxLDU4VXW4Su+lW/DZ1PgZ4+mRHkEMf3Gzg55xHb
         Io/Q==
X-Gm-Message-State: AOAM532TaEc14q0daN6pkdwQ7yqPIxJ1XGn4hfgKWoRuiOFGH7vN1Asy
        STv5N6ERdmFwkR7Lh1zCuYR9mw==
X-Google-Smtp-Source: ABdhPJxaYZdj/xG+CL5lGzuWNzLxLTa+TXMS2nsMW4MzKuFZrrCTWcMMJEAJ0qSOgkfjCzpbGiqsyw==
X-Received: by 2002:a05:6870:e2c9:b0:dd:b78a:82cd with SMTP id w9-20020a056870e2c900b000ddb78a82cdmr7964695oad.50.1647872105167;
        Mon, 21 Mar 2022 07:15:05 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c12-20020a9d75cc000000b005b24b061940sm7349297otl.33.2022.03.21.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:15:03 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:15:00 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] pinctrl: qcom: sm6350: fix order of UFS & SDC pins
Message-ID: <YjiIZBbPN7pAUl1q@builder.lan>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-5-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-5-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Mar 08:33 CDT 2022, Luca Weiss wrote:

> In other places the SDC and UFS pins have been swapped but this was
> missed in the PINCTRL_PIN definitions. Fix that.
> 
> Fixes: 7d74b55afd27 ("pinctrl: qcom: Add SM6350 pinctrl driver")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Your proposed change looks good, but when I look at 7d74b55afd27 it
already has these entries in the correct order.

Can you please confirm that this is still applicable. Or help me see
what I am missing.

Regards,
Bjorn

> ---
> Changes in v2:
> - nothing
> 
>  drivers/pinctrl/qcom/pinctrl-sm6350.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm6350.c b/drivers/pinctrl/qcom/pinctrl-sm6350.c
> index 4d37b817b232..a91a86628f2f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm6350.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm6350.c
> @@ -264,14 +264,14 @@ static const struct pinctrl_pin_desc sm6350_pins[] = {
>  	PINCTRL_PIN(153, "GPIO_153"),
>  	PINCTRL_PIN(154, "GPIO_154"),
>  	PINCTRL_PIN(155, "GPIO_155"),
> -	PINCTRL_PIN(156, "SDC1_RCLK"),
> -	PINCTRL_PIN(157, "SDC1_CLK"),
> -	PINCTRL_PIN(158, "SDC1_CMD"),
> -	PINCTRL_PIN(159, "SDC1_DATA"),
> -	PINCTRL_PIN(160, "SDC2_CLK"),
> -	PINCTRL_PIN(161, "SDC2_CMD"),
> -	PINCTRL_PIN(162, "SDC2_DATA"),
> -	PINCTRL_PIN(163, "UFS_RESET"),
> +	PINCTRL_PIN(156, "UFS_RESET"),
> +	PINCTRL_PIN(157, "SDC1_RCLK"),
> +	PINCTRL_PIN(158, "SDC1_CLK"),
> +	PINCTRL_PIN(159, "SDC1_CMD"),
> +	PINCTRL_PIN(160, "SDC1_DATA"),
> +	PINCTRL_PIN(161, "SDC2_CLK"),
> +	PINCTRL_PIN(162, "SDC2_CMD"),
> +	PINCTRL_PIN(163, "SDC2_DATA"),
>  };
>  
>  #define DECLARE_MSM_GPIO_PINS(pin) \
> -- 
> 2.35.1
> 
