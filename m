Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245AF463EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbhK3UH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:07:27 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43894
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240062AbhK3UH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:07:26 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A57B3FFF1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638302646;
        bh=fw6PzsUlrYkA4VQaJdC32HD2E/40nvvVW3E5iBZZ8sw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZqT+azvMuca5WILsodHk59gH5gaHyYun9FX4GOr8hghRSJu0Ih/RBodaTh+84WAJ5
         AXGCp07A23JVc0NQqowelqXUDtrmufVuh7LxJ4HpxOtdglweUWgKC7VHhJzi9CJUs7
         OetpkpcoeY+W2Lhd/hMQ/NZGHLR2HGmRGZtcHvNUpy1F3zdvNKNUrEFTMxYnpkc9EF
         5y+ph8Jjk7qEiwFtjxRqzgNBn2wU0x4GRljGvmucsPbSkcEvBUNhl8oFYnmg/WMBzF
         9wp626VMC4Qq/LGkVuuhici/RHFO9w73elKQVHpA3864ONSsWxAvxNrfPhEczaJ/WX
         7Y5WEWT+JmcPA==
Received: by mail-lj1-f197.google.com with SMTP id q19-20020a05651c055300b0021a259ae8bbso7924866ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fw6PzsUlrYkA4VQaJdC32HD2E/40nvvVW3E5iBZZ8sw=;
        b=fE/jIqQYHHoC1rQoCOrvICrVjjdeoHZuS32bBCWschKldATDobeQkApXP2h/cOLJYP
         rW+rBsMmZgJ4Cd46Hckh+veClF4SVorW2yGtuuCL6QzeXHcQr4dHJ1Vl0AxKgSgHAjmS
         9/aYAnYXYywhnSl5oFdtls0eOG2mjFFY4fBrX292TYU9QmZBjZC1nzz7Vc11CMNIo/qM
         /mrIgA6f2JY6/+FCPOXpY7nxPLhobDKGPV/iRDRS6j8CxLTh2M8kPNlSlzvJAWZvR+SG
         +1KRJyXCgcYm5sP+I6HK+AJgI4WVI8n9IZaeCE/Ke0qj3zP39Q1jTq10fJavnft7u6tb
         cLnA==
X-Gm-Message-State: AOAM533Ccak+MiHuqdDC34EtVCOVp7w9LBoFq1TsBYphXCH/9BeMu7+j
        LDS3wrmSEDGTT9iAILXBL5qT4kM5ApfF+yZ2Yy6OGV67DVK4EyHZBcZ9xDzhw9/tUvpBigJr8gL
        CKJiqsfAJ0vuhUcxYu9i+5xFiFIz2EODEJHPdEHiZiw==
X-Received: by 2002:a05:6512:1313:: with SMTP id x19mr1315898lfu.279.1638302642903;
        Tue, 30 Nov 2021 12:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFLghjinwu+ez5oEJYvHxibl/oZqNQ9vjDrtAMuAhvpEiBodlkvDGbx0fxE9dNxNZ4Hjs+pg==
X-Received: by 2002:a05:6512:1313:: with SMTP id x19mr1315862lfu.279.1638302642618;
        Tue, 30 Nov 2021 12:04:02 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v17sm1816842lfd.287.2021.11.30.12.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:04:02 -0800 (PST)
Message-ID: <4b5bebb0-ed74-8132-1e6b-cb7cbc21439c@canonical.com>
Date:   Tue, 30 Nov 2021 21:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-serial@vger.kernel.org,
        Youngmin Nam <youngmin.nam@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org>
 <1638294184.179325.2713642.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1638294184.179325.2713642.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 18:43, Rob Herring wrote:
> On Tue, 30 Nov 2021 13:13:21 +0200, Sam Protsenko wrote:
>> Add constants for choosing USIv2 configuration mode in device tree.
>> Those are further used in USI driver to figure out which value to write
>> into SW_CONF register. Also document USIv2 IP-core bindings.
>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>> Changes in v2:
>>   - Combined dt-bindings doc and dt-bindings header patches
>>   - Added i2c node to example in bindings doc
>>   - Added mentioning of shared internal circuits
>>   - Added USI_V2_NONE value to bindings header
>>
>>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
>>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
>>  2 files changed, 152 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/samsung/exynos-usi.example.dts:35.39-42.15: Warning (unique_unit_address): /example-0/usi@138200c0/serial@13820000: duplicate unit-address (also used in node /example-0/usi@138200c0/i2c@13820000)

Rob,

The checker complains about two nodes with same unit-address, even
though the node name is different. Does it mean that our idea of
embedding two children in USI and having enabled only one (used one) is
wrong?

  usi0: usi@138200c0 {
    // enabled device/child
    serial@13820000 {
      status = "okay";
    };

    // disabled device, keep for reference and for boards which
    // would like to use it
    i2c@13820000 {
      status = "disabled";
    };
  };


Best regards,
Krzysztof
