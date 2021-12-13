Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80747378C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbhLMWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbhLMWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so12212080plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZNwW/9OvsTV+qiT9UTy8s+5iJpx7ikW0euH58EBkfg=;
        b=NH3Cm+/syr/5xH9ERMY6nynRgidgBKfGUOPYwvA0S8g5losLW55MQ15c9wEJ1GIsLw
         6udRqMoOIYxmjEV5xF/iD03rdu5qnPxmCpemrM4PdQkAt9aFzaji7xKckzWKA11a5B7X
         CZODHSGzhf7pxXXCxuQcEcSNDS8YsXPVy6EcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZNwW/9OvsTV+qiT9UTy8s+5iJpx7ikW0euH58EBkfg=;
        b=s8wt2zhVxpmiyQhjaBD703x5yIl6dNCI/W1LrfoBmsKl3bJVCJbrP6FYolc+0ZLVYJ
         +IC3T1Jf7g0SkKqu9IK8c5W61qAPKoTQ5BqhYJPt0nZ82N4e8IZRC7mV9211ryli2YIv
         gaADJlf9qXBAwZYgbDk4v4Yfh2pUzurW1JYici5lOzzi6qvSYTfxpay3VrIoSFa4oRfy
         D4hFHVUtJwJO1Z62+bHXK7aDKo+iMkxzvW3V8xSIMtv+XvhOvE+b8kmPjvayW/mA4atI
         6T9f3j5HYhLiu/YmPZAg4SINngYea0DHYB8ttzolyPmx/3Be3c02fexHZAef62xZB4Gt
         PXQQ==
X-Gm-Message-State: AOAM531zYWTa0zaqzoxiFwLR18PBWPG13CX4NlJ82aNDzsLyd4CVP2G3
        AnTQCAMeEftAGjWgiXl0kBZ7ug==
X-Google-Smtp-Source: ABdhPJwKT+0xgRk2d57afPpPfd4FYioMYH89TzHnCO2B2FQX5nKanmNkPh07nocEglnADxkKKkkfVA==
X-Received: by 2002:a17:90b:4f84:: with SMTP id qe4mr1293960pjb.102.1639434818728;
        Mon, 13 Dec 2021 14:33:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm14588219pfc.53.2021.12.13.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] sata_fsl: Use struct_group() for memcpy() region
Date:   Mon, 13 Dec 2021 14:33:19 -0800
Message-Id: <20211213223331.135412-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; h=from:subject; bh=xjmOZ6hvD4alrAJgxUmOWZ9wXhl8T0JJv7fV13v9FkM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o3LdWv0XJ6IO5ViP/ddJkOmEUD9tsspbNlh28V CdXNcV2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKNwAKCRCJcvTf3G3AJkGkD/ 0fbKX1w+xTbyOLXyjwIZ4ymK2oxp713yRgI8PwrtAgZyhbm+wteIcDOEKpj2oZfrUv6KolOyCp/NSw ptVZnx8vr6WOJ3CQpClqS1QAd1t7gx27Ml/aZMaT3xvNNRD/R/qk+fkmjPok8vNBrDLSqqdNYRajZy OOD2Rfoq5GjZjTKMA0sYDSir/Sv9vYm1n4YYLlhDFTX+S0ufYDF2DyUDWtWh+7mbT4cTicdPymoZcq aUXD7W7ggQGeEH8+PLVfwwKgwdTFNsJ8KIvunT0BZNSgje1C28UiUb4nLnZdn14ra2u+FmNY3k2WEU 1/bbgAjZ42QM4vNdtQ7NBdhfaqS7yBLwLDR2991hxuUXQcAFGBDitD7yy1J3fRPtcqZg8Xv8V7EMA9 8KpQBg9I8VKFk7Ks17mAz5x+crM9pLZXGLHIY3F0D7oZ1SGILs2q6FPz5CIdiXtONI46dn0zjWlzJB t2aZo9V0Hg/gcJbuQNRAagsY1bSfwFEm6pxLX0MFwTxMzvIXxkn8P1IFAIeIUVHbweeEpCm1wN94cc ois/y9GcQ6ZTw9+BtD/JF9U5c5gdEcu08ZFyY5iXMuVTe1zQVeYIIau+boAu/cpSsRAftxXwft3Yj6 xl6TTEN1YVdYj+e9F5GC7rhvP7Kmk/9hESx3E5ZhCgGhyjUMypOtCgz2G4Uw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct command_desc around members acmd and fill,
so they can be referenced together. This will allow memset(), memcpy(),
and sizeof() to more easily reason about sizes, improve readability,
and avoid future warnings about writing beyond the end of acmd:

In function 'fortify_memset_chk',
    inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field();
      |    ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ata/sata_fsl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 3b31a4f596d8..c5a2c1e9ed6b 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -246,8 +246,10 @@ enum {
 struct command_desc {
 	u8 cfis[8 * 4];
 	u8 sfis[8 * 4];
-	u8 acmd[4 * 4];
-	u8 fill[4 * 4];
+	struct_group(cdb,
+		u8 acmd[4 * 4];
+		u8 fill[4 * 4];
+	);
 	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
 	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
 };
@@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
 	if (ata_is_atapi(qc->tf.protocol)) {
 		desc_info |= ATAPI_CMD;
-		memset((void *)&cd->acmd, 0, 32);
-		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
+		memset(&cd->cdb, 0, sizeof(cd->cdb));
+		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
 	}
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-- 
2.30.2

