Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5695ACD82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiIEIQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiIEIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:21 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDF30F7C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h188so7466330pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DNUOFwSGpdK+nnrxMG7S20eDsCufcwNG30HnXLUld24=;
        b=eH5yHC7E3boaNZSJoFGkpKwRTCJkbyHVEkXkQS6xSCqO+cZV0Y8cmWXp03lKyOj7oH
         d3fWNvodjlK85jXLZNTu43uTDK/eC2fzKm74+52vrd/DXXsl/mwsRxe03esHNX1aBavm
         ZhQ3qfdoU8OXQplyZFimzo5999MI//98slFvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DNUOFwSGpdK+nnrxMG7S20eDsCufcwNG30HnXLUld24=;
        b=aXQSB6Z0J7Tz1/Et1dgvfhUDdskufCPZr9RljrhH96BNyscHIuojQ/MeMI5pSwylmZ
         ucPSdbyPJXw1/N5ZMsIUCihCGQ+z+VRmrIQmhQxiWBKaxCwKwtREB4Y1YgWO8CxE5pdP
         fYMkQRppQH/4Po2EJjpV13n+VcmcwP7ZGhfkCpJ2EJXh2i3sV8/5PNdwqwJdA+w4xVNZ
         pm8kd6LdNrgwnKdq1ZwNfS4el1IoUEdkaidl6QC7ee0FqAr/kmtOVYzQMLgiFNrI+ENP
         XDVhT7GqpFp5d34oQh4zMU8+Tovm6xnKzg4pHze51234gBx5rnOOT/KKcseom/O5k7qn
         w5aA==
X-Gm-Message-State: ACgBeo1qwpAK1oYrnT0ffzUeJPLcbtrWI+jdtUAHeH8RjSzn/kJttWyg
        uBEDqnCeAPMxER/tvfu7wFKJiuinU/2lvw==
X-Google-Smtp-Source: AA6agR75YXRxs7K6WXZCwu9cFa53p0bnH4Ss1kJ8jGsE12knaZ8A2T65N2kxadwOs6l6K3OeXznNpw==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id l4-20020a056a0016c400b0053508900d4amr49041501pfc.0.1662365777547;
        Mon, 05 Sep 2022 01:16:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:16 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 3/3] zram: Add recompress flag to read_block_state()
Date:   Mon,  5 Sep 2022 17:15:47 +0900
Message-Id: <20220905081552.2740917-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220905081552.2740917-1-senozhatsky@chromium.org>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
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
index f144f31c3c4b..791f798d356d 100644
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

