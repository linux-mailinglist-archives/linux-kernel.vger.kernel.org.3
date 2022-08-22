Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9759BC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiHVJMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiHVJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:12:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E424C2F66A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:11:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso10587307pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bB6c9COj0TKXVRkzAz082VJG+S58SANMM7BukLX9sqQ=;
        b=V/LX6Qm9kd3DeIqpATkMyrs9/OOpj7iOC/orV/xTyQnJuYBJDfHZqazIohJVReqKBA
         eki1kfCEIUWbKTcw/aTSEJ73n8HFldJOYhjlX2LgCZDLw7nCUQY+E5uebEwUyhWkFBqZ
         6BpRhEkE8Tlp9nriNGWGO8iqJ9MObcai1VKSl1ZhYa94OPNFqHmFqb3/WImBB+zs4bDO
         ray5WtU+DurZmVSAiF5tp1EtY7DP1qFX+PdVEocFmkdK+az9qvqN+RYhbE9f3s3WrnV+
         4isQ9U6MQr4b7xTQ4GN7DHLbwTmBvHjv99hwzTH0MAvyU8SJpAOJacmm6D0Y0yv/Cb20
         pg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bB6c9COj0TKXVRkzAz082VJG+S58SANMM7BukLX9sqQ=;
        b=g935n0OzuqEx/tGCw4RDBttuOfD/sqFiW9Mdf8CO/w+dBzO41D9rlDG4G7oHuWSl0F
         GIfkFyB1D+boyhExF+KvdgJ1JVcFHBmEtE98VWPko0q9w2x+4aof8mgYE1jxuy6reRC5
         D625yJrmOMTlPUFmEsPrHjzK63NMqlHgIQ9fimyj5+RtIgWHQi5HR7npIhGJ1Qy9/Mdf
         AyZmc/YhorzdtNhog9GZCxMNVTyGM/g6zVmv8DtWNnOrTUaBPOwTeTgv4XP1uQ9YYzmE
         g6GaaXhd9/0TXh8c1xlweFtBAHTPMFLb0Ky/Cu75YDJRckd9LtlAmS2TsoS6bAinf2UR
         Xkzg==
X-Gm-Message-State: ACgBeo3AQ8yg+BfjRBVD8ON8WEvsTixyXAyvG4nfDPE+lhnKIg0mUexC
        1nE9NvImmuLPk96VIjf/90w=
X-Google-Smtp-Source: AA6agR5IuknrDuP6QGefW4ziBI84RyCMWRiVUN4X6LASDwqisUnoo8EQAIdgBdE4TBpQbf9lStOmzQ==
X-Received: by 2002:a17:902:b903:b0:170:9964:b47b with SMTP id bf3-20020a170902b90300b001709964b47bmr19536348plb.83.1661159516703;
        Mon, 22 Aug 2022 02:11:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p24-20020a631e58000000b0041975999455sm6889215pgm.75.2022.08.22.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 02:11:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     al@alarsen.net, linux-kernel@vger.kernel.org
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] qnx4: delete the unnecessary checks before brelse()
Date:   Mon, 22 Aug 2022 09:11:52 +0000
Message-Id: <20220822091152.204858-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/qnx4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 391ea402920d..9dab8f65ba75 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -118,8 +118,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 				bh = NULL;
 			}
 		}
-		if ( bh )
-			brelse( bh );
+			brelse(bh);
 	}
 
 	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));
-- 
2.25.1
