Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06115008EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiDNI5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDNI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:57:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9B286E1;
        Thu, 14 Apr 2022 01:54:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bg24so4526205pjb.1;
        Thu, 14 Apr 2022 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlrygEC6KXKgkNGdS+3kNF4KtvObv7m6riwHMp8DaBI=;
        b=pxGLxZdZH7aBAccmSgd0PAlQ3ZDNNZ+vlLAkgx6R4tVeTPnP/jTCAuVjeleH9a5Ntf
         +vDIxFXc/o1CzAuzpalEiC6YeMdaU7geT9FbvXyOd7RpeLB3Mt3c45VzssmZ5yongvSv
         surkdzFePt1yd+DAqaT9OXAuQsO9uOpHqFfjrWsXeOnE9gv8umYO3ab/vHEBoVHcS8/H
         E5K8mWCmCIKQXIrA07BDy/WSx8BZVhV/QcGEACdeEIdGSeSdrECYqSV4URLGIOCla0Pq
         ihNh9qhl+DRqHvlZVaGPjkEZ0qd0bfx/6iZR3gsDSn7ctzjTmyqEfn2j8ANyjQffxbDN
         1k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlrygEC6KXKgkNGdS+3kNF4KtvObv7m6riwHMp8DaBI=;
        b=DDqAPkU32YhXqk/rQlH4Tll8j70gTTBot4nVL98Qj1wpcNbTryS7FCIqGiUjPB21PU
         BJQwt0q9guE4PqSsdGDlMSKEhGA6NlmlFpopL1jDoEdIeKTzhoZkfJ05N+FlD47L+ccB
         qJW5ZPGtLi+MGI/3FvQhJgPVkt7NNH6lTOU0uGhtVPm2AVn/esFbKTTH1fEXB1ELuxoM
         MUYrPPP5+sk8T9jBx6FFuu9YIiPljazx2gfWD66z3cI3mShSV0OsQoeIrkR1YT1+6ZNV
         Eby9LDMCwWsKvAaT0xW1gX+bwdfGXoJc9tK0CWTkhuAXn6LgJBVNj0TFRiBJcoiXMfxt
         Bvng==
X-Gm-Message-State: AOAM530vB9kdhiMDlpESwZTEkjmEZWWOK1OvTcY6Ae63OTsZr3towilq
        DF8ScKJRkK7J30Va6smxeHbuXmyfB5Q=
X-Google-Smtp-Source: ABdhPJwNOfMY2l7XDuvLWXlB/mBCXwx1VwTQp+09T7cagrrffs7zFJjLf2m16SDzZjlOk9q43ouosg==
X-Received: by 2002:a17:902:ea0d:b0:158:5910:d683 with SMTP id s13-20020a170902ea0d00b001585910d683mr20912784plg.95.1649926476495;
        Thu, 14 Apr 2022 01:54:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm1448983pfu.82.2022.04.14.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:54:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-omap2-mcspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:54:33 +0000
Message-Id: <20220414085433.2541670-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-omap2-mcspi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 60c9cdf1c94b..6c7ca588437f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -246,9 +246,8 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (spi->controller_state) {
-		int err = pm_runtime_get_sync(mcspi->dev);
+		int err = pm_runtime_resume_and_get(mcspi->dev);
 		if (err < 0) {
-			pm_runtime_put_noidle(mcspi->dev);
 			dev_err(mcspi->dev, "failed to get sync: %d\n", err);
 			return;
 		}
@@ -1068,9 +1067,8 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		initial_setup = true;
 	}
 
-	ret = pm_runtime_get_sync(mcspi->dev);
+	ret = pm_runtime_resume_and_get(mcspi->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(mcspi->dev);
 		if (initial_setup)
 			omap2_mcspi_cleanup(spi);
 
@@ -1317,12 +1315,9 @@ static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	int			ret = 0;
 
-	ret = pm_runtime_get_sync(mcspi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(mcspi->dev);
-
+	ret = pm_runtime_resume_and_get(mcspi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
 			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
-- 
2.25.1


