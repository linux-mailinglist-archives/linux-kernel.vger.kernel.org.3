Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01C5A7415
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiHaCtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHaCtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:49:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B2B5141
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:49:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so10065175pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=R0e1KmOUIwSrlRRc3FB/cF6lPx+IvbAcp8rZjan78uA=;
        b=hP3XPdaoiN+yzpgRGBIStdo85vfckOqAbr/a8nPj+5mEFTfVW4iYHQK/pGE1/lwu1E
         j8ADQMa5c6oFgt2pZ7vLv5CWM6PADE4OKygL8TlDWg5wE9E1ARaqI0eDqcrCUM6rxjKW
         tHSsTQ3h75IZVp7l60bSjPshdiCD3bzvYQMkXwtbEMEUPLPQVLAE2+6Mel+xmQmmHINT
         Iy+drZg2CjPtKdB1hB98qWAKW+s4lBnZFnut3s/WJz6U85VojArFlcExkaLqj4adIjUT
         O2y6AnpfXmxCoNrh8IWqst2e2VzEct4cw3zHaPz4J6xStETKTSwpWXKEZEMv81CzjrLT
         5eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=R0e1KmOUIwSrlRRc3FB/cF6lPx+IvbAcp8rZjan78uA=;
        b=bce0a1/vtMQ1GhFyDVyV6UuXsikq+D7F2a1L+H9rUPyU2we3Fl+nFhJAJvMVKz//m+
         /xRXiumMugpKdKegDT/jyEuBCubFG9XgqnGlDNnuPRw0Nf7QaswtrQgLc7CvbI1dIkAo
         /m032bkc13fEXA5h9geZFotjPRowcWTmxzuCOdOMNaJAOyyQTmOi1U65VKej9QpjPJo4
         idNLDgt9pX/jDkRPoCsPI4wOXzhdxv3g7at6ZgEi6mP7O23uLkeyWniDOLjjYc4WDNVc
         Ffovm+LS5p2LmqLjIg498tH3T8hDFSQHbKIEPHdPNfG+CsqKQ7yLf91a4CCPJInN0ftf
         iB4A==
X-Gm-Message-State: ACgBeo2vyfy7A+H+PwbpQtK3BFLNqBUiJQgM3+ZeFt75XAhxe2GXWBxS
        VTnMxX9BWDOlTlCQAYFWCOs=
X-Google-Smtp-Source: AA6agR53T8VHDxdlIkjE6D8zAYLO8sfhmk1bD84HCn6OfiWD/yxoKNDOGrL6cbNCMI7GafIYlgoWPQ==
X-Received: by 2002:a17:903:244d:b0:175:3ead:4586 with SMTP id l13-20020a170903244d00b001753ead4586mr2181376pls.28.1661914145882;
        Tue, 30 Aug 2022 19:49:05 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b0052e5bb18a41sm10047018pfb.58.2022.08.30.19.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 19:49:05 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3/3] ntfs: check overflow when iterates ATTR_RECORDs
Date:   Wed, 31 Aug 2022 10:48:54 +0800
Message-Id: <7b8b8633d921665a717734d011a92f713944d0fb.1661875711.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661875711.git.yin31149@gmail.com>
References: <cover.1661875711.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
Because the ATTR_RECORDs are next to each other, kernel can get the next
ATTR_RECORD from end address of current ATTR_RECORD, through current
ATTR_RECORD length field.

The problem is that during iteration, when kernel calculates the end address
of current ATTR_RECORD, kernel may trigger an overflow bug in
executing `a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))`. This
may wrap, leading to a forever iteration on 32bit systems.

This patch solves it by adding an overflow checking on calculating end address
of current ATTR_RECORD during iteration.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/all/20220827105842.GM2030@kadam/
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/ntfs/attrib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 904734e34507..55e618c9e63e 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -617,6 +617,9 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 			return -ENOENT;
 		if (unlikely(!a->length))
 			break;
+		/* check for wrap around */
+		if ((u8 *)a + le32_to_cpu(a->length) < (u8 *)a)
+			break;
 		if (a->type != type)
 			continue;
 		/*
-- 
2.25.1

