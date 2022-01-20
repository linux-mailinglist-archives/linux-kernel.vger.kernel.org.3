Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76F494C92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiATLOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiATLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:14:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E09C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:14:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u10so662308pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=F5M7UU97aeaKFlWXzbzhubb6sQH6XXPzvK8qY90zdFI=;
        b=LlaftMoSjmS7CcjiT0eW+E8wOCpGua1zMYZuvK5oa886QwzmHXoqCn30P414wOKG1+
         7TA+FNtzCrgUJWKUDbsvEKMG1gzqAENaaycUESh0v19EXFGduz8xLU731Jo1fcLFkX4x
         vUKAXJXo+kby+YhtkqDHz3CTXXfzEUZ6LNhtjyiQugcoFbUJtJuNzncK/sdAazh2mgc+
         Bt08CTlufbQhGDQUt3/NklEFudUaIyOxXQ2a5bTp67DMuPzT9vXauQmzNBXYWz0OYksi
         OaUBX8bswGPJ2wqRLOIYNyVTOwiQG5XSch1MXwLKJQgELJwIyOA39RO/PkMYhNVz/Jwd
         7jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=F5M7UU97aeaKFlWXzbzhubb6sQH6XXPzvK8qY90zdFI=;
        b=vFlUiEyidfERPA7Wy/hp2LkSlPR6Yf99UEkGdfY38UU6zjfVYDJ+fZAwgzzP8ia1ae
         fSbZqL6KfCOIyHLOSvT0mohYw3IJcpZJwDG3HpnoCUbw4dtEgqMgeBtsqZaYgpcZ4Kzq
         CSDN8vQXxjHmigNljB8Ljp9Q+4xaZ5334ig1kBYJnEr04NWQlueXtNDjJYjCjsAK19tF
         HTo9rrmLo6kK5rnHU0XlJjtQpN3TQSLFm3QloUiZO383iDo/jQiiLj7wVMgNvfaXrAgk
         FaG0b+0jtLpo4/V3tMD/3m++8q5oH58I7FXLQi82WKtmTaaOWRD/+kTzLFS2TxhxSHEw
         6+XQ==
X-Gm-Message-State: AOAM533OYT9hrF2IvdovQ1S82oKdyvSsBws909S1yCVrm7MYSoHzfVK5
        C7eF9169SnJabmJYHLvF4A9VhhoQfEQoVApQ
X-Google-Smtp-Source: ABdhPJx0enZDXZHZfgwlZXBVpllsJYhCKzlIj5JU3J4ugwepEsOK64yzyO6JyB5PXNh/BKorwaFiow==
X-Received: by 2002:aa7:914a:0:b0:4c6:c181:5251 with SMTP id 10-20020aa7914a000000b004c6c1815251mr775086pfi.41.1642677241729;
        Thu, 20 Jan 2022 03:14:01 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ck21sm2074426pjb.51.2022.01.20.03.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 03:14:01 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] edd: Fix memory leak in edd_init
Date:   Thu, 20 Jan 2022 11:13:54 +0000
Message-Id: <20220120111356.8052-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edd_init calls edd_device_register(), which calls kobject_init_and_add()
and propagates the error code to the caller.
And kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add():

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix the error handling by adding kobject_put().
And callback function edd_release() in kobject_put()
calls kfree(dev). So remove the redundant kfree(dev);

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/edd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 69353dd0ea22..1135e66f92bc 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,8 +748,8 @@ edd_init(void)
 		}
 
 		rc = edd_device_register(edev, i);
-		if (rc) {
-			kfree(edev);
+		if (rc < 0) {
+			kobject_put(&edev->kobj);
 			goto out;
 		}
 		edd_devices[i] = edev;
-- 
2.17.1

