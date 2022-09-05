Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B75ACDBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiIEIYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiIEIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:23:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED332BAD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:23:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x23so7845230pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ARMalt43cGQStsEP0fAYz16MOL60Ugpll7VhrHzWrN4=;
        b=AbhuZG4cLnD4jAtfo2ZO07aIOwcJJvwIZESzjpZ5Ee+82ZNdfngwPfiuw6v9PXi/eR
         /BxJ0orFnk5MpMZv+Y+LnbYJFKUzam+yFwSFhDCiAYDY6+eOU2UMsM9y+K0yq02gvGO5
         3LeNv89oR7dUBGGFpFwPExYtdVrQijvYiu+Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ARMalt43cGQStsEP0fAYz16MOL60Ugpll7VhrHzWrN4=;
        b=WaqjuneOI+Gfb6Y/kKcC37JT9Wkf1PZSC0lIf63lQXnvA09iew9Im7c85sfEoZUv5t
         CZKaQMJM5QJiwYcr2pN8LR5hSkkk9JCNyNpdRJUe5BC53QP7dUPI+BAHFZ1ELjvWN5wt
         4AqizSu8E7B30gmiaU/o5YgKe55uH4pvCm4N9DQsQ5tnrC0Q6gFzWqOIbuQ3LpxFnaE8
         dmLglXQu22FfTCNLUTWl+1Zz7R1lffuVcm/8iB9eTCQsD4Pyg/GYoILUGIGmo8HNAMXe
         NEV2y7ihcbRw4LxW6s/yufXcPqdsYbS+0GsvGWo02CT4K6TtAc5VNTAzvnJWBt5p3pvS
         1Jzw==
X-Gm-Message-State: ACgBeo1KqFsOUCKnEP0FW9RrVOxb2PxSs6nQ6cBqkWis2gXnr2v4aW/Z
        ZT5DrL9gG/odDuRJb2pdHasDeA==
X-Google-Smtp-Source: AA6agR6MdV0jQOWw7gPUNPTuBQ7N8UC1YJh59UXImF2+oeIhZoDkkXTWCLMASpJ6FNqJ5k4s2QvS5A==
X-Received: by 2002:a17:90b:1652:b0:1fd:eca8:d2be with SMTP id il18-20020a17090b165200b001fdeca8d2bemr18456213pjb.79.1662366225603;
        Mon, 05 Sep 2022 01:23:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm6807093plf.30.2022.09.05.01.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:23:44 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 5/7] documentation: Add recompression documentation
Date:   Mon,  5 Sep 2022 17:23:21 +0900
Message-Id: <20220905082323.2742399-6-senozhatsky@chromium.org>
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

