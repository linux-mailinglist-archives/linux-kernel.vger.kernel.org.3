Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C617503106
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356132AbiDOVnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350077AbiDOVm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:42:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A663B1274B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:39:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso9211038pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pnnhVnGjhESFSvN5AIAUxQOTXkNGysYpxD5X0481Phs=;
        b=Mr7FDGOCaG90Xqb9CkSUPuMLdgZLTpRANkq0G9fniO9sl7RuxMhwa4pMV7r5aAPtzr
         WmI0puD3f3vvRKTbriacpoZCx07mwNv4Q8uGwKJ58b15UjhjHbYdIdBK34DjlTTZpRkX
         YqcK6dt1qkBadKHIxzvtlkwWFYo49k1qxyF2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnnhVnGjhESFSvN5AIAUxQOTXkNGysYpxD5X0481Phs=;
        b=yf56q3a4slGfX5KceriFFpU73iRZDTLJJgO2a9rzvLrxWvcDA6TLBx6bVqITFAof7z
         0w2wBlGq9XxgoU3TkUWne5UY8jPxb43EWW/AHY9Wy+3wHUpvcboWjR15DW5ZUtrd4kpK
         /yehfnxbUpj09nJKDzR7GH1FbN7dYYs+gZkyeP34tAj6Whhh3o5DlyS/Mx9wdaty7lZ/
         nRP/TI9rF2hRhhveY7v7Iljvw+NyTuxpkUbFuIbSrFYfinDE+EHGV0BkawepWLsom52L
         gGzqHN9QqUABVFcAgororlq3hYuZ0wLb7Cp/NnlhJUqwUdo4jJMKbAXTw58s0CgQjujO
         5kRw==
X-Gm-Message-State: AOAM532eDLGXLRAQ9eYSChv5SLfubdbnnadyQlinNVtYaV39gytYvdlZ
        0U44oxDth6KBlWMevtmY4LNwqA==
X-Google-Smtp-Source: ABdhPJzezmjazjpZOJiGsT/T33Plq2/us4Na0I8/Us86rxlwMws1XdK7SKgVBfiOxbVNW1v+4cbJfw==
X-Received: by 2002:a17:90b:3b8f:b0:1c7:b62e:8e87 with SMTP id pc15-20020a17090b3b8f00b001c7b62e8e87mr6192674pjb.156.1650058794221;
        Fri, 15 Apr 2022 14:39:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b27a:b3e7:2e3e:e4be])
        by smtp.gmail.com with UTF8SMTPSA id w9-20020a056a0014c900b004fb2ca5f6d7sm3707308pfu.136.2022.04.15.14.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:39:53 -0700 (PDT)
Date:   Fri, 15 Apr 2022 14:39:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v12 5/7] pinctrl: qcom: Extract chip specific LPASS LPI
 code
Message-ID: <YlnmJz/wjxfkZFua@google.com>
References: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
 <1647447426-23425-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1647447426-23425-6-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:47:04PM +0530, Srinivasa Rao Mandadapu wrote:
> Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
> to allow reusing the common code in the addition of subsequent
> platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

>
> ...
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> new file mode 100644
> index 0000000..8c95d0f
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

...

> +
> +/* sm8250 variant specific data */

nit: the comment seems a bit redundant since this is now the sm8250
pinctrl driver.

> +static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
> +	PINCTRL_PIN(0, "gpio0"),
> +	PINCTRL_PIN(1, "gpio1"),
> +	PINCTRL_PIN(2, "gpio2"),
> +	PINCTRL_PIN(3, "gpio3"),
> +	PINCTRL_PIN(4, "gpio4"),
> +	PINCTRL_PIN(5, "gpio5"),
> +	PINCTRL_PIN(6, "gpio6"),
> +	PINCTRL_PIN(7, "gpio7"),
> +	PINCTRL_PIN(8, "gpio8"),
> +	PINCTRL_PIN(9, "gpio9"),
> +	PINCTRL_PIN(10, "gpio10"),
> +	PINCTRL_PIN(11, "gpio11"),
> +	PINCTRL_PIN(12, "gpio12"),
> +	PINCTRL_PIN(13, "gpio13"),
> +};
>
> ...

The nit is just a nit and otherwise this looks good to me, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
