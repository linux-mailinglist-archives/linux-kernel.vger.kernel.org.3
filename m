Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382F4D99C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiCOK7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347748AbiCOK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6A35269
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:56:54 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5FEE13F220
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647341811;
        bh=ht8KpCSDXfMeLKk1Iy9OjwDkeWKdnRpzH0Z8PU+F89M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LSDzC0deInfWjrGAItDnx4m/E5k6DCq6tWecLyJ4YhEooqeREvuPhb+4GYTT5NeYG
         t0tVG2+hX9U9/ytDV/AhjC/oYZFQkbKAyUTzea48+YXxlcCMJYSIoeZBoavgQNDBbP
         7dc9HdzAWeKM0RVFROooP5t3YgWV00Eh57aRbfXkzXcfyocZRDty2UxtD5muiTdxOa
         hnsQYy0NHqJAVomjhMv8RieBND6DFGRdFEpxxYKenGzKGMJn6rksDmEZN0Xw/ule0q
         r6Q1ZYtHCRngqmVDgl6Wvp1Kj8ClUcSVNfcc748Ko8aTE4A3+ZJ55sUh7OAydDiB1b
         oXlHYbvuYeO2A==
Received: by mail-ej1-f71.google.com with SMTP id jy20-20020a170907763400b006db62b6f4e0so9463161ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ht8KpCSDXfMeLKk1Iy9OjwDkeWKdnRpzH0Z8PU+F89M=;
        b=4ULbswoU/TVWbtHhqCt6RX73sPtIV9Vmmc9wCH/CoOANPW+7mnC0JdjHCwr4vDcsAQ
         8fhmmWiWq1OuCYjK+/IC+/cRzoeHvwM/VAXzg5O0YMX28TZ6aLipFiIa3kfNN26pM9Hh
         ZRUK9TaiEsNHnoR6E6i9t+JZKGnlXkrAAWjFykxkrC9StGehAl5NGEP8iJ2sqRojyRG5
         /ji8KA/oU+pu0dx8GVCfgCZTjtkIg4CNn72C9AjREMcbiAkGpImOh0ZnTVImXAiSj2YN
         trDQASEKPrVnA48ot03TyMjKG4ubE38PSjBCJRlENMOWgWwc49KmalnQwgzUuIQOISTr
         vO/g==
X-Gm-Message-State: AOAM530p5a50gDXI1xzwN0u7yY3aCrIzF8R7wcwT0ate5Ap6CBi1HAuC
        cyMyZluvqH+R5o92lm55mhGY/GlAdktKcfCrbMR92W8ac8/vNF0b2ISfBVpxlibHOSuStJ0fr59
        mbgPzuZyFCSboakEsSPCS0bpJffwzfdSLblHhUypqKg==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr22467081ejj.275.1647341811109;
        Tue, 15 Mar 2022 03:56:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Vc0VBi8iyHSnXP0SjQn1EF5R+EUhGiixvRk7hd4/4ka6soIYQAQL/knRyeFkxKGN4H/zyg==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr22467063ejj.275.1647341810849;
        Tue, 15 Mar 2022 03:56:50 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm8011143ejz.199.2022.03.15.03.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 03:56:50 -0700 (PDT)
Message-ID: <095b4dad-ade6-c742-1993-e5dc89f5cb93@canonical.com>
Date:   Tue, 15 Mar 2022 11:56:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V7 1/5] dt-bindings: display: mediatek: add aal binding
 for MT8183
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jassisinghbrar@gmail.com, fparent@baylibre.com,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220314090033.25773-1-rex-bc.chen@mediatek.com>
 <20220314090033.25773-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220314090033.25773-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 10:00, Rex-BC Chen wrote:
> Add aal binding for MT8183.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index 61f0ed1e388f..6c8c83988a24 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -23,6 +23,8 @@ properties:
>      oneOf:
>        - items:
>            - const: mediatek,mt8173-disp-aal
> +      - items:
> +          - const: mediatek,mt8183-disp-aal

Use enum in previous entry. This is weird setup to have items with one
element and then duplicate it for another oneOf entry.

>        - items:
>            - enum:
>                - mediatek,mt2712-disp-aal


Best regards,
Krzysztof
