Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F55AC721
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiIDVpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiIDVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:38 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB88D2FFCA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e7so3873263ilc.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TAwV35ZWZLIKqOElwfkhFfIbRXseVOLIKBiUUUQjUVQ=;
        b=YQSF24Us+VgO6MmkwBVVohgShZMcax7Tlk2S3GvdeKpX8+kDOiSv3UtwHdryBa/MfZ
         MVJvIEFu2ceZYdrJvC7LCgaG6cEGWWOo9rPDcMnnD+bMW23GiPRN5wZw8EBRiwT0rE4D
         tyIORau8tjxdkTvurYsJa1KKbPC7Xw24bYyvtnAHFUTaVJyVUi4XMOenzHqGO8vAeZLz
         IykguT8g4g+lANiwbVQH2BC/Z9FWb7/vEYDvWbQ9K6c9NLNB3P6ZPkHEEo1aJnLu/3DP
         so/ytamyrgwlaVUiFuKwgSUCvGgReaF3szmlQpVggMMm6ySVIhuDBYvRb9VRu2wy021f
         mxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TAwV35ZWZLIKqOElwfkhFfIbRXseVOLIKBiUUUQjUVQ=;
        b=LLoLBCZYSXj7jmUM8N0TfwgUEECHRE5mCehEL4q7xaONnziZnReAyFWv5Ie3Mh3kz3
         dliB7NjSLFPXGvaPsJMdQ+yXlWAXEYYpDXOpCc+uWnXYFVbp5lAEmS6eleKZDe1fW7gq
         yWOYzjZ8naLyTOWIltsb62o7azz/uPVSNGTh9sEiVgQqva37/O2HOGtDk/IHIE5SMqsR
         1oUy8aUTgtNRY4JlkUjRpwOkrBPMZEeHGZz3yxodwe8MP/pd7AIkZChsZmcM8WRVBQ0c
         pWbXogc81bu4YFuc4KCBRS6rzzjwWkPM6oyQ0bM1WOUSMmMN3fDcHe3pCZyqFWi8PhDy
         ZHhQ==
X-Gm-Message-State: ACgBeo39gCeZaXcI3uuH6P33FY7TvK59rUpkGVQSoxrkAiz0VYhUDvev
        FQL24vT8JQV+aFG8FDOxa00=
X-Google-Smtp-Source: AA6agR5dlZ+2mbjYaiVo07B1ri+ETbudxxDzknKKyObWsKY9ZVDTd1RmO8d48xns2r12tpVnSs9bbw==
X-Received: by 2002:a05:6e02:12ed:b0:2eb:753e:cfb with SMTP id l13-20020a056e0212ed00b002eb753e0cfbmr12322927iln.14.1662327763512;
        Sun, 04 Sep 2022 14:42:43 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:43 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>, vincent.whitchurch@axis.com
Subject: [PATCH v6 35/57] dyndbg: add _DPRINTK_FLAGS_TRACE
Date:   Sun,  4 Sep 2022 15:41:12 -0600
Message-Id: <20220904214134.408619-36-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ecd3379090c4..04f49df308a7 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -42,7 +42,9 @@ struct _ddebug {
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
+#define _DPRINTK_FLAGS_TRACE		(1 << 5)
+#define _DPRINTK_FLAGS_ENABLED		(_DPRINTK_FLAGS_PRINTK | \
+					 _DPRINTK_FLAGS_TRACE)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
-- 
2.37.2

