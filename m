Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF1550937
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiFSHqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFSHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:46:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C98DFFF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:46:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z14so7649315pgh.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zi2hANL8Cm7Sp2/zSGWsY1GUGs9yZByfPb49/shxHgY=;
        b=jG2xBZ+NE3BZjnsis7BxycHNkJB3bsq48VKgMTNAQWh7rVo9O5VeA1xpSDSLLGkqx8
         zMZbRIMCWFDs52k3IfD5+JJpGCE3+GFu03qlVzB8tatOJIj0eG7KWsF5s5LQEZhwBpfD
         AiJu7Pywz11X7GQsLm2r3U+e1HUiSBhaDN2xJmFoDwz2eWREl94db0NDwOzXogiFQkw7
         UTDpDR4tNMK4YWSjDrxoKagtj1120IJe033jXCwvqzEpSvJYP3sqfscxNXZew+mUkmbf
         puMwyK91YUqZashhRcwzaY1e+Eggk/L+K1375tIUKoAUvuLOInY4xMMz6v1sPnNzcz86
         MP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zi2hANL8Cm7Sp2/zSGWsY1GUGs9yZByfPb49/shxHgY=;
        b=BdpJSZKPOtod23yoCOoU6n6wc+gmVU8JIDrhEu8T/ArMsQG3jN6EMK5F3uQFSY3MzC
         eTFinT27iS/09XBOdT3ect4QVGQf/yi3hm0SPRiUOU8tU5igoeIveJQsESKqX5jZy95z
         hYr27FgJrRnXyLhrBHXJxtZDVgZ840aKlKgstmF/aERtiyPPyGEhkwV0oe+mXYv2ZHCq
         okWA9a+ZSYDcqFHJetHhQiwz6rRNy7DlRP/RcWS3K1om57VQJAYop5bkNv27ODGJH4S/
         XIx6s5A1YzMm/U+EseHru9tt/MHJWm/xFP+SyFD6hxVbVCfglaMZ0yWCh128s+7PfKc+
         r+OA==
X-Gm-Message-State: AJIora9otG5gyq8gpMdOR77MyW4b35ZWVepmUlVVSlffcy+b9h9KVtV1
        DgUEhKtpoHS7iuDQGL8AsAoeEZn4loQ83u5u
X-Google-Smtp-Source: AGRyM1sjq+ZE7QFLvpSFQFinuHDQKolQFAp58KVFszl6r9tulU96WRHuTs8GJQJCEC4MsuE7uzkn/Q==
X-Received: by 2002:a63:6aca:0:b0:408:8af6:a885 with SMTP id f193-20020a636aca000000b004088af6a885mr16753190pgc.477.1655624806960;
        Sun, 19 Jun 2022 00:46:46 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id x6-20020a63aa46000000b003f24d67d226sm6652023pgo.92.2022.06.19.00.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 00:46:46 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net, lib/once: Remove {net_}get_random_once_wait macro
Date:   Sun, 19 Jun 2022 15:46:41 +0800
Message-Id: <20220619074641.40916-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO_ONCE(func, ...) will call func with spinlock which acquired by
spin_lock_irqsave in __do_once_start. But the get_random_once_wait
will sleep in get_random_bytes_wait -> wait_for_random_bytes.

Fortunately, there is no place to use {net_}get_random_once_wait,
so we could remove them simply.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 include/linux/net.h  | 2 --
 include/linux/once.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 12093f4db50c..8613772a1f58 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -303,8 +303,6 @@ do {									\
 
 #define net_get_random_once(buf, nbytes)			\
 	get_random_once((buf), (nbytes))
-#define net_get_random_once_wait(buf, nbytes)			\
-	get_random_once_wait((buf), (nbytes))
 
 /*
  * E.g. XFS meta- & log-data is in slab pages, or bcache meta
diff --git a/include/linux/once.h b/include/linux/once.h
index f54523052bbc..b14d8b309d52 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -54,7 +54,5 @@ void __do_once_done(bool *done, struct static_key_true *once_key,
 
 #define get_random_once(buf, nbytes)					     \
 	DO_ONCE(get_random_bytes, (buf), (nbytes))
-#define get_random_once_wait(buf, nbytes)                                    \
-	DO_ONCE(get_random_bytes_wait, (buf), (nbytes))                      \
 
 #endif /* _LINUX_ONCE_H */
-- 
2.20.1

