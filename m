Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FD4D4818
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbiCJNeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiCJNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:34:23 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA4148657
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:33:23 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CFAB53F1A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646919201;
        bh=pf7ItnfaW7ig7cvFz3o50P7qA0KQs4HS2dTOLYB9BVI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=o8efPZql+rP+zbs70OTRjhErME2z6DNP9NugHfxTGflcNah9dG5x+ydJs6omeftKG
         6fVrlIX5+v5RCXha5DWZZKKx0Mspa6FzoEkZDh9bviWvwQX3x1T/INNtygWkLxhf6H
         5vzZtX0ZrifjMLkcGy/C0AqRqz4r8n+/Fnzs4dHP07Ml5N9BFrWGmScylWZMBizZP5
         kQzc0v/fe43L0rdOQCGUsbJEio8xFRWz/WE6jblSXj25y5y12utICH+BO1Y3oB1YkO
         o1SslPsTmP7zqzYoTod1Lqpr459Km/e6d3opUtiLcLPIwrsjPdpT3TPbLZ5Gob6S91
         bAGroNkVjU8Pw==
Received: by mail-ed1-f71.google.com with SMTP id l8-20020a056402028800b0041636072ef0so3077615edv.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pf7ItnfaW7ig7cvFz3o50P7qA0KQs4HS2dTOLYB9BVI=;
        b=WqS3dlvwJX2GWVa9qHYuU+1QvTP2hnfaP1xtSlQ1VVOQJ7IpTCz7WMGeaL5Zf1F7R7
         QOZBuNZGbwMJ+cMBE47k5y2/Rz000NS042iJm1D96+BzRqw6lkKbceTX3ZsIk3R7Fxg8
         qbWE1RG+O3ZyQJPhaYHJHeN+IBpSRqHz1dol28VBPAqiUZBn9Wn22aOT8zkgrTdbn62x
         9O74ejx8QqsvCLJT6NCsUU1gfDAp+ip4TzAbXU8WR1iuUsqPxWIRTNlze7SV3+Y/3zfH
         Ai3vbDQLmOSZOiMGR7QdzZxLSQnoXg5IVR4g3L4LoOnWWO4QVBU9Sji3qPMujha9IkQD
         Qrfg==
X-Gm-Message-State: AOAM53300GUPnp+Mc7KJcaVzcgJNzPy4cGxpiJfIW0i3TgGuY0Fwc/RA
        MzdkZ5cr/+2i1nHeB7vaoQM25SJI8Bp5h0SgydrwriH+/mStL7O3RVBnCQRPEqMxzf6BPfVcBox
        WQz6N2tAXz909W+yNMWDw8VSiVG901fnG/aW3NoWF1g==
X-Received: by 2002:a17:906:74c3:b0:6da:be6d:d64b with SMTP id z3-20020a17090674c300b006dabe6dd64bmr4324839ejl.695.1646919201542;
        Thu, 10 Mar 2022 05:33:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCCnILWS6O8NF0QccmUIZKB7piFBemuWv5RosCsexSn5KFanUN3loK37T97Thy/V43ongQTg==
X-Received: by 2002:a17:906:74c3:b0:6da:be6d:d64b with SMTP id z3-20020a17090674c300b006dabe6dd64bmr4324818ejl.695.1646919201311;
        Thu, 10 Mar 2022 05:33:21 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm1821076ejb.220.2022.03.10.05.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:33:20 -0800 (PST)
Message-ID: <75695818-3d74-b809-bd40-ffbf4724df47@canonical.com>
Date:   Thu, 10 Mar 2022 14:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, michals@xilinx.com,
        robh@kernel.org
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
 <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
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

On 09/03/2022 13:00, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..97c7229d7f91 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,17 +14,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    contains:
> +      enum:
> +        - xlnx,versal-cpm-host-1.00
> +        - xlnx,versal-cpm5-host-1.00
>  
>    reg:
> -    items:
> -      - description: Configuration space region and bridge registers.
> -      - description: CPM system level control and status registers.
> +    description: |
> +      Should contain cpm_slcr, cfg registers location and length.
> +      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.
> +    minItems: 2
> +    maxItems: 3
>  
>    reg-names:
> -    items:
> -      - const: cfg
> -      - const: cpm_slcr
> +    minItems: 2
> +    maxItems: 3
>  

One more thought - it seems three items are required on cpm5, so you
miss later proper allOf-if: which enforces this.

Best regards,
Krzysztof
