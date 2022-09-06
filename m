Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325A5AE313
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiIFIj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiIFIiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:38:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1DC7969E;
        Tue,  6 Sep 2022 01:36:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 123so1251145pfy.2;
        Tue, 06 Sep 2022 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BLldUmawu01GzUZglxj6MBSK7Wi8J1495Ow2vHiQCbA=;
        b=iMG0S4zofl/DfVRmN8zUOquTtKl6J8uMm50G+Ub1HZrWIY0EA+ivHPMlCqT2OrglC9
         D4tFhZfIq+6PQudEACeyJG9ewydxsZMq1gH2Cu/n/CFrV8Gixo1PTXTXsh9hdAchHSvR
         RBXMTwli/wkm765TGK16OG8+0re3CpYkDwul96NHyCLIh753F4iwInM1N/by6yrmI5YC
         ALDhRvtggX2RETZEBNJqOrdBhDUU9hMdWrltrODDT0Xhs8V2F8/0o8og5cbBdztNGtYH
         TZEpiUTQvu1WzlN5Yie6G+46wcuS8gQAa2fzCOMcyAkgcaucZ/SCV1jn7Ip0PE+Gy8rc
         dSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BLldUmawu01GzUZglxj6MBSK7Wi8J1495Ow2vHiQCbA=;
        b=uiASZa3o37QfWRI5e9WZSFIM62k2B4D471CzSkrzKkvUdoEIefIBhbKMBEBlzjKyht
         2IaxLccvhGe0GQ/0wONcyLuHm4O83zMZnjz/oEgxMAoax6dPhOrtbv8ZI2O5I0GykUb3
         7E2yL737yplULj0jKdF7pAPbT7HRgsj0QtKs+8nfQZgyM3z6cdxFuURg35H+O7a3DVgG
         Fpaw/Kk6FVPOq5D7WBEpFs5lYcYgmRv3Jr8bdAgUimhksPMSn2JewfHxJoIGmUTM+wGS
         T63HJpnaMHj7s4ZOjLHW6CgOv6p/DZ6Cj6dC2xK/YkC1qN0/Gu2cJjFL9XzEKwz3wXnK
         r+1Q==
X-Gm-Message-State: ACgBeo3Egwr2JA6Yq/DWPnZ97fIFEvqeHgSpt8cHCHuYBRXl+rhycGeV
        AR27jAQWvbBKD9OQTJ/XsxusQrNQE9UX1A==
X-Google-Smtp-Source: AA6agR6YBXOXWI2PPAafdZxRc+Vmw5GkwSeGIJwkLd7ubrEomLInuRV12ZMwVC2kJ7ZkegqiyI/hzw==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id k17-20020a056a00169100b0053b3f2c3257mr21270799pfc.21.1662453409662;
        Tue, 06 Sep 2022 01:36:49 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-80-193.emome-ip.hinet.net. [42.73.80.193])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm9474506pfj.57.2022.09.06.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 01:36:49 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v10 4/8] lib: add linear range index macro
Date:   Tue,  6 Sep 2022 16:34:00 +0800
Message-Id: <16d18d1b789f83dd6f6dcebcd28ac8a2b9ca01de.1662476695.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662476695.git.chiaen_wu@richtek.com>
References: <cover.1662476695.git.chiaen_wu@richtek.com>
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

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 include/linux/linear_range.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index fd3d0b3..2e4f4c3 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -26,6 +26,17 @@ struct linear_range {
 	unsigned int step;
 };
 
+#define LINEAR_RANGE(_min, _min_sel, _max_sel, _step)		\
+	{							\
+		.min = _min,					\
+		.min_sel = _min_sel,				\
+		.max_sel = _max_sel,				\
+		.step = _step,					\
+	}
+
+#define LINEAR_RANGE_IDX(_idx, _min, _min_sel, _max_sel, _step)	\
+	[_idx] = LINEAR_RANGE(_min, _min_sel, _max_sel, _step)
+
 unsigned int linear_range_values_in_range(const struct linear_range *r);
 unsigned int linear_range_values_in_range_array(const struct linear_range *r,
 						int ranges);
-- 
2.7.4

