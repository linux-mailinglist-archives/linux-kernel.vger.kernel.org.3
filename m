Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BA5ACD7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiIEIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiIEIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6393DBED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y29so8006628pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ARMalt43cGQStsEP0fAYz16MOL60Ugpll7VhrHzWrN4=;
        b=cQVKvubgWaoRbZYTjgiOV04EQaA+PJkhinoKlPFno51F4mzronmiF7U+mwYxvF4s3Q
         5MM6S8ICClfNa3uBwdz8UY2mlEFwhSxCfGXTPdxqT8WWBu42rdP7LQcLzDKvyWW73kts
         Q8Wwk1DHyX5Ob0hWV2EYNohECRVz9LUuGJxkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ARMalt43cGQStsEP0fAYz16MOL60Ugpll7VhrHzWrN4=;
        b=tO4lJqvLRoQ2cFhFUqcFJ5HIZnqX3IBTx6pdWYPoJjvHIS602/5TPI0kGKgMtLx4k2
         2XYk8E//cvkb5F0vLmwoXyQQX1dXbu44IZEIWczH74AJc3H+niyITx1LuKxBgLH0kn2n
         NsFfhY3YZckKK8DSwDzQfLriKg5E8UMZ3fbx5vch2blEu5rES1BK6uBI47FHJADzeeLF
         NQjkWW5SzEuooEQqz2J5BQdgUWTRVl+6eriZkJ8sQajfXDiNECfWX3Ih6XgucsFRjmEK
         fbhBWZd/NQMq0oTt0Kx3RhvF6A3qqGsCxXk7SfbV8Wvx1UTiCK1T6ujy+D5P0pkKUHWu
         HhLQ==
X-Gm-Message-State: ACgBeo0NKPM1U6CjDSvGSXEhXkjfSypmQ5v5TIlZVFMVjz6lp3olSyRc
        x3rzYAl8RGxrt8sRgiB+m8zalWgYQfjryw==
X-Google-Smtp-Source: AA6agR6Y13UabkGj2Pw1xPeKlx9CcnBMiy4uG1v3LoUZbuUY3pNQYy723yfvhdQOcHQZVmLZNUpHkQ==
X-Received: by 2002:a63:e317:0:b0:432:38c0:bde3 with SMTP id f23-20020a63e317000000b0043238c0bde3mr10927879pgh.567.1662365785944;
        Mon, 05 Sep 2022 01:16:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:25 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 5/7] documentation: Add recompression documentation
Date:   Mon,  5 Sep 2022 17:15:50 +0900
Message-Id: <20220905081552.2740917-9-senozhatsky@chromium.org>
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

Document user-space visible device attributes that
are enabled by ZRAM_MULTI_COMP.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 55 +++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index c73b16930449..88957fcb6ad7 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -401,6 +401,61 @@ budget in next setting is user's job.
 If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
+recompression
+-------------
+
+With CONFIG_ZRAM_MULTI_COMP, zram can recompress idle/huge pages using
+alternative (secondary) compression algorithm. The basic idea is that
+alternative compression algorithm can provide better compression ratio
+at a price of (potentially) slower compression/decompression speeds.
+Alternative compression algorithm can, for example, be more successful
+compressing huge pages (those that default algorithm failed to compress).
+Another application is idle pages recompression - pages that are cold and
+sit in the memory can be recompressed using more effective algorithm and,
+hence, reduce zsmalloc memory usage.
+
+With CONFIG_ZRAM_MULTI_COMP, zram will setup two compression algorithms
+per-CPU: primary and secondary ones. Primary zram compressor is explained
+in "3) Select compression algorithm", the secondary algorithm is configured
+in a similar way, using recomp_algorithm device attribute:
+
+Examples::
+
+	#show supported recompression algorithms
+	cat /sys/block/zramX/recomp_algorithm
+	zstd [lzo]
+
+	#select zstd recompression algorithm
+	echo zstd > /sys/block/zramX/recomp_algorithm
+
+Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
+which controls recompression:
+
+Examples::
+
+	#IDLE pages recompression is activated by `idle` mode
+	echo idle > /sys/block/zramX/recompress
+
+	#HUGE pages recompression is activated by `huge` mode
+	echo huge > /sys/block/zram0/recompress
+
+	#HUGE_IDLE pages recompression is activated by `huge_idle` mode
+	echo huge_idle > /sys/block/zramX/recompress
+
+The number of idle pages can be significant, so user-space can pass a size
+watermark value to the recompress knob, to filter out idle pages for
+recompression: zram will recompress only idle pages of equal or greater
+size:::
+
+	#recompress idle pages larger than 3000 bytes
+	echo 3000 > /sys/block/zramX/recompress
+
+	#recompress idle pages larger than 2000 bytes
+	echo 2000 > /sys/block/zramX/recompress
+
+Recompression is mostly focused on idle pages (except for huge pages
+recompression), so it works better in conjunction with memory tracking.
+
 memory tracking
 ===============
 
-- 
2.37.2.789.g6183377224-goog

