Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499CD57EC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGWIAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiGWIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:00:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B41DF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:00:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id bh13so6155922pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lfnDOjXhW7oeG1YfdtLm2gXojFDgdLapEjPNrm2eGM=;
        b=P+d5RjY4Kh2suZ/56c+y0VXrKklcrHEDMb74mAOWHVESlUV9kC1/+NnMJDrPi0kDrr
         iE4UITe/OxQnb8eRCcuSEl0YOPU5qxu93RdJD2PQW+l3gu/wTpLDE9UDh+2IA4RM4jAo
         lTKrtTxgOkfLS44KLNaNMGS2t9dVZhBdigo8TCgODn3/96rKJLG4wcwPL6HtGhlEZpqJ
         xyMbhQOG3V9mscZalmDhjely9aVDLWVoO7R0r06NS/NrrRqGYzvrSTpPR0nstKdkFMPg
         3ArlREqd9fLo6bEvySQBWNDYD20Hts96q5OtrjQTM0qNyotZZdlGKrmIRdE3NwN4Ddpc
         Ae5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lfnDOjXhW7oeG1YfdtLm2gXojFDgdLapEjPNrm2eGM=;
        b=TV59NIa9A/2j6oq4jQcZ3QJPwf6zBDMBiQOOpXPTbLO4RH9lhfGLm5zBPxDaSd/vy1
         Mgju4Yu+cG7tDhjokqKMSa1czi4zJ0wbU1KBHeACbyJ1yY44MDLQ6h/VDYQ5b4H7ut8Z
         ljIep1BZDVXNcKAW1Z0fPAjCAOFx8uu/uZT01Mu7tgorh+XCROjSJGbfRQiTDOIMAUAs
         cB75F0V/F85u2Uva7+cea2XkSyGXgF1VRCJXI1bD7ptAg9YQ1yKYMj2OH/Hwe5ryOuKM
         Qgasdnu5AdPft74VuX1oPKIvg4s2stc0+3smju61aUWuB+8cuQBY2HzQ3uo+QTa8irMb
         8p2g==
X-Gm-Message-State: AJIora/HhtcbjkuifKtqwinWgWtGo5mo2YRVD4mS/e91IvwdLd0qwmUi
        5R3NAMDZoJqvQ/8RvF9+dXk=
X-Google-Smtp-Source: AGRyM1s1LPV6UAsJk1cWI9v18U6ylR2x3JT4IywPniYlyfHVl9UFa45nZNpShuvzDO3wWgVixEMRew==
X-Received: by 2002:a65:6c05:0:b0:41a:d13f:f0fb with SMTP id y5-20020a656c05000000b0041ad13ff0fbmr1070388pgu.393.1658563205817;
        Sat, 23 Jul 2022 01:00:05 -0700 (PDT)
Received: from localhost.localdomain ([223.79.193.31])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7970f000000b00525302fe9c4sm5245646pfg.190.2022.07.23.01.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 01:00:05 -0700 (PDT)
From:   John Sanpe <sanpeqf@gmail.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] lib/lru_cache: Fixed array overflow caused by incorrect boundary handling.
Date:   Sat, 23 Jul 2022 15:59:31 +0800
Message-Id: <20220723075931.163245-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This problem occurs when malloc element failed on the first time.
At this time, the counter i is 0. When it's released, we subtract 1
in advance without checking, which will cause i to become UINT_MAX,
resulting in array overflow.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/lru_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 52313acbfa62..04d95de92602 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -147,7 +147,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 		return lc;
 
 	/* else: could not allocate all elements, give up */
-	for (i--; i; i--) {
+	while (i--) {
 		void *p = element[i];
 		kmem_cache_free(cache, p - e_off);
 	}
-- 
2.36.1

