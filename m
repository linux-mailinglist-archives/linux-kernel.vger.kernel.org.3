Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984CE4AB03F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiBFPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbiBFPdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:33:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76CC043185;
        Sun,  6 Feb 2022 07:33:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p21so7125998ljn.13;
        Sun, 06 Feb 2022 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1yeJca7mYlZUgKl4c+J5ok9Iamo2xeksK3yD1Z4yV0o=;
        b=AQ0E9ql3HFJI7KmgZdwTqyKD3IdLwnOWuTRmThS++tmGXRtS4M16KxT0ZVcGInsXvh
         4bGfF3j+1iR4jo8wXi4rhXlSlgNLnv6NXGI3TeRDNtOy7j4DLCpjZpRqkvCDllrVqtbr
         N1N3kHsnyK2ezXkViXLlndJAI+siAbEttYv4y1xNXtNi3f0To38j5t15+SNC201Hqphr
         POnv1YRIGiMjwdliVZL96n55FqKeD7fFMHiVZKLWd3Naqe2Owyl60PGOJ2lHMyaO0UED
         CyXPInAcHd0g5HfecIO/rM2rKbZyt/qdXO+rYJdxVhmgRClw9iaqOvZg4IUCtznlMfSS
         n0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1yeJca7mYlZUgKl4c+J5ok9Iamo2xeksK3yD1Z4yV0o=;
        b=0U8BNXUSm5Q5spm5pp1UpKSvO3Ou1hAfkacEIrWhkWBBo2JOV56YysO6RgUBOp9BgM
         U8R0j1EwwoUabdtgoIjmMJ2XI/ztzCEc/a0m17Gv6l70JswQVbNE+UhAoSeOMoOJvRuT
         T2ZWvTHPnIn/qXU6fOzxQEsY2n6DrnElQaUPOZGnpmyUOYAW7nES7gbdZOHt4UNVChJl
         VrJAa7vin2W4yUEqipm/UPBsRxwLDhRaH5s+9I8fBXGsN32pOwIApQomhJ6lWw2z3bHT
         aMOIz1z5rdXDwgnGBQneHVGlz+nDt9T5Z0yPS4nwWCBO3h0kQKJSVIuZDsITq4h3k8sV
         n9UQ==
X-Gm-Message-State: AOAM531JuVVDgIn16WqdGLYef+doQR54Ti/bb03PX2Sd5edzMOirjPJk
        0qeEDDWYZThyfkjxJGe/mqM=
X-Google-Smtp-Source: ABdhPJw31lnQibnXifLzPpkMfVsnDikM7U3pUDMm8E4A6VN7JcF0E7MFzm8PfXHO5IfvTBI6xQm8Gg==
X-Received: by 2002:a2e:86cb:: with SMTP id n11mr5846231ljj.250.1644161629198;
        Sun, 06 Feb 2022 07:33:49 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id bp20sm1137929lfb.42.2022.02.06.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 07:33:48 -0800 (PST)
Message-ID: <f6af1977-51d5-527d-669f-d71cd0fcb64f@gmail.com>
Date:   Sun, 6 Feb 2022 18:33:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 7/8] memory: of: parse max-freq property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
 <20220206135807.211767-8-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220206135807.211767-8-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2022 16:58, Krzysztof Kozlowski пишет:
> Passing the memory timings maximum frequency as an unit address was
> a workaround and instead 'max-freq' is preferred.  Look for 'max-freq'
> first and then fallback to 'reg'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/memory/of_memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
> index b94408954d85..bac5c7f34936 100644
> --- a/drivers/memory/of_memory.c
> +++ b/drivers/memory/of_memory.c
> @@ -212,8 +212,10 @@ static int of_lpddr3_do_get_timings(struct device_node *np,
>  {
>  	int ret;
>  
> -	/* The 'reg' param required since DT has changed, used as 'max-freq' */
> -	ret = of_property_read_u32(np, "reg", &tim->max_freq);
> +	ret = of_property_read_u32(np, "max-freq", &tim->max_freq);
> +	if (ret)
> +		/* Deprecated way of passing max-freq as 'reg' */
> +		ret = of_property_read_u32(np, "reg", &tim->max_freq);
>  	ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
>  	ret |= of_property_read_u32(np, "tRFC", &tim->tRFC);
>  	ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

