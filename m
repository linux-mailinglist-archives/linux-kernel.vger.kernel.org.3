Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802F04C0DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiBWIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiBWIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:00:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366E79C5F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:00:02 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 502083FCA6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645603201;
        bh=0xTh4hFbTPwbf+ePQ8BHMeIBtxU7/uHwVLEfcY4fm78=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XXBpG94nBYkvSPOPtvuP3dGLRH5InnZ6umkC7oOEsvG/gclfQVW7mWq8cQ4o/KeAR
         Gg+OYlDpr+iSu/k/gxXQpQkSFFUtyDmhsOsaLWczsFOpXODA+Jmmv2kc99MFGzd8aO
         wLK6mpw1Dz6UjgV8isd8Ai6YqdA0VnsDiPDz0Tlzse0aGgAj88wn5LaScqH1BoD55x
         CZ20f5Ep0D+K35o7iij4CKyBRFv0t98uRBqwDttYGwMPoy17arG7ZmOo92mCU9oLwq
         YMQe4OIT6/6px61fqYqbz3m0A4HK/D/zQqgrx5ygMBnR087WulubdroWaGnqbnc1Tx
         I7EmkkkeYgMPA==
Received: by mail-ej1-f69.google.com with SMTP id sa7-20020a170906eda700b006d1b130d65bso2812405ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0xTh4hFbTPwbf+ePQ8BHMeIBtxU7/uHwVLEfcY4fm78=;
        b=IUnBnBLF+MPWO7OkreWoMNYrNDLytU9ecJ+vMD0BujIdXbRaeHUsgxyi4YtookLnko
         PofCeX/Bml6n05ZsB0dCvcRNQ0wMbQW5C0QmQXNBJavSAZJh9vu7tA5ZSdpYSpVu7PfR
         Y0O84K42iro4Pnfp6r4kPp9kzeIQR2fUYOtlw6VODTWsA/FDAz9kbFnIiHrXdP9CVm0o
         wf/yf/3zg9nCiRVOLPrnJQ2JIO/wSLZ+4H/kHUkOFILkGU6ZKoLdnNarDvk+H/RzjLZu
         QXpUxgVacqxij/VQRNSlNtdt4w+IOAXVtqlsZAK7+leDpjRmCPO6a1MXFT9Z3Tgevwrv
         3gdw==
X-Gm-Message-State: AOAM5318dMmTa7j6r/ib4YJwQzxMNuuBPUNHF1H9tHOJ35K369IWhcIB
        sbfG7QKs0k0ZB6zPdCODWAEVRL7YEdub1sjG7koZhZl7hWqjBPhNXCVjE7ydnUnnsR3tEKbIuDl
        LyU5qBVIziNRS/e640zb2axqxA+XUPrY6ONzA7nESyA==
X-Received: by 2002:a17:907:78c2:b0:6b7:ecfd:7b94 with SMTP id kv2-20020a17090778c200b006b7ecfd7b94mr21592120ejc.370.1645603200903;
        Wed, 23 Feb 2022 00:00:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbTuWFvalNHVl71bvqSMslTNLiOjQOQDzYAoctBuKPGYWkAs8WXXS8I9PjQCBFuI0UnVbTAg==
X-Received: by 2002:a17:907:78c2:b0:6b7:ecfd:7b94 with SMTP id kv2-20020a17090778c200b006b7ecfd7b94mr21592099ejc.370.1645603200691;
        Wed, 23 Feb 2022 00:00:00 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id h5sm7085865ejo.124.2022.02.22.23.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 00:00:00 -0800 (PST)
Message-ID: <3abfe9cb-68d7-5644-c422-226ca259e7c9@canonical.com>
Date:   Wed, 23 Feb 2022 08:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add sc8280xp to the RPMh clock
 controller binding
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220223044516.3776637-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223044516.3776637-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 05:45, Bjorn Andersson wrote:
> The Qualcomm SC8280XP has a RPMh clock controller, so add a compatible
> for this to the binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
