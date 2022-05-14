Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174BE527183
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiENOBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiENOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:01:37 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEB62F0;
        Sat, 14 May 2022 07:01:36 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e93bbb54f9so13910757fac.12;
        Sat, 14 May 2022 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlHDlcHjNYXzX3RkcBnNlMLpBpY4z86D8OUXp3n1KLE=;
        b=Uedh5j0NhdygtpwIZrBjg1nnAh2Mr8wUBIOTj1eU4y/C8SbrwBEny0GfFqYvWNfSsH
         0039LsEf2z6lHZzu/cVFICOZCle9dLejbCesRVJfzIVNTB4FfqYT9ANj4ROzFE4EHMhD
         itq945oVoRHh6PRPdeVDDDoI0MLO0oHgR7zfdiMri0M89RH180lyzp0RTej0Q8zJwmHs
         Mb1DhZOC4eYRpL1aYICdAtH0mGIS5nhv8CJWezRsAkwytcAbW8TnfN50IG4y9zurEvyM
         FNwKuANUoHY+xX+5XgDxQfuBD7hUou6/xaNklhGWEGnWHFZsykVa2KldPPwFO4IozG4o
         XgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AlHDlcHjNYXzX3RkcBnNlMLpBpY4z86D8OUXp3n1KLE=;
        b=P+MuoNHCBwHUwZQo/Tzan/64MM/Ib+8UcGVKzt2XZnfGBAwL/mCpzA36inqUSoZt8B
         GrM/MQftMXyna8LDs+FtbUC4Ip7RJpQ24ZB3Yes8PDlLfu/XzIrEFV42P3GvZY56K9Dz
         jZYmcmLGWewiBY1QYlbndPFDCjXtiPSlzCDUonr0xTSjrVgiY5gtmlmVTEyLeDEn/7AA
         m5zIl4mYVzv/zxBc+qJ8UrrLowLUUhSeX9qYCT95JTpv+B+mVlgBYYEWyVWn+2jrWZb7
         9y4VpWDJww9H9zeIzGvI9gWvTRX9ycBrD4rr/d+djq7ukYjy7ODIfcDn4C+jqpRTbALg
         byKw==
X-Gm-Message-State: AOAM530Xv3UPZwA2ppvS9giOKGME2eMpXqzilG2PhOd+wfqJEM/TPlMy
        i96N/xnske/+DOhsy2RaegjvVmmNJnxC3A==
X-Google-Smtp-Source: ABdhPJxwhLRAaMOyRm+KV6BkHe5KGTx5InvmsQOf4eCj4jzC2wASt9WlMHMh0+ZJtf9jvIg1bR9j3Q==
X-Received: by 2002:a05:6870:34a:b0:f1:7200:5bed with SMTP id n10-20020a056870034a00b000f172005bedmr2003941oaf.288.1652536896125;
        Sat, 14 May 2022 07:01:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0da6000000b0060603221263sm2162670ots.51.2022.05.14.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:01:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 14 May 2022 07:01:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: Add SC8180X and SC8280XP
 compatibles
Message-ID: <20220514140134.GA1276720@roeck-us.net>
References: <20220408212854.581481-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408212854.581481-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:28:54PM -0700, Bjorn Andersson wrote:
> Add compatibles for the SC8180X and SC8280XP platforms to the Qualcomm
> watchdog binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 16c6f82a13ca..cdb09a2d244d 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,8 @@ properties:
>        - qcom,apss-wdt-qcs404
>        - qcom,apss-wdt-sc7180
>        - qcom,apss-wdt-sc7280
> +      - qcom,apss-wdt-sc8180x
> +      - qcom,apss-wdt-sc8280xp
>        - qcom,apss-wdt-sdm845
>        - qcom,apss-wdt-sdx55
>        - qcom,apss-wdt-sm6350
