Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554A34954C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377436AbiATTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:15:38 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44577 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377439AbiATTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:15:17 -0500
Received: by mail-ot1-f54.google.com with SMTP id a10-20020a9d260a000000b005991bd6ae3eso8803018otb.11;
        Thu, 20 Jan 2022 11:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyrwo10QyE+4jJbptyHxhaksxCDlRjk9NtGrqHUVbIM=;
        b=bkZN1d9mGDjF3ysCq96XxYbpRtMUlzx9Oy8r0BQOvtcZnZgS3dhqDjlqiLDmSaxrBq
         1h/XuT70+7ZU7+DnOoTt5ldCjkc0RGboYhozpXLpM0nrJeSyKPeHgkmUk/GVafvvowS5
         kok2U5Xj6anz4Fp8OgckzVO48shDcSNtQRKvaxnraf77WK9cCoGANozF5jeIodJJY7t0
         ffUtOBaZTvIhbmYuzsI3rdtVlj/ahtI9Ep0L3JIrwDF8DF5sk7ly+eFhkNm33f32SaeY
         SIqD2wmARckPsPe5zzLi+x63yHIXgOzYqLZBBF/i2Tk1ReUHOWF+ArXuSEr1/c4HmxBU
         I35g==
X-Gm-Message-State: AOAM53340YwDLNa+BsDFlDpw7p2ysHqXJDaeIeuFtesKDPupj31H7Kip
        ecPLg6WXHwfr4w6l47FzZQ==
X-Google-Smtp-Source: ABdhPJxYTxMfRY7ea8dOo2dUuJi40kbW0MB1i8W+LJ92BUkcJjagBigdEeKiYRZwW/zQOIKw9R2ENg==
X-Received: by 2002:a9d:74c2:: with SMTP id a2mr168097otl.23.1642706116831;
        Thu, 20 Jan 2022 11:15:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j11sm38114otj.30.2022.01.20.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:15:15 -0800 (PST)
Received: (nullmailer pid 1784314 invoked by uid 1000);
        Thu, 20 Jan 2022 19:15:14 -0000
Date:   Thu, 20 Jan 2022 13:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, sboyd@kernel.org, krzk@kernel.org,
        linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: Fix node name pattern
Message-ID: <Yem0wtltC/6FklZu@robh.at.kernel.org>
References: <20220120161442.140800-1-nikita@trvn.ru>
 <20220120161442.140800-2-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120161442.140800-2-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:14:40PM +0500, Nikita Travkin wrote:
> It looks like it was intended to allow two types of node names with the
> binding:
> 
>  - With unit address, e.g. pwm@1f000000

Yes, but the format of the unit-address is up to the parent bus which is 
outside the scope of this binding.

>  - With a suffix, e.g. pwm-clk

No. pwm-0, pwm-1, etc. only to cover the few cases with no unit-address. 

Third is just 'pwm' as the '*' on the end means 0 or more. Though a '?' 
would have been more correct.

> 
> However the pattern regex only correctly matches the first variant,
> as well as some incorrect ones.
> 
> Fix the regex to match only two patterns shown above. (Either unit
> address starting with @ and following with one or more hexademical
> digit or arbitrary suffix stating with - and at least one symbol long)
> 
> Fixes: 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings to json-schema")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> index 3c01f85029e5..4926fe65886f 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -13,7 +13,7 @@ select: false
>  
>  properties:
>    $nodename:
> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> +    pattern: "^pwm(@[0-9a-f]+|-.+)?$"
>  
>    "#pwm-cells":
>      description:
> -- 
> 2.30.2
> 
> 
