Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3290849B171
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiAYKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiAYKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:15:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8AC0613EC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:15:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 4-20020a250304000000b006137f4a9920so39594713ybd.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=doB02I4qSIR86llAlGQe+kwodmbCH1lEdNRlPOZ7RJM=;
        b=Q+ZIkfTltqz4qOuwoZbjAXVwZkFHvt0AQRjZ6h5mJ67D6lTbnrm+bPFcLOu8wShVK/
         4D71NwBWnNkevWqEtzjzuif2JuO/zovBD8IoOT9U7cx+hW04NWDPr272TLJp7a/5I4kv
         mQ8t4Ot9XGq0Cr5Vy8QDxydT7JVf2l6fTznlnMOGWEC2QPaiMn0Jut+ecgFgFjtzd3E6
         blV+1TThV7ZqC1Ub2U8BiMfc4FGJreB+EZ9MI+70L2jtk6Vr1fYfnkaSgetGLZ0/n5dO
         FnV+E58JkIPQKE9xjGxeWCvpt+hLwkhliI/eqg3NUlVaOW+q7CLyYLGe5eb1Zn3dxaa0
         Kp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=doB02I4qSIR86llAlGQe+kwodmbCH1lEdNRlPOZ7RJM=;
        b=V3XNW1qL7VKyUR1We2M9Tl2whL2FN9EYQHeapNSS0DhrADjCvRq/JB3EEChsuGHa99
         pcKaHwCxoSP9Eoh1L0r/I6Zn5LgejKIzU57cDeLYmDjBD1CJSFcQdsRjIBfMqL7Y8G+i
         i1Fytf6CIwZKIsLdmnsN+VtGuaHDqZsIjWEe8EaBlqW/9ucjO6mwal48U6ZV36TIM3eY
         OsnaiBDQs4W/oFIk75o8KOS5XALz8jKvAIsg0bInx1OCJRLRj4AZwMlVHAKyaUJN6j/T
         qB5yWVRIZL/tpURKKeGHS5Q3RhewvksaIcuwqJcJp3jVNNVdvUJXmn1Ogc/nT5F4u6OT
         0Neg==
X-Gm-Message-State: AOAM530iCzruZ+GhtM5EtfLTVGWd30kK6IzL95EDNid/6m2YdVGexh4I
        XB0xUfWnr/b9URTGx1Trsk//8Beo53iS
X-Google-Smtp-Source: ABdhPJyOhFP5FqSpeywDFHUbBXaMD2WR8iKvWmZKfzHPZowdZTykVxzzx6348bJ1lA6I9ZspUFBLUPDDOJ+n
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a81:a105:0:b0:2ca:287c:6cff with SMTP id
 00721157ae682-2ca287c6f46mr6115897b3.420.1643105747887; Tue, 25 Jan 2022
 02:15:47 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:22 +0800
In-Reply-To: <20220125101527.1812887-1-tzungbi@google.com>
Message-Id: <20220125101527.1812887-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20220125101527.1812887-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 1/6] platform/chrome: cros_ec: fix error handling in cros_ec_register()
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes cros_ec_register() doesn't unregister platform devices if
blocking_notifier_chain_register() fails.

Also uses the single exit path to handle the platform device
unregistration.

This fix depends on the fact that all the callers of cros_ec_register()
allocate zeroed memory.

Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_ec.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fc5aa1525d13..3aec890edd39 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -245,18 +245,16 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (IS_ERR(ec_dev->pd)) {
 			dev_err(ec_dev->dev,
 				"Failed to create CrOS PD platform device\n");
-			platform_device_unregister(ec_dev->ec);
-			return PTR_ERR(ec_dev->pd);
+			err = PTR_ERR(ec_dev->pd);
+			goto exit;
 		}
 	}
 
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		err = devm_of_platform_populate(dev);
 		if (err) {
-			platform_device_unregister(ec_dev->pd);
-			platform_device_unregister(ec_dev->ec);
 			dev_err(dev, "Failed to register sub-devices\n");
-			return err;
+			goto exit;
 		}
 	}
 
@@ -278,7 +276,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		err = blocking_notifier_chain_register(&ec_dev->event_notifier,
 						      &ec_dev->notifier_ready);
 		if (err)
-			return err;
+			goto exit;
 	}
 
 	dev_info(dev, "Chrome EC device registered\n");
@@ -291,6 +289,12 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		cros_ec_irq_thread(0, ec_dev);
 
 	return 0;
+exit:
+	if (ec_dev->pd && !IS_ERR(ec_dev->pd))
+		platform_device_unregister(ec_dev->pd);
+	if (ec_dev->ec && !IS_ERR(ec_dev->ec))
+		platform_device_unregister(ec_dev->ec);
+	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

