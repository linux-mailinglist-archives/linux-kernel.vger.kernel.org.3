Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0851383D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349098AbiD1P1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiD1P1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:27:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77191B7141
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:24:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so4541866pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QdhV8CDaw7JkKEE9tx4pn2GT+kkUsub2XH7WvC9j+b4=;
        b=xv7VLWMd1cz4mahyngq4sPHIH1yVBKtCPVw9MFC++tYS7BinGDosWt4GtHdNlvdR1T
         ycVA75dXpZf6RfwcL3JBMP5+lqNWVhVC7/69ih9GznNZcLtduC9PZ3XPm15EdML42tLX
         p2Ikb3FZ5f+r8UkSVz+gj/ayEl1mqWfNnrHEmRxY3r4R78llAlZJMw2BDaMeLlunJaNB
         wyMYG7GWUXltbnebYGSHrRgVHm+mSWSYgYAaeh5PHMweYPTV+lHw8dEHW+LR3MmRFPdu
         +d3zxnR29XOaJdriNI1Bh4t/JYjqFTylC0XMU2nFlQFxzkA9WtLZljsE9wi3UwkbM/EC
         dFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QdhV8CDaw7JkKEE9tx4pn2GT+kkUsub2XH7WvC9j+b4=;
        b=FmrEnjDL6nICHZOvpDMwtonEcOKFs/PpyFBHHKgqH1j/Hl57u3tnH3ExI/o/9Vctip
         z1g0Q+9oEgzeNJTmgqjWbpeuEuX/VdVdo/b4YMM1rKdMo/QG5E7wAw7n2MTfrOmsMMQm
         y1erM/+FX/nSB8eUbV8n0tVoi/GoIm749qeH5+jKSFfY3AmfVZDHThrXStBnXKnTYCDO
         AZrsyAknNaPUC9/ZiABoCTkghuMicGRJn9SzUoLfK4Pebbra2/Wd8XYtUrDWhV9jJKO4
         z8pcPl+6Qyjkl+BqM/CjVRNDFABIPrIo7CxbsR+FYR4PeRPQ507UVeySewuyBOZYwV0+
         ULDg==
X-Gm-Message-State: AOAM531XZbSplNbRCUJCz8VFkymUPNYTR3+ZUQok3qUgsF1LaqgFp6Y+
        1U8zRSnap1vfn5ii05MQGjUESQ==
X-Google-Smtp-Source: ABdhPJwsN59y5bwqXRcvp0+hJ6YMZMdQKurahIbauVk+jIva0dUfxrEV3PS840fiE+oxSoOpHV+bmg==
X-Received: by 2002:a63:4a09:0:b0:382:597:3d0d with SMTP id x9-20020a634a09000000b0038205973d0dmr28421246pga.18.1651159442883;
        Thu, 28 Apr 2022 08:24:02 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w37-20020a634925000000b003c15f7f2914sm3081056pga.24.2022.04.28.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:24:01 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:23:59 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: support i.MX93
Message-ID: <20220428152359.GA2264925@p14s>
References: <20220427092054.3765690-1-peng.fan@oss.nxp.com>
 <20220427092054.3765690-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427092054.3765690-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:20:53PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 remote processor(Cortex-M33) compatible string
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index fc16d903353e..38ffb9ec3c69 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -15,6 +15,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - fsl,imx93-cm33

The devicetree maintainers and mailing list have not been included, making it
impossible for me to pick up this patch.  

If you had included them, they would likely tell you to add things in
alphabetical order.

Thanks,
Mathieu


>        - fsl,imx8mq-cm4
>        - fsl,imx8mm-cm4
>        - fsl,imx8mn-cm7
> -- 
> 2.25.1
> 
