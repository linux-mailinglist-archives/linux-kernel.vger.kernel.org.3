Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00404B856C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiBPKXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:23:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiBPKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:23:05 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E2240B7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:22:53 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 42B3D3F4B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645006972;
        bh=wuR90S9txt4D8ZpyD8BmkEY7fqkqr+OEq1oue1rbm+I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jlDlR30gUFvjkTZRuzp22FEdktHu7JDXPFGWpvebE8RmmahgKWKBA6pEVtpoU8hKe
         Qlu6hHrAONndzRhWYrIvPuL7CqXRInNzqCiJaVi9Q6993RLFZPEEBQ4l4olLXIFGs8
         npS30TQbORJ8HMdt4T61zrmK/1OiXSgdudmufL7N1bEs98PMKqIMIFR3wQ3okZrXdo
         5LejIchTK1HnQqd3DnKqOgXjQveIpBYEZr79pRNCVXn76qZHDehkJjLuc58HTCr0JU
         rdeQJPJof8v17v8u5LbxRU0PkHVrLfkbBVMIvQ/g5DtjYL7Dq7KNerpCqcS+sk35+C
         sbB3CP+DgESbg==
Received: by mail-wm1-f71.google.com with SMTP id k36-20020a05600c1ca400b0037ddae32528so287318wms.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wuR90S9txt4D8ZpyD8BmkEY7fqkqr+OEq1oue1rbm+I=;
        b=HCoHq/R1LBnjd0bMFMyuaFYAFRkFg1RkXeUx/q8Fn6kPSFsY1P2SFi81okywbbtqJo
         7GLSUZMH1Yag4Y6qESTjsWMzb7L/+SSdh7rH8Wl7d9SVeWAxBUl/qFLuvkmMCZZrgj9q
         Irol0oLcaPsneB6Jf8iPyiXuiCU5zmXK30m8gYl7j3V26dcBrQrPSorP8vnxQ3UqAJsO
         ynnT8XldX6qIrujpRwxH5lj8Ciav8s34BbZDDGJA9fJYYJtRlS1J8GhaAnchIhQMfVXX
         qxNY99SKBdNcVKfv3jy7F8nz/iMbrEYou2odQ4cWAD+4n4YdjseFU9M4RyDs9QTcvqED
         wUCg==
X-Gm-Message-State: AOAM531MA0R6uWnBHMBzYE6g2u1ZVj9RN4aLrk6KUEZKLSLjbVtdzq1c
        ZDYn7txKN/b6pK0TU4wkgncMjo1+VH9wv88P2rJP9DKNjuLmTSjMVbgmqe9/55o3ll9ncsBRmW9
        Dy6M2sOx222NgkuVH3wcm8uYcjebNDJf+H5HdCTGvBQ==
X-Received: by 2002:a05:600c:2e47:b0:37d:62d7:24bb with SMTP id q7-20020a05600c2e4700b0037d62d724bbmr905760wmf.71.1645006971954;
        Wed, 16 Feb 2022 02:22:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0tm5zca8pzPPli4+p2IjYg6ZL4qjnL96rMvrKZhljZw4NnZGhrPPdbfPJHZ4Z1myjwiM05A==
X-Received: by 2002:a05:600c:2e47:b0:37d:62d7:24bb with SMTP id q7-20020a05600c2e4700b0037d62d724bbmr905747wmf.71.1645006971809;
        Wed, 16 Feb 2022 02:22:51 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r11sm26194194wrt.28.2022.02.16.02.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:22:51 -0800 (PST)
Message-ID: <370739d4-2da6-b620-ec79-adf8d00c8c33@canonical.com>
Date:   Wed, 16 Feb 2022 11:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v2,1/4] dt-bindings: pwm: Convert pwm-mtk-disp.txt to
 mediatek,pwm-disp.yaml format
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     allen-kh.cheng@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <1645003971-16908-2-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1645003971-16908-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 10:32, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> 
> Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format as suggested by maintainer
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> ---
>  .../bindings/pwm/mediatek,pwm-disp.yaml       | 71 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ------------
>  2 files changed, 71 insertions(+), 44 deletions(-)
>  create mode 100755 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> new file mode 100755
> index 000000000000..edf2a2e9ea72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek PWM Controller Device Tree Bindings

This is a Display PWM, not a generic PWM.

> +
> +maintainers:
> +  - Jitao Shi <jitao.shi@mediatek.com>
> +  - Xinlei Lee <xinlei.lee@mediatek.com>
> +

My comment about pwm schema was ignored.

Please include pwm.yaml.

> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-disp-pwm
> +      - mediatek,mt6595-disp-pwm
> +      - mediatek,mt8173-disp-pwm
> +      - mediatek,mt8183-disp-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    description:
> +      Number of cells in a PWM specifier.

Need a const. Description can be skipped, it's obvious.


Best regards,
Krzysztof
