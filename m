Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA75AB541
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiIBPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiIBPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:32:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEB41BE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:15:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j26so1449469wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vho+m1JeucUWDUID2NTMp/Noqso8ylqG8qhETHGnWbE=;
        b=QVOiQ2e7b4P6KA2s1KjnsxNEuUTskSx/mRNh8xvVVJe7CdZqbZqcy0gJl4S6H9za6D
         yF8sX0J/6Vu3KQYvuMWTkOvGNW5WsIqHfLqk51R1wijjiAGl7b8oqNIE+OOmXKMqsTS2
         XClwgCJhR5GazQ1izvnAKX5Qa1vjJ2A6RLSNVSYvhyeZTQeTeodPSiCfPatk9SqzEKiy
         Kh4NXr1RWZu/WKw3M3HhVI8IBfF7Bm7CqF14G1rzwK7dVHPqzNqId9I0W2EDz4sDUMYV
         sJTG+sJNnfxpWKSVwQeUAUZ1Pu5mVFoNfHvptmsq+2DrzqpqjWqHqStXjOwB5OdDoF2i
         WlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vho+m1JeucUWDUID2NTMp/Noqso8ylqG8qhETHGnWbE=;
        b=5T6pv5M1t2rMczBK+7NFGcvKTHBTZOZtDGEFQpXVx2tcMww+RrPizrtQXV6MgLbzZh
         oNFvLckhqMpDPvUrbY/jJgA+WOUhidMfLWRT8nOJlv/1K4yx64cZmeYNZcM/uI16gSRH
         5qUJWfrX6b6jXNpcJ55NxnZ0B0cGEtqXOaU+lG5AoVbRXq2i69K3yMH6uQT1SzsVazYi
         rJRMW+cqrjKz8Gc0e8gNDMWQH0ETWq2lq9awpYsxAaKXK4ynodjZ4aMuyN0XBjXfXTS/
         Xr6G6asIOjWubx2JqKuU9AX0QIgbmRm1kf4KSkJD6ry2MnZjpfUmiyDX05OB2oPHpihC
         9lhA==
X-Gm-Message-State: ACgBeo2DSHG6YObIdDwkLBtb23nlhI/8hCLZ3y2Bd9+EZMRwOsRejYp7
        eYn0r9SiuRO/gK2nWd/34fU2KA==
X-Google-Smtp-Source: AA6agR5YmV6Ry4M1ECcCPF0E4/LManFJOQ1dPt91d6wIVp9px6/G8v/itdygTPG+0kCcSxt+YL8fsg==
X-Received: by 2002:a7b:cd11:0:b0:3a8:3f6c:9abf with SMTP id f17-20020a7bcd11000000b003a83f6c9abfmr3299238wmj.30.1662131700793;
        Fri, 02 Sep 2022 08:15:00 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c014a00b003a4efb794d7sm2361493wmm.36.2022.09.02.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:15:00 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ola Jeppsson <ola@snap.com>
Subject: [PATCH 2/3] misc: fastrpc: Don't remove map on creater_process and device_release
Date:   Fri,  2 Sep 2022 18:14:22 +0300
Message-Id: <20220902151423.3351414-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902151423.3351414-1-abel.vesa@linaro.org>
References: <20220902151423.3351414-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not remove the map from the list on error path in
fastrpc_init_create_process, instead call fastrpc_map_put, to avoid
use-after-free. Do not remove it on fastrpc_device_release either,
call fastrpc_map_put instead.

The fastrpc_free_map is the only proper place to remove the map.
This is called only after the reference count is 0.

Fixes: b49f6d83e290f ("misc: fastrpc: Fix a possible double free")
Co-developed-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0c816a11eeec..50c17f5da3a8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -316,6 +316,13 @@ static void fastrpc_free_map(struct kref *ref)
 		dma_buf_put(map->buf);
 	}
 
+	if (map->fl) {
+		spin_lock(&map->fl->lock);
+		list_del(&map->node);
+		spin_unlock(&map->fl->lock);
+		map->fl = NULL;
+	}
+
 	kfree(map);
 }
 
@@ -1266,12 +1273,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->init_mem = NULL;
 	fastrpc_buf_free(imem);
 err_alloc:
-	if (map) {
-		spin_lock(&fl->lock);
-		list_del(&map->node);
-		spin_unlock(&fl->lock);
-		fastrpc_map_put(map);
-	}
+	fastrpc_map_put(map);
 err:
 	kfree(args);
 
@@ -1347,10 +1349,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_context_put(ctx);
 	}
 
-	list_for_each_entry_safe(map, m, &fl->maps, node) {
-		list_del(&map->node);
+	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
-	}
 
 	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 		list_del(&buf->node);
-- 
2.34.1

