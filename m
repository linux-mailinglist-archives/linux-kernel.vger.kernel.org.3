Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F088C4D4390
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiCJJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiCJJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:30:24 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F44FC70
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:29:24 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2DC83F32D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646904562;
        bh=1NdJWh/PvB3rUR4jNqgZINU0/6CuntLvKcmqadFgqrk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XHDZTLf9MkTlTSI+7JVhith+BSQbETCwM6WorVsHgMMrzIqtFEK3w9lgFGKTeUpNT
         PdVXHiihtiRIWrjmcoWKCCNf67Na/kvZY4V3ZabOyV+SgbmTgqtTrfQRmneZsOjkcR
         zF4JVt+NqnSwLZ7W6zvxlIJ1+G8MDYOSTG4HbliTnOhIDQVkbPL4Xrg2O2A4hwdkiu
         AId4ysmIpwneu2l6WaL3hpxTWmtDdlodjR/tDxj2by+npIVMcyLE/Xv5h3QF1t+P+a
         raCgnFAuO9T0YZJ/2ugRdL2K7vGT7DlIR8V/gKSLPmQRWLaDsUkWhh4264DE+oKdlo
         wtHrhnkM2ILqg==
Received: by mail-ej1-f71.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso2777829ejf.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1NdJWh/PvB3rUR4jNqgZINU0/6CuntLvKcmqadFgqrk=;
        b=jZbUiaD2M4Twf4B7xH33QayJNdxLUiAJ10ZTnx2N6WtWsHy+2/6QbOertPGr1QSyeb
         ZOGPQNJLDUVdI2A3ugPergp4G/h7Nrz/giZ/1nekMajGaYT014KUNo8N+meRrCB7IsuF
         DdYWlszhVTiMLlQywyst1fRf5a1G2q0I82hyc16+eE87RAy6Irr4zyiu46PolkbI2YUh
         dYboMuf3XzNbp8rn5NOLeBsF/KipHJiYBKhwOtwz83fdR+hw4NUfEoz2xkgRNcM8lnNa
         8EMUl4EPKmKEyFUpu/cFCIS7n2WX3KM+nOxfCAjJWa6C7x91Vq1KWG3lcwL2BffP6LtK
         TFqA==
X-Gm-Message-State: AOAM533PxceQKETB8N1oP8MKAKOeNrZPkvGlRVjiwdI9T/PZ0+4gFNGX
        hkWozB0x9i1UABiBbAPf0KVCXH6VfGpFmY/ZL26ppvrk+o0tNa8/Zzp7urQfY7Ayk+8CMCDget2
        jntCsMZeNnh8l569V4duI7sCY/ZIfjZPdPlR2mlrQDA==
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id r16-20020a170906a21000b006d509fa11cemr3628268ejy.172.1646904562604;
        Thu, 10 Mar 2022 01:29:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsL/hVWFJ2S2dnF40xaxa9bw6b0lYz8CaZYtyrcNxk8PiNss5Y44G6uC1XRYU2bqtrqXyM6A==
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id r16-20020a170906a21000b006d509fa11cemr3628254ejy.172.1646904562431;
        Thu, 10 Mar 2022 01:29:22 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7db89000000b0041372781e69sm1775343edt.52.2022.03.10.01.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 01:29:22 -0800 (PST)
Message-ID: <8e531efa-1619-a337-0d54-5f0cc24404f7@canonical.com>
Date:   Thu, 10 Mar 2022 10:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: Add QEMU virt machine compatible
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310021224.599398-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310021224.599398-1-robh@kernel.org>
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

On 10/03/2022 03:12, Rob Herring wrote:
> The top level QEMU virt machine compatible, linux,dummy-virt, has been
> in use for a long time, but never documented. Add a schema for it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/linux,dummy-virt.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/linux,dummy-virt.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
