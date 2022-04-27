Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC15A51222F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiD0TMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiD0TMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:12:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909011113;
        Wed, 27 Apr 2022 12:02:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dk23so5240407ejb.8;
        Wed, 27 Apr 2022 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nRsrSZUdccGt8LRLTvc1f3066sqUlL3H8wQB+8CbAZM=;
        b=oI3+Pk0O84Q7xhxIXyeolKjcngLs7+jcTCJHTa0ksRxWgXNWFSMxJIA0UmAccbtqA7
         F2VjRBWqGNDcNP6jbMzBuINw/oc5sK1/EZD9x1kC7GrfCVGrjq3GRqjGpC8SvSy2rbEM
         dDpK7HnogLvq+qPCx7mybM5IaoBXavO9uXmytlp58AjkbukUaUMsjzCY4cPJMx8Fnxyl
         8jKcrvHJ/Lo+rfLgfgv7+6WP0qIWBEypKOlvY0DPPkLtPtF0ccjRFRtm2/3B0vRmw21B
         MF2BTA3bGpyVP6Zsh03jPM1HwD3XSDSJ+81lVtKJ8mQS/s4bILCpChYQd7migae76qFV
         iDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRsrSZUdccGt8LRLTvc1f3066sqUlL3H8wQB+8CbAZM=;
        b=EwRdhMSuQUHIBBXTA7Rp2NoN8zau7L9Cyf+8Asgcd8RJLcBFSrq3GTaoAd/MN9oW5D
         9pPRypW3sHtEqwulsIr4jcfNqsn/cjSLFA4fdwevYNVkIz8XTO8ewB3MsA/kFrOiTU4U
         pAV5VvesIr4zl0CI/9N5HiUEf9nBX2r7VzoFRzoLbzmYvHQFU3XrT6PxpGBFVs5Fofcw
         BfuzHDlgHvvGP1g8r1iJbJd6mKvdFWoANCfQgXc02dunr6LcX2fS2MhtbtzGOsI98chr
         V6KkvPPHi55ZoxaeHWgllWDkRSVs5Yo0ZnffEyCz2izEr5mrqQEsQ+cnGfUb9jOFEWmC
         eGdg==
X-Gm-Message-State: AOAM530zrxdVtonZFMrzA46d/ONBmyJfjRb+gs9+eGI0ZxBggahqG1TZ
        k1yceMKnU8oVUo+aIbrbvbBGN0RSSKA07Q==
X-Google-Smtp-Source: ABdhPJy0Mjet+HjxsoEJgp/AwTr+A8CehTApQ33EoGLfYGLxo9jXmuRR5VCj1fk2EiLPzrIUAMNxYQ==
X-Received: by 2002:a17:906:b50:b0:6f3:ce99:3c39 with SMTP id v16-20020a1709060b5000b006f3ce993c39mr3446298ejg.52.1651086152184;
        Wed, 27 Apr 2022 12:02:32 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id d11-20020a1709067f0b00b006f395247b5esm4652604ejr.84.2022.04.27.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:02:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 42/45] media: sun6i-csi: Request a shared interrupt
Date:   Wed, 27 Apr 2022 21:02:30 +0200
Message-ID: <2179026.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20220415152811.636419-43-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-43-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. april 2022 ob 17:28:08 CEST je Paul Kocialkowski napisal(a):
> Request our interrupt shared since it is typically shared with the isp
> block. The interrupt routine looks good to go for shared irq.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 3963a88a2e0b..a88deb8ba1e7 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -264,8 +264,8 @@ static int sun6i_csi_resources_setup(struct
> sun6i_csi_device *csi_dev, goto error_clock_rate_exclusive;
>  	}
> 
> -	ret = devm_request_irq(dev, irq, sun6i_csi_interrupt, 0, 
SUN6I_CSI_NAME,
> -			       csi_dev);
> +	ret = devm_request_irq(dev, irq, sun6i_csi_interrupt, IRQF_SHARED,
> +			       SUN6I_CSI_NAME, csi_dev);
>  	if (ret) {
>  		dev_err(dev, "failed to request interrupt\n");
>  		goto error_clock_rate_exclusive;




