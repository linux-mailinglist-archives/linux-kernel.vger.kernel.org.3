Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A814894F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiAJJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbiAJJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE8C034001;
        Mon, 10 Jan 2022 01:12:24 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id pj2so11473542pjb.2;
        Mon, 10 Jan 2022 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MA5aJkYexI+3gxXmnqrDt6y1iMXmwH2sipH7h3l2T/8=;
        b=LAyP3ZHXITzhDzYrLuXKkTVxF00+FnKh0EFu7O1GsRVgkdsWl6NC4I3bYui1OB5PiA
         vmQ360Da6YlViHz3ighBuNkBJ0JCefSa91GppCG/0whdjDywOCmZX5to/KbPnrA4ZWsi
         fDbE4xsTDoB7Iqo/vH2YUYN+RjhjcS67evELHnK5yAgm3DvswXe/903yrLDpxmnJD2o9
         S77ewUuBzlSFF0X+zUyCs0f2MXISJ9r7mYzyYUJ1vKexRvVmFeVLgXGkVal9mP115phl
         Evl0luNiizt7Ce2ClFW1AroanadHcdWp5t4oxl2SXkUuozYufxvdrsn8DpLD+FgNYk1G
         ANBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MA5aJkYexI+3gxXmnqrDt6y1iMXmwH2sipH7h3l2T/8=;
        b=p4x6/3ed0CjTgk47/YyT/2LqO8kfUufTPxdBKUC3553FxCiT3AXrtXT8/rWWaXplrC
         ZDMKN51p7fvK5EOLCSoWSz9d7/NgenjtuuMkiHPsdZyzLHybxnDbdSvVCeVvov2TgUZX
         QIOXYfQuDlVt7OYJcdqiClurGH1nEB2m9hutP9xQXI3uI9mecav3dzvTAHSLJ1yIU78L
         ULpXJU+rNs060exgUU81mFjvMQTRMg8RkNRM+v1YhIzqv+MoNLUnAfQx72gx9HsW4UbO
         FyqXPbOP3h1v1/gTeSM+WjaFwuW+yVam5tP8NNRAvKoGMsOoXPqXPJSSfTPJ42S0dhYA
         EDRA==
X-Gm-Message-State: AOAM533GRpJOoKUaG1ivfVfJkzGOuWFMfPVU2xetDpfEzANUMH6HiaCF
        PMxXQg7iC987h0T9OijT0Ls=
X-Google-Smtp-Source: ABdhPJyzY1KDd5ZB8tkJakiVIfPqn83Mo3LLd11awzreh+qXGyl17XBw7GTo2pOGUP0HY4IKCzzAdw==
X-Received: by 2002:a17:90a:4489:: with SMTP id t9mr28782900pjg.223.1641805943631;
        Mon, 10 Jan 2022 01:12:23 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:23 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] blk: use standalone macro to control bio.bi_iocost_cost
Date:   Mon, 10 Jan 2022 17:10:40 +0800
Message-Id: <20220110091046.17010-8-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

This is a preparation to make iocost modular

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig             | 4 ++++
 block/bio.c               | 2 +-
 include/linux/blk_types.h | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 50cc1b56852c..e1b1bff5c1e9 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -26,6 +26,9 @@ menuconfig BLOCK
 
 if BLOCK
 
+config BLK_BIO_IOCOST
+	bool
+
 config BLK_RQ_ALLOC_TIME
 	bool
 
@@ -134,6 +137,7 @@ config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
 	select BLK_RQ_ALLOC_TIME
+	select BLK_BIO_IOCOST
 	help
 	Enabling this option enables the .weight interface for cost
 	model based proportional IO control.  The IO controller
diff --git a/block/bio.c b/block/bio.c
index 15ab0d6d1c06..a9e2347b0021 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -268,7 +268,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 #ifdef CONFIG_BLK_CGROUP
 	bio->bi_blkg = NULL;
 	bio->bi_issue.value = 0;
-#ifdef CONFIG_BLK_CGROUP_IOCOST
+#ifdef CONFIG_BLK_BIO_IOCOST
 	bio->bi_iocost_cost = 0;
 #endif
 #endif
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fe065c394fff..495ffc29bab0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -261,7 +261,7 @@ struct bio {
 	 */
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
-#ifdef CONFIG_BLK_CGROUP_IOCOST
+#ifdef CONFIG_BLK_BIO_IOCOST
 	u64			bi_iocost_cost;
 #endif
 #endif
-- 
2.17.1

