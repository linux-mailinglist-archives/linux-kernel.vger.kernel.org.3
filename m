Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700684D30BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiCIODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiCIODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:03:39 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183227CC5;
        Wed,  9 Mar 2022 06:02:41 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso1800231ota.3;
        Wed, 09 Mar 2022 06:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2bsT/eha6vQRCunWyuGCCZHXPrqQ9VTlY5oTvI04YI=;
        b=3nyGjQ6JPF6p/Ta+LUnBKDn14m30XR+P/5Ba27LvReYPxSUAIs3vrG6h24Z/k2stdq
         Nb0nXfWpv+cnE39tXbzW+62X/c1WB0TXzUHUfk9VTM6TDx7hW6ClveWko/v3PEO1H48y
         Ecpx/G11lxHIHK+djOQbBizxy5jeWMRV7rrlMh1Bx6QQQsmOXEhTYNkoSPvYGIaaeEWh
         Szgf9PeqBg43bvf2r9nfTWQhijM4gXk4VmFBS/5lAAjVy02SqD3YudNUjAJRcQ1DuYdk
         /ucsDWodaSen8qKBomvyH69aVNaoLcYun7PBfpLeoyAHeRAXjitnamczI73B8IDC6KTN
         g3Vg==
X-Gm-Message-State: AOAM533mLVTat3JbeIssiRSBq4HQYYpZwNr8S+cUq/DOpvoSRmN9Oial
        3BsIYkMF/HaALgOI9IgtJQ==
X-Google-Smtp-Source: ABdhPJzd/R0M9Di5kVne+hQYW3KIlYwUwdKbU/tPCjkd3SYy5tmwWk2sEh5o27IvJtXqUKCC5IpBMQ==
X-Received: by 2002:a9d:325:0:b0:5b2:4b69:4e73 with SMTP id 34-20020a9d0325000000b005b24b694e73mr4181198otv.34.1646834560263;
        Wed, 09 Mar 2022 06:02:40 -0800 (PST)
Received: from rob (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r21-20020a05683002f500b005b249ffa43fsm961722ote.22.2022.03.09.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 06:02:39 -0800 (PST)
Received: (nullmailer pid 2797503 invoked by uid 1000);
        Wed, 09 Mar 2022 14:02:38 -0000
Date:   Wed, 9 Mar 2022 07:02:38 -0700
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     skomatineni@nvidia.com, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, ashishsingha@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        broonie@kernel.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v4] arm64: tegra: Add QSPI controllers on Tegra234
Message-ID: <20220309140238.GA2797451@robh.at.kernel.org>
References: <20220308183026.66394-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308183026.66394-1-kyarlagadda@nvidia.com>
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

On Wed, 09 Mar 2022 00:00:26 +0530, Krishna Yarlagadda wrote:
> From: Ashish Singhal <ashishsingha@nvidia.com>
> 
> This adds the QSPI controllers on the Tegra234 SoC and populates the
> SPI NOR flash device for the Jetson AGX Orin platform.
> 
> Signed-off-by: Ashish Singhal <ashishsingha@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
> v4:
> sort definitions in include and dt files
> 
>  .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 12 ++++++++
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 28 +++++++++++++++++++
>  include/dt-bindings/clock/tegra234-clock.h    |  8 ++++++
>  include/dt-bindings/reset/tegra234-reset.h    |  2 ++
>  4 files changed, 50 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
