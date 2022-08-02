Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9F5880AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiHBRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiHBRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:02:30 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3D255BA;
        Tue,  2 Aug 2022 10:02:29 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id q14so11117653iod.3;
        Tue, 02 Aug 2022 10:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=MiaX/+ZZUFz6nZZMxDrJuCzbh/EX76DMC3XeOh9+aik=;
        b=O1s8K3YryuUqDvNLeUK2H7AiQ/b4rtAsh5E7+5dllS4NQcLshqNddWuuj3DyZSiNn9
         dqZaJwTWLAgQb6k4I3+haWDTF/XhR3v8awCOaqTqOatIB3f7xhLA0u/5I5+ILfJtxZY5
         swbF2GGmXkx6jO8jhp9mSZ5m/zU3BNnHD4ADZowtZDIyIdvUcdITKM8qaB+LbtHALwup
         tFyugo9DS5SR1UcJ+IKoKFmk4KoyAudaaSfEeWz8T8yVJ9sFovqc9B6GZJKEXp2BzY0H
         qAHeMVs339vGX2DVOcmL9jVjPkkX/H/gZYHuNHPnQRcfRKVxsQ2023uemkVe1TL2RLyH
         UcbQ==
X-Gm-Message-State: AJIora+l6qf+E8x2P19yMfykX5OJe8piEQ8Rwhdco2YV5YG3rrzFr4vp
        pd+GZ10GDFI9Kz3/AeKiQA==
X-Google-Smtp-Source: AGRyM1v+ycBOkCn7pHq4nN5H0WwvOFomY6D4GlbR9CpWXKVl5udKsotJWNvDjJbE0SIFRvQBOQTzWQ==
X-Received: by 2002:a6b:cd4f:0:b0:675:b0bf:d999 with SMTP id d76-20020a6bcd4f000000b00675b0bfd999mr7780143iog.193.1659459748570;
        Tue, 02 Aug 2022 10:02:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x2-20020a5e8f42000000b0067b8e3be94fsm7288790iop.8.2022.08.02.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:02:28 -0700 (PDT)
Received: (nullmailer pid 296633 invoked by uid 1000);
        Tue, 02 Aug 2022 17:02:25 -0000
Date:   Tue, 2 Aug 2022 11:02:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-amlogic@lists.infradead.org,
        Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        David Lechner <david@lechnology.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Klein <michael@fossekall.de>,
        Artur Rojek <contact@artur-rojek.eu>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Tony Lindgren <tony@atomide.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        David Heidelberg <david@ixit.cz>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Purism Kernel Team <kernel@puri.sm>,
        "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH 2/3] dt-bindings: power: reset: drop quotes when not
 needed
Message-ID: <20220802170225.GB279692-robh@kernel.org>
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
 <20220726115748.101015-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726115748.101015-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 13:57:47 +0200, Krzysztof Kozlowski wrote:
> string literals do not need quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/reset/regulator-poweroff.yaml     | 2 +-
>  .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
