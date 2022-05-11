Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765F522EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiEKJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiEKJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:01:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D001EC79
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:01:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 129so810117wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COIK1t5gjSur/DAhaG10JunYZpa04U3DaiZ5/f2aC+4=;
        b=VsbXgXQtBCRz2lOBDh/Sz3PKK2daI95s686Fldo0fTSRHN88XGee9kwwzl781uLzWN
         NlSlF5xBFgEImZ/eaw/xIoUfA4RA6K0fvuPPlcalSmk48934PyhKUNUjroz0NFVI9tKs
         WEIw161WKHg8DY8sPJ7Jd/JLvRpV/SoCFdRGqBBeLghHUsZIE+Ysp1+rVZvB3stXqqCf
         /Q/lFCIIJeiCKDhJW+aFewMKUhN2OSBfXlr/UOIfLQHRLf1ZpHQL0e1EBt2olfUbECSC
         r9+S6yIuYb7UfE7AVDKHSCS1MV6Vr/d7THvYS2KLOx8HjOa8Vy58skQMTcx6EqdR2jNr
         SyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COIK1t5gjSur/DAhaG10JunYZpa04U3DaiZ5/f2aC+4=;
        b=OPh/3mid4WWuc8SejuaPMXURrh/680IhepyXDmHkjFQCq5QDdoTvrS9JMa+eLyogbj
         uDxFB8mJdEWfwXX0cxpZB/ekdQHxWeU1iZqONITpMpTLayjdP/2aweiSaVQCpTDUVqR5
         XzBGXTadtAt+fF9HnNyAO0Cmb3yU41pBT9uaGvkYsowmqi7zUyMsnQj/JljqVNbxbtGd
         P25iZILGLnbK2tk/vLZX7biThlbCzhcWw++VeF6FGgjmKKKa95psEKoqgQPUmbjPVzeU
         2D4RZz00reDg6OC2eJPPHUQNaLb/kj5fo5gsbWjZ1wCI0wbFKBm9iL2OqUqUYa0HXQTo
         N+2g==
X-Gm-Message-State: AOAM530ESxM95r0yGU9NyYPQsr2z2l/tngvWcygHMYZkwlWLJlxsNQWq
        av4Z1iHfgl617+Ijp3Q1COEAHeLavGUn3Q==
X-Google-Smtp-Source: ABdhPJzn9OLH84pRG9TZQ5rSHvcrOCqlino+kqe6rjV9XLWNaRLwD735N2cKQHimnvCkqfPGSBN8JQ==
X-Received: by 2002:a05:600c:2205:b0:394:193a:80ed with SMTP id z5-20020a05600c220500b00394193a80edmr3698887wml.191.1652259662292;
        Wed, 11 May 2022 02:01:02 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b00394975e14f4sm1588272wms.8.2022.05.11.02.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:01:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yi Yang <yiyang13@huawei.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa/simdisk: fix proc_read_simdisk()
Date:   Wed, 11 May 2022 02:00:32 -0700
Message-Id: <20220511090032.69109-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Yang <yiyang13@huawei.com>

The commit a69755b18774 ("xtensa simdisk: switch to proc_create_data()")
split read operation into two parts, first retrieving the path when it's
non-null and second retrieving the trailing '\n'. However when the path
is non-null the first simple_read_from_buffer updates ppos, and the
second simple_read_from_buffer returns 0 if ppos is greater than 1 (i.e.
almost always). As a result reading from that proc file is almost always
empty.

Fix it by making a temporary copy of the path with the trailing '\n' and
using simple_read_from_buffer on that copy.

Fixes: a69755b18774 ("xtensa simdisk: switch to proc_create_data()")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1 -> v2:

- change title
- expand commit message
- rearrange changes, fix build warning

 arch/xtensa/platforms/iss/simdisk.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 0f0e0724397f..4255b92fa3eb 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -211,12 +211,18 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 	struct simdisk *dev = pde_data(file_inode(file));
 	const char *s = dev->filename;
 	if (s) {
-		ssize_t n = simple_read_from_buffer(buf, size, ppos,
-							s, strlen(s));
-		if (n < 0)
-			return n;
-		buf += n;
-		size -= n;
+		ssize_t len = strlen(s);
+		char *temp = kmalloc(len + 2, GFP_KERNEL);
+
+		if (!temp)
+			return -ENOMEM;
+
+		len = scnprintf(temp, len + 2, "%s\n", s);
+		len = simple_read_from_buffer(buf, size, ppos,
+					      temp, len);
+
+		kfree(temp);
+		return len;
 	}
 	return simple_read_from_buffer(buf, size, ppos, "\n", 1);
 }
-- 
2.30.2

