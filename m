Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8E47BB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhLUIL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhLUIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:11:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71DEC061574;
        Tue, 21 Dec 2021 00:11:26 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id y9so11680020pgj.5;
        Tue, 21 Dec 2021 00:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNQ27S31DQKVMGNaa41vJ0MWzIDdPEbu6tohUmL45Xc=;
        b=pWK7rOOe6EgoIgreqR5MDZpNyU04GgACI0jFEnyQ7jExs/7udsljcJrTRwZEPfYbwd
         YkVlyFt10PL4riFiWcVbhu8LmpmmK2H0ZQVtO/z68Gyrsdhqd7Fnf5dneJzJ+LI6GzAL
         9oCUXjCyX+2x+mrhIiSi1ZE/oyDDgMWJ4ihXNqpLPvF752E50HoZQDFsmvJl1jujPur7
         +oR2aKa7zgfO1CFOFyJ55EYKbJqR4LZOWhVfPUx9BpozHtEnpoQ2fUA0U1BXMdos+56s
         Mi+wCnO9sOOaWnXXwVOuDesraAB8rkTU6lpx+r9R7Q3I2BDYwJnouyEcaOvJaxArG7KY
         i18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNQ27S31DQKVMGNaa41vJ0MWzIDdPEbu6tohUmL45Xc=;
        b=7zSa4bwpPwUv4ZB8LnXvLK2cfZzal3TLTcukTKbefafGC5so4o2Pg4Z1viYjCAuyhU
         DkgD0KQGi8dFyi/WbTRiE1bx5Rq8DQOeQRg4hsuuqXZg3zl+Ao8OI56GFvLBHZqjPyej
         hi6N2RYM1M46tv6h0LYCK+h0CLRT/cQqQQsnLoQsAizC9tSLdqXvG8bmo11OaLjFi2IY
         KoKj7unNfX8VK2upB32/jmCDpkz6Qm9FZgx3lgHNdgGKSlChNacI34HMprAzo4X8120y
         Jw/0/bJHD+Nzq+nsL2R0x3sObTW6Wu7gGU+dRsAsyJPJnT9ffw9ZsGp+NwvKAIZbUVil
         8fgA==
X-Gm-Message-State: AOAM530WXUtvlBz8lLwSPuL8LbRHvwon0NkBO/QU2+5bnwn3k825ncRT
        K8B1InUPPS+C2NWhfHtdWjgoEnw/pqM=
X-Google-Smtp-Source: ABdhPJzivj4IPkq9WcmMOBNQPCbJy7iEXusOZPE0zZnBwVmWYQio52v+igjnlqR4d8Jn8/gjmKRBYA==
X-Received: by 2002:a62:8042:0:b0:4a8:15eb:db10 with SMTP id j63-20020a628042000000b004a815ebdb10mr2128313pfd.28.1640074286391;
        Tue, 21 Dec 2021 00:11:26 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id t8sm21024635pfj.26.2021.12.21.00.11.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 00:11:26 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  block/elevator: handle possible null pointer
Date:   Tue, 21 Dec 2021 16:10:42 +0800
Message-Id: <20211221081042.78799-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a check for q->tag_set in the front of elevator_get_default,
and there should be a check here too.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 1f39f6e8ebb9..b7d0bead680c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -636,7 +636,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return NULL;
 
-	if (q->nr_hw_queues != 1 &&
+	if (q->nr_hw_queues != 1 && q->tag_set &&
 	    !blk_mq_is_shared_tags(q->tag_set->flags))
 		return NULL;
 
-- 
2.27.0

