Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC90468FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhLFDXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLFDXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:23:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1281C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 19:19:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so9714821pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=JRCJVtamUUaroED1nWHJzoeg1mlyoIA8vGQkHPHJwiY=;
        b=ZUU/lOAa5jYgUc0gr1xv7DnfvA4g/hfTf2f4Pv59OJHFCocSPx+Hji2is4ixK/RZAz
         l3FrXhR2QKbZwJQVSxFd2MLwEFDbkZ89K5Qs+WAELUQLJpRFJFhaI+NScqxQBWeTDYPl
         sCI+pDfDCFgVsPEGfAfjNGIDU1uV955XYNAJbCMhXYDaEQM16j0rm6+xz3kqG/AEo1xZ
         +0q/zTVxWCFuyxUMTuav452wKFSvDxP+XKdnFq2+//ULfiRKZ/jA/xXpMrUexwZ+SqXv
         CYg5deeJiIEPUvoL4lrLZ+hQ3iDWFjGXmNbXy/YDTa5sVMkuX4OPLJKTLua9rwKLLw+6
         q3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=JRCJVtamUUaroED1nWHJzoeg1mlyoIA8vGQkHPHJwiY=;
        b=FZqTE+G23n2JkMVvbfMuNrwizwe575+JLRYKpBApd74zofPCDXnB9djdPp+7+UyKI9
         W1NM9nG+g6JkmylRXq8vcWQ7jZ44fQUG+Aeu4n4qNqsXVgdf93ahRgd5a97sh9bzN4Mv
         RyG1a3S+iSYjVsyKbmnnw8L6AAwcVpCs+b/u7k31VfLAlX3WOSdmID3dIltLDkCZ7L8g
         xMKEWtzPQ+Q/ySiIl2fFpzhUjKch8Cm6WOLa2lpw6itGThGaSqf0BsJVU9x8eqZltrOE
         gOoz0KvxcSLtZb5X2SGEjh3VWnJBZYT2NGniILyhF1zTohJYRuKwHL/w37Hsg7mPCqRo
         ZtYQ==
X-Gm-Message-State: AOAM531y0sbwvMKdVSkSUPbKZENajVlegdQovaoM9XUwM2Ft3RgMOLKy
        tpzTBNmu0RS88YUpYpyEoqmWVtFw76GFDw==
X-Google-Smtp-Source: ABdhPJx9jlXIb3H3+JFdf3F4ytE+Cz8tBA+7WqQMV07bzmBVohEGoUcJzPHMi7eKVMYXA/krteEXuA==
X-Received: by 2002:a17:903:10d:b0:142:6343:a48e with SMTP id y13-20020a170903010d00b001426343a48emr40568502plc.29.1638760780269;
        Sun, 05 Dec 2021 19:19:40 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d20sm10200261pfl.88.2021.12.05.19.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Dec 2021 19:19:39 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: mask DIRECT_RECLAIM in kswapd
Date:   Mon,  6 Dec 2021 11:19:22 +0800
Message-Id: <1638760762-27239-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As the eg bellowing, using GFP_KERNEL could confuse the registered .releasepage
or .shrinker functions when called in kswapd and have them acting wrongly.Mask
__GFP_DIRECT_RECLAIM in kswapd.

eg,
kswapd
  shrink_page_list
    try_to_release_page
      __fscache_maybe_release_page
	...
         if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
                 fscache_stat(&fscache_n_store_vmscan_busy);
                 return false;
         }

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ef4a6dc..3b5c5e6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4083,7 +4083,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	bool boosted;
 	struct zone *zone;
 	struct scan_control sc = {
-		.gfp_mask = GFP_KERNEL,
+		.gfp_mask = GFP_KERNEL & ~__GFP_DIRECT_RECLAIM,
 		.order = order,
 		.may_unmap = 1,
 	};
-- 
1.9.1

