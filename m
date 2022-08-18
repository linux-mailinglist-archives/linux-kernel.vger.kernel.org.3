Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7733A59837B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiHRMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244699AbiHRMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:51:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125A7CABF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:51:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bx38so1611365ljb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wAqai+lXG/XM8EttQSkFjFqBGi7USxO4pZCplt3DnME=;
        b=mVVqXERkdEtMBQvWvwInmEeiAtkRN2jSEfsK/gHOd+N3so+k1Z7TEAWpWI0w6pSX2K
         zkAohq61XTRTyDz6+UUGzX1uZOHgp61QPeu9P2Uv6ZsgmiwgTvbWcsAJZW5kgIu5NF8v
         cLgf3I/sthTuqGVdybqLZ0piop06pn4P6NsEDQXraP1HprX1cXhl0w/sDCOGmQQZ4l0d
         IrPDp9H0uvZ4sr97AVvQXqdAe7N5FTRA0P8RJw2GiE730oQBt0lCIE3lEfkxjQT+cR4I
         4r1gCgLB4OmIVEvge7SHdIr0W58W3HuOu+RxYO7V0m5HVFDlCZDzmiXhbFx48pOYE/zN
         PntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wAqai+lXG/XM8EttQSkFjFqBGi7USxO4pZCplt3DnME=;
        b=gc24ypno5WJctmyaHi6jXRnEHVNQVdts33x3ipM4zYorcVocS8s7nFO/ykM9AlFUVq
         tE0YMF3Jz+gVp3Zg9NpaR03RBuG8ZRgMMFsEO7or5pKmcgvLeS+OgCSVbMCl/rZUiOkL
         oajax2vIUllKC5eZtLgQa2W7+3OZErOV2kys9R5g/fliQTK7+BQ0wrDaZVVFyLnhqsD2
         Sn0j8BtdSPYL35WTCd94jSQjeaAMg+tQTP3N6k4uAtxJhRL05E1uOvjF/O+1i4v3JDWs
         qXgVbRm/kHWq2iaIGJLV0h1gSd4lK1/GKKTAiec6pSAf4S9G59rZ6+/zcIIDyvRo5tTj
         KuOA==
X-Gm-Message-State: ACgBeo3fLuIlF9iETQyNABBdi7LKPqAPcu2wba+fea9MT3oKoRQjOUgp
        XMs9AeI4+cl6x27wH+oQsaFSLg==
X-Google-Smtp-Source: AA6agR7nEPbqE+6xr6o+AFM2JxbiRFCsOLtcOWcSBgLsZS5/v6lBOfAfGh51i5XsjzugZinmU4Fksg==
X-Received: by 2002:a2e:9acd:0:b0:261:6fd6:cc with SMTP id p13-20020a2e9acd000000b002616fd600ccmr830228ljj.55.1660827103843;
        Thu, 18 Aug 2022 05:51:43 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id i19-20020a2ea233000000b0025df4aa1e3asm209865ljm.64.2022.08.18.05.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 05:51:43 -0700 (PDT)
Message-ID: <3d91fe87-feed-d083-9eeb-51293aead67a@linaro.org>
Date:   Thu, 18 Aug 2022 15:51:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RESEND] dt-bindings: timer: Add compatible for MediaTek
 MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>,
        daniel.lezcano@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220818124602.20394-1-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818124602.20394-1-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 15:46, Johnson Wang wrote:
> Add dt-binding documentation of timer for MediaTek MT8188 SoC
> platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index f1c848af91d3..8bbb6e94508b 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -25,6 +25,7 @@ Required properties:
>  	For those SoCs that use SYST
>  	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
>  	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
> +	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)

Where is the driver change implementing this?

Best regards,
Krzysztof
