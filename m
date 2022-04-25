Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCF50DE40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiDYK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiDYK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:56:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C18233C;
        Mon, 25 Apr 2022 03:53:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s4so10482793qkh.0;
        Mon, 25 Apr 2022 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peu4gv2FGZBgMzK4VqAafb6JLZ20qiywVqW5LgkX7HA=;
        b=k3cm/jAoa4Rlwh8j9n1yh0OEi1U//6+xYMOoKmLhpBOQXCge5e7odetNJ6G26YeaD0
         E+PgVeXL//+axDEh/GawTgprgOBXnWaG4zRccGVHSzR6mPNyodu5lvNGobuT28+xPG1o
         di+aJkuY6Vk+h4R3FNWarZjAwTviontQqYwe+/U/Kmvir1tBzyWVTQT2kQWgnEZMGfWu
         77HudJFfuWjytUg+Syeh8hGyJ6If8XrBf8aaTA6oOeCJQgS9CyS/nKUH9ajn79ueqnxc
         TjWWTS1pOhosUyLkDTm0pmUhY+g1z+rM2ffRbvHflVUgsjM6dxwPF23xvq3T3qLzyCZL
         KzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peu4gv2FGZBgMzK4VqAafb6JLZ20qiywVqW5LgkX7HA=;
        b=0hMtsd8FjkwTGG54bJiI4KTuvo20bmS8ePlg753lNIsZ13WRW7MflyOj1NzXQ1lXk0
         26zascdi9h0kgvYvBbyQ7REGur+fv30a4vCs6n+IVRO5axRdDjxE5ySZYd4t/RxqesKE
         cFV1Abz7jFl7jndnD+CxNlkOIn7aqUMDrOOhlxRDUoYPi1xFqoH9/obH/PSRlk6osxDD
         Nc6altJPayMmV//YY0Ts9jVZzWbq4n7SaGdyBBhhgCo0Db020sTunTgyUN7x2ynsNBta
         CwvcvArEph4ftHhYJiay3DQ1yWMErYjKMP2bZHM6IIHQwTEZaOGguXD7AVtl0VskLtTI
         95Ow==
X-Gm-Message-State: AOAM532ZCsXeuPVARYtRYVaKrDz0VACFO+Yfnf65fFDKxYa8Ro/l9IDh
        /4Gs1xEnfGKnvurdYPxs2LQ=
X-Google-Smtp-Source: ABdhPJxr2rj5ClM4IGDuDoTOolpultTM0NaIh3DYqTMoh/mzT8/nPsv39h4IK1Mr3axvwbxCToC9Mw==
X-Received: by 2002:a05:620a:6cc:b0:69b:dd1b:3235 with SMTP id 12-20020a05620a06cc00b0069bdd1b3235mr9522389qky.374.1650884024797;
        Mon, 25 Apr 2022 03:53:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y9-20020ac87c89000000b002f364b84040sm2591273qtv.34.2022.04.25.03.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:53:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ulf.hansson@linaro.org
Cc:     axboe@kernel.dk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mmc: block: use kobj_to_dev()
Date:   Mon, 25 Apr 2022 10:53:39 +0000
Message-Id: <20220425105339.3515368-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b35e7a95798b..983151b7296d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -330,7 +330,7 @@ static struct attribute *mmc_disk_attrs[] = {
 static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 	umode_t mode = a->mode;
 
-- 
2.25.1


