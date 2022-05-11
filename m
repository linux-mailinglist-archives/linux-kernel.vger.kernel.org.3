Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9852334C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbiEKMnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiEKMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:43:47 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004D041305
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:43:46 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l1so1992657qvh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qsiv1TVIjBCFn3mJfyoC7yf67O63B0wHbv7qQGoztZw=;
        b=d21c6940FfE0c2Irk5Vc66TrQ/aBxdFayMLY6R12Hfe5c0Z4DIiPb6fprSRS/JSh+Q
         7LrGhqqS4nLdyDU28ahlf25w5NvMPtiETfLaDXRkOR+OaDCvn3CUsp0+Svk+laHjwc6b
         NIZaBJ7UaCoJR1VF5+wIWCBH2YSbhEs+YclmjpywjDMCncLsMapc/57vTGul1DcOEz82
         uIYVXtr2qXH3pbXATJQvKsh1OqSsbJpxUly9sseAzur8u3o3I/b1Z+zhhB1bioth6naS
         4t1tckVMc/UYoHcm0zzRiin4K+f1sw+Xg2BEkOdV79nJ4daruUjQynShtgJ5d5lak1UC
         Y2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qsiv1TVIjBCFn3mJfyoC7yf67O63B0wHbv7qQGoztZw=;
        b=XpBdLKPbXQg4Z5IWMt1KItYWif/pkf6LnEyNr9SUGMTerl70ti5ml+btCFmwYm6cGQ
         fg5hm2XTy756l3Tb6wGgPBiyhnwvrykNxrlDY/OFByH+69ue1IiLSREjJZ3cdJGdUAJO
         0kn0dLJ9utx/4e49ifXiJ/I/1R72lUE2h8tjBcvvHqH2l5CyvmMMbYx8YBitoqga9daP
         QU0dXFOi4P1hm8izP7NLy+rSzefRlvRNx9Dpv2hK9/CceZgS+P60tEBFSpkkfymRAnlT
         g6J7meBsQU/eCtGcDjryojVLWEDcSRN6QWMQsoJpQyID4ek+6k1QESJFuZphWLkrPahM
         en1g==
X-Gm-Message-State: AOAM530q4VNaZx6Mbz8uav/VBsYL05HwC/hvEuMTfWnd9JGRW9Ef760r
        Sj9IXTS5DuM79/050f3HezY=
X-Google-Smtp-Source: ABdhPJyD+dne4X5d/D8O0zW7qdXw8MHevWPZhch4IGLhSDRx6E4RMv8mWL93cQn8RvIcmmzcdcL7uA==
X-Received: by 2002:a05:6214:c42:b0:45a:d3e9:5797 with SMTP id r2-20020a0562140c4200b0045ad3e95797mr22147371qvj.103.1652273026014;
        Wed, 11 May 2022 05:43:46 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id s19-20020ac85cd3000000b002f39b99f6b1sm1111016qta.75.2022.05.11.05.43.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 05:43:45 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     ming.lei@canonical.com, linux-kernel@vger.kernel.org,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH] driver: base: fix UAF when driver_attach failed
Date:   Wed, 11 May 2022 20:43:36 +0800
Message-Id: <20220511124336.66705-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
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

When driver_attach(drv); failed, the driver_private will be freed.
But it has been added to the bus, which caused a UAF.

To fix it, we need to delete it from the bus when failed.

Fixes: 190888ac01d0 ("driver core: fix possible missing of device probe")

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/base/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 97936ec49bde..7ca47e5b3c1f 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -617,7 +617,7 @@ int bus_add_driver(struct device_driver *drv)
 	if (drv->bus->p->drivers_autoprobe) {
 		error = driver_attach(drv);
 		if (error)
-			goto out_unregister;
+			goto out_del_list;
 	}
 	module_add_driver(drv->owner, drv);
 
@@ -644,6 +644,8 @@ int bus_add_driver(struct device_driver *drv)
 
 	return 0;
 
+out_del_list:
+	klist_del(&priv->knode_bus);
 out_unregister:
 	kobject_put(&priv->kobj);
 	/* drv->p is freed in driver_release()  */
-- 
2.29.0

