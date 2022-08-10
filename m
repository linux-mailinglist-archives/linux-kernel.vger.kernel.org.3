Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB658F48C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiHJWyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHJWyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:54:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA635A8B7;
        Wed, 10 Aug 2022 15:54:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso3617161pjf.5;
        Wed, 10 Aug 2022 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=lxZ1NGAiSTP73cSUEoGkOx6aRZyABhhViwltGrYhe9E=;
        b=owAIw5XnlxRKipTQS/kUnxW97nZAbohYpcMbsOvQ0alvR4Z4RdrlUkYJTbOKg5WGwx
         RVXF+rno6+iqBd8fyOnwS2HCzho8dxvBSLnKRvaEtfiGga3U7txf8Fgn8VhXsZcDGbZP
         ktk8jidhPs6f9y6OX7qJwsdcVIavhVqVrPf88aLWG94V/3ZuwdAFlMvowiC8EMqUmS6N
         vIjz85SXIyYc+43lzj27PBWORfff48Arq+B7/gFrTyw/awy9s96IXQ5CP5pUBf90yEZu
         5Ev1mWx5E3h6U6qAMJaKcu2DwcDNxepV980jobU6q+lvquYLPZ7tB1mXb7yogRKiunOk
         Xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lxZ1NGAiSTP73cSUEoGkOx6aRZyABhhViwltGrYhe9E=;
        b=Ljh3KG042Nuc4cEh1WRKMdC9QtodZTEIb25SzG41/+5hjhQqJCxXL7avH3t6R5sjqb
         +s6tHvGtkTcRuoSliSG0Wexy8mM6bEbyWO1JzPZ1C0oHMXFJEjAxn2FTk6MOGeQQHsr5
         JxE53NQR1iA1XQShHud+f2Pud6dW5Uz+ODsiKcROahekCK4DL/wLQkaMLjGAXZEkXshD
         VuuAjY7Ps22yFuyZwMf/GYJEKYk7drRYViOl8IKWFTbzFwyHcx6B+5MYdD1ewWixTtXK
         KxjA09eYbHgtkeNJ4oEWeZyudvBKxgKzBY5EKXWYSE4A7g8emfrIGfujuRvmdRGK3KCa
         l2Qw==
X-Gm-Message-State: ACgBeo0v01Ebb0hEm3S5ZrzfdKVr8eOx8qFlyNvg519jtw5p3jxDfmH2
        XYlrvOMhM1tEpMRv8gz2f6o=
X-Google-Smtp-Source: AA6agR7JEoiU8e8aUzYwboJBL1uZG9zUuw7r3JBfVIeLgtMOh8tPNt6wxTuTAo7vqrkXvDiyS4PepA==
X-Received: by 2002:a17:90b:17c9:b0:1f3:3a7c:a3a7 with SMTP id me9-20020a17090b17c900b001f33a7ca3a7mr6041466pjb.76.1660172039748;
        Wed, 10 Aug 2022 15:53:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0016be96e07d1sm13584240plg.121.2022.08.10.15.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:53:58 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:53:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
Subject: Re: [PATCH v2 0/7] Input: mt6779-keypad - double keys support
Message-ID: <YvQ3A2/Pop4YzzQ8@google.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:56:05PM +0200, Mattijs Korpershoek wrote:
> The MediaTek keypad controller has multiple operating modes:
> * single key detection (currently implemented)
> * double key detection
> 
> With double key detection, each (row,column) is a group that can detect
> two keys in the key matrix.
> This minimizes the overall pin counts for cost reduction.
> However, pressing multiple keys in the same group will not be
> detected properly.
> 
> On some boards, like mt8183-pumpkin, double key detection is used.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied patches 1 through 5 (leaving dts patches out), thank you.

> 
> ---
> Changes in v2:
> - bindings: add matrix-keymap justification in commit message (Krzysztof)
> - bindings: switch from double-keys(boolean) to keys-per-group(uint32) (Krzysztof)
> - driver: add a function pointer for row/column calculation (Angelo)
> - Link to v1: https://lore.kernel.org/r/20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com
> 
> ---
> Fabien Parent (2):
>       arm64: dts: mediatek: mt8183: add keyboard node
>       arm64: dts: mediatek: mt8183-pumpkin: add keypad support
> 
> Mattijs Korpershoek (5):
>       MAINTAINERS: input: add mattijs for mt6779-keypad
>       dt-bindings: mediatek,mt6779-keypad: use unevaluatedProperties
>       dt-bindings: mediatek,mt6779-keypad: add mediatek,keys-per-group
>       Input: mt6779-keypad - prepare double keys support with calc_row_col
>       Input: mt6779-keypad - support double keys matrix
> 
>  .../bindings/input/mediatek,mt6779-keypad.yaml     |  8 ++++-
>  MAINTAINERS                                        |  6 ++++
>  arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    | 21 +++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  9 +++++
>  drivers/input/keyboard/mt6779-keypad.c             | 41 ++++++++++++++++++++--
>  5 files changed, 82 insertions(+), 3 deletions(-)
> ---
> base-commit: 668af1b6548837b44a2bfe65dcbae6b250adbf63
> change-id: 20220720-mt8183-keypad-20aa77106ff0
> 
> Best regards,
> -- 
> Mattijs Korpershoek <mkorpershoek@baylibre.com>

-- 
Dmitry
