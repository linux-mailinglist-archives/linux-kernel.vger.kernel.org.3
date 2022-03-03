Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE74CC65B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiCCTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiCCTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:42:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF611A6378
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:41:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so3861333wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2iz36OqO+jJdVuW+N+ZU8T8BnAKilg+w/Ds7DOBUBqc=;
        b=ue5oc5VPyETrPzFUI5tMGWXNiS185SPWKtF65IQwQ8xjOEJBTsqlkLW11dFs9AUawE
         /DqBBuqSIaymgZxjn4q4XebOpM61LpRpAasj3CBwMmaltTCAgz8RrZDoWQVARRBYOWLM
         ZATUI/FMIHvt/Oj55HEb5KU+vio6s5llgv1ytHRWDrpdhkBny//uqi426HgraMzr8bV/
         9DrLkA6uquYAc4QYPmNe39H/9Wg1OgFxUaJ7IV9FTiGv8nEHb8C+43FVJq1s151WMbKO
         B4SpRlna1oorMDGQ39I4TkITXj/lN3y/5QwDPJkvW7jgaE9N/PbCjYVIi3crn9Fc/GTk
         LHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2iz36OqO+jJdVuW+N+ZU8T8BnAKilg+w/Ds7DOBUBqc=;
        b=qAyC8Dzc/C74KqcMnQyCIs2lzhUahhnJ2ONY3RypreariLpXe8GWbmxit65dL5q3PG
         /TkJEHM9WMq/kenBRV/TX60b1gKKFi2aFgKEr/yNEHUIMX8QqVC409hJ7EVdpei+7Mss
         qzXqlyrPZLU87XGodXKsD7BeFadW55FbOLbJ0M6pivr2WK+zrs9dN8QwmfGWPwSz1XqR
         gpGrbW90cDXk7ZHeQx5Rdn+pxMqRr8p7jfCRrNIjH97UMm6Vle+ibpbo6VqRFUB7nBli
         5QQ1pQZ4TiZADY6Is9NZtxvWjf2XBiOERlDzW9gIA6xfJfPDswzM7vxXF+9DaTj4sWqv
         X3Rg==
X-Gm-Message-State: AOAM532ounF+7eqsdzRnTExhICJfptgN7o7or0jp5OIIcJ8H1MTkD8be
        kysDvztU7unpEbKYJNg82cs7pQ==
X-Google-Smtp-Source: ABdhPJxeRW34laxVBvgaVBv3M2eH0QaO9wO8gWc12fv7n8JCsG+wcXFQzJGW9RUr1sYLQWexnzqMCw==
X-Received: by 2002:a7b:c382:0:b0:388:2e76:49ed with SMTP id s2-20020a7bc382000000b003882e7649edmr3351768wmj.195.1646336452447;
        Thu, 03 Mar 2022 11:40:52 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id e15-20020a5d6d0f000000b001ef7dca67fasm3255157wrq.114.2022.03.03.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:40:51 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:40:49 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        john@metanate.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 17/18] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Message-ID: <YiEZwetOpRhZ4iCa@Red>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
 <20220302211113.4003816-18-clabbe@baylibre.com>
 <1646315078.991896.1495435.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1646315078.991896.1495435.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Mar 03, 2022 at 07:44:38AM -0600, Rob Herring a écrit :
> On Wed, 02 Mar 2022 21:11:12 +0000, Corentin Labbe wrote:
> > convert rockchip-crypto to yaml
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 64 +++++++++++++++++++
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
> >  2 files changed, 64 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1600075
> 
> 
> cypto-controller@ff8a0000: clock-names: ['aclk', 'hclk', 'sclk', 'apb_pclk'] is too long
> 	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
> 	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
> 	arch/arm/boot/dts/rk3288-miqi.dt.yaml
> 	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
> 	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
> 	arch/arm/boot/dts/rk3288-r89.dt.yaml
> 	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
> 	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
> 	arch/arm/boot/dts/rk3288-tinker.dt.yaml
> 	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
> 	arch/arm/boot/dts/rk3288-vyasa.dt.yaml
> 
> cypto-controller@ff8a0000: clocks: [[7, 199], [7, 461], [7, 125], [7, 193]] is too long
> 	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
> 	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
> 	arch/arm/boot/dts/rk3288-miqi.dt.yaml
> 	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
> 	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
> 	arch/arm/boot/dts/rk3288-r89.dt.yaml
> 	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
> 	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
> 	arch/arm/boot/dts/rk3288-tinker.dt.yaml
> 	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
> 	arch/arm/boot/dts/rk3288-vyasa.dt.yaml
> 

The patch fixing thoses warning is in the serie.

Regards
