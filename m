Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F288C4C27BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiBXJJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiBXJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C328B19DEBD;
        Thu, 24 Feb 2022 01:08:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso5136076pju.4;
        Thu, 24 Feb 2022 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zpTkLEmJvFxi4VKhdqLWNaYMcorcu60fImPOUFH7K6M=;
        b=NMcz+1BsNPWq6mNOwq3KuY3XBZGPyq29cK8/rlh9MjKfPSKBz9IzXsF9YlJEyLKwB8
         3liAc7Iuv7pyktDY7+6A5XowXB0raAkuNkHhR49nKs/K6qnAapEj0vpSwE0xnpxRwAhS
         kKlSfWh77COtdXCIPk5Y0CPqlrsnucdHvJwSHzB0N2wV7PdT4OHoir/KUu3cd91EpcMu
         FMKyLNtFKMLphu8NcQrGYO5gZuUJBiPhaT8+ZJiMSqCwBzwPpzqt2CGu7s3Hwxfba2gE
         0uX1tJGo5fVGqde5YcyuOaWpSaY4MJ6TkoV9IftVMEtWVTA96uhHyJbPTDkOZg9cBZWk
         L7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zpTkLEmJvFxi4VKhdqLWNaYMcorcu60fImPOUFH7K6M=;
        b=BdvHt8Npm0hxLQbX4Ul1YgB9ixySeYuNfZpb1e7oBZVswAFafbJpyWsSoN6ZeaXnjO
         iny5ObWSuj+p1vq9u8peHVJFzfOsRdYkkoTZHinlZPZQloQEFUnGnqMxRAKyOXExB75o
         JSWhJR4i+Qrn3U3WimGaDqE+SCGuLkEUNXhkFx6b65UofMa0B3Hn1GKLk+bu5hSk4YMg
         4vUElsu1Pfv0/8S7f7hZP71rzG6BIRD0U9YxGmDTSj1+gEI98r5Qs9/ucEDZTV9AiSTk
         cEedxRXjspf9xou3FQWqDxedNMT1EyGLxsbflNi4GSHozFCrYqYYVYfqV2z5PdbwhUTh
         MOkQ==
X-Gm-Message-State: AOAM530gC9o2niI4saLYW/NEIllboa0fg3/4XiA5O+soCkxtgd4v8uaG
        tv7ctef2kE4gxf5q1HcSLsk=
X-Google-Smtp-Source: ABdhPJzDOiWYTFTN5CiYmYR350ZHz6g66bstb69UeiBp+sSPiTpA6JK9JjxTPhR49xgrrLO992IsQQ==
X-Received: by 2002:a17:902:7b8d:b0:14f:f1c2:9ff4 with SMTP id w13-20020a1709027b8d00b0014ff1c29ff4mr1644281pll.54.1645693721140;
        Thu, 24 Feb 2022 01:08:41 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:40 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 08/16] blk/rq-qos: export the sysfs for switching qos
Date:   Thu, 24 Feb 2022 17:06:46 +0800
Message-Id: <20220224090654.54671-9-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the blk-rq-qos policies has been changed to use the new
interfaces. Thus we can export the sysfs interface, namely
/sys/block/xxx/queue/qos

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c713d6b305cc..052b5f03fc73 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -572,6 +572,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(queue_qos, "qos");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -631,6 +632,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&elv_iosched_entry.attr,
+	&queue_qos_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
-- 
2.17.1

