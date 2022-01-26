Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112149D670
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiAZX5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiAZX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:57:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803CFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:57:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r59so1120787pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKDJjrxw99oaoGuyysDvfB2GBHozPwxZDO5K9D5Zwlo=;
        b=JVlZvzaGbk5Kh3oX3SgJL9OdKPOpg8MmZJPCl0V43218KTTRvE/FXF/bz2FwhwgROo
         1pbAcoufXGeqNAS7IsLS20/8w0eo0snQsrBTr2o0zEJe6zLlBPsPNDSL0l/Ea0E7Uhx3
         EW48vhsDEUGnBQY0IwwTSv2N50UXHbdjcXuu5m5vktRPK5ycCGb69geMjtozDAQMI+nR
         9siWzcu/q8I6QbfUputbNeS/Hj1Jb4NrGg7EIZo4ZinaFpIKvEUEe8AtRmKRJK/FwRLP
         AGgzTXR6BpnxNXgX0x66elkTwqUF8YwLPkaWXSPE4aN9LL3VmF4hsPjsXSXMWqYf9d0/
         /FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKDJjrxw99oaoGuyysDvfB2GBHozPwxZDO5K9D5Zwlo=;
        b=NZReVANWBLfiIR53o9LIkDEWTLIQZ4haIGMRS87e31p6cpychymndqXX7sJ7GdGU9c
         80uNPwTma/ZB653PXtlAr6hhnz0/zbMM5hz8pw2UH+ue62keMJhkJFbr6xSfz7FUuE/n
         yiWucxECgF+jlQxh51QvyOq4a/97PQuwOVjWusRo8eDCk6cB9yQ9RCkszP1cpWP4p34Y
         Ms7KizMt1vUWba1dHprfgM6cgmfdy45k5wMYIXCR22ogjt/UFjqPz8vRVcvNFnDhyNUp
         t6vB8z9WLQqaV2ELC0A93k4eCyW1Io9IATarONSPvy7XZ+ojmL/V/kTmxKUbjA9rC2N+
         M3AQ==
X-Gm-Message-State: AOAM533hjLC3BiNGZ7/g338reILkFP4P1lJuARB7hKS/kwcaJ2AlkKk5
        /w6KP5XjnACg0lDSUs7Uy0w=
X-Google-Smtp-Source: ABdhPJwzgqWb0mqT6jUi/+qs1jAD9USgSpE2wrj5W8iphk9NJCE8wbjq+XwuqUW9r/7vWK4+uYK/rQ==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr731804plk.129.1643241461123;
        Wed, 26 Jan 2022 15:57:41 -0800 (PST)
Received: from localhost.localdomain (192.243.120.23.16clouds.com. [192.243.120.23])
        by smtp.gmail.com with ESMTPSA id f8sm3465701pfj.177.2022.01.26.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:57:40 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jk@ozlabs.org
Cc:     davidcomponentone@gmail.com, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fsi: master-ast-cf: replace snprintf with sysfs_emit
Date:   Thu, 27 Jan 2022 07:57:28 +0800
Message-Id: <07ad7a3621b9f92e291710ec58225a5e4580a46e.1643183118.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/fsi/fsi-master-ast-cf.c:1086:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 24292acdbaf8..e33c1cfb44cd 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1083,7 +1083,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_acf *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			master->external_mode ? 1 : 0);
 }
 
-- 
2.30.2

