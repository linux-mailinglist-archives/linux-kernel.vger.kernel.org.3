Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2C4D0C05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiCGX3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiCGX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:29:46 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5774527E6;
        Mon,  7 Mar 2022 15:28:50 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id i5so17082508oih.1;
        Mon, 07 Mar 2022 15:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVvzRwcrmqCD5sIuTw06DJoMahe3r0oq+Cma9RxAwg4=;
        b=YYOof2FFDsRcLn602zkkvmWeb3G48ZTpEWBTAPfjRJ/Gnn86bRcN3WLuflTY+vvJ/H
         O6I4KB2oUt5ETKXdj3Zlk5JnCnJN84YCpO5IuUZSH/zYuqOVIu8RT963sfu730WkcRWy
         QkgvBUkuu4VMOaBsUL73xrryDGMVHIIswu4qtW6De8iKD7JNqOG/2/ZniPoByVpi5+E2
         zANXl3D6Hk68r8XUKWf538av/FO6YkLaZKDE1h43Ok4IbwjOi+/F3R3v6RpzXvELn6HX
         hZLORzvZ19YFm/Bq8UydfgLfIxihqg7F+PyHEp4v3MPLOuG9EO+QnOFWSMV62YVQNOHj
         DRMg==
X-Gm-Message-State: AOAM5318XVb4MMhNfJyeCZTQsbgkYAjnxhNbIu5acKlYHd0YoFjp2fyC
        3C0ryl+MmCguc7Sew5eqjw==
X-Google-Smtp-Source: ABdhPJwTbvNYHHuH1SkYiIHsikdCFEp4VIL5Jq3FfR2GME7j62q5oMLly4zIPkLL7toglfqJWD/X0Q==
X-Received: by 2002:a05:6808:2383:b0:2d9:a01a:48d6 with SMTP id bp3-20020a056808238300b002d9a01a48d6mr951959oib.289.1646695730264;
        Mon, 07 Mar 2022 15:28:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o10-20020a0568080f8a00b002d726c76b77sm7093528oiw.15.2022.03.07.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:28:49 -0800 (PST)
Received: (nullmailer pid 3465035 invoked by uid 1000);
        Mon, 07 Mar 2022 23:28:47 -0000
Date:   Mon, 7 Mar 2022 17:28:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Samuel Holland <samuel@sholland.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Yong Deng <yong.deng@magewell.com>, devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: sun6i-a31-mipi-dphy: Add optional
 direction property
Message-ID: <YiaVL3Xk0XP7y7iL@robh.at.kernel.org>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
 <20220302220739.144303-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302220739.144303-2-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2022 23:07:31 +0100, Paul Kocialkowski wrote:
> The Allwinner A31 MIPI D-PHY block supports both tx and rx directions,
> although each instance of the block is meant to be used in one
> direction only. There will typically be one instance for MIPI DSI and
> one for MIPI CSI-2 (it seems unlikely to ever see a shared instance).
> 
> Describe the direction with a new allwinner,direction property.
> For backwards compatibility, the property is optional and tx mode
> should be assumed by default.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
