Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9B4DB4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357216AbiCPPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357129AbiCPPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:20:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3A62A18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:19:11 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0924C3F60F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443950;
        bh=n1R86AH40JMDGlhsJXdbdtccHR5xtuigPuTWuYsB7aU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dweaW/dTT4y4d2tP/nY+nmEXnaeZcYG0ThxkFzZwWeDHdEpT3zhoiP1cxmPUloE5A
         qb562dlLiFP5aEwTFFlUgW2FRuqZdXQ9EhRyMAhZiBWD8myL8Ssd6+EPyWgrTufVVl
         NjYuQGC8vX0EGoUlBNiwja1lRZJDaz8OZY3qn+9koT9e7MOrQbm+/hj7Ip6d5RyntE
         mGGtzhVq3Ak+R5S2QCRtTHgRtSHjuliZk9bF5/aur33bNos0N+iRG8FoDpDFPZoqTN
         ct4LKTZnnEYclVsWVjfVQnFx+FViH3uczb1jrJ5s/CNRTzTCf7UTCc9eRsdN81UNdv
         2B7VRlqHeb2/g==
Received: by mail-wr1-f69.google.com with SMTP id e6-20020a5d4e86000000b001f045d4a962so666775wru.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n1R86AH40JMDGlhsJXdbdtccHR5xtuigPuTWuYsB7aU=;
        b=1XihbAssTMYl1F3BfhlgKHyz8D9zYkRl3wg23uLfSUqkPudNOs6RYGhcdUztROfpRB
         UjE0mK+1iSdPNfmj09m2YlImXXY0uRo4FN7imgPXibndF+QKCsQMO+wsOPBTzrlAPRZ8
         sTq2cp4W3M61WpL5ABhfp6ZqgH1pqLGYmYQbivzlMDzZ1XYO+m7VLgQicW6B1cE2iC7n
         Tp5mCdbsnmqWv1qCvOe0hZ8IqN1OanhLxaMdxv0LG6mo/9A5RE6MAKK0aR8bdAslCyR1
         QBg6wu1h6Ae+rU3nqBFxgTqCG8avsR2TmVpDA/xbuul6rJNXHDJh8h6Hvc9KiU1iek+J
         yAiQ==
X-Gm-Message-State: AOAM533Hg2fuq/jbTnJwbRkssmzUkDfM9Wnru1omhaWWrPlylHxPylTO
        Ag8Ff/Gq/rTXXYTYa4jFcuSMWYnFbTbaFKEIbZIsawVf4vtmXvOky2cLWod6+VADdFWn8rK2XNH
        /icGKLKmMfMYZGMQzYy95TKCTlT32CfqmPL7X5HxiDA==
X-Received: by 2002:adf:fe81:0:b0:1f0:246e:ae5 with SMTP id l1-20020adffe81000000b001f0246e0ae5mr353627wrr.652.1647443949232;
        Wed, 16 Mar 2022 08:19:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7KtAfQn8O30h7vKxDeRV7uri401Yg0lHLAU4i8wtnkZBBAptCPe0PeY+wSBS+LC5ypMwvEw==
X-Received: by 2002:adf:fe81:0:b0:1f0:246e:ae5 with SMTP id l1-20020adffe81000000b001f0246e0ae5mr353605wrr.652.1647443948978;
        Wed, 16 Mar 2022 08:19:08 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id v10-20020a056000144a00b00203df06cf9bsm1821028wrx.106.2022.03.16.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:18:41 -0700 (PDT)
Message-ID: <cf765199-30c3-f963-4d9b-8f225efd5b32@canonical.com>
Date:   Wed, 16 Mar 2022 16:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V8 1/5] dt-bindings: display: mediatek: add aal binding
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
References: <20220316115155.17834-1-rex-bc.chen@mediatek.com>
 <20220316115155.17834-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316115155.17834-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 12:51, Rex-BC Chen wrote:
> Add aal binding for MT8183.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index 61f0ed1e388f..eb0299b80522 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -22,7 +22,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: mediatek,mt8173-disp-aal
> +          - enum:
> +              - mediatek,mt8173-disp-aal
> +              - mediatek,mt8183-disp-aal

This should not be under items. You have just one element here, so
directly "enum" under oneOf.


Best regards,
Krzysztof
