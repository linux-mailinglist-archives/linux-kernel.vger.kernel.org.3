Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DB595536
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiHPI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiHPI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:26:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A713C72B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:55:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f20so13400397lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SM85WUFG4iEcrdGXUW1ovRXHJvVq4YoOra1Othbb/sI=;
        b=EwhBI+O8yhjttvfqkMyGgqju7SabAqYWbFGrQ9MqCy/t8smDKOrX4ZLMlouZVonOz6
         iwvUksftnAVCQQ7TsS7aZFhUmu0J1KZ0nv0sISODZ/JJm25kK6/oh3Z5hRk4iHlbdsyy
         OLFSD4mtvOZ6G6kjpeHJI+nEF0AzSt6YDOaTTqEP6TUJJcWxVbhfCK/EvupvSqvb11a2
         2t1zArEwfbv+BviVGZO1nHlkcm46oGvdOGa2Tzc0elglZ2hnByt0eGRQkeQhiWK5pABR
         nmm83J4PIgVhKmKs8nE/LYEcrRuI2syBUzb5wbOaZIccCAceLxa1Z5hwXW0JMoDIHIKI
         lRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SM85WUFG4iEcrdGXUW1ovRXHJvVq4YoOra1Othbb/sI=;
        b=3JASRdVJR6q/Zri+l+jcCNQ7cmA22UL8CxN21BO1x9YfOj1DICIWP17ZuDhubDj56h
         58+vE/A3Q3i3XAd58WfGdQuY/pzbuYFgE+okUhpvRtQmFgidEA8SQKrkhyVypBSLE1th
         YruleSL9klZSWgKs5tuQOhOUj2JNFxYyUiAigFYo0m+RZAuOjlrosWU2hdBg+qtf+hzU
         AVpb5saNbkbyZ26Tlkn2ig106FqzdfzreKY354FoUCUc3FqXa0SH0KM3JmdTEXQeHk9C
         mKeRlMSlvGGsVNmB+muuJU/26lfU7LsBL0nK4Ks+oyyNq6funUd+7LiY4gj2psemUKk5
         WkKg==
X-Gm-Message-State: ACgBeo2Y97t4VW/l1Yf/6hWx8d+HQUp4Vqj7BBb+BpQMor9UeI3vQ+RP
        gJOyh0NrRgYZ1pa7QCtj0EUSjiIGbNYplgST
X-Google-Smtp-Source: AA6agR7IeUpFg8yHso/TiNxbVUWwOdABAJVuP+7GB6b2iz3fuXp47F/1wpnpJjS37Xv39u1GZHp8gQ==
X-Received: by 2002:a05:6512:304c:b0:48c:ed09:1e95 with SMTP id b12-20020a056512304c00b0048ced091e95mr7274477lfb.642.1660629310351;
        Mon, 15 Aug 2022 22:55:10 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id o15-20020a05651205cf00b00491203d6cc9sm935238lfo.131.2022.08.15.22.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 22:55:09 -0700 (PDT)
Message-ID: <7f1e6b96-49f6-e83c-7711-d6a60cd012e2@linaro.org>
Date:   Tue, 16 Aug 2022 08:55:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 01/10] dt-bindings: sram: sunxi-sram: Clean up the
 compatible lists
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815041248.53268-1-samuel@sholland.org>
 <20220815041248.53268-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815041248.53268-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 07:12, Samuel Holland wrote:
> Use enumerations where appropriate to combine "const" choices and
> deduplicate fallback compatible strings.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
