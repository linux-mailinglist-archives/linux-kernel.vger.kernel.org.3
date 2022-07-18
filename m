Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC769577978
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiGRB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiGRB6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:58:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A25F3F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:58:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so16777181pjr.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CokcQbp76rvQZ9pFN70oiecOHjxj+5itFymAFXRWP/w=;
        b=m4ieBHKCCwFZ384POZtd2o6j31IhBWp6vMOQyD01RAFflwhAJMOiCvVA6AqtHOFHiJ
         xIST7kGxmkJvEjRh7kiaSqhkOSOjFJu0LdI31wqlAnV873qAdYcp7P78Y5ROQiBnQc0Z
         FLgnpdZK1PtLqbRa7ANbrnu2wspZzXYRf7afzfEGlQm7sayAO5FAPUsYWZ4jR9CLHL1Q
         gAjBDOKb1zyQdDfl7BGYzfYhvNQaODNfl9eMuNAjIZWnyIWPea/4lgZtDJnPkYzqPleH
         u7C8Ig5tHmPOwM9P7sqIcOvqLE3TLEXp+hBw94yyW0uNiZ467nkCadPUjkoEw9JU/GQO
         I0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CokcQbp76rvQZ9pFN70oiecOHjxj+5itFymAFXRWP/w=;
        b=HpVfyqF9waFNxU91o/ER7Jh8O84XZ8C4pGbam/WFrQpE0t8FolM19KCjAt+aMhLZLn
         fO7uB2yWYxZYJHTLpi+9y2h2vZDrXil/SiIK/bDDsC/Ziw8pv0QDEkA/iGG5NI6XdTcy
         /McCH5BfFSqWvIAGfy6JFnZygKOFEwAy1cnD/ZhpNIVghO/zCmkQ4QMNdXu7z5HIgJ3/
         covGBfD3Hqrhal8Ngfi+tF+jviOszyRlReOy/KYSskMJb9ksRC5itTqHMSjnkdEauiKA
         KgGzEELFRJ7Blc8BtobU0WFmHmxqBt668dzsHZb1PfvGSswUAEm8JB3/Rv5P8AfJZxQy
         ElWg==
X-Gm-Message-State: AJIora+mpk4gdF/1pjRRAet6WaBSIvLdHngy7NDwrFVEZYc5L/e4br5l
        7dRlYmbiD+r1VChghyWKyS2uuw==
X-Google-Smtp-Source: AGRyM1vIfihkqBtkEsdM480xDTf0pZmVCt+QrVqHWkFHuHDk0VjD562Z9iUFwwdfPKoSVYZZswiVpQ==
X-Received: by 2002:a17:902:b287:b0:16c:2ae8:5bcb with SMTP id u7-20020a170902b28700b0016c2ae85bcbmr25855619plr.164.1658109528966;
        Sun, 17 Jul 2022 18:58:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w15-20020a63c10f000000b004114cc062f0sm6900906pgf.65.2022.07.17.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 18:58:48 -0700 (PDT)
Date:   Mon, 18 Jul 2022 07:28:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6375
 compatible
Message-ID: <20220718015846.y7s7l5tj2eywfllt@vireshk-i7>
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
 <20220716193257.456023-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716193257.456023-5-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-22, 21:32, Konrad Dybcio wrote:
> Add compatible for EPSS CPUFREQ-HW on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 2f1b8b6852a0..24fa3d87a40b 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -25,6 +25,7 @@ properties:
>        - description: v2 of CPUFREQ HW (EPSS)
>          items:
>            - enum:
> +              - qcom,sm6375-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss
>            - const: qcom,cpufreq-epss

Applied. Thanks.

-- 
viresh
