Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A766146E124
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhLIDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:12:27 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38547 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLIDM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:12:26 -0500
Received: by mail-ot1-f49.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso4849785ota.5;
        Wed, 08 Dec 2021 19:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qKDzffIh+yqfr5ok/mJJwzw+1owN6snSg8a9RwLCVp8=;
        b=J2xLy14o28AoOUDvL/tYK4fZclaxJMK1fjyxRU75oa1sendCJWd129jw53aaeBjkpt
         HyMH11oMB1Jz5MeysrP2pXbHsYjKvq9iBco2tcKvLvRXMccRcrxnU/WYWz8FWJBLvYTl
         whrLGLbGlKeDH9uCe++6CxrRuJFbkmzmzJX8zHp6q27qi85jCxnNevohQDdtrYVaDK2o
         bc97rqPxMeSQ/OmWakBODGWCitpW7xTRvKH7aCulquDWa51fsiq0naQ5xNUi9dcv22dd
         JT9Al8qiCVS29NV9fJZFiMMi76KrpsK5snoIL0yssheEtO72OwgPomSA0inAMv4EXAvc
         Qiiw==
X-Gm-Message-State: AOAM5322xxqzhgSz7NDoeqB4O2gOgZRz/hv7N6XEYD/Tv/j/oggInMdh
        4/4dXxp1R0rseKPmDYkPvw==
X-Google-Smtp-Source: ABdhPJwSOLjcoCkCaqCYmfKf8LK8Pv362E+51R1zit9LTCiYpPmFHxXc6atFl2Y6QiNZGg1ReFtq2g==
X-Received: by 2002:a05:6830:1447:: with SMTP id w7mr3166109otp.199.1639019333757;
        Wed, 08 Dec 2021 19:08:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i3sm798136ooq.39.2021.12.08.19.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 19:08:53 -0800 (PST)
Received: (nullmailer pid 934412 invoked by uid 1000);
        Thu, 09 Dec 2021 03:08:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, benjamin.gaignard@collabora.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-staging@lists.linux.dev, cphealy@gmail.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas@ndufresne.ca, aford@beaconembedded.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
In-Reply-To: <20211208225030.2018923-5-aford173@gmail.com>
References: <20211208225030.2018923-1-aford173@gmail.com> <20211208225030.2018923-5-aford173@gmail.com>
Subject: Re: [PATCH 04/10] dt-bindings: media: nxp,imx8mq-vpu: Support split G1 and G2 nodes with vpu-blk-ctrl
Date:   Wed, 08 Dec 2021 21:08:51 -0600
Message-Id: <1639019331.983790.934411.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 16:50:23 -0600, Adam Ford wrote:
> The G1 and G2 are separate decoder blocks that are enabled by the
> vpu-blk-ctrl power-domain controller, which now has a proper driver.
> Update the bindings to support separate nodes for the G1 and G2
> decoders using the proper driver or the older unified node with
> the legacy controls.
> 
> To be compatible with older DT the driver, mark certain items as
> deprecated and retain the backwards compatible example.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../bindings/media/nxp,imx8mq-vpu.yaml        | 83 ++++++++++++++-----
>  1 file changed, 64 insertions(+), 19 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.example.dts:62.23-27 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1565517

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

