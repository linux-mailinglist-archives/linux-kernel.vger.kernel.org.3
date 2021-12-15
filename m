Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718247598B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhLONVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhLONVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:21:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:21:17 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id l18so15457167pgj.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Vi+9tkKMEGtdz8FnRinsSQljBeYWvCw1bcC5u2KAYc4=;
        b=SEemoU84w0RgZzOfkNVYreTtLSrP07EazxLkoOy/SUea3f4t+beB0FHazSF4XBL1YJ
         t6DIjGGP0iKNY4wBpu47PliUokbkJv22i/KSKWX5ZE3HKLmhLlhrpZWQ2i3QCbIS1sow
         8AEvWsAVh7IgeWsGjj69c9pngYl6d/nQIUdmctAqaHZ+jub/8bsmS29YdZc1W8J2dkYN
         6lKClvTMJ2klr4802Wmc6TMEsnPYslPyHRTkeMgqJoz6VzGOS2o/sunV9u5xWj+EGKR8
         r/Up5u2yjduZ0fxJFxEC/BMR+niTyuDc/N0IqlPM3Zy4m/26ah2jcoEElrT6cMewRQ1B
         sihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vi+9tkKMEGtdz8FnRinsSQljBeYWvCw1bcC5u2KAYc4=;
        b=mP9Ss+eIHuqpeGIqMLgFH5tI+74Hq+8sde4dKqAOIu5KIWgHlkrgaaWTkP8OiCDDsX
         Ha37Aq6KKkSV7wsaXmzuWGEadG3YPaAYN94FQS3jsF1oiTSCL6NaiOs7IoHvzczKbf7o
         DF1RbVRHn6Guphvf+sM25gAkc5PzCt9OOZvqMoUGb5hDYKf+rpFVst5xiKAjPr2BUxGq
         KYcH44EBJk6RY1dhi98XVvInFS+tKAOk1RD6e9qdKWtrm//jQPLjSDy99q0TSSocFe6C
         rRNmmrMYCeXIgGKT6/ZOW81He8G4ZGyzH6lPnQ/wHSzcVO5lp7GwYWURPDvaG04fpKLA
         +geQ==
X-Gm-Message-State: AOAM531wkwDno4yQA+G7575LQZA1Mz+7S6XREjbpmNbp99K6ApRloTz3
        Un/djayqwkg6Vv3zrnjVCC4=
X-Google-Smtp-Source: ABdhPJyf97EO6xzPbv6JA17GV+bOgjYwhSDz5csdkt1ya66pwl/z/pA9zRqk1fiPRX+Pm12GpQ3QKA==
X-Received: by 2002:a63:5c0a:: with SMTP id q10mr7683052pgb.213.1639574476985;
        Wed, 15 Dec 2021 05:21:16 -0800 (PST)
Received: from localhost.localdomain ([117.254.32.175])
        by smtp.googlemail.com with ESMTPSA id s8sm2561141pfe.196.2021.12.15.05.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:21:16 -0800 (PST)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] binder: use proper cacheflush header file
Date:   Wed, 15 Dec 2021 18:50:18 +0530
Message-Id: <20211215132018.31522-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder.c uses <asm/cacheflush.h> instead of <linux/cacheflush.h>.
Hence change cacheflush header file to proper one.

This change also avoid warning from checkpatch that shown below:
WARNING: Use #include <linux/cacheflush.h> instead of <asm/cacheflush.h>

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cffbe57a8e08..446ed306d313 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -69,7 +69,7 @@
 
 #include <uapi/linux/android/binder.h>
 
-#include <asm/cacheflush.h>
+#include <linux/cacheflush.h>
 
 #include "binder_internal.h"
 #include "binder_trace.h"
-- 
2.17.1

