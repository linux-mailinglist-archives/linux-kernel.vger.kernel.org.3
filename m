Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1949B99D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbiAYRGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:06:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50804
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377982AbiAYRDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:03:14 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F0FAD40045
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130193;
        bh=Khs15J5Mbq9aHaNEf8S9OePqypIZSb0dV1fDUx3j1zY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=cXO/rwQQaJqr5Lc/RYx57oNwkSCy4C02ZRX+ItMkoRRblufoL5udYutdu4Q3Og9n/
         W+O+G250MfOmRVCavMYbv+EVLB4R7McCvSMAGut3nfHZcER5Ou2v3y7gC4CFxf7DJo
         1E4JmyesFth5uk18zYYKAH8LOx8kggg1bdIMcWJuMI0MRCzz7rmhe7v2QhVZIndvFX
         hisg3U+QIXrmmfGS1X65zXRt/MN8pnC9wOzrLAwf6NGzOclk9C0H0q3CpSwke7ecsP
         i7rU5zOXGlOcIVY6F+6iGFoIqIx9iYS9h7TxRPaF+2o705vapdkQFod9K2x5t6dvam
         LTXWW4LpDjr0Q==
Received: by mail-wr1-f70.google.com with SMTP id g8-20020adfa488000000b001d8e6467fe8so3326214wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Khs15J5Mbq9aHaNEf8S9OePqypIZSb0dV1fDUx3j1zY=;
        b=Q6OMF0AVTVhY+yiQKwrH1eq8VD982nTqAdTQXwe7+EiSOAzgFRa9jkplSk0QbLTBUx
         qycl13/oSw0LDNyXJ1+FwTQroXkuhk5wFERCCibxn0p5Uq+34JtXOy+IuOUcm/9qikcg
         2XZ24okcH75stFk2/i0WHa/Vhg2umZBn3LwgSS0lGgZvu5l0Fff0t6qTGqfZZ0nm5AMa
         HQmypLPnXDoSv8LMaL7Kn9LcTFRQ/pA3r9Y+1rtc4CBUR7uPZ9RLgrNJZFb3WaSQsGZa
         bcuq0HeFwoqQH6U2VT1yUHhjzd4xZ6L5qYpo76xHKX9wsNHbcqb/0OwqwlS1IpqR1f+2
         lVKQ==
X-Gm-Message-State: AOAM532oHBQ6Wqtq+JMNCeFucYFxoI8HztXEHQWZzAeQhklHaA5WUyZz
        Sl47g1KqtvJN2IiLm2hXGVe/nAO9ZQiOwxvy/PvDseqhOdYW2IAmCZBLu85Xe+qGybsdt+ShVxy
        Xs2kjY1GjlZyZ4Oeec+vqKDH4kHyj7j2e+UOe9tmoHw==
X-Received: by 2002:a5d:4343:: with SMTP id u3mr18313340wrr.504.1643130192783;
        Tue, 25 Jan 2022 09:03:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG9zjm9t7btrydRtRdnKDOUoYdpl+wsZCbJPwqP/WbdmBoRfkoAn21BZz2+hcP67O92cBkLw==
X-Received: by 2002:a5d:4343:: with SMTP id u3mr18313323wrr.504.1643130192571;
        Tue, 25 Jan 2022 09:03:12 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i3sm17162548wru.33.2022.01.25.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:03:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 00/12] usb: dt-bindings: samsung: convert to dtschema (subset)
Date:   Tue, 25 Jan 2022 18:02:30 +0100
Message-Id: <164313008959.78836.16134870344795249201.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 12:16:32 +0100, Krzysztof Kozlowski wrote:
> Dependencies
> ============
> None.
> 
> The DTS patches are independent and I will take them via Samsung SoC tree.
> I am including them here just so automatic robot checks won't complain about
> DTS differences against newly dtschema.
> 
> [...]

Applied subset, thanks!

[01/12] arm64: dts: exynos: add USB DWC3 supplies to Espresso board
        commit: 31c33503fdb3965d6aaf0db4a8c42e7d8cef1dff
[02/12] ARM: dts: exynos: add USB DWC3 supplies to Arndale
        commit: 52d53d937da8889964c60216a0333cb19fe0812d
[03/12] ARM: dts: exynos: add USB DWC3 supplies to SMDK5250
        commit: ebbb07b8d349fc2eccb67780850d2d1bbfc918d6
[04/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Snow
        commit: 9745be7b5a3be39a00e6bbda3305e2d789ee4082
[05/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Spring
        commit: 111ea2d6dd217684db4e7a97a2bda3bf14734427
[06/12] ARM: dts: exynos: add USB DWC3 supplies to ArndaleOcta
        commit: 0a14272479627bb9388ece3b0ebac72a3928062d
[07/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Peach Pit
        commit: 7adf978462dadc41ea7d4138de53bc9a15922191
[08/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Peach Pi
        commit: 72477416ac12e88384a96575c5f2e4bd7ac8feeb
[09/12] ARM: dts: exynos: add USB DWC3 supplies to SMDK5420
        commit: c441d2d73107fcb45c0affb345fe6b9bc3fd3bab
[10/12] ARM: dts: exynos: add fake USB DWC3 supplies to SMDK5410
        commit: 4043114504cc05d0a7ca2a061838699b500599cd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
