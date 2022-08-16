Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE35958D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiHPKrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiHPKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:47:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0EAE22B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:06:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id by6so10002777ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3P+rHXFq/Ju0+klAigNeKQlci4oKet9YOA0bldjm0Zs=;
        b=csHnIcOwUWQxrQCh4kMZCM3lIHd/7QbLGLsWO0pdvwAF9+9GQoRb6Ia4FcgmceJfvP
         BHynpZrRt5dGjq8BpcXQdRwEpJ3bDbr2mCaeslxUxw7Ntkl7yZoH4hBtF0JpE6iZxVR/
         JVkMN5M4IiY1ptjbQ0o8GYQOS2H0Rg/WpGUqykfDw6RBj5ij3Jcv19c6YOcFHxtpF7bW
         aTXpX13HCqPzWz93p0tLATReG5w33k29t/MixKOTAxXLsvM2gDJqwsJ1C18dA0y5dq7W
         fAD/WrvRjt0eYtE1RaLUO/0yvAOaHSNRMYrw4AeByRv4h4LsVD17ZnuLgvwA7BMPkSzu
         T5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3P+rHXFq/Ju0+klAigNeKQlci4oKet9YOA0bldjm0Zs=;
        b=DMS0eqOQ8jl+HOw0Shey3S4pahDjMRoWkp4IvvljC0cR8JANh32W33CTvjD6kV3yIy
         h2HRg87eHrJSrGiRZ6swPWI+al5vuBWc6U1n/M0FzKMT1O9mPun+xQ6v0xrYu6raAso4
         Nq3Mkuk4NciZpWbbUgHqrDYysCMvHaZk4Af6jotEkNmoW1As+7kFYMT3bpMZNv27JyCU
         8Rgb8wmBTzpwgOTqWYQUamLeCdrYIv7YpzGYZQvKWppfUEruSTwo9QTiUQDfUIDKLPNF
         fqwyKPvCZotAFoWra5wSgeVOLk/tpqs4/b8wgooGp44JAt1F2V8oc9uhLOJ5SN6t3UFC
         8prw==
X-Gm-Message-State: ACgBeo3AHp2fFyjvZZ1nZylUDrw8c8/XqeP+vZVpW3VVkky/gWh2aa/0
        +LlzqVy4/o87fa3DTog/PYOR9A==
X-Google-Smtp-Source: AA6agR4BH5PwcsY3gEJ8rvtE71DqoG3p/u7jTfoGw6gfPC++4bLqy79XHhPj7FU2rIJuhiD66NqjJQ==
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id k1-20020a2e8881000000b00255779025e6mr6184568lji.525.1660644405978;
        Tue, 16 Aug 2022 03:06:45 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b0048aeff37812sm1328349lfb.308.2022.08.16.03.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:06:45 -0700 (PDT)
Message-ID: <7532753c-60d6-a8cd-b462-bcbf01035d89@linaro.org>
Date:   Tue, 16 Aug 2022 13:06:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
References: <20220812165453.11608-1-quic_ppareek@quicinc.com>
 <20220812165453.11608-3-quic_ppareek@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812165453.11608-3-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 19:54, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes to sa8540p-adp.dtsi file. This will be base for many ADP boards
> to be introduced in near future.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts  | 377 +--------------------
>  arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi | 384 ++++++++++++++++++++++

Please send patch with tweaking -B/-M/-C parameters, so the copy is
properly detected.

Best regards,
Krzysztof
