Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30B4D13C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiCHJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbiCHJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:50:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993B340C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:49:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j17so27621031wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Vptup9snjTByrwJQ9zSJpQbWeuT9OeToRX24egqXZE=;
        b=ZkvqwDQcHKwDX84OOnDMiAlBzjBS5NMVrq2VBIAW9dRo+lZGFGg3x8XK1DFS0RuYw1
         jkV5mgBKgGBFp5ULdFQWgj/rYPEFcRog/8vMTiSd1HDGyxrndTzswnzycMaUOgt3FaSq
         Si4oRF2seEYg/4ywLp4m+dCSVQ21bFYQs4tdSA/h9Zqw8dlrlIjX/8JZ7tHQoslw4+BM
         mfZcM7JvwHmpjVfSeSZpYHdOEViNZa1ftqdyTxnwads01Am5McQdyroikyUjnWjDG/ZM
         vas1/rV6+k4Du8d0onFwDWKgrEL58IWmFBTXPLQ14vSzHRBVn/5T7oAtbmci3wBzyYAN
         RkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Vptup9snjTByrwJQ9zSJpQbWeuT9OeToRX24egqXZE=;
        b=akDlY1zzyGULx0gfGCrAN07hu9g/rE7A0cfK26aC5npO88aPT+pXPjDqUt/Zokqk16
         5nTQmfFqKOsw393EZ3QDctfNESbAXPgSHW75WiOZP5zO6781OC4uVOy8tfOVx24uKQFv
         LvVeGzX+VfWU6dxs6/9a0vL1iiePuli4vJlU7/KfOeGqY2oh44xpMKH6dwkgnCkGBfE7
         mTq4ELoNrM6d0EeaN5GRe0/J4A1foRl/PfHrt9UnNWSfW+3PJtTGOv3/94zltxTUVHZu
         HmdpxCrvwCbobuJm5NALPq+OR7uVqOQtqzTMTuiJBqrxhEdPgS0tW5iw0RpPjMDaCwH2
         eScA==
X-Gm-Message-State: AOAM533SQ9ekuduwUrD5hJr38bVX8BMO2EvGQuDtJhmmfMRyML4LEJ63
        /t0yjPkVeal+oa/9q4w5eP6xTA==
X-Google-Smtp-Source: ABdhPJwyHtSnI5DdyZsEddgf/hq4aj4GLJcAaVuxD5wI/kt3z5s/DN1pKpabP9/LthhErPegg06whQ==
X-Received: by 2002:a5d:6e0f:0:b0:1ea:9418:c2a5 with SMTP id h15-20020a5d6e0f000000b001ea9418c2a5mr11280082wrz.244.1646732957483;
        Tue, 08 Mar 2022 01:49:17 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm1684885wma.21.2022.03.08.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:49:17 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, robert.foss@linaro.org,
        laurent.pinchart@ideasonboard.com, xji@analogixsemi.com,
        hsinyi@chromium.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, arnd@arndb.de
Subject: [PATCH v2 2/2] Revert "arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI endpoint"
Date:   Tue,  8 Mar 2022 10:49:11 +0100
Message-Id: <20220308094911.2680291-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308094911.2680291-1-robert.foss@linaro.org>
References: <20220308094911.2680291-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 32568ae37596b529628ac09b875f4874e614f63f.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index e8f133dc96b95..8f7bf33f607da 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -171,8 +171,6 @@ port@0 {
 
 			anx7625_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-				bus-type = <5>;
-				data-lanes = <0 1 2 3>;
 			};
 		};
 
-- 
2.32.0

