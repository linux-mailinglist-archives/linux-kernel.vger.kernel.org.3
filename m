Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32989487A64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiAGQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbiAGQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:33:37 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D76C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:33:37 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id b26so11143802uap.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKSah4ftdKgnYH/5hc63jfRi1amTCzCRzRwNFNBPqJ0=;
        b=PFB+S1WQQgqerJaTeJSXsFDSjqsJ/DjTZMXnoe7RtHHVtZnt/VYOBea7F0AT+vJG7v
         sD+BOlP32ooXAaU3H4iFa4HkKV2BgBGPiBIaVdu9iekxPUxRvc0HZVlTQZwmx+tUodMR
         38au5sQ6vxvquDV4ra602cTBFsNolF1KR9ZSEiugeTQGcEQWYIUTYXWIwEmNQM7JnppQ
         wpIC5uPsqbUuDJdk3mqa4FQ2gn4OzaLpS6WZFKVt7+gHnEU3wF+A7w1Gbax3yUm1Josx
         iL96Qgqx//3j0Nztw6dFxLICsslE5KZ/OZWBebrCf6XR+bPtz9oWnMjzwtkRaDa8GR1v
         ZJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKSah4ftdKgnYH/5hc63jfRi1amTCzCRzRwNFNBPqJ0=;
        b=S+w+TNwOwB+ecAfGKtSroS+eWqpOM4QsPIjhnjX4xvkaLllqIvu1PFAnArTa7DYEtX
         h87kDby1S46oJGtZbkqYLgd+Z5Yk+Jk6jBpjwihhaYUJe5vWorJ/GzsGQYaHJN0sLsmt
         tQgP7Jxs6o9w39lL8bESyOd14qGlzQEPNWXn8gOsfwBfm2xpDNghehccjJcRZ3jrkYsR
         XUVkJyp2zdg9UbxQ6vRWm8FWnRadobRRh6/Wkcv29Lsx77X7JxpuYBPyMlb2iH38sBAC
         lZmPz5JH/eJSd7A3J0MVOp4cVv0MUTN18vRaravK7eROyTJiDu87INyXwaBCulT6cZmB
         qTgQ==
X-Gm-Message-State: AOAM532R958XWMU+dFxj5GcGHmLsSl9uR3n3qsG8gcqW0GrDNf6Vx/5k
        ASiORnA+nmwyKeQc0DnkFdLGhi8noRk=
X-Google-Smtp-Source: ABdhPJzmn0b45sNrcvPvCIwEm/UfjCEorJ1FNwL5ECsZeAj84HCca+jQUAD3jbOXlTbFZsu8UbVHYA==
X-Received: by 2002:a67:e303:: with SMTP id j3mr21959298vsf.33.1641573216680;
        Fri, 07 Jan 2022 08:33:36 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:504a:2bb5:b3f3:9180:c62b])
        by smtp.gmail.com with ESMTPSA id j76sm1115880vke.27.2022.01.07.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 08:33:36 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] regmap: Call regmap_debugfs_exit() prior to _init()
Date:   Fri,  7 Jan 2022 13:33:07 -0300
Message-Id: <20220107163307.335404-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Since commit cffa4b2122f5 ("regmap: debugfs: Fix a memory leak when
calling regmap_attach_dev"), the following debugfs error is seen
on i.MX boards:

debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!

In the attempt to fix the memory leak, the above commit added a NULL check
for map->debugfs_name. For the first debufs entry, map->debugfs_name is NULL
and then the new name is allocated via kasprintf().

For the second debugfs entry, map->debugfs_name() is no longer NULL, so
it will keep using the old entry name and the duplicate name error is seen.

Quoting Mark Brown:

"That means that if the device gets freed we'll end up with the old debugfs
file hanging around pointing at nothing.
...
To be more explicit this means we need a call to regmap_debugfs_exit()
which will clean up all the existing debugfs stuff before we loose
references to it."

Call regmap_debugfs_exit() prior to regmap_debugfs_init() to fix
the problem.

Tested on i.MX6Q and i.MX6SX boards.

Fixes: cffa4b2122f5 ("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev")
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Use regmap_debugfs_exit() as suggested by Mark.

 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 21a0c2562ec0..f7811641ed5a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -647,6 +647,7 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 	if (ret)
 		return ret;
 
+	regmap_debugfs_exit(map);
 	regmap_debugfs_init(map);
 
 	/* Add a devres resource for dev_get_regmap() */
-- 
2.25.1

