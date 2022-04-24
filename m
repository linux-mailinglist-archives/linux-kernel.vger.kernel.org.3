Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C604850D333
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiDXQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiDXQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:16:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A87F14DEB5;
        Sun, 24 Apr 2022 09:13:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id x3so7914320wmj.5;
        Sun, 24 Apr 2022 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ObLcZEUQxD8FwLhd5DJnfColWxUYkRGqghpm3bA5uM=;
        b=ncvMStXd44nfdtehxW3QyeCA9dTGDoz0HQIC9gjUtqGA4Iom4noF68Ld2hN/+86Vaa
         otCal3sGJ9Oy34hY0kEz5vx2n58DyRb6aqG4IONt+ieYQOBL7qtsxyfgN8CzBSEAeO2p
         ttWSTb0tJ/RwnAqpbaHOkSgVe53l2H45vfdcuRt2P70KMs7XXxRN1yP1RubOSGFf7LNW
         eSIoRelsI15zZQW8zzkUY0H7hqD7DpmpzyrDTHz18WOyskaHQNxjevmmS2zwul9Klyd3
         an7rreHbFQlVduA9o1EGniC/qBWBBIghxgcxTh0UQw8I9qxnU/loW80CZpIy6NKO8B2T
         v59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ObLcZEUQxD8FwLhd5DJnfColWxUYkRGqghpm3bA5uM=;
        b=DTkcDBp/gw9jqQxnki3pMCB6XstgBWEFm6wYCTw0SohJNO0L4QEBbKamwsiWmFTirS
         aT6WEHgcf13EpcKdzD2i9eKQU9XWgMUCf015O3CBJkaIrmMzVCLq7nVIxH9IzV6voAMV
         HPvPnOm0JfBWcagChYtso8ftbdpvCtNjXJ0zEoMXAez55V53ZBt/36SVJHy7E1+bFUcK
         c3RCPvev+NGk9R8q2Q+ISCrOGmuUAhaxi0BivSLViO1oPF2ufq2O/DPdfP1oFRYkvhuW
         H6qqYJvW3jsLlVfbZndi5CeEtOiP3cckaDbaYkeG80jXaZxA07TeUsJzlkVTG19vGaoq
         C+9w==
X-Gm-Message-State: AOAM530W7enj8QVxEGuwQBrgGshL++zsw2eXnnbjeY7kk1+GPxnyeVx1
        jGe02Qr/wZF8PuiKqfBTzsg=
X-Google-Smtp-Source: ABdhPJyh3p31G4sIeVZXTGFdvpzzk7/VTR2UidhWmiitY7AivHww4XQg6U7xwHJh/6v4nJfIiLzehg==
X-Received: by 2002:a7b:c94a:0:b0:38e:c252:4a58 with SMTP id i10-20020a7bc94a000000b0038ec2524a58mr22601807wml.177.1650816812065;
        Sun, 24 Apr 2022 09:13:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm6840310wrr.67.2022.04.24.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:13:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: remove unused pointer tblk
Date:   Sun, 24 Apr 2022 17:13:30 +0100
Message-Id: <20220424161330.1360068-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer tlbk is not used, it is redundant and can be removed.
Cleans up cppcheck warning:

linux/fs/jfs/jfs_xtree.c:2551:17: style: Unused variable: tblk [unusedVariable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jfs/jfs_xtree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 3148e9b35f3b..d29979d0a6aa 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -2548,7 +2548,6 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
 	   int xtype)
 {				/* extent type: XTPAGE or DATAEXT */
 	int rc = 0;
-	struct tblock *tblk;
 	struct tlock *tlck;
 	struct xtlock *xtlck;
 	struct metapage *mp, *pmp, *lmp, *rmp;	/* meta-page buffer */
-- 
2.35.1

