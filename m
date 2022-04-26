Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575F50FE71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350753AbiDZNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350703AbiDZNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A4606E8;
        Tue, 26 Apr 2022 06:11:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k2so4980020wrd.5;
        Tue, 26 Apr 2022 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tEEuINU9CLeosBzNUr8N1QxM1jQkj0neKh5P8tCc92k=;
        b=O1SB+eyaNKMxVFwLMjV99omf3LI6roUOB60slMCRwhfBHf6LJqul51W2LLMDVZJ4t1
         bN4MznsAKv6jB8cX3T11rdwLcHbzh1Z5uHMdADd5k2l8UwVUtsdMuzusoQxNP9rUOB3O
         egDI/T3lei0TejHOnQvaRVpzah1s3FSAU3esoeU+9iTBYMmqhm9iz2fs0fstT+8CQaYv
         6zhWoCn8D/2R6447UDhjE0atWYldRNsTi5mOwdazyK5S4vBj3sYicEnUoExOk5H7O3a/
         LeAUPxNkfdZWguZ6XEKyKvivfIJO5IJ5SjpMWkYQk6ziW/+2XkhW8iOn/uJr9oDeaGO3
         FAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEEuINU9CLeosBzNUr8N1QxM1jQkj0neKh5P8tCc92k=;
        b=N+xgEy2Cojk+rL8US0nN12Y61BEEEr31eiJsVn3xCIgBcf6cMWUNWQmFJ1aPqYl1BW
         +4ldiWIsA+Q13u8BKzJL4W/Xr9pfvBQG0V97vDs2e0wCx4YfteSP2NN7Sa6VAHTt2Q3u
         yDdHUYJ5IYEyaGD6M7h897UL1hFg2UrXK35DS69Z6C8IxBxHhWbgkRvXrlrQWkaCOWRy
         WBwoK8EBXpMI2UEgxts1DBNOhNf8BTMCW8r2d9N5zwAWJ9kkv9iNlvc9U9uQahcWhY3q
         +Gik0Clxwomwt1AsKOkvVQDhNpsi73DfrCuftH99g8NZo08sSgXABAfDVN+c+V68B1VV
         LCcQ==
X-Gm-Message-State: AOAM531fJ7xAZ2qJ602uMXD7359rXrBJUmL1P4+d4RaAx9ccg+6CG9Zr
        ryt8RDzLjiO8Awy62dYwgos=
X-Google-Smtp-Source: ABdhPJyv2gaQbAYWWTQoOaLntXu67rTSWkXh5XUl0pKu1wwkzCl02PFb7a2WYOmT5rB0f6mD6Io7Sw==
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id f11-20020a0560001a8b00b0020aaaf775e8mr17741384wry.66.1650978671837;
        Tue, 26 Apr 2022 06:11:11 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:11 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 04/14] iio: add modifers for pitch, yaw, roll
Date:   Tue, 26 Apr 2022 15:10:52 +0200
Message-Id: <20220426131102.23966-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
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

From: Andrea Merello <andrea.merello@iit.it>

Add modifiers for reporting rotations as euler angles (i.e. yaw, pitch and
roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d087b2607cc9..aa5f98d3b334 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -137,6 +137,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 0993f6b697fc..4853701ba70d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -98,6 +98,9 @@ enum iio_modifier {
 	IIO_MOD_LINEAR_X,
 	IIO_MOD_LINEAR_Y,
 	IIO_MOD_LINEAR_Z,
+	IIO_MOD_PITCH,
+	IIO_MOD_YAW,
+	IIO_MOD_ROLL,
 };
 
 enum iio_event_type {
-- 
2.17.1

