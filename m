Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C3554092
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355750AbiFVCfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355532AbiFVCfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:35:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC4193E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:35:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l6so5982978plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGl5+ehxGLowleALKzjeGZ3rc803Ngllm888LIuNvsg=;
        b=VnSeM+TIr/QKBFk6gml/hHQpsnIEappV2NO0YNXNvzqho/5OwT2bSkTkgVw7aBqaqj
         WBmAErFIKMAcMurvSHpjhakvBhtB9ttIM2zdqaVRZ8L+ervOtdO8ERPa9fVyHQ+GF4pV
         fgY8bpVPoxVuaZIDRoyNgZouHIMQ24/OmUW14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGl5+ehxGLowleALKzjeGZ3rc803Ngllm888LIuNvsg=;
        b=5dIIKqmIVn6cPHtgOY8wdUYrVzGreZQjXBecI6kNpLySEcR5+JPn79WdRboRiWEyj/
         FD0RAD2GXGX8VTN2IgF7V8aV0peKa7pQqetAHSS6AmFP6ea5g4iixFCgu8OCZTi/Vavh
         Ie4P+ib8arw2p+WsbVXkam4T0VANsc6D0W3hCELNfVtVauQfoavnIJ7ePS9H8saEnYxH
         aVBZT+4Zl7OVU0PSfSi5/7pMHjRuzJ7hzB+nMdKlOsO+0Vc+/HMtfOG25IaRqnmLR9sK
         LHVeuGKfb9GeTkMktpiKk0Oshx5JII4ua69vO9oXcZgihlXIyzXUJGyYBQva3OAUf9Fv
         kEPA==
X-Gm-Message-State: AJIora92Nf+Yce+9PTHNeLWWV0lnSth2MTsUqMPR+ujS/LXA4M+Ahuk9
        Roog6OgNoSLXBJYO4F96ZQAP5Tx/HOuZJw==
X-Google-Smtp-Source: AGRyM1ve8EpdrHDDtoCMYvUHnzTm2dlt4MX4QTcOCfexmssRE74lOtugg9gSecI8FR/TbYd4g4O9eA==
X-Received: by 2002:a17:902:c2ca:b0:168:db72:16a with SMTP id c10-20020a170902c2ca00b00168db72016amr32526387pla.171.1655865308850;
        Tue, 21 Jun 2022 19:35:08 -0700 (PDT)
Received: from senozhatsky.kddi.com ([240f:75:7537:3187:1922:709:82a7:e4d3])
        by smtp.gmail.com with ESMTPSA id c11-20020a62f84b000000b0051844a64d3dsm11991277pfm.25.2022.06.21.19.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 19:35:08 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: do not lookup algorithm in backends table
Date:   Wed, 22 Jun 2022 11:35:01 +0900
Message-Id: <20220622023501.517125-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always use crypto_has_comp() so that crypto can lookup module,
call usermodhelper to load the modules, wait for usermodhelper
to finish and so on. Otherwise crypto will do all of these steps
under CPU hot-plug lock and this looks like too much stuff to
handle under the CPU hot-plug lock. Besides this can end up in
a deadlock when usermodhelper triggers a code path that attempts
to lock the CPU hot-plug lock, that zram already holds.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 052aa3f65514..398eb9e24eff 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -63,12 +63,6 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 
 bool zcomp_available_algorithm(const char *comp)
 {
-	int i;
-
-	i = sysfs_match_string(backends, comp);
-	if (i >= 0)
-		return true;
-
 	/*
 	 * Crypto does not ignore a trailing new line symbol,
 	 * so make sure you don't supply a string containing
-- 
2.37.0.rc0.104.g0611611a94-goog

