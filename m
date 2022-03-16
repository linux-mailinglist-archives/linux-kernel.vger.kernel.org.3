Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B34DB608
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357477AbiCPQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343489AbiCPQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:20:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5756D4C6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:19:37 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B6A43F4C0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647447576;
        bh=ZRYQ7z9tZ99+GzXwYfi9q+aq0P3XgrXRoIknWvHPWiY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Da092m7MQiFrclop2JPRDe7V0I3y3BjCBJwYLXQmwQ1xopVwD+NifT1FsgPXiGN+o
         lCcIO9aiDht0Zpd7MA8xco7M6yEZUAD4Lv97xsj+INZveiAaaG+4I5DKz9XIQdGQW8
         T2dvvb6d87YJuvQYQLed2CnGbxNhAHG3LaMIMxbZouxU/sjio4oHxhAaifwZp54o3w
         4eaC2eOhzRydZ8RO6p0+ILlCa5r3xtzYNdUbD1jOP30ynZ7SRhv2CG4AJEvven5/r9
         teeO2RxL5/5v11B81pPlgJfNJupXtH01tm7fxgWnpePvwlOUW0Xs327iUxIJrC9MKe
         M5MXd9hKW/1cw==
Received: by mail-wm1-f70.google.com with SMTP id t185-20020a1c46c2000000b0038c7372b2e5so346000wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZRYQ7z9tZ99+GzXwYfi9q+aq0P3XgrXRoIknWvHPWiY=;
        b=Vtkzqso/IRsg/ickDhLIcn0ItZGl8D7ISeMeIQZRQ5HZh+407FKTDhPmO0WjHOcOju
         ubXeR08a/P7GsrsIhA2kTD3PSQbC1u7ukQUoN0RwcnzIDgiqWSsJthyrMcnelCgH3pCD
         XFxGlu0DiqwwdtJ3ng2E3JFpxLr+iN+10AdYR7rEDTzItz4HYI/nLvdP0sEa0SiHzttw
         rvr708yG1+iJKRQpe4DDCX/3V4gQZDKqitUJ6kX6uHvhpiuah5/BGA0GgaeRSh7DZfXh
         +0OQFc0QVJLlMDieOUJ2asF79n+osTWc+XmG9IkDsYky/AUUfBXTcnH4gYPC5gl3G14w
         hNGQ==
X-Gm-Message-State: AOAM532e5FLXYb/s1x+KB0CnX5fJPhLI3BnV3qqzGn5kx1yreUGAa2OE
        e7UD6/7wYJISBgfw4HGCmNVd2BppiEmuI06plYPK32+DMEQNmHTrjl42ceJ0hxhkuAiqmazR9fn
        /mUaqVOBM1kmjN4C1+m0n/xOfl37KOarnSoYDlwEndA==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr554990wrs.227.1647447575679;
        Wed, 16 Mar 2022 09:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgYANb6+IHUjd2tYv3t6zuG8C+19OKOirVe7PMEmdJAJNWdgt0WY7zKPbaRDMj+QIXT6tXnA==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr554978wrs.227.1647447575512;
        Wed, 16 Mar 2022 09:19:35 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i11-20020a05600c354b00b00389f440512esm5719821wmq.32.2022.03.16.09.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:19:35 -0700 (PDT)
Message-ID: <fe67c7e7-957b-3abf-a929-5ee346657bcf@canonical.com>
Date:   Wed, 16 Mar 2022 17:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1647399369.git.lhjeff911@gmail.com>
 <71c1b80e0083f38de71f36193e12b3cbff2ec852.1647399369.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <71c1b80e0083f38de71f36193e12b3cbff2ec852.1647399369.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 04:01, Li-hao Kuo wrote:
> Add bindings for Sunplus SP7021 thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v5:
>  - Modify yaml file remove reg name and change nvmem name
>  - Addressed comments from Mr. Daniel Lezcano
> 
>  .../bindings/thermal/sunplus_thermal.yaml          | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> new file mode 100644
> index 0000000..176bc07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sunplus_thermal.yaml#

File name with vendor prefix and comma, so one of:
sunplus,thermal
sunplus,sp7021-thermal


Best regards,
Krzysztof
