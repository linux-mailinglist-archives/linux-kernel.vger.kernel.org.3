Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D64840F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiADLfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiADLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:35:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421BC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:35:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so2820314pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1DGzBL1UAoUhku6PkAfehlR1NmuvOe9coYqLYbCZAU=;
        b=BMo1G/okIcIn2fwT5PHfNlITTD9hL9LKTVcMNmlhBPEKpBiTy4q9xYpn6odb7/VihE
         TiaSe7QfV2/4JSVablNaRI7ECNjR+wY6ErLdRGDxpsoNlDZAMN84XAi3B+lxT7df4wuw
         VfxQF0yFdZ9x7Es09Yjwx8qQcXE63YrlmVzKSZd2QwhZZegIp40RbHZ/kOUbp2QvDwtt
         HFWQAmYA1KT4L2B1br88r/78HtzbvUBHIfSrNU6fzoD8eDEkVPb3FvGHfvO4AoKFDdj7
         uwL+Jx1ap5xoGHzR7olIScYZeniq3+rzNE2eMiZIgyU1s/gHwVwpKBAJ4bArX2dltgGD
         TZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1DGzBL1UAoUhku6PkAfehlR1NmuvOe9coYqLYbCZAU=;
        b=z7haZNDiFw6dDlT+Lk9i7RQ7Oz5e3H/K04GiwzNOlilf9CXRJ9oPemktNMcCSM+KgB
         ZhBUJkwAcwGF3GfCGpP41EQKpATtmh4jHi5KbTNhgtdFriPhsMbND/APR50DqG4GTICV
         +qTcH5L1q8PAIFlsfolf1GAlYpiLx/YOsONRsGygC6egsx11AnD5Z21gTfcgtfAhKFw3
         0QK/RMCJnxVhSBtfJcoiOTnvH6r+6Pq/MY/OUJGhhF+zpNzTceGYk6UqCafRMhmRJiiV
         cdI5oODo2zbYdT64iOgErNWlTMQeXrZxYZsh/SwrUGVbAc45MPZ++J0KaAzHIbOJ1Fx1
         VNkw==
X-Gm-Message-State: AOAM530x0ID0Csssq3vuTr3d6mWGjnTVsbzKj0tqAfK8oFR1MHaJ6F2q
        +a0RDzNNwGSJwvBY1OCUEdn34EwgJTQ=
X-Google-Smtp-Source: ABdhPJyCT1pXJ/FWoVfC+7MovOkPwlAXhvMAH7dhw79wyuFOJCRj5/0OGHXFdtqa9UuSBMRz50kSsQ==
X-Received: by 2002:a17:902:b08b:b0:149:88bb:b477 with SMTP id p11-20020a170902b08b00b0014988bbb477mr34001657plr.137.1641296104831;
        Tue, 04 Jan 2022 03:35:04 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f10sm46617824pfj.145.2022.01.04.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:35:04 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/android: remove redundant ret variable
Date:   Tue,  4 Jan 2022 11:35:00 +0000
Message-Id: <20220104113500.602158-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from list_lru_count() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/android/binder_alloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 340515f54498..4f221d1839f4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1049,18 +1049,14 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 static unsigned long
 binder_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	unsigned long ret = list_lru_count(&binder_alloc_lru);
-	return ret;
+	return list_lru_count(&binder_alloc_lru);
 }
 
 static unsigned long
 binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	unsigned long ret;
-
-	ret = list_lru_walk(&binder_alloc_lru, binder_alloc_free_page,
+	return list_lru_walk(&binder_alloc_lru, binder_alloc_free_page,
 			    NULL, sc->nr_to_scan);
-	return ret;
 }
 
 static struct shrinker binder_shrinker = {
-- 
2.25.1

