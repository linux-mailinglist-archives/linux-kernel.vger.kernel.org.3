Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D452369F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbiEKPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbiEKPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8824967;
        Wed, 11 May 2022 08:01:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k2so2189268qtp.1;
        Wed, 11 May 2022 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipDuBEhFw2DyeLXG/FGMhARGVjkT9bgP/MDyzET/qKc=;
        b=VqceqPLS+1htYwbnkdB1KBG2uG8SPVKbSfknbCr7putJwxx2cf4O1v6nSo207w8Kfk
         mRwrH00M1xaanbcOw8aB6vSJfgrOybPgim2cr4NaasjycYeaOsZy/RM3naCj5jy8hl44
         UHIJ8TFs9MghONZDytS/GtSeZYibpyRbzeXrzHHeCbqCAK6ThohEfj6Fyw7tPU49UKs3
         Md+mXvivlDeSsQkXR7b1yuJskVs7+nMz9LUOoBQ8gkX0lcOHu8nO1joX3gtpEfhg+0/O
         9FKWuMrl78hOvqVRXoLP6dPaeZWs53md1YdoqzeYomqSXNMBnNLu7CkkGiagycu9Or43
         FZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipDuBEhFw2DyeLXG/FGMhARGVjkT9bgP/MDyzET/qKc=;
        b=B7ByMtKvKmzjH5khOwlX/JEUYwy3QjoEtVTurYZrODUfIVAlkIoYkl3YdzyONizno3
         FmHJrgKU+ztOs0y0c4++S+ZNtH4D4rQHlG8yqt/3SIxdFaXiCzlOgei6qMLWuB7D6O8s
         FksRc9C0WbCOGOjuU2f4I7ehZoZbO5eQryhmAsrBfh6JMLFwp0zScD6VEHA81sTZAAO+
         9OOPjeW+ihiOXkwzAXkRKMxXmp6G1pZn7hlxmc0E9zxJvpNsYBa02DbsLb6LZFM8RWx7
         QuhPM6Xa4sPuJGg1tIn2OTAp75uCVVmvS2loiYo3eMcUYw+GWlTeeFwg0RmwBBIU9hfR
         DPSQ==
X-Gm-Message-State: AOAM530l1OCSEKI2iuuY3zPpppK3yWXTcc4mTjn4ciUeZglAh++u2W1L
        0SG/AuD7pgnGUzzWHLh5bm8=
X-Google-Smtp-Source: ABdhPJxQDBcvlYHhaql84573qZ07O8V9rUoBzOAlGDd772zbH2KQTV4gZdCmubxlDvAK9RPHKFpbtA==
X-Received: by 2002:ac8:5fc9:0:b0:2f3:9bc9:e174 with SMTP id k9-20020ac85fc9000000b002f39bc9e174mr24002632qta.51.1652281285192;
        Wed, 11 May 2022 08:01:25 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:24 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 5/6] arm64: dts: rockchip: enable sdr-104 on sdmmc
Date:   Wed, 11 May 2022 11:01:16 -0400
Message-Id: <20220511150117.113070-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have working io-domain support, we can enable higher date
rates on the sdmmc card.

Before:
Timing buffered disk reads:  68 MB in  3.08 seconds =  22.07 MB/sec

After:
Timing buffered disk reads: 188 MB in  3.02 seconds =  62.29 MB/sec

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 991b7b1b8443..71df64655de5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -582,6 +582,7 @@ &sdmmc0 {
 	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vcc3v3_sd>;
 	vqmmc-supply = <&vccio_sd>;
 	status = "okay";
-- 
2.25.1

