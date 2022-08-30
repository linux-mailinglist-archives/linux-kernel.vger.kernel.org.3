Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F515A5A46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiH3Dmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiH3Dm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:42:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8EAC261;
        Mon, 29 Aug 2022 20:42:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l3so9866491plb.10;
        Mon, 29 Aug 2022 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3iztdmN089REoQPlCSNzlH0JI17HfYILuuDitsqzGPY=;
        b=DnyIRF7nyUAJtZN7g6y9o04lk6jibE1cUQfZIc3+eRhySeCnxnm/MscurEDoGGVBL3
         a8ec3qa1ED8BfJJ8AWswt1mibY29AbLkojUWRS4I0VhClziI179mUYgFqCcwTUdcIF76
         1KW9HFCJQg/565KAZVsMYKeAk234nXwNuxhS2qPwm0Pf7d/8WEacls+q0cNYC+0rGbjO
         FD2OCWB7tgqGlLW7Uck69cEMWzPI8GEuyfG7kgJ2ds+Vlsd9KoSlHKXs+HjXyucOnJ0e
         If76pNDwzyFqcmBlY/MdZS7yyE9/lZmfGweOQxjGkJsW00p7G1cJfliG72k7FURzAuRd
         XwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3iztdmN089REoQPlCSNzlH0JI17HfYILuuDitsqzGPY=;
        b=MfFOfzLqWSX0gy3FTplmzHlaWUd+Ab7ZAlilpDLU40S3xZN8Y2SHmdbm//ShoJz7vn
         vrG6el+/WJodOjyoDqVyYcydlpsvlx7yatjrOvJSj3Cfj4whhsZ76R8Uv7udhs4JuKvl
         QC4t7QX9jlSwGzEaOPuPdCUcuQcFWRp/PILKpg+dOqGXw1NDjG2mkFjrBikzpIF80XCp
         Bitia0AyZUCkvZufWD0klYI5z99iu6pV/kUd8kXLDE7mwKEHnGvVJVV+9qGDnMX2WMXa
         fr9GEN+333UqOXxayEelR/szhvtcL0/j5IRat2llCNRqTdyvciYu+ptOfh1wzeR1/gfd
         IICQ==
X-Gm-Message-State: ACgBeo3cae2oeav2aQjOr0beM4WlpZ8MrOP2vr4765OCnop2V4p2GLnv
        iEgIC2d9cwmtiAIQYsL9Cwc=
X-Google-Smtp-Source: AA6agR46UdRpvqM2r/G6VJkMeDqNmxN0/9MmcW+FxaEZbXO22yNo9RKv1KBD1Fc8SrKzFh3RXA2TTw==
X-Received: by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr21253886pjb.200.1661830941194;
        Mon, 29 Aug 2022 20:42:21 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-77-88-242.emome-ip.hinet.net. [42.77.88.242])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm8439577plh.170.2022.08.29.20.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 20:42:20 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v9 05/10] lib: add linear range index macro
Date:   Tue, 30 Aug 2022 11:40:37 +0800
Message-Id: <20220830034042.9354-6-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830034042.9354-2-peterwu.pub@gmail.com>
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
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

v9
- Revise LINEAR_RANGE() and LINEAR_RANGE_IDX()
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

