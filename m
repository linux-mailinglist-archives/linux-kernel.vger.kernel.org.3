Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB56590BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiHLGCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiHLGCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:02:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009346DBE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:02:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so21401pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=LGB0WFClYhcqqe+YL7LSXVJfO1SXGUU9W/Gp8VSqST4=;
        b=Q49esEubX0ROqAm9EfEJiMjDXGIKOSdrQ+32dsHJAMyc7cO3cIFgclS3aTKmpJdi4j
         Ei4mQ+QIMU/oMd9+Fmf9+s4IH2yoBmiGWV4FipurmPbMYNJv7tDomANzDmdBgmdFFD7C
         xCzyE1TqJcAmmve7sHdhYaVnPUlSc/VL8orkGPQmmsBQ/1zlxKBI6EDoHfH9tsi0rnLK
         GEKF9OQILyRW/lbRLahujxk5y2LkfkigoF+NO5R1LxDgEdYU5QdNa0+XAc9QcFo5CcmN
         Z3jU9hX0UNXTFTm4RD/Oyu8LoNZjRgJEF2RRJxUnRzu9ILrMIYCLJfzHC6gJXQ7NQ/ga
         nsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LGB0WFClYhcqqe+YL7LSXVJfO1SXGUU9W/Gp8VSqST4=;
        b=T/tJWU0uF+f9/Uj4lJjZpeOOd2nzeJw4KurruKgd+vAbU55LbNniI6bZd6ymJ/zh2l
         WiV96wKB/+chDjJKZqzxoMlrOEKw04XwBwpfVlvxlhYQKK40NvR57E4WolNg0RkWRBhT
         xBeQKVrUbEWbgOAD+gOVoOYnGHWOuELioGwi0bmMV+SIuxOqcOv+zuQPQec9UpdgsI1z
         6YE3EVLct0QMSTsHe0R169bOCGU1LnybYuckyilHhkZAgGIyuJmqV7c1JDfh9dLDNU6p
         LHBJstwZuFUfEeELLh5X9f1bNhYAd6waFT8wQz6wLpiUZyJwdwTUXNnhn+S6PbOgXMNS
         4weg==
X-Gm-Message-State: ACgBeo3oZ+fsbQm7u7apT7oi8sj818tZd9b2UAqSywIaOQ5W1m5NEbxI
        Lj95W+d7xvgyq5sk5eaPPxFtpmaJS+U=
X-Google-Smtp-Source: AA6agR5rBczvnAzYLabH3mHMNCmt0pTO71n0M2QUKwFWtNWRVx2VFRqIHJQafTFPqUGunw0wo6WvDg==
X-Received: by 2002:aa7:8289:0:b0:52c:e97c:dbe4 with SMTP id s9-20020aa78289000000b0052ce97cdbe4mr2461650pfm.49.1660284140428;
        Thu, 11 Aug 2022 23:02:20 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001708b189c4asm740020plg.137.2022.08.11.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 23:02:20 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: [PATCH] erofs: avoid the potentially wrong m_plen for big pcluster
Date:   Fri, 12 Aug 2022 14:01:50 +0800
Message-Id: <20220812060150.8510-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, 'compressedlcs' stores compressed block count rather than
lcluster count. Therefore, the number of bits for shifting the count
should be 'LOG_BLOCK_SIZE' rather than 'lclusterbits' although current
lcluster size is 4K. The value of 'm_plen' will be wrong once we enable
the non 4K-sized lcluster.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 572f0b8151ba..d58549ca1df9 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -141,7 +141,7 @@ struct z_erofs_maprecorder {
 	u8  type, headtype;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk, compressedlcs;
+	erofs_blk_t pblk, compressedblks;
 	erofs_off_t nextpackoff;
 };
 
@@ -192,7 +192,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = m->delta[0] &
+			m->compressedblks = m->delta[0] &
 				~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
@@ -293,7 +293,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -497,7 +497,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return 0;
 	}
 	lcn = m->lcn + 1;
-	if (m->compressedlcs)
+	if (m->compressedblks)
 		goto out;
 
 	err = z_erofs_load_cluster_from_disk(m, lcn, false);
@@ -506,7 +506,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	/*
 	 * If the 1st NONHEAD lcluster has already been handled initially w/o
-	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
 	 * an internal implemenatation error is detected.
 	 *
 	 * The following code can also handle it properly anyway, but let's
@@ -523,12 +523,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
-		m->compressedlcs = 1;
+		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
-		if (m->compressedlcs)
+		if (m->compressedblks)
 			break;
 		fallthrough;
 	default:
@@ -539,7 +539,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = (u64)m->compressedlcs << lclusterbits;
+	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(m->inode->i_sb,
-- 
2.17.1

