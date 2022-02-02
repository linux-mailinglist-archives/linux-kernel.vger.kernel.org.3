Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3A4A7473
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbiBBPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiBBPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:17:41 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95731C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:17:41 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h8so11544071qtk.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Yzp7UgTJSpEim5DDLkluETjGLodKmNBRS1tOayIgzo=;
        b=dUggYVyRuCJbR+LNUU3wymi7BuY6ux8cpsuX3sFjZAEJAJ9LgcZVAi4KRvqwD07KTW
         /0VDx7zMtrHKomHN/b1SMVppGZfqqJ1VGzrHzOkYdXEqaY497YiokOuVRNHHEVSsWbI2
         2LB1KixG3pwmdcVGMbXhN84Q1sEyUq9g1eJtWQmFPeJ1DK7yPFSUdp1nlFmLWf3BtzA0
         1//LqNK6kJ1W3WBIv2WN2/obvaZ5LpR8kzlcCMb/jQiRxzbSv1LLBaqp1kc6EbT2mJXa
         MTMYH1wg7PDWs/AgHIzV1BCNFKtnfqpg91GLM515VCJ5lLXR2En2zl80z/mAAgjOEOt+
         uvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Yzp7UgTJSpEim5DDLkluETjGLodKmNBRS1tOayIgzo=;
        b=XBWQ4Ov6BmUAhohfUEOWgXQONlr8/zqDGcqoUYP9ACzPSHBAgR5HzIdtzHwS0ltV5N
         V43WbAzdUfrphAqhQDDK6fAJsztZjo3moeavEEvaWTDijYSGj+hJ3ofrq/xLZCGu0poI
         5E67SVJufzi3eySs5SukNFeF9U03Yw/5AxRdbs36L52VPEOwrK8daeTeIRsz3P2VDhts
         ysHGZXMJMfgUnJevPyOwvBigY8gefUEm87NMefFWNPZ7omA4Ht2toaAJDSA7I+NOzeLo
         IC3ZDmbBIn7oMdDtRkwr7iVNxIdn9nuzca/jgtJI0HQ5h3KhEHB7ta13pDO9BTIi0Es+
         oqfA==
X-Gm-Message-State: AOAM5309lTbFakA4ggQzcx1c+e3afRiywSUAlgmIkdXD+ZMvwhJTPztZ
        OGo4YqXzR8UBK5q7yJpIcjjnm37aVeg=
X-Google-Smtp-Source: ABdhPJxS9wfrjBuLVX0099xeKce/X18D6wukaXuk37UojkekhRKJ73nx5hUopPBtysTDOGyF/prI6A==
X-Received: by 2002:a05:622a:492:: with SMTP id p18mr20473063qtx.56.1643815060423;
        Wed, 02 Feb 2022 07:17:40 -0800 (PST)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id bi5sm5667607qkb.116.2022.02.02.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:17:39 -0800 (PST)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH] kcmp: Comment get_file_raw_ptr() RCU usage
Date:   Wed,  2 Feb 2022 10:17:34 -0500
Message-Id: <20220202151734.10418-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This usage of RCU appears wrong since the pointer is passed outside the
RCU region.  However, it is not dereferenced, so it is "okay".  Leave a
comment for the next reader.

Without a reference, these comparisons are racy, but even with their use
inside an RCU region, the result could go stale.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
I was looking for examples of task_lookup_fd_rcu()/files_lookup_fd_rcu()
and found this.  It differed from the example given in
Documentation/filesystems/files.rst, so I was initially confused.  A
comment seemed appropriate to avoid confusion.

 kernel/kcmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 5353edfad8e1..4fb23f242e0f 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -63,6 +63,9 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 {
 	struct file *file;
 
+	/* This RCU locking is only present to silence warnings.  The pointer
+	 * value is only used for comparison and not dereferenced, so it is
+	 * acceptable. */
 	rcu_read_lock();
 	file = task_lookup_fd_rcu(task, idx);
 	rcu_read_unlock();
-- 
2.34.1

