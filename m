Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB55ACDD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiIEIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiIEIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:23:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADE31344
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:23:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q15so7950187pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=E05eGk8Ts+47tHWXcyTeAoJzHa+CPKznHpzjFQelL1A=;
        b=acK8pXsPob7Y5s+Bg0YkKeVygfkxhsWVef1JJLtRM5ezbfg1jCdDeReYhs5vLFpc3+
         7C2+UY0wr24vSRkT3J9v1mb++EIgdgPbFzDQep88QpoFUDw9Mx7FNM1NK9g3unavDjvT
         ZwrREvj/gc8m4PHJNEjGYalq9yyae/RaZt7Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E05eGk8Ts+47tHWXcyTeAoJzHa+CPKznHpzjFQelL1A=;
        b=Rl2Vc0zYgZgHPtrYteREFzJhrs+Qe5zeo8k/3lXsqf4GU6EgFo4pOmMNe40LxQ//7I
         Kox6z16zUhn99WUiULUYEJRdM/EHrYdbxM86rh0nN/KXhbBWPXGo79LHUuVzkoAyQ0Q/
         6hnmYj9HT24/RY8CLpfBrpMUcE683M09K5E91lmOhn8n7TNqomlo/Ultdxz3GNSwKWyK
         chJ1ksEPETUQJxz3+Es+BcAsmucJeKVbqqeQEwEUVbFtaWNcPPRvvr6dcinMohnmUI6g
         yEJlAJ3YoDoSaMr/p7k1tDP2PY+OTCuWymmZrWpTe/6Lt1XI+l9fs71nYC+aDi+Rstha
         sEIg==
X-Gm-Message-State: ACgBeo07K1TfwWZ4GDeaNqTmAU73HqJc4GRQBecGAVu78eF1OMXWOdNb
        trHLKLgZZ3+D0Tky2jYuaV0+GJSkDpwaNQ==
X-Google-Smtp-Source: AA6agR7apkwdHRSEq/AOrRxCZYMadHNajCXFhmfCQuwClOVZjsqItLs1Hn/U6/65l19Q0gXR//E8EA==
X-Received: by 2002:a63:d1f:0:b0:422:7774:1969 with SMTP id c31-20020a630d1f000000b0042277741969mr40307627pgl.88.1662366231066;
        Mon, 05 Sep 2022 01:23:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm6807093plf.30.2022.09.05.01.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:23:50 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 7/7] zram: Add recompress flag to read_block_state()
Date:   Mon,  5 Sep 2022 17:23:23 +0900
Message-Id: <20220905082323.2742399-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220905082323.2742399-1-senozhatsky@chromium.org>
References: <20220905082323.2742399-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag to zram block state that shows if the page
was recompressed (using alternative compression algorithm).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 9 ++++++---
 drivers/block/zram/zram_drv.c               | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 88957fcb6ad7..70a3d0243b45 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -466,9 +466,10 @@ pages of the process with*pagemap.
 If you enable the feature, you could see block state via
 /sys/kernel/debug/zram/zram0/block_state". The output is as follows::
 
-	  300    75.033841 .wh.
-	  301    63.806904 s...
-	  302    63.806919 ..hi
+	  300    75.033841 .wh..
+	  301    63.806904 s....
+	  302    63.806919 ..hi.
+	  303    62.801919 ....r
 
 First column
 	zram's block index.
@@ -485,6 +486,8 @@ Third column
 		huge page
 	i:
 		idle page
+	r:
+		recompressed page (secondary compression algorithm)
 
 First line of above example says 300th block is accessed at 75.033841sec
 and the block's state is huge so it is written back to the backing
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8ed41514b8f0..f3948abce2f7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -936,13 +936,14 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12zd %12lld.%06lu %c%c%c%c\n",
+			"%12zd %12lld.%06lu %c%c%c%c%c\n",
 			index, (s64)ts.tv_sec,
 			ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
 			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
-			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.');
+			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
+			zram_test_flag(zram, index, ZRAM_RECOMP) ? 'r' : '.');
 
 		if (count <= copied) {
 			zram_slot_unlock(zram, index);
-- 
2.37.2.789.g6183377224-goog

