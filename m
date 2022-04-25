Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3650D9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiDYHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiDYHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:10:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6D1D0C3;
        Mon, 25 Apr 2022 00:07:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so25002889plg.5;
        Mon, 25 Apr 2022 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ay3sdGiDRHAPLPYUlZwep9fc4pZc95saAfFzOSdMcB0=;
        b=gIbi/PHa0EU9rMF4Zde9AU1LOrBfzDAXIPHTe64Ra5e831ug9HRk2d9vv03+sV8M3l
         P4AVhu9f1oQ+2Nv+r9jp9XUWjtcJQzJGps3p/x/xDqyHq02NtfHDhnP4hXNqjKTpZAgw
         xt6rK0EBVAKVKeux4HRf2ta7nvbFL4nCNjlw9iRT3Zg6PlorRkt+mbwtiUymhhUgupfd
         ecJ49hTSje7EXfTACL9OGz/LLCqMiB10XpwLBl4JeK+5qUb1moWz3RXCJnN7I7mwhsd/
         ITvmY3le3dE5hhS/MU+v2hu+QAaPCmSXZybhmtmiOCixVa21J93xRA4IZOkCQu3ocWiV
         jixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ay3sdGiDRHAPLPYUlZwep9fc4pZc95saAfFzOSdMcB0=;
        b=6hohWjkC2XBx2dQiHFoS3YJC6zrHLC7/FSOX3obxUWwvsnnOFn5rrDE9mvViOiSy2J
         qk+PHjesw31M1xCbhmT5QHcQVT4SKRVHLmwyk1weD+y3micQJrHoQ9uX5VdpLBtYr5jM
         ruZJUx5qP4ZJsetVbvrbAk8q8fAUDJAP+iJo6msYCfw6SV8ZamnXl9JTRGXVHvw5fwwI
         ON2MkQrA//+kzfjPAZRvCxnIaF8CX1R43qOkzCJjN+iaEOieesvkPSNhpnXm65LZNgPc
         AeskudOSiSDCqMRYzDdeUfpHPkPYC+RA5ziVOuJNtkSJEU4cVlmpNv+aOnZkqWb8vAzv
         ixjw==
X-Gm-Message-State: AOAM5306v9lo95RRJNBebBmpJJxOZHZwbCAyNJzg8c/gqJYBLj9sCajd
        TQZ14xJkz8WSvpoFYSuzdXU=
X-Google-Smtp-Source: ABdhPJxQ+cP+q/BEoK6qYVudcxKI/PH3V3h+WoY6dfVCeJ1LPwgv/snRJZdUHfu15PHsAzfQzMv3kg==
X-Received: by 2002:a17:90a:af98:b0:1d4:67d4:d122 with SMTP id w24-20020a17090aaf9800b001d467d4d122mr19106442pjq.166.1650870450460;
        Mon, 25 Apr 2022 00:07:30 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.249])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm10794907pfl.135.2022.04.25.00.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:07:29 -0700 (PDT)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: fix the ABBA deadlock around agf and inode
Date:   Mon, 25 Apr 2022 15:06:20 +0800
Message-Id: <20220425070620.19986-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, we encounter a deadlock case where there are many tasks
hung on agi and agf xfs_buf. It end up with a deadlock between
agf and inode xfs_buf as following,

xfs_ifree()             xfs_bmap_btalloc()
xfs_iunlink_remove()    xfs_alloc_vextent()
  hold inode bp           hold agf
xfs_difree()            xfs_trans_log_inode()
  require agf             require inode bp

The task requires inode bp with agf held block other tasks which
want to require agf with agi held. Then the whole filesystem
looks like a agi/agf deadlock. To fix this issue, get agf in
xfs_iunlink_remove() after it get agi and before get indoe bp.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 fs/xfs/xfs_inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9de6205fe134..c0a29fd00b0e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -36,6 +36,7 @@
 #include "xfs_reflink.h"
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
+#include "xfs_alloc.h"
 
 struct kmem_cache *xfs_inode_cache;
 
@@ -2337,6 +2338,7 @@ xfs_iunlink_remove(
 {
 	struct xfs_mount	*mp = tp->t_mountp;
 	struct xfs_agi		*agi;
+	struct xfs_buf		*agfbp;
 	struct xfs_buf		*agibp;
 	struct xfs_buf		*last_ibp;
 	struct xfs_dinode	*last_dip = NULL;
@@ -2352,6 +2354,14 @@ xfs_iunlink_remove(
 	error = xfs_read_agi(mp, tp, pag->pag_agno, &agibp);
 	if (error)
 		return error;
+
+	/*
+	 * Get the agf buffer first to ensure the lock ordering against inode bp
+	 */
+	error = xfs_read_agf(mp, tp, pag->pag_agno, 0, &agfbp);
+	if (error)
+		return error;
+
 	agi = agibp->b_addr;
 
 	/*
-- 
2.17.1

