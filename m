Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880D5593435
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiHORv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiHORvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:51:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE71D137;
        Mon, 15 Aug 2022 10:51:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 17so6958306plj.10;
        Mon, 15 Aug 2022 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yFM5NAH4FbqVZAUN+RpSLe1Fb5MJe458XF5fgVWxzb8=;
        b=CK0iyepL58aRSd9LzU3quaQk58TnfOXRzthLNyTjGfWMiRTJsrmdiF/ja9RaaNW2c7
         +fHU/9iCI9PjCnXTg49kGl/pME6keQJQVdyeA1Q/TAR30FKQYG7X4gWMyXdlUKQE+T5x
         gi6wRafz2djcfvrN/EgRyKfGR06izb63WYF/zQa1pSgccwk9SttjFfIC7Y7uvne6ytQj
         BedEFLdHTBW+qMFCmXwtM53T6JqvB0nkw/iCOf5vgRRaZ6SgXdh63pIWmq/cBvj+7X6f
         jkKx7Qd02UV422TUXwxuJeFA4edIw4BqNEbUHPSGU5tfExwX8XRDDauCo7t5KsYuEPGU
         IeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yFM5NAH4FbqVZAUN+RpSLe1Fb5MJe458XF5fgVWxzb8=;
        b=2CO5Kx+M2JzG9aDv2Ad3MJRgX808JXGI6gavrCvpokhl/w7CbIFABDmRucJG+s6g/t
         tWFsxqXS2vfaC/MmKR/gx5XZiMDd0LZ737KRa6dLoFKtD0Dm8hI2DbVpLSj+EbTw72H1
         omCBg4m2b2dhS1ZvzU1MYUf8YURC18q2nQ/sDRp12/JxKE/Sh2xAnzIhN9NqZ31G847d
         5xi8/nTfm8wYOpZ51t2F9/jIaQfJ0cy/Qh2lGAuOYWFooDP0bF3Ge1w7yhZr5xL81jhQ
         gxRuty1HoJliv2GRW0rKr/PULjndKgpZhyyGrbHmMDDZdjrl8p8nwHsNJHlkHrr2D4Al
         kSEw==
X-Gm-Message-State: ACgBeo1urG5m6kWstVjzoV4qv0JEN8s4wuib0LvzdDhSQsl4Ia4n7OvX
        WV+6nWMqerN10tnLxJehF7o=
X-Google-Smtp-Source: AA6agR7zPE2a0Hljj/eaQbuo1x5tVTpRF8Pxvb0Jz+Uz7gjjbwLldkebWpZ1+R22rpvpXNAIYkJFPw==
X-Received: by 2002:a17:902:dac2:b0:172:5f2a:f30 with SMTP id q2-20020a170902dac200b001725f2a0f30mr10831822plx.167.1660585880460;
        Mon, 15 Aug 2022 10:51:20 -0700 (PDT)
Received: from carrot.. (i114-190-253-100.s42.a014.ap.plala.or.jp. [114.190.253.100])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709026ac800b0016c5306917fsm7259729plt.53.2022.08.15.10.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:51:18 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiacheng Xu <stitch@zju.edu.cn>,
        Mudong Liang <mudongliangabcd@gmail.com>
Subject: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
Date:   Tue, 16 Aug 2022 02:51:14 +0900
Message-Id: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
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

In alloc_inode(), inode_init_always() could return -ENOMEM if
security_inode_alloc() fails.  If this happens for nilfs2,
nilfs_free_inode() is called without initializing inode->i_private and
nilfs_free_inode() wrongly calls nilfs_mdt_destroy(), which frees
uninitialized inode->i_private and can trigger a crash.

Fix this bug by initializing inode->i_private in nilfs_alloc_inode().

Link: https://lkml.kernel.org/r/CAFcO6XOcf1Jj2SeGt=jJV59wmhESeSKpfR0omdFRq+J9nD1vfQ@mail.gmail.com
Link: https://lkml.kernel.org/r/20211011030956.2459172-1-mudongliangabcd@gmail.com
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Reported-by: Hao Sun <sunhao.th@gmail.com>
Reported-by: Jiacheng Xu <stitch@zju.edu.cn>
Reported-by: Mudong Liang <mudongliangabcd@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nilfs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index ba108f915391..aca5614f1b44 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -159,6 +159,7 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
 	ii->i_cno = 0;
 	ii->i_assoc_inode = NULL;
 	ii->i_bmap = &ii->i_bmap_data;
+	ii->vfs_inode.i_private = NULL;
 	return &ii->vfs_inode;
 }
 
-- 
2.34.1

