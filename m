Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB16B4D0BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiCGXWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiCGXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:22:32 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406656450;
        Mon,  7 Mar 2022 15:21:37 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso19855970ooi.3;
        Mon, 07 Mar 2022 15:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwqBsAiwDA57OzBbnIQApP2KsOEcfE99XASAzmUckUs=;
        b=Wy//6Z68zjnAA5Y71EKIdbLiAgDKvdqMCDXutIY1lpFcaNm0TOAPQRFKyPxAwDZ2BJ
         TTl/xe9C9IsnAbiNsvr1/H/lZADPtwM34QSBM1TcNifRq2jOnRoRaNrKQdevc9zOI7q8
         RIosBpDIAHl9HkCH6Z/rjP1+Ts2vJBwxDd0mnlp+JC6eog3WwzgNzn+n5w+FR9kztrsQ
         HxXLsgguUaMUsqf3ZNGrux+rUPSFQdiTmqATyDjSrJ5tNUiOvikiKcR3VkJpIVJPlOqx
         UR/haiaEj9UQwpsHpWhYhspYF0y0gUtPGnutWc7Dh49j7nh6sYxV0jTtmQXq/U+44bQW
         CCQA==
X-Gm-Message-State: AOAM5321JlyRnwTKn9j6T5UJ5q5itaNPaqpU90ICO9ymDh7GZbH+bFSZ
        eFkSqgtkM8AWs6bdnRQOtQ==
X-Google-Smtp-Source: ABdhPJw/AE1EhWJP6qxkDyeRTJYp+la3lVDGzD9DakazOBHyOJ9Qw5nCO7bMG8JD6/2WWxv5bamQjg==
X-Received: by 2002:a05:6870:d151:b0:da:4cd6:552e with SMTP id f17-20020a056870d15100b000da4cd6552emr788011oac.136.1646695296565;
        Mon, 07 Mar 2022 15:21:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay44-20020a056808302c00b002d9d2b564absm2177987oib.43.2022.03.07.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:21:35 -0800 (PST)
Received: (nullmailer pid 3453254 invoked by uid 1000);
        Mon, 07 Mar 2022 23:21:34 -0000
Date:   Mon, 7 Mar 2022 17:21:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RFC v3 1/8] of: Mark interconnects property supplier as
 optional
Message-ID: <YiaTfsMDs7RGob2N@robh.at.kernel.org>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302211100.65264-2-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Saravana

On Wed, Mar 02, 2022 at 10:10:53PM +0100, Paul Kocialkowski wrote:
> In order to set their correct DMA address offset, some devices rely on
> the device-tree interconnects property which identifies an
> interconnect node that provides a dma-ranges property that can be used
> to set said offset.
> 
> Since that logic is all handled by the generic openfirmware and driver
> code, the device-tree description could be enough to properly set
> the offset.
> 
> However the interconnects property is currently not marked as
> optional, which implies that a driver for the corresponding node
> must be loaded as a requirement. When no such driver exists, this
> results in an endless EPROBE_DEFER which gets propagated to the
> calling driver. This ends up in the driver never loading.
> 
> Marking the interconnects property as optional makes it possible
> to load the driver in that situation, since the EPROBE_DEFER return
> code will no longer be propagated to the driver.
> 
> There might however be undesirable consequences with this change,
> which I do not fully grasp at this point.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 8e90071de6ed..ef7c56b510e8 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1365,7 +1365,7 @@ static struct device_node *parse_interrupts(struct device_node *np,
>  
>  static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_clocks, },
> -	{ .parse_prop = parse_interconnects, },
> +	{ .parse_prop = parse_interconnects, .optional = true,},
>  	{ .parse_prop = parse_iommus, .optional = true, },
>  	{ .parse_prop = parse_iommu_maps, .optional = true, },
>  	{ .parse_prop = parse_mboxes, },
> -- 
> 2.35.1
> 
> 
