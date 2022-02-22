Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB04BF7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiBVMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBVMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:03:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6AFC6210;
        Tue, 22 Feb 2022 04:03:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so32729129wrg.11;
        Tue, 22 Feb 2022 04:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbmY80ocxNOiijSbsV19VPgVTJ6ROSn9KA0LYKbj2Ss=;
        b=MwbETFFEcrGhyG+LH1t68UsAe53GCSf6urVxWoBvDVlCGfAcvUfapW8Uxq2bXd6Bw+
         aNVFsaEE9mCxY2/8v7SKrARfQWLVCFjZ1NWsZB6kbfSTPt7zurbCxv8a4q9oe/gQZ7zU
         DoUAEqETC2nTzi6H82/0Mxti9k2vVGD6zRNO4+59/m9VP/krtr62munaBLFtEX74wHc3
         cNTOniX5rpos3Liz/tyu+dimFrg/XCPhg3LEimTqM8RyCA8wU7uG4CnZV0MY+zaWug6X
         9QTWE+/aBMPOrBVboZ8H4+CC2tWeoWnbV0UrdobfF1KybUnzJNh5n4os6+JHJquE2Qj2
         57Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbmY80ocxNOiijSbsV19VPgVTJ6ROSn9KA0LYKbj2Ss=;
        b=mFNLG+PDn6tUorOOipFFOJV9bzIV4+1ynKdlyoU4Gbbe+yhvJ2gwFPSY0tTJs3GG0L
         MRxSi3/VpynwbiqeK+/ZcTuYZJYOwgvCKh7MrU/Nfbq31e7Cp0O1pvqz3wqMcyD5Cyq5
         5CBC5JRqgS2auJEPBluBapM0EOEztP1AElKCVwcWjJ9YN/UJF9ZpT4WuVC2z8/ap93IZ
         951yySSLrjYBfrfM7G3la+wTp+wRCmU4c0nTaFOScqP/CbZZ2NQmSK5qyWfp+djfxAdB
         1LchR0Qa1UBxlI7lKNnIKL4huDUAN/uKpBDQrMDc6Lgy6OXFjP0U8vzjm1MRYI0zqvwO
         FWNw==
X-Gm-Message-State: AOAM531AovNfwg6m1J4HP3SziZLSxGZ66qK/5pPnOu3cA09IotE+LS0/
        kkPV2Sf0tbAIB15mOxL+0JU=
X-Google-Smtp-Source: ABdhPJz+y6HNF/vXrsjO1hB+4KCEYzs7HiueM6A9qCnX0USE6K7ZbYhvnQYVzFCmpLKSxqerxRCFGA==
X-Received: by 2002:adf:f846:0:b0:1d9:3079:a02f with SMTP id d6-20020adff846000000b001d93079a02fmr19192537wrq.62.1645531404467;
        Tue, 22 Feb 2022 04:03:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t16sm3178500wrg.99.2022.02.22.04.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:03:24 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: make a handful of read-only arrays static const
Date:   Tue, 22 Feb 2022 12:03:23 +0000
Message-Id: <20220222120323.86480-1-colin.i.king@gmail.com>
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
them static const. Also makes the object code a little smaller.
Reformat the statements to clear up checkpatch warning.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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
+	static const int ofs_und6[] = {
+		0, -2, -2, -4, -6, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
+	};
+	static const int ofs_und8[] = {
+		2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12
+	};
+	static const int ofs_und12[] = {
+		2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12
+	};
+	static const int ofs_und15[] = {
+		10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -10, -12, -12, -12
+	};
 	int qp_bpc_modifier = (bpc - 8) * 2;
 	u32 res, buf_i, bpp_i;
 
-- 
2.34.1

