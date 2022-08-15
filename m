Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94776592BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiHOJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiHOJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:02:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE052127F;
        Mon, 15 Aug 2022 02:02:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l64so6061344pge.0;
        Mon, 15 Aug 2022 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x5c01E7cObCgh325Qd23DlOZuK03/1+TgA9EfmEhXiI=;
        b=n23cIOUnS7wGzWf2/WKIwPZnDaiVkh7Bw1qWkzrnbWWsNbIaj82HyXguuN2QeLcEmF
         JnTerZuW2v5tzohkNapXRpGyHw/jl8O+Bq6Z1ZJTPGaCLYNaowSXC/zxlloB6Xak6OX8
         zIDhfYpDEFmvIHDO7yl+xsgrWV9lcKRYsyrN5016afz42s8ppIZoSi8wNR9WvPtV3u1o
         6Op1Saf/13DZrHIge+7tw5H3KTRHRZY6nc0LLRrJgk/j6QtjKGpXToLwU4Ngkw410Ugk
         dE48ZKXL0kM9H1ROs+s4lx0EeQhTq0OVA3CdRXx3jCs7bH3IMN7zW1+Jni59m/PB46Ea
         QnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x5c01E7cObCgh325Qd23DlOZuK03/1+TgA9EfmEhXiI=;
        b=qUFpa3WsWwgG7faZm9/gFCfybn62TYVYBbQ7zCSdEogV7tKZXUjioHsbSRpPseaTNB
         HKrCTL8mI3xWQrwPytGo1mfZ1qqpQqtz2x81dmqp3dJqhr/4Au3I3SLypBeIsg87vYR2
         Dpb6/ssRpSKN+GVD7kM4gHnR2ZXZ3c0druXgShKTNgOLDlrsMhUR6n0G3keJjNGHib7e
         zp58oREA3gjz1oQOWfLiLXQMRis7urWph+Jo/dXDddCsEzBiPvTbb4UQ2nPnx0mIHiiD
         07veAR42nd1x3I+rb6CG/Ees3F40T92RlvsXy/VU+57HawDT5tAfPRjSFmVnY1DOx5pc
         ZNPQ==
X-Gm-Message-State: ACgBeo2Mdsg4W4Sud8BBZHXHvozDnc0Bw1aNv7TCEKWxr76vcd4Y1thn
        eMI+VZr24ktMSAXwhKUiLzA=
X-Google-Smtp-Source: AA6agR6QcylJrjojhoBCQF/tkCRHXF/L3Lw0QYLHX52HspD4U5HkkuiRt7lOteR2Lov1ozcfoK0s/A==
X-Received: by 2002:a63:5201:0:b0:41e:2089:7174 with SMTP id g1-20020a635201000000b0041e20897174mr12997948pgb.519.1660554155392;
        Mon, 15 Aug 2022 02:02:35 -0700 (PDT)
Received: from DESKTOP-IBN2BAQ.localdomain ([123.110.155.185])
        by smtp.gmail.com with ESMTPSA id a17-20020a656411000000b00412a708f38asm5491612pgv.35.2022.08.15.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:02:35 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com, lgirdwood@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [RESEND PATCH v8 06/12] lib: add linear range index macro
Date:   Mon, 15 Aug 2022 17:01:19 +0800
Message-Id: <20220815090125.27705-7-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815090125.27705-1-peterwu.pub@gmail.com>
References: <20220815090125.27705-1-peterwu.pub@gmail.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add linear_range_idx macro for declaring the linear_range struct simply.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 include/linux/linear_range.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index fd3d0b358f22..fb53ea13c593 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -26,6 +26,14 @@ struct linear_range {
 	unsigned int step;
 };
 
+#define LINEAR_RANGE_IDX(_min, _min_sel, _max_sel, _step)	\
+	{							\
+		.min = _min,					\
+		.min_sel = _min_sel,				\
+		.max_sel = _max_sel,				\
+		.step = _step,					\
+	}
+
 unsigned int linear_range_values_in_range(const struct linear_range *r);
 unsigned int linear_range_values_in_range_array(const struct linear_range *r,
 						int ranges);
-- 
2.34.1

