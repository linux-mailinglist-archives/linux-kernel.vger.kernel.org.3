Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93204492D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbiARSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348215AbiARSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:41:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2FC061747
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:41:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so3182482pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ay3fyST/TB94sONxHR7b5By4j2QtODR7DIN157vfh2M=;
        b=TXlXir0BydZWbO6nWqig4vnOEv/uUHMdfltWYngoqHR49H2kUqpAWq1g8yvAxGHLZc
         OZPVjLuLcUPW8n3IYZbq5qOEqs1geZz9C7N4pDT2nvo3gh6vjJJGPFKHuQpI/GJ62FSO
         fcmOyj4fJN37FZCfIbVQZeJpRVp6ISit2Eds2UfQQw7ICgmHbLUQXYPDmQUJI5rQGzJ7
         0OpMLelp7bgpVmrvl9Scx39HvwgCgmnA5E1A/uCZI8uDmjtx2huFBMZlIad8DK574dph
         dYI6lZxwlh0oRw+Jq+gwPUggdcIRpRR1Q/NyuqlmqKQSnRMphhb3RWwjzQ4mOR4pbf5P
         V9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ay3fyST/TB94sONxHR7b5By4j2QtODR7DIN157vfh2M=;
        b=NsidrtiEKONdN8G80ZKhhe6iFmdng8FQV34Se3qKrMkIHAq7gyZoJZPm2d8U4a6knC
         9BsIDNfnI38gMGdY8yY/N0aXpG9+DI5+BE3rDx8CzUrKyw74h+h9fL9VbOgCLa6gJSR0
         E784w0HU5MBQtCcFdx+qJP9xI0VMBMUp10UuXJDdOzSRWsf8KWJvX3jJXIJJBp8rCYJp
         P8vnVg2S3dV3o5EjaAhHc7INfPCokiqemX79A8uL1uF3dc7J7PA+ths+BdvVdQOdwj3g
         IrFBy2BhJkS7nFRSHIsnoj+vlXinfBvHtjOCmKwC6wdPkmdXGkBhwtbyJZFPC8tHczpP
         B77g==
X-Gm-Message-State: AOAM531gvhuGLsTah40JjIXLES19pAuivcYNAzQ2j122oP7sBWaQEW7D
        NruNiXNOKh7TQpkTz+2SDzTIbg==
X-Google-Smtp-Source: ABdhPJzSd7ETEMlNr+rW4yuEu4Kx+V2y2FMIlXPfLonnXz+cw5D5VuJApAptMjw1XJDzduHRJa+Inw==
X-Received: by 2002:a17:903:2287:b0:149:fa57:ea87 with SMTP id b7-20020a170903228700b00149fa57ea87mr28483960plh.94.1642531287656;
        Tue, 18 Jan 2022 10:41:27 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s24sm17192814pfm.100.2022.01.18.10.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:41:26 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:41:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Message-ID: <20220118184123.GD1119324@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-4-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33:25AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8QXP compatible
> 
> Add a new property rsrc-id for SoC which supports SCFW. This rsrc-id

You are introducing an acronym that doesn't have a definition - I have to grep
the kernel tree to have an idea of what SCFW is.  That consumes time that I
don't have to review your code or someone else's. 

> is used to check whether remote process is under control of Linux or

s/process/processor

> not.
> 
> To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
> cores, need power up M4 through SCFW, then M4 could start. So introduce
> power-domains property
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index fc16d903353e..ed1bcb3046a9 100644
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
> @@ -59,6 +60,15 @@ properties:
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
> +    maxItems: 1
> +
>  required:
>    - compatible
>  
> -- 
> 2.25.1
> 
