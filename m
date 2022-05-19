Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3488152DDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbiESTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbiESTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:31:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1130334B96
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:31:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l15so4332311ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcIoxyw5IPPQVSw6b4XvGK3gQ1lftBzGtolvV7OQHCI=;
        b=XfwZiKCo0naqPksy21hJ+p926M2akt6G2FQMprV62tSEF4WEB7GJcV2rSzrEZxUn6L
         hfpFYHxILyl961Qn4kJYs5UrQI7FdU3C5PHyJ7yD2tgx+IsAoDF+vpUYiUNWgKkMGjdY
         /XKTUDwIokP6lijS7ew2sEbwYvP17RdL9qFfYjbg3WzeZdC1baCLkxN1YqeKSt1Y1cAf
         1MBOlnRBiN2XRCguaOa6PH/enSJwIzZVmIE/Hl0WLyitOCPL634MXf5adOc3WAnmsva3
         LGnys+XcVkEyhOmAVJvoqpqV+vUxFTteJNRGcmA0N9Fp17ghs39PVlccCP9rvzmm/xjb
         eq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcIoxyw5IPPQVSw6b4XvGK3gQ1lftBzGtolvV7OQHCI=;
        b=67RIZEzVbx/SJN40lTt7c2Dw7dVADsM6/4FsY5lS1PFp/VRAFVzpeGGhZpxAggNRNG
         k6pNAIJwHmOnsuessP0HG0R+AsfmZRxtq2c0Gfv6cgp+bMRfzttxCpyrZOPVNh+gKd90
         r4cVTTwgvfSgv5K7plmmaEcTeVgrrRjQ7gFiNY1wTVEwSlcaqe+Kp9ZXu82LCjYmOmuy
         IjUwPLQEneRFNApdF4t+mqyqcZb5qtenNvjJ0V+IthN1BMrFD0a2abInwgTFu5xluFZk
         xUTx5cPV9UHIxzGpPIhJP0GmWfnLj+OWvcEU0HfXJf9Fjnev8siJSwDQSI+sW/Xx05DG
         vrjg==
X-Gm-Message-State: AOAM532IiNLZ9+m/VGxzAVhBU0/Pn6c59vAVxPvj2jTuWJbVH85oD36d
        TnxtUA9UJs+Hcx+kR2Bi43Uvrg==
X-Google-Smtp-Source: ABdhPJy4IsDX3sjvmACMRTE4zhXyBhPcz7HkL+dbzkEYqOVdpy6tg6lSsSg+CBxJP9NxpsKd3MMVHw==
X-Received: by 2002:a05:6e02:1c22:b0:2d1:87b:c6a3 with SMTP id m2-20020a056e021c2200b002d1087bc6a3mr3678321ilh.184.1652988698427;
        Thu, 19 May 2022 12:31:38 -0700 (PDT)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y10-20020a05663824ca00b0032e7456da06sm134390jat.15.2022.05.19.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:31:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] random: wire up fops->splice_read_iter()
Date:   Thu, 19 May 2022 13:31:33 -0600
Message-Id: <20220519193133.194138-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519193133.194138-1-axboe@kernel.dk>
References: <20220519193133.194138-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that random/urandom is using read_iter, we can wire it up to using
the generic splice read handler.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/char/random.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 529afd31d549..6da8f1441815 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1647,6 +1647,7 @@ const struct file_operations random_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
 };
 
 const struct file_operations urandom_fops = {
@@ -1656,6 +1657,7 @@ const struct file_operations urandom_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
 };
 
 
-- 
2.35.1

