Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE57F4E8AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiC0WoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbiC0Wna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:43:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799150060
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a1so17890065wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwcBGQ6dA75HdxpcUCrD8mvsn7/MZTlw7uERAWlwKmI=;
        b=AYDLTANXWRzGnB+sIMp01grvGk/SH+cQkVVSn0Jme+Sp0Hdpav8Wlpi1giPYDpywOB
         f6+XMddOzg//0bbLhJQCLnkfAV0Ch64BSBs9oAbxmdSQ0aFw6LF+1eH4sCXHn+oCWJK9
         HAUXrfbNKPFhPTj2hSbp90b+fYh/KO1rXKZin8vWp75AbJyk6dGaR6kJh+zhJpkys+jQ
         Pk2FkzjQ/WrzkwnRLJGntCY5EY+d50uMvlP3KirJCkkCRn482UEZBSRYDpkR0UJ46DUu
         laMi+vD1+SNfyKxtrkIT5iuFhSooYpFxBbnxJgCDry2m5x5p4qdMYjJqUvDmSn3XsbJm
         bITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwcBGQ6dA75HdxpcUCrD8mvsn7/MZTlw7uERAWlwKmI=;
        b=ACJnrtbInDeek5Bb6jWzUCpbde3RmHarOHWOTSrAfnHiteIBsTJF66YDtmYQ5CgmG5
         +mEoeEHXT6drpD/me1zedq5C+lnO7QwWwQYR8p9PpK0L9kuufv0J24iAL2raAfkZpjQg
         XaRZHVCKVbge+F+7tnlC8HWIPzB8dxsJMMUnlqXWwS2EJqNwrmWcILN/dwCurzfLAuMb
         bSp5/Xxz6SNkCTTMakF1aEivL4zsO7Hd8IiAn1D30r9SvSGTzOcViZ+Z47YuyhXJJOBs
         qzpWhkdfEjxc66qAlflEu293Oi+0SG+QkPLIUCUNt2F42tn0/riUptuskdKDKmzumoAa
         cC2A==
X-Gm-Message-State: AOAM5305eYPxO9NCQkxJQDlRK7Jiumo1We86E1Bts/D2BbdyoG7dAH+k
        KEtEnV9ydhgNO219ws0rfa3MYg==
X-Google-Smtp-Source: ABdhPJysfkYMrMgHwodSSnzMkqerBi1jwSuIF2iefWJ4/FcOg7MYEeM+UjIlCWYlQv0Ck0GULeS7uA==
X-Received: by 2002:a5d:6daf:0:b0:204:12b6:a15 with SMTP id u15-20020a5d6daf000000b0020412b60a15mr19676354wrs.340.1648420894641;
        Sun, 27 Mar 2022 15:41:34 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:34 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: [PATCH v9 21/22] drm/mediatek: change the aux retries times when receiving AUX_DEFER
Date:   Mon, 28 Mar 2022 00:39:26 +0200
Message-Id: <20220327223927.20848-22-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

DP 1.4a Section 2.8.7.1.5.6.1:
A DP Source device shall retry at least seven times upon receiving
AUX_DEFER before giving up the AUX transaction.

Aux should retry to send msg whether how many bytes.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index e099491cc6a4..7a197c4a7143 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2016,7 +2016,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 	bool is_read;
 	u8 request;
 	size_t accessed_bytes = 0;
-	int retry = 3, ret = 0;
+	int retry, ret = 0;
 
 	mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
 
@@ -2050,14 +2050,21 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 	}
 
 	if (msg->size == 0) {
-		ret = mtk_dp_aux_do_transfer(mtk_dp, is_read, request,
-					     msg->address + accessed_bytes,
-					     msg->buffer + accessed_bytes, 0);
+		retry = 32;
+		while (retry--) {
+			ret = mtk_dp_aux_do_transfer(mtk_dp, is_read, request,
+						     msg->address + accessed_bytes,
+						     msg->buffer + accessed_bytes, 0);
+			if (ret == 0)
+				break;
+			usleep_range(500, 600);
+		}
 	} else {
 		while (accessed_bytes < msg->size) {
 			size_t to_access =
 				min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES,
 				      msg->size - accessed_bytes);
+			retry = 32;
 			while (retry--) {
 				ret = mtk_dp_aux_do_transfer(mtk_dp,
 							     is_read, request,
@@ -2066,7 +2073,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 							     to_access);
 				if (ret == 0)
 					break;
-				usleep_range(50, 100);
+				usleep_range(500, 600);
 			}
 			if (!retry || ret) {
 				drm_info(mtk_dp->drm_dev,
-- 
2.34.1

