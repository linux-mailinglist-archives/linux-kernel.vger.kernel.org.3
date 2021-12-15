Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E6475CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbhLOQDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:03:25 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33392 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhLOQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:03:23 -0500
Received: by mail-ot1-f45.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso25547257otf.0;
        Wed, 15 Dec 2021 08:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xe/HfKxTm30DSYVeCryK/T+prtaOXtlQsHhhgKcn9BA=;
        b=2Azru8x7BKG7AJivHgBTrBGgXVqwBHPgt7obmoJc/milMBuNj9Ey7/5/gDBuIHsHJu
         TB3gxOybfiLJi7Ulj6FFEg/p4BBbsDRskUDCLOfmNKy0pTAXuOx+T20Ajqlcsc/KvU6U
         vcMo5LB/tiEHMf7GaF9w9j6H3EEz3VmEa4X067A5bh9D/46keBP1zWPHmWIkeTl942k6
         L7fleLjStpOhPMc0CrYnissASoEAuRSQmNECtJIdC1MB6KEuS43lVwnhO91Biq+BIVpd
         1J7OX3xfpnEk4so4ITRb1R9n9vehsdvl6OVifaxehKgWGEMaZ6aD+yJoBiwZXVsq8W2W
         LG+g==
X-Gm-Message-State: AOAM532Q70r5YuZ1CMM2WqhuBH/IMMDr32besy/afBRGHIhmFQo1qELZ
        7j6DTxnYr6QdXQV5pFyMrQ==
X-Google-Smtp-Source: ABdhPJyc26sAWDjW5Ma9yjRYf51V/CNKMYBUkWE2k3ib18TK3TN8L2LhtWUymRdccSZjKJnaYOWe2Q==
X-Received: by 2002:a9d:12f3:: with SMTP id g106mr9156177otg.175.1639584203012;
        Wed, 15 Dec 2021 08:03:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm505242oom.32.2021.12.15.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:03:22 -0800 (PST)
Received: (nullmailer pid 1396374 invoked by uid 1000);
        Wed, 15 Dec 2021 16:03:21 -0000
Date:   Wed, 15 Dec 2021 10:03:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     krzysztof.kozlowski@canonical.com, tony@atomide.com, kishon@ti.com,
        nm@ti.com, vigneshr@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] memory: omap-gpmc: check for nand node name
 instead of just compatibility
Message-ID: <YboRyR+SqBV03cY0@robh.at.kernel.org>
References: <20211208124611.16843-1-rogerq@kernel.org>
 <20211208124611.16843-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208124611.16843-3-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 02:46:10PM +0200, Roger Quadros wrote:
> We have added new compatibles for controller so just checking for
> "ti,omap2-nand" compatible is not enough. Check for "nand" node name
> as well.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 624153048182..9f0062a262db 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2183,7 +2183,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		}
>  	}
>  
> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
> +	if (of_device_is_compatible(child, "ti,omap2-nand") ||
> +	    of_node_name_eq(child, "nand")) {

It would be better to stick with compatible strings. You can match 
against a match table. This should be 'nand-controller' really if this 
binding had a proper split between the controller and nand chips.

Rob
