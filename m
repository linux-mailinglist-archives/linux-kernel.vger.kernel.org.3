Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB855D271
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiF0MIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiF0MHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244B12A88
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:05:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l6so7959829plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=31piJZFjl6u1ZUS8JijCEBXfXUqiNLSbSjWd4CZM8/0=;
        b=CHsCH1A4UDMOJj8bUkS3g+NQUhct6E0yIuccrdV2sFFER/sbGdPly03ee4V20i53Y0
         ZC9n3QT2m+OqlNEZTPFwX+16BAQ5S/GzM6LCz2K1DuEHD5OmuhSRaoEuU5i1FVGNHEAC
         umebAFJN/oSpCMeUTng+aa45v8NRN82vC8i4jSsf6584W+Cb+Mvtge2jhOwh0SghzrAE
         VY+IlNk74mJNEq6aNfYTQ8hgpyo1rR0RDjv7MBkl+F11blqODhaECzScM9P8cT28VKiX
         cD0d7DoQKPkv/4ddNfRqJUyqN1/80HY6NwUHtXWTBOLwT5uYZjkoE7smLV9kkoiAfxR5
         No9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=31piJZFjl6u1ZUS8JijCEBXfXUqiNLSbSjWd4CZM8/0=;
        b=0b+iinGi42jwGU58R5H9wLYjzu3qUIs4ab0dt6ox+gxe2WKp3eBAeY+hy8u0vW8DdV
         2IET3Hi4T3YEhmW1D9kS6n6P4yDps/jsS92NV44Jr4jUMIiaCEhPuXURkPcQOKlAC8wV
         XjXeICvxgQCnaMdrEJwDYj2Tb+4euHZYq0BGcD8E7mlcZF4ey9hIAt6hssQD0T02s2de
         W1DKcqsLTyzPz17xE5c9pWe9PzufRuoW0CrEdEDY90IJ3+moZ5m7j2fJHomVJL3RnI/W
         tQLexz8n2V5OsEkJYCRwVMlqIKZ9TFZi2oXU4w7XedKzBUUpuj4d3ywuX+D6+d6H/Zwi
         5HYQ==
X-Gm-Message-State: AJIora9+qfZYav3pk5V3Z/ZtmsDkDs2Kh+UxB6b2uTJt+H6dezRXUou7
        ZmS0KTZ7qqrjqszIvaY8yb3rb8klgc1DD8J6QgY=
X-Google-Smtp-Source: AGRyM1tZ5UdceWUidW1fLkGc8FbMreZwYD+v6CRtef0jVtUcEFGbt7pmN61IybFKwTNVuYoMBhvZuw==
X-Received: by 2002:a17:902:ebd1:b0:162:224f:abbb with SMTP id p17-20020a170902ebd100b00162224fabbbmr14080012plg.160.1656331517944;
        Mon, 27 Jun 2022 05:05:17 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id 3-20020a620503000000b00522d206bd04sm7355851pff.178.2022.06.27.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:05:17 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yangxi Xiang <xyangxi5@gmail.com>
Subject: [PATCH] devtmpfs: fix the dangling pointer of global devtmpfsd thread
Date:   Mon, 27 Jun 2022 20:04:09 +0800
Message-Id: <20220627120409.11174-1-xyangxi5@gmail.com>
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

When the devtmpfs fails to mount, a dangling pointer still remains in
global. Specifically, the err variable is passed by a pointer to the
devtmpfsd. When the devtmpfsd exits, it sets the error and completes the
setup_done. In this situation, the thread pointer is not set to null.
After the devtmpfsd exited, the devtmpfs can wakes up the destroyed
devtmpfsd thread by wake_up_process if a device change event comes.

Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
---
 drivers/base/devtmpfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 8a3ddbae3b70..e4bffeabf344 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -482,6 +482,7 @@ int __init devtmpfs_init(void)
 	if (err) {
 		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %i\n", err);
 		unregister_filesystem(&dev_fs_type);
+		thread = NULL;
 		return err;
 	}
 
-- 
2.17.1

