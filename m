Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504BC53F493
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiFGDeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiFGDeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:34:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5807748888;
        Mon,  6 Jun 2022 20:34:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so3518112pjg.5;
        Mon, 06 Jun 2022 20:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rENSrCziR776p1G0mR4wiqTt+86dBSxlCmvPvnvJHXU=;
        b=hKweBMiCX47zGDlA0CzRo5RSdmoU6rANmAa+R0a7itzvm8ZrhNPqV1T85WYdbd1QY9
         2GebmTBO7nbBldNXJBYCravnsb3Sw3qOgs73nNQ8YQeGg/OoPYhcnjsu5fLu7UyZyYrp
         xFk4ejGoXenYLUO6qnJEGczLFzkX+MPnEjTgaCEeG/Qf6WVDM263zEWpVxIboLlcP4+t
         H/xffJKGGbeEw+B2qVYgS7bs4gsJhWzLozATgZBvdj26BspcfxvcB7txCvBKqWtM8gyL
         Na3FqKr8X2VSm9JHwxHwrIFqoPCvdoPoLm8bP3MzavuX9wymPSsqXnv6lkodUnRZJ2I0
         dC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rENSrCziR776p1G0mR4wiqTt+86dBSxlCmvPvnvJHXU=;
        b=fbV4CrIZz6T13fozsOhieQubDLAYZLxIgpvhbAIMvnRT+0TAmMhzhV3KwIx+dfHOjj
         bEtTxZX4ZMZ5Nb0TSyk30ah7Rh7CuVNofDIekJWE1lFMu68UiuCftKiSyBeN75JYgp5+
         C5AFn0F3JCYpeDlwXJDqT9g4REYJEjKuv5q2fTwnUucmiSeY8+NNEsJiKNycSOnLCXcK
         sTDsDc+hxHp2/Z9HSGkp0R/mzuKLqkGLFdum2MxVCMqQuKUCV7jraFf2SvsqjTSwRkZL
         WM6JnDXMEEV4JhXIPz2NVZw3J/We77WBtgQxREayUFN2k1YlQTRgXTMdncGGhhTB9uFD
         5tRQ==
X-Gm-Message-State: AOAM532eCaH064o3jzOfx86FhSArgSV0dHpegmw2JDOA20tw6+z9/iRI
        rca2zRS4GVVIp2nag+uMkhw=
X-Google-Smtp-Source: ABdhPJy8Zctyu0TzP8b6r7G2jJ5NGsZfHC0rsMLJyQf47TRZ4V8OqzmtwSWLvX5u+pOS03fIIwE+AA==
X-Received: by 2002:a17:902:b949:b0:167:6548:2d93 with SMTP id h9-20020a170902b94900b0016765482d93mr14310735pls.131.1654572848822;
        Mon, 06 Jun 2022 20:34:08 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l24-20020a17090ac59800b001e25e3ba05csm16700350pjt.2.2022.06.06.20.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 20:34:08 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Miaoqian Lin <linmq006@gmail.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sparc: Fix reference leak in scan_of_devices
Date:   Tue,  7 Jun 2022 07:32:58 +0400
Message-Id: <20220607033306.688-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() returns a node pointer with
refcount incremented, we should use of_node_put() on it when not need
anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: cf44bbc26cf1 ("[SPARC]: Beginnings of generic of_device framework.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/of_device_32.c | 4 +++-
 arch/sparc/kernel/of_device_64.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ebf51e6e78e..020b1c023d75 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -412,8 +412,10 @@ static int __init scan_of_devices(void)
 	struct platform_device *parent;
 
 	parent = scan_one_device(root, NULL);
-	if (!parent)
+	if (!parent) {
+		of_node_put(root);
 		return 0;
+	}
 
 	scan_tree(root->child, &parent->dev);
 	return 0;
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5a9f86b1d4e7..f044b4c1975b 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -705,8 +705,10 @@ static int __init scan_of_devices(void)
 	struct platform_device *parent;
 
 	parent = scan_one_device(root, NULL);
-	if (!parent)
+	if (!parent) {
+		of_node_put(root);
 		return 0;
+	}
 
 	scan_tree(root->child, &parent->dev);
 	return 0;
-- 
2.25.1

