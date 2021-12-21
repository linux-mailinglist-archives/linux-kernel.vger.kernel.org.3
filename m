Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5747C34A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhLUPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhLUPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:45:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:45:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v15so22170081ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhNet821PMImWBYgd4Bln2UetYZb37zsPJPFCWwdaz0=;
        b=N0r9VqWRfsB3LjKvCZKit+wrGHEUElN9dD6ZkLn2VFac5ET5p8oCLbkxzF0BQCzVWp
         ODlqOQJk2xKcc6PRfR6D9ckxT8pVUPamh8kYzTsd8WO91170kUiRbB0OT0Y89NbZrziC
         QjGoVFZERqqZy2uxcWe6NkfVQIJXTCQ3JK1R4fS6t5jOnfJFlNqQgcOqqq7O1SWW8iqw
         TIWoEbRLqeT2UJ6R2IhgUJrcwgx+J+kGmN9SiReU3Jx99P2Z8Jjh2beqABX73P6PEe1b
         DDHSe4MlfQxPcTXNkALV3jd8+NMEz3dVk3jf3bBfm2Hu/xN3O2bTpEAi2rMAV9AiivsS
         xuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhNet821PMImWBYgd4Bln2UetYZb37zsPJPFCWwdaz0=;
        b=bqmCLcAeDCihuGh/pnoCkhKOIY3LhQmVlnq3TTJdc9UalJYk+wYbTXQSmuEyl/1uDb
         1cAId28ntGbzDkd5eXQLczDsY5pVujMDrXaQAHaZx28WvDyzaz7ZqnaE9hSP190stBYr
         0Ipe92rfdSOZI979EGMs+eyHJO/UhNCFDO16lukkzVQxVI/Lu39Lrwc5NjGVZUkZ/7Nk
         ak5f1aaf9BJProeoyDbOLsWm/8e7KzEl3culVhRUDXCMbGx5jqA2U4P11htM81NkQr+/
         uM4SOVsaKalTHa3v1QI8adAZJb8JfSYkkl+7bh98QVNCk17E9tnB2GdVRHxvj6Op13G8
         9/mA==
X-Gm-Message-State: AOAM530Gb2QtnRhQN21lmS4eurtp7ZQMkOUtIDsAVAhfu0GIPSOvD/Ld
        wd1jEcK9vGz0njI78YXEbe6SBTa2AE0=
X-Google-Smtp-Source: ABdhPJwrhhqiklAoCYcS0bSh+9hYIR/RpKwSRIf2H2JlpCHQOE+Jvff9d9ARipNe7l0FnVLd2ditLg==
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr2899319ljr.170.1640101556764;
        Tue, 21 Dec 2021 07:45:56 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id bj11sm2687357ljb.62.2021.12.21.07.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:45:56 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] nvmem: fix unregistering device in nvmem_register() error path
Date:   Tue, 21 Dec 2021 16:45:50 +0100
Message-Id: <20211221154550.11455-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Drop incorrect put_device() calls

If device_register() fails then underlaying device_add() takes care of
calling put_device() if needed. There is no need to do that in a driver.

2. Use device_unregister()

Now that we don't call put_device() we can use above helper.

Fixes: 3360acdf8391 ("nvmem: core: fix leaks on registration errors")
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
That put_device() was explicitly added by Johan but after checking
device_register() twice I still think it's incorrect. I hope I didn't
miss sth obvious and I didn't mess it up.
---
 drivers/nvmem/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 785a56e33f69..f7f31af7226f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -901,12 +901,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	rval = device_register(&nvmem->dev);
 	if (rval)
-		goto err_put_device;
+		return ERR_PTR(rval);
 
 	if (config->compat) {
 		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
-			goto err_device_del;
+			goto err_device_unreg;
 	}
 
 	if (config->cells) {
@@ -932,10 +932,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
-err_device_del:
-	device_del(&nvmem->dev);
-err_put_device:
-	put_device(&nvmem->dev);
+err_device_unreg:
+	device_unregister(&nvmem->dev);
 
 	return ERR_PTR(rval);
 }
-- 
2.31.1

