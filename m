Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F884B86B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiBPLdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:33:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBPLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:33:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967BB0A4F;
        Wed, 16 Feb 2022 03:33:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso3812104pjb.1;
        Wed, 16 Feb 2022 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/Q5i1rs4lIXUeYDzL8nbllPDsVhaLW6OGjHpaEqXpZc=;
        b=O0B1XlkA1cPZBrpkAdvWaT2/Ssr79kVD3zVUFxXI6jaYUSswhqsh1gmP3PrcwlkvJs
         E2VSZWxdxYgsnZEp5HhjwsNzvkcXXj93Ze2LaYLTC+Zw4rQRsheaIISHbztmUkzXEnGj
         KR2birAbkaIX/vUrIHRozSr3gwDP9q2zEudod4HpMScS7cj5MWFxYRqiRuOpdDcXPm2x
         z1FpymYtl8TAjewxgQVfy1Ko2yKgLOfpwX8LsBzd1OHyy1dMsNKTmrUSqGeK4cPYv52b
         C9XiO8xECRXdPJnR4O0MtYifLiEleeE/kzQjleiSXebpAwm6iF+ihjWLKGmkdFZ9YVOk
         DpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Q5i1rs4lIXUeYDzL8nbllPDsVhaLW6OGjHpaEqXpZc=;
        b=BXoC+6vA2G4e5xu+LGseAqRRM3DQyL/5k5WazDvMyInZJB9/H8Xdvv39031siI79BT
         IwIIbQJu9buZ50UHxaeomKyJRLife3/NYGbD8PCwWLWUjrRxd5gZgzF6jVx7a5BigZZE
         WBkKXWItoz7gF0GKpJjVakgx/r+6dMMxeSgCojyTEp/+p7wxSAr79q8308xczesTGoDi
         fRcu6IWnuTp1XR6wpOoRAKWHEKVRYs0StfgGXYanpGbV+doi61ODCoPLtmGfygO1JoZc
         ehTz9fNydqr25XvgvlA+3LufxoR+WUeaQUIq3ciiFtTC2SFCv3bkM3cd8LoV1p2quUFc
         bjGA==
X-Gm-Message-State: AOAM533ftlVkTuseoyxLKWE64W3RonuEW4uWtukVTHQkeY8fJeEtVNkg
        /54jsLN8l/ASnhCSVuTwBR4=
X-Google-Smtp-Source: ABdhPJx2chKXIlg3Cf++XymkKVZ6f5B2YEliefIb7XFKvwNsZj2zFoG9Joym3NIYUV/sZDZ3TYuEbQ==
X-Received: by 2002:a17:902:7485:b0:14f:3b6:1847 with SMTP id h5-20020a170902748500b0014f03b61847mr2114546pll.70.1645011203126;
        Wed, 16 Feb 2022 03:33:23 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.72])
        by smtp.gmail.com with ESMTPSA id n2sm21607370pjp.56.2022.02.16.03.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:33:22 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Date:   Wed, 16 Feb 2022 19:32:12 +0800
Message-Id: <20220216113212.83000-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

When __alloc_disk_node() failed, there will not not del_gendisk()
any more, then resource in rqos policies is leaked. Add rq_qos_exit()
into blk_cleanup_queue(). rqos is removed from the list, so needn't
to worry .exit is called twice.

Fixes: commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d93e3bb9a769..108c7207d048 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -50,6 +50,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-throttle.h"
+#include "blk-rq-qos.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -322,6 +323,8 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
+	rq_qos_exit(q);
+
 	blk_sync_queue(q);
 	if (queue_is_mq(q)) {
 		blk_mq_cancel_work_sync(q);
-- 
2.17.1

