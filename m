Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99434BB825
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiBRLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:33:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiBRLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:32:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BDA2A0717
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:32:42 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C80C3FE41
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645183960;
        bh=UvFAlplJwnxMAQBlNc5igwERL0YBCCEO2tKezb7VW+A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Z2bNVh6XLleHxDbY5PwyQgeshjB70zlxdh+Gegl3/4gh/hEx/xdN8vD4+rPi+fTqV
         0aFsE0I/a5N0MfOalCvsiUBmcdEtcKah4S1CnNROVU408gzUdjyk49LCJhfQSxgPON
         jqrIss2KgaFYTolBviuhKHPDICijatUHEfiERABKtwLtwmfdvWNHP/5o28BUOEEdud
         n1Ru28FKdDgpdjKk+5aqekjZosi9DORKwAxQ5g7GycBerq9CMBq3sOJicZcNMd4AJu
         zU9ST7LtVeDIOWa/YLdXLeLC8nO6HAOkFi5tAuEwdvrkTTCLWqEyru3JGHiyrIDA9K
         nkZc9TIvTbgoA==
Received: by mail-ej1-f70.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so2911886ejk.16
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UvFAlplJwnxMAQBlNc5igwERL0YBCCEO2tKezb7VW+A=;
        b=lD5e1UFITdZ2PUx0JaaZ17Gg4+XvmS6ebe608+CX6+Bzx+3KNzTzSOZ4+qHl5q9E0x
         avFBdYrs5crcSLduJuG+jAvoZokK26tqF79oVvZPclirzNG6HfSx50flypXsqbpPJ/w/
         wtxLDOATdMiZbKzYQLS5z1flQPx3FTZP7TbxNd7YDQGqp8mBI36xpg4n5xua9dtGJEma
         V1SRm/u6ShjOpQs5rGjqiiM9PaUvpTgpIWojuEErIwv910CZaQ/KIrSdu8hHrCA4x0sw
         FpfXwADUfQhiFRA1/OAABCpyTtW7tDXKbu3eka09krCEY7poIXAe8qUmYMHO2PKCqKpA
         C4vA==
X-Gm-Message-State: AOAM532xd+wMznbDykjv3dPGl3LsEMQ6NsJna3L4bvUfqJ8HweJck7Js
        ZOugfIHes7q+3xx/3Gu69Rk/m8sssM1MGb84KQZGyfYX0W8rjivMlcNB0An6jm7iVHFDvDvX7Kb
        yzC0Uqc8MAjRx4NDPE/egPNKAkWJ/TrPhLt5k2EJ8sg==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr7948024edi.154.1645183960091;
        Fri, 18 Feb 2022 03:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2BGgtV4Rd6cxQm5ku1pja1UubWBVIolHvtF8LVAKjcSADCCBUKO4UoAMMNJvsWlax6cMtgw==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr7948005edi.154.1645183959873;
        Fri, 18 Feb 2022 03:32:39 -0800 (PST)
Received: from [192.168.0.114] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i6sm2177831eja.132.2022.02.18.03.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 03:32:39 -0800 (PST)
Message-ID: <12b558e3-dc99-db6a-73ea-7d704262ac6a@canonical.com>
Date:   Fri, 18 Feb 2022 12:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] Documentation: dt: extcon: add optional
 input-debounce attribute
Content-Language: en-US
To:     Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com
References: <1508406773-887-1-git-send-email-raveendra.padasalagi@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1508406773-887-1-git-send-email-raveendra.padasalagi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2017 11:52, Raveendra Padasalagi wrote:
> Add documentation on optional dt attribute "input-debounce"
> in extcon node to capture user specified timeout value for id
> and vbus gpio detection.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v3:
>  - Modified commit log to name debounce-timeout-ms to input-debounce
>  - Added Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Changes in v2:
>  Rename debounce-timeout-ms to input-debounce
> 
>  Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> index dfc14f7..d115900 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> @@ -10,6 +10,9 @@ Either one of id-gpio or vbus-gpio must be present. Both can be present as well.
>  - id-gpio: gpio for USB ID pin. See gpio binding.
>  - vbus-gpio: gpio for USB VBUS pin.
>  
> +Optional properties:
> +- input-debounce: debounce timeout value for id and vbus gpio in microseconds.
> +

Use standard unit suffix. See schemas/property-units.yaml in dtschema
sources/repo.


Best regards,
Krzysztof
