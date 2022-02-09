Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84534AEDB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiBIJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:10:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiBIJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:10:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A9E03CD97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:10:29 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C33B43FE41
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644397645;
        bh=ukUcgEqDwtgLJM31dxy+4xX8XcrHusscNiWdsQHxisk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=K5BTAT9OZLppVVCleY3m6YFExMG/1aHjtHlvFl6kP1Sj+PaqFB0ZtzT1fpw+hRQMn
         ndf3GkG/gGNXF68LMwhBzdDpwtAD1q0SVe/Cca30JjXc/d/nK73IbX6vDxqSRciDU+
         u6Zzy5MY9l8O/gtD8WniCBw/tS7LwYm0tjGQbMhK5DlJxx/Xj4z5y9tiMrKqPHkbj2
         Y6DAVLON6CXL0CovoPGt7vlro8Y+oiUITb4EwOx/UGf5Qpu7U0831WHVB5yARYTUwa
         bG3C+I9zyk8zzRuWt0WivLDc5nBLZWo3M4wQA6DPKqdIkTp//dszxfd6VPDWnEwgfy
         IgG1KN3VBTxRQ==
Received: by mail-ej1-f69.google.com with SMTP id z26-20020a1709067e5a00b006cbe0628826so885597ejr.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ukUcgEqDwtgLJM31dxy+4xX8XcrHusscNiWdsQHxisk=;
        b=Ofd5NptPTtzUKEGlBd4jcPq61DTncworZ0PnBWbTCi3tjUH8IMy1tS85ez4jYrEwkV
         /FfSgtwwixmPbYOGGn8+MP8TrheBFsWrj5rA1+Y/GLsE2uNC6k67yjlVxoF2sVS7oFut
         AJzuVAWlB3kqNqT4o8x/PJiQ9VC0ZybIWCfNJTurTr6dCeom7Fp0fxyxl7zzMsJkD3PJ
         00JTJ3nLe2cCqh4RPeMgH7INXng7SeDVu+40puC8RehBLfBF26/uL8r99+84TB4sXXjP
         YLxfRPMGN9gG8+o39v9dHd+Zk1TqKJs7X4TAN4HyczEL0PnJngex8sFh/tuRCnZcilbt
         uuzQ==
X-Gm-Message-State: AOAM530uFCKVpI4UxaxLyVkrE0+dhThpMSKBKbn6FbKUBpw9JRns6mIn
        TcCdr342hFVjAYlNVwaZbzcOp9oTtuQ9mvS2LgI4F1g4jTuC0PiY7guKaBUQc/hy37uVLwbc0fK
        i+DgzTiuVhSkIt2gyj+BGbjhmYn6ChtuE+/xr27noPA==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr1116265ejc.770.1644397643747;
        Wed, 09 Feb 2022 01:07:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9uxWgVcPknk7fehf+KnxlsIBkuqa3Vzp0iYYmlZOw5P2qEBJnVCBCmibBMCkfMCTZST/mHg==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr1116243ejc.770.1644397643507;
        Wed, 09 Feb 2022 01:07:23 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id j20sm262008ejo.27.2022.02.09.01.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:07:23 -0800 (PST)
Message-ID: <1196e292-23ea-78e5-7d72-38586f65e26e@canonical.com>
Date:   Wed, 9 Feb 2022 10:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: timer: Convert faraday,fttmr010 to yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220209090058.1472964-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220209090058.1472964-1-clabbe@baylibre.com>
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

On 09/02/2022 10:00, Corentin Labbe wrote:
> Converts timer/faraday,fttmr010.txt to yaml.

s/Converts/Convert/

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - added moxart example
> - relaxed some contraints as driver only support one clock and one
>   interrupt (as used by moxa,moxart-timer)
> Changes since v2:
> - increased max size of interrupts
> - fixed all issues reported by Rob https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220126160021.3537591-1-clabbe@baylibre.com
> 
> All aspeed-bmc-vegman*dts are expected to fail and will be fixed via:
> https://patchwork.ozlabs.org/project/linux-aspeed/patch/20220127141604.1163-1-a.kartashev@yadro.com/
> 

(...)

> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: true
> +
This should be false (and was false in your v1).

Best regards,
Krzysztof
