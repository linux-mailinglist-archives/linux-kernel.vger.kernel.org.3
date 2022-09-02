Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644715AB625
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiIBQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiIBQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:01:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE7C5D108
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:06:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e20so2653386wri.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ULSBxBsOqdpwFzaPZ22j0kNiyro44UCp/qPP6WG4pUQ=;
        b=VfSVdt0GWEa9o6bZAvYBDsj3WBCtig9qxGkAwfoVlHzZojsv2xWY57x7Fh7YfwPhE5
         GB0mK5i92H0+TW0EVBbl4Z2ws0tfCzGUVdApCIWbO3mVbudJt3Vt8UTezgsV38hLHe5j
         92AH2RP3TK2aaPAhUk4f4omkqYcFFZqgeVl04MFaOPNDxOb2rCUNNYCyoageu1+lZ4Mn
         pJpG2bS5815LzWe4SguSR5uGvlkSxfLleQ/ee1phN6JzcpbzmL3BQZ18dW6dh1jloSyM
         2qgTtYilqnpQzMq5tREW31OuWzVUYfkERyo8Dqps25WZNLkv6wCTXW9BqDOR0yCb8jv1
         KA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ULSBxBsOqdpwFzaPZ22j0kNiyro44UCp/qPP6WG4pUQ=;
        b=cCgahVKBIcVySt3+NA4XY7JNSRxBoj7sqB6YZyKldi/ou7l7GG8F88UQwUJmIVP4hx
         mk7K2v6lDWa6Y3hmSIUf+T0RKnfiwe4iyWtVGXBCS0jLknDeQ4VkyBPK4fYkjujqviWt
         8xYROOAOhewcbcxBP8F9Jm9sPbc4DUG4gxU2vr4DBcOrP2SRga6DIyIrE4yq0/K6CEVZ
         88qimEdR8KO2TD3sjZxT+VIyTf11zTvHKzTz5nYpOwCRsViTw2F8nM2J/aADmNQnYPKs
         3gVuetuWz0bHIKehP8Q3R6pxTsXrCFNMrKNu0GDejfgHTYb15RdUeDdUU7yVuSNjUme/
         /Mfg==
X-Gm-Message-State: ACgBeo1wVEDXkE7dBeD4NS4WADswV7jRCN0Sr0zy9ygJhclkmUmXKotB
        jYTGskdBZwDUQSPu82R6Nmppnw==
X-Google-Smtp-Source: AA6agR68fv7LGJO4Aad4P2WItH/nXXhbfO9USrV2UE6cE8X9hGnpoyx8viAUcqabzuBelYoqTdUsHQ==
X-Received: by 2002:a5d:5b08:0:b0:226:f421:79ba with SMTP id bx8-20020a5d5b08000000b00226f42179bamr5194084wrb.44.1662131163314;
        Fri, 02 Sep 2022 08:06:03 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003a5f4fccd4asm8241871wmr.35.2022.09.02.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:06:02 -0700 (PDT)
Date:   Fri, 2 Sep 2022 18:06:00 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/14] misc: fastrpc: Add audiopd support and some fixes
Message-ID: <YxIb2N5BLFyXlm0u@linaro.org>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902131344.3029826-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-02 16:13:30, Abel Vesa wrote:
> This patchset's main goal is adding the audiopd support to fastrpc.
> There are also some fixes and reworks.
> 

Please ignore this entire patchset. Will resend.

> Abel Vesa (13):
>   misc: fastrpc: Fix use-after-free and race in fastrpc_map_find
>   misc: fastrpc: Don't remove map on creater_process and device_release
>   misc: fastrpc: Rename audio protection domain to root
>   misc: fastrpc: Add reserved mem support
>   dt-bindings: misc: fastrpc: Document memory-region property
>   misc: fastrpc: Add fastrpc_remote_heap_alloc
>   misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
>   misc: fastrpc: Rework fastrpc_req_munmap
>   misc: fastrpc: Add support for audiopd
>   misc: fastrpc: Safekeep mmaps on interrupted invoke
>   misc: fastrpc: Add mmap request assigning for static PD pool
>   misc: fastrpc: Remove unnecessary if braces in fastrpc_internal_invoke
>   misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
> 
> Ola Jeppsson (1):
>   misc: fastrpc: Fix use-after-free race condition for maps
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |   5 +
>  drivers/misc/fastrpc.c                        | 337 ++++++++++++++----
>  include/uapi/misc/fastrpc.h                   |   7 +
>  3 files changed, 284 insertions(+), 65 deletions(-)
> 
> -- 
> 2.34.1
> 
