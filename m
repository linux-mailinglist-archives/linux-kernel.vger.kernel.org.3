Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08B4D368C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiCIRUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiCIRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:20:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1DCD5E1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:18:49 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8CAA23F19E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646846324;
        bh=H8Ivl0XLyOS7GNgoia0im1pfPz2SRotfVrPwXjnk3/c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=skfAzQurnGVDBoYR3TBZ8UY2SO7EeK2ILGG02shS9b75zwGYO42u/quib01t3ocPF
         ifyqS6J3hKX9wLI4jwc9XBb07FZJPoI+eyiQ83iF5bdzIAIxgR6Olja3DGhZwoZSqR
         5y6ARD7cPimoBd1BA8ZdEJxyuY9ysSGGVox/3G+38nclqo+1YWXEMxmwFCcqVSKShQ
         YlbQ/r2M2SwvgX6BN50oxuJ3U0UE+97aWiyANwuYuKFxxIQjbrUrirRcnfnPd0oP7k
         HIp2yxRXkGtCqGqojLatOCMEwRC/4TlHfFqd9tqSHbsijMf+0cFxAc+zXj83LbxjNq
         VXQpItKVuImxA==
Received: by mail-ej1-f70.google.com with SMTP id hq34-20020a1709073f2200b006d677c94909so1662104ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H8Ivl0XLyOS7GNgoia0im1pfPz2SRotfVrPwXjnk3/c=;
        b=EWCJp0UKc2iXxOpllq9a6xUw02r5Kg4yeOeRL5XI3+CVdeTmPJzzBYbzx48Ulku1Pg
         V4sm7tYlHOAyCTONf9QowuPnyK/MPP3uCd/1L7DhJ9w2OjvQsyoyehSiAUmaq+0hp8sh
         5Y6Cr4evJPS+QD5OmZMfmf/uW5H/0pC/o3qtVi6wXbCoFqx1YedmBwB+Z9w/SXqgolAL
         YbWYlBK/FjQyY6YXi9l3twQzrlmCox2iTSB1+KcQZNfR/5th84bAXxYQuzPrf+jBueKA
         nWsJFVhk1UvmFDH1jHQEYXUF6jlg+Kribhl3lPqBaJLtNW5rGQCABw4IGhOFe+U0WzBp
         PrHw==
X-Gm-Message-State: AOAM531GoY+6hpbzVq3wZIBUzhcFJqpUGO5DJ7FXaPux1UG3w8ksoYOK
        SVkhanujMvxWVWBGEu7Q6A8Is9H6htT+Tk3u/hBa/ZPYD1Jepp+TQXMaVuLrOFoHqhkHNMnt5LO
        fuy+OxIY106Us48HMijkeUYlOGbT8KfqSMOvF7taPYQ==
X-Received: by 2002:a17:906:3cf1:b0:6cf:86c6:8a12 with SMTP id d17-20020a1709063cf100b006cf86c68a12mr749671ejh.202.1646846321157;
        Wed, 09 Mar 2022 09:18:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoD6omDe6HZFAnJP+cvkzbuKcGFkT8i7+ULUKxhNjWehKZ6E0AiATCG5uWRGdE3yK+Z3N7TA==
X-Received: by 2002:a17:906:3cf1:b0:6cf:86c6:8a12 with SMTP id d17-20020a1709063cf100b006cf86c68a12mr749653ejh.202.1646846320969;
        Wed, 09 Mar 2022 09:18:40 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm969225ejb.182.2022.03.09.09.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:18:40 -0800 (PST)
Message-ID: <b7ae988c-b420-83bc-0a4a-e82393d1549f@canonical.com>
Date:   Wed, 9 Mar 2022 18:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QXP
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
 <20220309102118.8131-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220309102118.8131-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 11:21, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8QXP compatible
> 
> Add a new property rsrc-id(resource id) for SoC which supports
> SCFW(System Controller Firmware). SCFW manages resources using resource
> id, here the rsrc-id is used to check whether remote process is under
> control of Linux or not.
> 
> To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
> cores, need power up M4 through SCFW, then M4 could start. So introduce
> power-domains property.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index fc16d903353e..f25c203dd2f9 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -19,6 +19,7 @@ properties:
>        - fsl,imx8mm-cm4
>        - fsl,imx8mn-cm7
>        - fsl,imx8mp-cm7
> +      - fsl,imx8qxp-cm4
>        - fsl,imx8ulp-cm33
>        - fsl,imx7d-cm4
>        - fsl,imx7ulp-cm4
> @@ -27,6 +28,11 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  entry:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Does not look like a generic property, so please add vendor prefix.
Suffix also would look good, so:
"fsl,entry-address"

> +    description: |
> +      Specify cpu entry address for SCU enabled processor.

s/cpu/CPU/

> +
>    syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -59,6 +65,15 @@ properties:
>        Indicate whether need to load the default firmware and start the remote
>        processor automatically.
>  
> +  power-domains:
> +    maxItems: 8
> +
> +  rsrc-id:
> +    description:
> +      This property is to specify the resource id of the remote processor in SoC
> +      which supports SCFW

Needs type, vendor prefix.

> +    maxItems: 1
> +
>  required:
>    - compatible
>  


Best regards,
Krzysztof
