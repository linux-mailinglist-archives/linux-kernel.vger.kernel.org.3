Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C317595A77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiHPLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiHPLnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:43:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE637199A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:14:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j3so10218223ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=O9pHGZVHujpeMWnCK1/1xLcvHuFaohpfkrM32FhJHXo=;
        b=TCvxuXP6wxXxvKskvU4lwECVskKqSVbmLZj+VRFBnzwAZptLkiXudfC9COh7H9QEaK
         NfRVyGKSr78aEVZUPzez8NffkbfjPxIPhXaT6/kEJ842fYqoujAgXM3OOfGl9NtiJVPz
         6Nvgb4L9xGlH9eTNXR3FvAdRbHXw8J74bJXM2vLONCBWrR+wHmhVR9URCv7nAxuj/MfJ
         6QC0buCoiEO1igxslD/mYR9QUB3XQlxH/h2oCf3BPdJ0T4nwjw12CAaGSlar3MJyNew8
         Era9eKwETliMu8NzPD0mRSa4NbP7BGCEhD2lB9OZPKsKIkLfnC/aibJvZaWUSptty3/J
         ut3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=O9pHGZVHujpeMWnCK1/1xLcvHuFaohpfkrM32FhJHXo=;
        b=NXlnrh3bOvuXN9Ug8aI1FoVfzXsqmmQ+P5tjec6el/cSmzJMizGO1Tq1aZErlpq0WT
         y6fgChX7jWEHbtCQxLHK1nQL2kzIzKjsAV0VpigrJz2dwHqD4Vf0Cau58Y+RiXdkQ/q6
         qsM8nmGxYZct0PCNEgEGssQ8kIqnKHA4HAtgRrDLGjOfHM1UK/lg32XiJ9pvWU7DzG8H
         5Dj3pnu/DjPrEi2s32+kKW3KtpBTSuzJTvpisvjYPSpAC+xwc8QJhDNX1EdwD3o/kYiv
         P+Ywn9JR6SGl1zGxVPKssyvn2N9fz6f9GRCQN/m8aEe/nB/QBRJ51PLXFC/XC75q6FHe
         dJJA==
X-Gm-Message-State: ACgBeo1+ZnNh2aqnfIRzzNtFUNMNAvWihaAh19PcgLc6sI4XATuDa1WV
        9rMXpleojCHKkfSRfP333cRVUg==
X-Google-Smtp-Source: AA6agR5fEzLvfeC+9F1Cr3Vuvyt8NnGGjn4fd1dcxYay0Ut+t9+UZTzqORBuYkZ6HhaCCrimKdpP9A==
X-Received: by 2002:a2e:9953:0:b0:261:8021:35b with SMTP id r19-20020a2e9953000000b002618021035bmr4000582ljj.345.1660648467694;
        Tue, 16 Aug 2022 04:14:27 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b0048af47aefecsm1345787lfq.290.2022.08.16.04.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 04:14:27 -0700 (PDT)
Message-ID: <96685b52-efcf-2635-04de-b9e08095fa49@linaro.org>
Date:   Tue, 16 Aug 2022 14:14:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] bindings: iio: accel: extend adxl313 documentation
 file
Content-Language: en-US
To:     George Mois <george.mois@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lucas.p.stankus@gmail.com
References: <20220816102828.182345-1-george.mois@analog.com>
 <20220816102828.182345-2-george.mois@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816102828.182345-2-george.mois@analog.com>
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

On 16/08/2022 13:28, George Mois wrote:
> Extend the adi,adxl313.yaml file with information regrding the
> ADXL312 and ADXL314 devices.
> 
> Signed-off-by: George Mois <george.mois@analog.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
