Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E546751CFD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388835AbiEFDu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388627AbiEFDuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:50:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEF2443E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:47:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x12so5132141pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GBnsUFI480KyuDDKiDj6EO0c5V7IXRlhq6lrsQR2EY=;
        b=k7uvdMBTxQMDq6M3LascyGTaiuxi2yT1elp1Bszljqv5oQ019q15F7QRpLZ+v1AwDR
         lO7ycwTQEmQQSfqcXkDIXY3Diu5PwWZmmgNHECwmCVNcXktbcpsr/CEtiOvs6y2orAk/
         SkMqSa4AXgPTI36JKkzNiGI47w67B2KjdIxEy/jk2jiLCJkAa7CQGY/OJdehRZLn72ca
         aVBe6NaCeqffUuvNNxvTBYNjI+uipnvNQKhXi5Uo9qhgPv6zfBIdVlFT7pX7Xwy2z8u/
         PqAisoU/4c+03vj7Hb2QgV8gxPPQJALYjiTG/WCMwlXqqjtNTK+IxyJ1rUt+uzsKqnmJ
         A1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GBnsUFI480KyuDDKiDj6EO0c5V7IXRlhq6lrsQR2EY=;
        b=0vgh8y9lKqlhp4W5dCqMMLlVULEX6CyD69pU6GEzU5MlUCneDcOki80YYA/3fEqIGY
         zAimJY2uaP2ldt+zxsmwA7BZbDKHFm6eRFK/AwjJQbfS2SkXP/s6P04pKRUmqwu6913e
         KgcnjPuXAWfCCFOQWqXx/ghPYTe0dT/q56HzUElLB87yVmlodFiMR4eSunkMT2RBRExm
         PXbcFWc8ytVJkMcBCf1EZPj04uVuhzi7rYxzYSE3KxEVk/V9LacRUcn6rvSqxpI7xW1K
         I7ML1ki/YcetK6CXLONe/ckffMFil4wN5YhhesVJjdRakLJN4m25YG/rhnWsksp9F/GC
         q0hw==
X-Gm-Message-State: AOAM531TQZltiCGoB95BupbO5JLWpnOE8HZem8adq4FGfjx9N4r7Jx7e
        +VHjrJ1ubukfvNFGEEo9GLc=
X-Google-Smtp-Source: ABdhPJyzdQZ2piTp+gk+/6EcJp5EzxsQPyiqNKXt9xJG3Eh1hHllS3jVdx2Ud8lyihP6lkN3sbk42w==
X-Received: by 2002:aa7:962e:0:b0:50d:5ed8:aa23 with SMTP id r14-20020aa7962e000000b0050d5ed8aa23mr1602069pfg.43.1651808824217;
        Thu, 05 May 2022 20:47:04 -0700 (PDT)
Received: from lbmac.lan ([119.28.81.66])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709028a9200b0015e8d4eb2cdsm398139plo.279.2022.05.05.20.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:47:03 -0700 (PDT)
From:   Liangbin Lian <jjm2473@gmail.com>
To:     ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Cc:     linux-kernel@vger.kernel.org, Liangbin Lian <jjm2473@gmail.com>
Subject: [PATCH] fs/ntfs3: fix null pointer dereference in d_flags_for_inode
Date:   Fri,  6 May 2022 11:46:56 +0800
Message-Id: <20220506034656.50038-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntfs_read_mft may return inode with null i_op, cause null pointer dereference in d_flags_for_inode (inode->i_op->get_link).
Reproduce:
 - sudo mount -t ntfs3 -o loop ntfs.img ntfs
 - ls ntfs/'$Extend/$Quota'

The call trace is shown below (striped):
 BUG: kernel NULL pointer dereference, address: 0000000000000008
 CPU: 0 PID: 577 Comm: ls Tainted: G           OE     5.16.0-0.bpo.4-amd64 #1  Debian 5.16.12-1~bpo11+1
 RIP: 0010:d_flags_for_inode+0x65/0x90
 Call Trace:
 ntfs_lookup
 +--- dir_search_u
 |    +--- ntfs_iget5
 |         +--- ntfs_read_mft
 +--- d_splice_alias
      +--- __d_add
           +--- d_flags_for_inode

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 fs/ntfs3/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 9eab11e3b..b68d26fa8 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -45,7 +45,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	struct MFT_REC *rec;
 	struct runs_tree *run;
 
-	inode->i_op = NULL;
 	/* Setup 'uid' and 'gid' */
 	inode->i_uid = sbi->options->fs_uid;
 	inode->i_gid = sbi->options->fs_gid;
-- 
2.32.0 (Apple Git-132)

