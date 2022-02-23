Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11C4C127B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiBWMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiBWMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:10:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17CF9D06E;
        Wed, 23 Feb 2022 04:09:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i19so13604817wmq.5;
        Wed, 23 Feb 2022 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XthWtcx8CQQ6z/Lfovl9ePMxpx3VHx/bDsastA+Xo/Y=;
        b=Y22cedrxeR+ywyVnUEBJ3MqpAQqnxuukkkbsAQRovrWabWEHabwzrgc17KdGiGOdno
         IcSfsG9xcKK/PzvfrAjNob+muSRsfRTssCmuqTuG2BcIK+G5n7awdRq11RmEftEXZvnh
         PCT24MiKvnplpPn91CXRNja1ceFgaPanB3ZtW3+5KplWtYVJtR2pm6BkopWOTggGr4MS
         fmfN8LKpVjtncGQs8v1RFqREMxuSg4hop2IeekPD+7BaebKmkEfRS3ZqoYIoUYHB2RRZ
         ffRba93CCry6mCGYojsiRTXVXoL7uzphXPQVl8sBZZSt8wYt/+IstT9JYggESauX2jFg
         BfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XthWtcx8CQQ6z/Lfovl9ePMxpx3VHx/bDsastA+Xo/Y=;
        b=vkHGYdX0zBerX6SHDNEoqiaQhRtveFr6uoYjvhCfSdWND6PTbnqmAHmywUcTj71N47
         Rnj1/CShSnrIsgJoQ6h7lvfg00PxWCzSegokApgXocKvH+bscZ5ZqPnlbouqxzIKN6BN
         tzYZBY0fCIEQxjVULwCQxP4RuApBVHyeVKHcg7u78Rgb/PnaabSoXh+3wNhTqg24KUdk
         EnLheIzX2yYwe7V9Z84PpwmTWDw9Y4whR6jaNLQxsMW8wL7I0g+UiHcspxKhRgHBXbZi
         kLKhjKuUYz/2BsIT3bBqRW6eVTki2jpxy/Y+TmQSxCqu9UBQKZo/Jeiu4BCG7P7xw14J
         kDmQ==
X-Gm-Message-State: AOAM533S5sVA8RY6I1Thza8ATyVT3v92Xfqu46NEm90hMCSLrL/KTeS0
        B42gN14iY8w5wytjd0f9vRA=
X-Google-Smtp-Source: ABdhPJwhENDV0VlSU5f4YqTw2faSx1qMsaw+VxmLxp2w2HX7Rtqr3nK3WWBoH9/uoF2ijiMQmEtPug==
X-Received: by 2002:a05:600c:48a:b0:380:3f3a:e08e with SMTP id d10-20020a05600c048a00b003803f3ae08emr7160797wme.1.1645618164119;
        Wed, 23 Feb 2022 04:09:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j10sm6733042wmq.20.2022.02.23.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 04:09:23 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] drm/i915: make a handful of read-only arrays static const
Date:   Wed, 23 Feb 2022 12:09:23 +0000
Message-Id: <20220223120923.239867-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only arrays on the stack but instead make
them static const and signed 8 bit ints. Also makes the object code a
little smaller.  Reformat the statements to clear up checkpatch warning.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Make arrays signed 8 bit integers as requested by Ville Syrjälä

---
 drivers/gpu/drm/i915/display/intel_vdsc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
index 3faea903b9ae..d49f66237ec3 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.c
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
@@ -378,10 +378,18 @@ calculate_rc_params(struct rc_parameters *rc,
 {
 	int bpc = vdsc_cfg->bits_per_component;
 	int bpp = vdsc_cfg->bits_per_pixel >> 4;
-	int ofs_und6[] = { 0, -2, -2, -4, -6, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12 };
-	int ofs_und8[] = { 2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12 };
-	int ofs_und12[] = { 2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12 };
-	int ofs_und15[] = { 10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -10, -12, -12, -12 };
+	static const s8 ofs_und6[] = {
+		0, -2, -2, -4, -6, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
+	};
+	static const s8 ofs_und8[] = {
+		2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12
+	};
+	static const s8 ofs_und12[] = {
+		2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12
+	};
+	static const s8 ofs_und15[] = {
+		10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -10, -12, -12, -12
+	};
 	int qp_bpc_modifier = (bpc - 8) * 2;
 	u32 res, buf_i, bpp_i;
 
-- 
2.34.1

