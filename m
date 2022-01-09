Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62C488C4B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiAIUb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiAIUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:31:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7DC06173F;
        Sun,  9 Jan 2022 12:31:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a5so19047261wrh.5;
        Sun, 09 Jan 2022 12:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVxqdhSmwND7LPC9Ui4ZQJOIVfvWlzvv/90s7w6B5IM=;
        b=c/Zk0NQcXA2SZ9SiVcMCotQhECHHHx7PSWjjvXc3/8beOJuLmOFmaZJ3B0UOrVzQiY
         Rvpt1XGBc0vy0b7vroeODiwR3LaXmdaF/O11MNffAyjvA8a2hSRInyDWEJ1VKGTogXTI
         pvQI30pctZNmdEbD3ly+7Pq9pjmqy4khzpI3vnJ0gHBuTVF0earYnmtKl1lMHPNqnPxL
         3U99hze3eCkl5+lAkf6yln2HDhbiaVMfypz5PYaNS9G4ALkox/GmA+3kxCkV6ei5dJG/
         7BRTQVrLytg9ZI/XwcBLhx+KXNvTrae3srdkbf0Ynwlm/I8Ur3PopP7ez7F+j5l05cvJ
         WCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVxqdhSmwND7LPC9Ui4ZQJOIVfvWlzvv/90s7w6B5IM=;
        b=iYldydz0Qtog/NE0EUg4YZ/2SVLNbD8TWiLYmmDnLxJR/SCwQW33TL3wNMuKyKsamw
         xnWpxvHmVOfejEg7v4kC8kHC6WvAKNMQFnU5nO8RTaG/5tr2HEhlzj/sZAaN2eVDZ7IZ
         IAGD8NUT1ce/2n6rCs8lKC0ffrpSSndo6WtGTNaUm7fUamj06IwJSBAvsYuD/u4ueGrh
         5S6QY1p6GCxuy3TJxcmvc0+NDiCiwt5oJzyYo67+e03QZ4n3FZTj6wSGq046R5KbIn2l
         BfudkT6tWy1bxYyfah97hcyXvs29JymjNAx6NrNM7B8x3thhEBTTEn2lNLWNOmLVhd5v
         diow==
X-Gm-Message-State: AOAM530kFqTCYm/Cb9oHHHZUhgVUvuiG1c7EP9P7QxD37O8tYhViK9Li
        YRaDEYWptOmNJSpcCQEfUjU=
X-Google-Smtp-Source: ABdhPJxVqtlvscb41hOdCYQDVd7o8btAn3V18ZKgh8iUFdh4Qc76jZk6Pjedl6ObHF3sbnrvwkRJrA==
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr62101570wrs.579.1641760313091;
        Sun, 09 Jan 2022 12:31:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f8sm5304253wry.16.2022.01.09.12.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 12:31:52 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i915: make array flex_regs static const
Date:   Sun,  9 Jan 2022 20:31:52 +0000
Message-Id: <20220109203152.51414-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array flex_regs on the stack but
instead it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index e27f3b7cf094..df698960fdc0 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -2114,7 +2114,7 @@ gen8_update_reg_state_unlocked(const struct intel_context *ce,
 	u32 ctx_oactxctrl = stream->perf->ctx_oactxctrl_offset;
 	u32 ctx_flexeu0 = stream->perf->ctx_flexeu0_offset;
 	/* The MMIO offsets for Flex EU registers aren't contiguous */
-	i915_reg_t flex_regs[] = {
+	static const i915_reg_t flex_regs[] = {
 		EU_PERF_CNTL0,
 		EU_PERF_CNTL1,
 		EU_PERF_CNTL2,
-- 
2.32.0

