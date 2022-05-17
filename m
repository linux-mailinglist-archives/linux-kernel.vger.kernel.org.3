Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D5529E24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbiEQJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiEQJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:36:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7133E2B;
        Tue, 17 May 2022 02:36:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq17so33557141ejb.4;
        Tue, 17 May 2022 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvIkZ+SZSnuVFUBNtp24/kBbyO+aODjZMJiPGY46AQE=;
        b=P7Zet47QTOLxAMMploN/gtFcpCsQahUrwANNEMf5srQdoy0K4SamF3yyncJKNsDWXM
         5776p+7csXvkuXke9lFLjFr67J3ITueWrn9ZBI1jMeZ0KT0JCqDT/leSy0+IKMs4yfvq
         owpKAoUAxZYmrYSkBVhQC3/8/84uNYugqLZ34fco+r4rrHv2J1enCptzzABiESd8Rlvj
         2nFwbEUpuAIMcw7yW3TxsCW2DZmJR2jMXEvk84rbspWa7yNNwsz1EwM7Zhlyq1dQXrrg
         0xa6ObPg/2tq+56ZVl5ZmftEdpjxMJ57E5KffvLAAbhryi/tg6u9BULJzt0ZT5xf6vWg
         ViUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvIkZ+SZSnuVFUBNtp24/kBbyO+aODjZMJiPGY46AQE=;
        b=W0z0FaYF9EBpbJhBp2xLAAcqQAv6UFtfOGkBXCkLTpeFjIMVlwxLrNc0UbmnyP0YnX
         282frEHlP1xciIOq2npnyyJ/JjyL14FZdOU7bDG2Bs0g+EP+ZQEpBEHXJBjENjCPdf1Y
         V888f9SUUFffltLmjyllmGBOWJP1/1iigbmIkFCy5fU5JNEONnwzKR7tG67o+lFM9hEM
         Xs4pM2+G39y40kVWT7c7LI7SCifPO41GVrHuVcZ8OQyahrLMLBjpCRHJ1COQUJYxfnDm
         b7U4OcqHkBFXTv3TPLpCgNWCb3z0VfP4JuhiJa9eIVb7d7EPqjx615KxiC5VE+Z4UKTS
         oZAw==
X-Gm-Message-State: AOAM5336DGUEoVCyuxLB+ninVMIJQuYKhg+t7xVXCEXdFJA8QpGAAMsX
        S+KMKm6uCCoIwwsVXQQGSD0=
X-Google-Smtp-Source: ABdhPJyudOovXBvAo9oOsyE0ZzGQys4UBYK3amp163if6al1uIl7HOLPapjy43U9xX6w/NLuhOESDQ==
X-Received: by 2002:a17:907:2d8d:b0:6f8:5c3c:7217 with SMTP id gt13-20020a1709072d8d00b006f85c3c7217mr19004815ejc.1.1652780208030;
        Tue, 17 May 2022 02:36:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 2-20020a508e02000000b0042617ba63a9sm6730603edw.51.2022.05.17.02.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:36:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs: remove redundant variable idx
Date:   Tue, 17 May 2022 10:36:45 +0100
Message-Id: <20220517093646.93628-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable idx is assigned a value and is never read. The variable
is not used and is redundant, remove it.

Cleans up clang scan build warning:
warning: Although the value stored to 'idx' is used in the enclosing
expression, the value is never actually read from 'idx'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e1392a9b8ceb..a8abe2296514 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1772,11 +1772,11 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 	last_vcn = -1;
 	do {
 		VCN vcn;
-		pgoff_t idx, start_idx;
+		pgoff_t start_idx;
 		unsigned ofs, do_pages, u;
 		size_t copied;
 
-		start_idx = idx = pos >> PAGE_SHIFT;
+		start_idx = pos >> PAGE_SHIFT;
 		ofs = pos & ~PAGE_MASK;
 		bytes = PAGE_SIZE - ofs;
 		do_pages = 1;
-- 
2.35.1

