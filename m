Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81E549FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347815AbiFMUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbiFMUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE264C1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i64so6662007pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nT549qJtxV1BDDwSTKGaAnqRktoPUt/jLCJWLyiPvHw=;
        b=BInp8cPtPQ4tK/ffMW4nn4lxciVcZ+ZvBkzgyySFAs7iefoJqIbAP4xFkGqyL37X/X
         QXxWt6GI9d6ccwv4X1BmqqGN+EIjbOPH6WwQ5WlLMlG2QMiBmuXx1Z+Hd/ksSeG2H1Um
         EqkeLB+Is+HjMnDt1Jq7FjCJwXZ3l/fMEOB3PVymJpLF3U5H9nXzGGlSLX+ES3uq+p64
         Fu2xBZEMgvKz96+lkBo2JKQYbzaRb/J+0MH+oTebasIzixN9dGFlHzQaNlnvlk0KJZsw
         IE1cdzkeDvtADYoexzp8jNInIheVq9nsosRQh+4FMBoDw0+EHy21vycjqA22JqJ8VBL2
         Mdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nT549qJtxV1BDDwSTKGaAnqRktoPUt/jLCJWLyiPvHw=;
        b=DSJSACxtRcn2JekjkKTjvFqjroJAVUw+gXAoFTcLcE3JczlJ+xEE/Xqa/Gewf0RXx+
         QyM47sPFHpBQJy2jQxRMF9fTG6DLLmqcLFOeIHDArjKFhO8RFy+h22pVkz7W+RotHnUy
         LnNfbbcHNC2TdouQYFsCwJv1He9TSarh4wPrf1Lu/rtak1GoW5ct4kYVOxDPP7Eo91UW
         8Wf8E1zNv2BTcZ2QkRyB8XA8u8SAU3NwOJpxMrDEluVwHcKuhgrPizVewrk7ks3DhR4U
         9EuAjEFCat6d7gYfQkTzEp5dtUkQ5BMItsHZjgkeEKvFgUdbIoYjK0NHC22R0KViAJsE
         4MgA==
X-Gm-Message-State: AOAM532JnlibXh4YiNKZ+KJcOUZfXPZ7YGhsQLR4x+mFWoSRT5GS21vr
        6As60SvDsnLZHrrKGun/nuXPgA==
X-Google-Smtp-Source: AGRyM1sHNrT6EA1vne9zoqSs4Kj6VT7gGBwneqiLiE6fypf57czAytG3WSUZqOvsMu1OwLx726vyPQ==
X-Received: by 2002:a05:6a00:338e:b0:51b:c452:4210 with SMTP id cm14-20020a056a00338e00b0051bc4524210mr583717pfb.69.1655150259258;
        Mon, 13 Jun 2022 12:57:39 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:38 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 08/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Mon, 13 Jun 2022 12:56:51 -0700
Message-Id: <20220613195658.5607-9-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91e9cd30326d..09828169c7c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1777,6 +1777,16 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun50i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/mfd/pensando*
+F:	drivers/reset/reset-elbasr.c
+F:	include/dt-bindings/reset/amd,pensando*
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <narmstrong@baylibre.com>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

