Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE35B284E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIHVRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIHVRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:17:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA141017C1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:17:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o4so19001582pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1vH0xwAwu857qan4VhlR5/CP90WnznqN8sYcRDZICDI=;
        b=gk2T77pZStWaE9I/LqZa9c/bsifhcll3rtR6/fuLmnHZ/awo/H8bGlIFRRUDD+vETi
         towhPxtzCYTUn9pkzSmxzV945mtXgao4gJOnF3+h33jtXFUU5+43QFLY8Eaac/XWeU6n
         az9u7NRr0n3kaSLEq44j4F2lGfgmUTCZ2H6W/05sFO9IAfAABugwXYCscy4QVLg3oZlq
         N9p03h2qHahtM6f4Tw6aP203Me92JQGYB+DRWcZqOCBjkBCgevgjQeKaHMnHZHkM6tzj
         4w4LHDtA4Hcjb4thTHEj4GZc/NHC6dXe5bIb9sddO5BE63FB6m8ENUmnbhqEMxLndQuo
         gkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1vH0xwAwu857qan4VhlR5/CP90WnznqN8sYcRDZICDI=;
        b=YQyEdcmxjlLN8SYbOaTjMK7D2kZbKl+oVF3H0vP2exCz6MAVcgR20W0b8cJXooo2rC
         0IB7Iu5es+FUeFcysPYhmNo1d7KCGzVRjAPQCOLUsRLZt8I5eIFEJc9WCdIzIbMqM54u
         16MBsgGt+d1HhYzne7oFbfX87J5MNGibQp4foAVn8RSYBHPJb3LWG8OCCskfmMujw/mz
         3NM/b1w9SQm2z6yQRl4sF/uOB+IRHl6vAyAlvgCpUI+0NB3GZjs+5cn2sHY16G9pfE3v
         OjlouIdQiEZHr8j9cgydnkauu+J21Y+mEdNHAzMQXF6ujmPEO4E+lrq9PS3NIK+nXaEG
         rAOw==
X-Gm-Message-State: ACgBeo2YZknHaK8hfAQjdpoODZAibi9P6RNb6+XVRDFbX/R4CBg6BUio
        ydufecmtei0c3nLVK8ij3j5c3miGVlQ30Q==
X-Google-Smtp-Source: AA6agR406OgVPwuy7NM5Fgfa+SA+jopPEu8bBwU13dMzAfJWMQfbzvKO+PqomEr74863czx6xmVe/g==
X-Received: by 2002:a17:902:e8d1:b0:172:9bc0:bc9d with SMTP id v17-20020a170902e8d100b001729bc0bc9dmr10827487plg.20.1662671862950;
        Thu, 08 Sep 2022 14:17:42 -0700 (PDT)
Received: from localhost.localdomain (c-98-35-249-89.hsd1.ca.comcast.net. [98.35.249.89])
        by smtp.gmail.com with ESMTPSA id pi10-20020a17090b1e4a00b00200de8ebc2bsm2306168pjb.13.2022.09.08.14.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Sep 2022 14:17:42 -0700 (PDT)
From:   "Yichun Zhang (agentzh)" <yichun@openresty.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Yichun Zhang (agentzh)" <yichun@openresty.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH] relay: replay_file_open(): NULL ptr deref in CPU hotplugs
Date:   Thu,  8 Sep 2022 14:17:30 -0700
Message-Id: <20220908211731.11534-1-yichun@openresty.com>
X-Mailer: git-send-email 2.17.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU hotplug may introduce race conditions. We reproduced kernel panics
due to this NULL ptr deref error when doing frequent random CPU hotplugs
in a KVM guest.

Signed-off-by: Yichun Zhang (agentzh) <yichun@openresty.com>
---
 kernel/relay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/relay.c b/kernel/relay.c
index 6a611e779e95..2db69fd527d1 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -816,6 +816,9 @@ EXPORT_SYMBOL_GPL(relay_flush);
 static int relay_file_open(struct inode *inode, struct file *filp)
 {
 	struct rchan_buf *buf = inode->i_private;
+	if (unlikely(buf == NULL))
+		return -ENOENT;
+
 	kref_get(&buf->kref);
 	filp->private_data = buf;
 
-- 
2.17.2

