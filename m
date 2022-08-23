Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A759D2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiHWHwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbiHWHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:52:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298065545
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:51:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bf22so13283970pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pRsqrry5laippNayvvDMzmJB3tl3SbNrcczIbs9fO1E=;
        b=d37kCSwNugvuhz4e71Zrv6D4FtMb7SCDbZOnfa+Vr+2IG0ztH/tWELIsSV5RxRLrla
         jdDTmgIY9eH040qZvjj2u2uITJJ5W+ogyVgeckWtW+eqloG4t4LlrM20w1n78m6vvFPP
         h1k8/P8MjVJ4gWkSvDi9lWPv2ZkvVhGOPF4ZaZs1cAxvLgEeqglbODkQpTFbOYXUh/Ax
         TeXbLp/WmMu8FCqi2YUHc5Sctw/EEkuQI+Icw8AMBCuuYAtROuE+dEW9TvZFyKhnHwrr
         kq3pnoRKZ/3XWaND91Tn+OManYlvmAroLHjM5f4E5BXr8VZXpZTNcTGy6gsXYC8GH+le
         Y9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pRsqrry5laippNayvvDMzmJB3tl3SbNrcczIbs9fO1E=;
        b=vJEKhHJGrAMTT5b5WAevIcXT3RVC7VxMqmD1+Esm7iT0Fa9lhwh6qBxWUGvM4dXDcP
         uB9fb6SBwK1EJeQWYONbXoffV6bBlbzHYhNWDRu6xrx5I+T3EMDuS360M8G9GuCwuOgl
         KL8teM0dsz6GC3Vn522hV+386F7R79iGEIK4xqFibMEFlBU3veKdOxkASasDH7fnt4KZ
         N3Q2/EhzsN0emMrTdaQNnoPv60Py89MJtIJVcjotp7VaZDZ8pWu2vnMKRUzr8Rc/WGN3
         iGgVDd8h3K5dqbZ7mU5SCyzr7TCQMJD9V7atIejjImG+dfHriqEOE1bqSBZ+WzLJlUjN
         wxQg==
X-Gm-Message-State: ACgBeo3YmzZVN41JkZK0Fp+3/0vXQTK6wbbR5nSSZ8bhiRQomCg09K1u
        VWVZQEjMXWlZgSwwVn0+en8=
X-Google-Smtp-Source: AA6agR4zIA4rbkMGLZNoCeWehte9EPmVYlh6ABBtHAK/ks23UsLoz+o5Fgui6cFfTXMOScwPjaVrDQ==
X-Received: by 2002:a17:902:9887:b0:172:7090:6485 with SMTP id s7-20020a170902988700b0017270906485mr23518355plp.63.1661241111456;
        Tue, 23 Aug 2022 00:51:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b001726a4ad819sm9810644plh.114.2022.08.23.00.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:51:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     al@alarsen.net, linux-kernel@vger.kernel.org
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next v2] qnx4: delete the unnecessary checks before brelse()
Date:   Tue, 23 Aug 2022 07:51:47 +0000
Message-Id: <20220823075147.208942-1-ye.xingchen@zte.com.cn>
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
Acked-by: Anders Larsen <al@alarsen.net>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Decrease the indentation of the following line.
 fs/qnx4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 391ea402920d..7d2a9de8c55d 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -118,8 +118,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 				bh = NULL;
 			}
 		}
-		if ( bh )
-			brelse( bh );
+		brelse(bh);
 	}
 
 	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));
-- 
2.25.1
