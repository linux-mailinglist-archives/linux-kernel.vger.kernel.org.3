Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3830E586DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiHAPmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiHAPma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:42:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609932062
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:42:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so4043812pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=F/mKqS076MwtXGIYmf7ms4xhT6MgpvQ8HviHZjdmqhs=;
        b=IFEtGqq7gPqVKSrjjT0byqYrwfZQNpuvFBjEqNKseJGeyOQTf6PQZ7a8YeKzacmpsk
         kvShvFI67IJB8xOD+mEkt4pHG54yZWaoi66+DrPnCoHP7h6ykhe18kgDpey9zMHJp2KO
         6cazarm9G8WrAGPyVpbXREw/ZLWyzD16BIXSPniBHSHJ/nXfOuXxXxmxJ/YZ78O0mYZ5
         hDUFXZf/wdaMFLHk8CtLOGnsZE04jeDq34latLhSBZAduni6ISSRzXdmtYXBCwV1h2uL
         4id/YqDHRx8pDobTCKF1BX26h7+Uvsi1AzjGohRaTYW09+y4TeZ/G3rquQ3X01uRC4Nk
         MyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=F/mKqS076MwtXGIYmf7ms4xhT6MgpvQ8HviHZjdmqhs=;
        b=5fPrWt32cpWCXZ+cd1kqL3/aq/KjWFBu5R0r2T6KhFvEwRdNsgyv1dCGh1BtLt9Zfg
         JvO6rmqPZPsLoRYIEI9wCCtI+G7Ui00FAsx6pJBhyburY5FyrvIQhFSIK9wNeD75i78H
         bwpZKw4mPJWWIiJavn9XqA16f2fuNvXWhsCtuwrN8wBburDy/grAVshyxxITgu8k9BVm
         NJd54FuFWIe5aq+05FGOVsOGZAmeWrJ/0F+Mn22pUvkjZ88utQBLacQy3fE/1Rof4w8m
         TrKTJQr90cVM0fdml+XGMrW1yWgy8QMo3SyvNf76f3jOF2KxWydNbXN/C7VAx09mxhzk
         LgfA==
X-Gm-Message-State: ACgBeo2QfRI9F5n5T/Hil9mN4gd5Ycpor0YB4eZ0il4/ghQbLlwA2AAS
        vkHHn2D88Mh9XSInRqxeBRjyHRC7VTej3w==
X-Google-Smtp-Source: AA6agR4B5h6Fg/XIx6aAl4h0R141KfA7CD10ltX3Np6jXoKbO87up6P+ZoAMniVFwo+6Wv35MCBK1g==
X-Received: by 2002:a17:90b:4b8a:b0:1f5:942:dcc6 with SMTP id lr10-20020a17090b4b8a00b001f50942dcc6mr4324408pjb.78.1659368549280;
        Mon, 01 Aug 2022 08:42:29 -0700 (PDT)
Received: from fedora.. ([103.159.189.153])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b0016bea2a0a8dsm5895114pln.91.2022.08.01.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:42:28 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     deller@gmx.de
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        dan.carpenter@oracle.com,
        syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2) 
Date:   Mon,  1 Aug 2022 21:42:20 +0600
Message-Id: <20220801154220.186048-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/torvalds/linux.git 3d7cb6b04c3f

---
 drivers/video/fbdev/core/fbcon.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1a9aa12cf886..d026f3845b60 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2591,14 +2591,13 @@ static unsigned long fbcon_getxy(struct vc_data *vc, unsigned long pos,
 {
 	unsigned long ret;
 	int x, y;
+	unsigned long offset = (pos - vc->vc_origin) / 2;
+	x = offset % vc->vc_cols;
+	y = offset / vc->vc_cols;
+	ret = pos + (vc->vc_cols - x) * 2;
 
-	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
-		unsigned long offset = (pos - vc->vc_origin) / 2;
-
-		x = offset % vc->vc_cols;
-		y = offset / vc->vc_cols;
-		ret = pos + (vc->vc_cols - x) * 2;
-	} else {
+	if (pos < vc->vc_origin || pos >= vc->vc_scr_end ||
+	                           ret >= vc->vc_scr_end) {
 		/* Should not happen */
 		x = y = 0;
 		ret = vc->vc_origin;
-- 
2.36.1

