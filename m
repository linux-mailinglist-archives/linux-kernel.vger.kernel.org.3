Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2884EB1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiC2QWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiC2QWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:22:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489AD1BBF78
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:21:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lr4so27762328ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTs0f1g7WvDZtbHS2gVt2t5BrJvOtg/n+niYAS/Xyjc=;
        b=WudrhGPJWhRll25Pk3YQkIhLidgFj29CE5C3Cur3YkNrBay/YmzKqH41mFPY23BpSc
         CZN/YZX6jR+0IqHFiHited4GqSn2eHISlCeflNqjf+LkqATvvERv0kg2QjKDUEODM/Gs
         fegaJ3fbGVM1ETitkRRN2CXH7QUhpvWRA0ZY3z5J/IEi96HZhry4qe1k1GZoq07Di1KK
         iAx2gHMOF8kTEFf7U1ZVmKWjJ9QctVfxvOJC+A8pzaDn8Gwmu12GjcWR3Jh0RxWxZlE/
         GUbi6FeXkMMEFdvYodAxjor50sfkhHV2tvdsKpeIWrwXrkhrwmTngKxh5cMGCTtc10S0
         8gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTs0f1g7WvDZtbHS2gVt2t5BrJvOtg/n+niYAS/Xyjc=;
        b=g2XQO5mfpPTHyn/egkPkt7+8XUK+dkh1GsoZ65lwGFJNjZh9SfOklu0dfvNJS7ng56
         qi9686/ONkZtwUrEXUC3iBHxc8jhc8+YWCq1buButUE0hfkIy4r/0qs51/tCx8fcp+bf
         gHQyk/6jS2SLdC1gx0UfSDlnURLkOTz4ZMl/yoypDyVE3W6pA7l/KY119TIF1cZN4O4D
         G1uvXJwT/ETI6CkEhWP7gQbsVjLYBthgaSPjrxe5xt1Bkupybka69ieT1rDPMghxJoXl
         CST0mmV/f4KelGQraZh6zUt/+ZtbWnCxuwtOhCkJGPjIsRl9Zb+irLnHVP3tWcrwAgQC
         yOUw==
X-Gm-Message-State: AOAM530l3823+MBRdeZ6scHkqlbbAYulpOzhirTj62sVAnLL+yD7oNNs
        PPAOstAZBPS/vH0F/QpIzcU=
X-Google-Smtp-Source: ABdhPJwUrfUhoPRTscwLb2VseGEB6d34ZA25ccFR2g+AV+b25O1JYI+Y5rBEZZ3WqiQk3k7T9SY/Yw==
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id ew6-20020a170907950600b006dab4cd515bmr35641179ejc.602.1648570860626;
        Tue, 29 Mar 2022 09:21:00 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906c20b00b006d584a09b9fsm7362571ejz.98.2022.03.29.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:20:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Colin Ian King <colin.king@intel.com>,
        =?UTF-8?q?Samuel=20Sj=C3=B6berg?= <info@samuelsjoberg.se>,
        Charlie Sands <sandsch@northvilleschools.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>, ira.weiny@intel.com,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCHi v3] staging: rts5208: Convert kmap() to kmap_local_page()
Date:   Tue, 29 Mar 2022 18:20:55 +0200
Message-Id: <20220329162055.28006-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore rtsx_stor_access_xfer_buf() is a function
where the use of kmap_local_page() in place of kmap() is correctly
suited.

Convert to kmap_local_page() but, instead of open coding it, use the
helpers memcpy_to_page() and memcpy_from_page().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 -> v2: Rework the commit message and use the appropriate helpers
instead of open coding the use of kmap_local_page()/kunmap_local_page().
(Thanks to Ira Weiny <ira.weiny@intel.com>).

v2 -> v3: Use memcpy_{to,from}_page() arguments correctly.
(Thanks to Dan Carpenter <dan.carpenter@oracle.com>).

 drivers/staging/rts5208/rtsx_transport.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 805dc18fac0a..b702c7caf944 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -92,13 +92,11 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
-				unsigned char *ptr = kmap(page);
 
 				if (dir == TO_XFER_BUF)
-					memcpy(ptr + poff, buffer + cnt, plen);
+					memcpy_to_page(page, poff, buffer + cnt, plen);
 				else
-					memcpy(buffer + cnt, ptr + poff, plen);
-				kunmap(page);
+					memcpy_from_page(buffer + cnt, page, poff, plen);
 
 				/* Start at the beginning of the next page */
 				poff = 0;
-- 
2.34.1

