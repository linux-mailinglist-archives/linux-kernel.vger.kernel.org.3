Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF14D4355
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbiCJJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiCJJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:20:37 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90FE1390FC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:19:36 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F6D83F202
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646903975;
        bh=wolYD6gWpPa4mgxaXy7jJAPNgL7qzDoq13axnLPnNdY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bEoswCjw12MM10HwRiNVlPmIcUOZlPQkmeinKVCPbjhQDsDJO1t2AenY2SC9U5zcZ
         Zm4EFczL43X2m3Kw1K24MmPrdwVo3g5mcZbX1zRwFl5bSB1nUnrepXeys0zfbEGkPu
         UIRO79D/4Xv4idqaPWMg1Gh4TGjThB2TYWuR8JsbmqZ/MhL1ZvLt5IhWHyBEZvCWv4
         Gab2TIAVxb5pUOgaDhLHlpVDvwfZ3XxJx6Uj63ubQ3cdL8IUfAxYxVb22zTGXycvRa
         gxLH+sa5aAAKiTDSODj5nRoqyWsgiD7Rju+6r96hBb1AZ0uNaO/3U8sktfScbahBrT
         nNtJ1D9IvMvqQ==
Received: by mail-ed1-f70.google.com with SMTP id l8-20020a056402028800b0041636072ef0so2745638edv.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wolYD6gWpPa4mgxaXy7jJAPNgL7qzDoq13axnLPnNdY=;
        b=g+c+NDqTuUhgx3StIgZ30LjJDU8pOL4/Hh50Rlj31KOus1344d92mk1bhmauuFwlOY
         LMr7LmY4snHF8z/5ZeOBsqZvz+A4eLtSBcVgjOEJvAYSEq/Y2SV8Q/W7Dn+4HPLxGltP
         rLnzUoegkEw3cIgYWyZsAaHH2an7TV86J4Ffod9NDfSYusICLd6TogVtWPv3ydv3ZVwF
         NJQ+vAg5TGAZ28iRn9pHsStHUvKggKyScO038suera27LrNftemIx2mSjPvxgfsIIs5I
         IOgWG5gyVyHRNatMN/zwdRTi/lqy05QWw0UwQuDGTvTSkf5I8kLkxFHx9pX3oH5R91dI
         kEUA==
X-Gm-Message-State: AOAM5331njM6flWYqfJzy2FMQZD51JWSlADDmF7D2lVGKOAnnnRLkxjE
        vEuYuCPTUWuCcF9Kc6gCfbDTRUeE271dnYj5Rqjm2aYoC7n0qXUYwf+O43bE5NZJbCncTs8X2+S
        8lNLANDc4c70R1xWv92sxeIwaa+99hD7PYGlcM9D0Dg==
X-Received: by 2002:a05:6402:1e89:b0:416:a641:9fe with SMTP id f9-20020a0564021e8900b00416a64109femr3324147edf.312.1646903974976;
        Thu, 10 Mar 2022 01:19:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEpz4RRjBaSivyyvtfkaXEPL3a3Xc4qFVuAT0sgvUR1JBq5DBBq0dWHJsog6DnKViiuQZrZg==
X-Received: by 2002:a05:6402:1e89:b0:416:a641:9fe with SMTP id f9-20020a0564021e8900b00416a64109femr3324129edf.312.1646903974756;
        Thu, 10 Mar 2022 01:19:34 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id y6-20020a056402358600b004166413d27bsm1772019edc.97.2022.03.10.01.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 01:19:34 -0800 (PST)
Message-ID: <e9f73649-8361-c844-8ed5-9e1132f991b8@canonical.com>
Date:   Thu, 10 Mar 2022 10:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: arm: Convert QEMU fw-cfg to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310013552.549590-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310013552.549590-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 02:35, Rob Herring wrote:
> Convert the QEMU fw-cfg binding to DT schema format. As this binding is
> also used on Risc-V now, drop any architecture references and move to a
> common location. The fw-cfg interface has also gained some DMA support
> which is coherent, so add the missing 'dma-coherent'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/fw-cfg.txt        | 38 -------------
>  .../bindings/firmware/qemu,fw-cfg-mmio.yaml   | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/fw-cfg.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
