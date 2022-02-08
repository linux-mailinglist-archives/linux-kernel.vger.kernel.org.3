Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD944AE460
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386448AbiBHWaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386709AbiBHVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C9BC0612BD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i15so608674wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4crFuo44YkHTtsyu93ovw2eXFVSYs3TA5dMCqcACcfE=;
        b=jQi7DARCTOMXz5tC+EIC8+SSebNsfkWcI1vfAOcJgnkqRbrl9Gbw9DcNTrzkF5/AM4
         UoT9eQCdb6EjYX8w+Ub2a2EKqQNnkAABbTe0Xq0077w3volpOypc1EzJp4JNSjN1cszY
         SUvcPj044oQe627lpXmNgf2p1UJPbTY4Y4FlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4crFuo44YkHTtsyu93ovw2eXFVSYs3TA5dMCqcACcfE=;
        b=iteHe8FPUO8OIa0HPXDTF2AnUZlUNRots8biRR4gJghJUu65zkmje7v2YqgAILR71P
         XU6jb39T1pMDnujyWM7rpkLTdNf4+VzrDcdg5Uqb1MkhxegRFl2mVWuu6QHwNdYQaZpV
         cUf5iLdh6NQ+WIl0R0zX0BDrZUT5Mab+JwDzWtUhPXqzApR6KRwqTX3HyShx2GavXedM
         Od6vLKjT1MFqc3O/A3lKeR7367mHC6FnoQ8E/sPQsJF0hcx0nytKsmlr0Wv4k8qrKu/T
         hOMNZOXR9i1m8CZUI2zNtM3gfhg7LkMUl5uxFmWM6K1xovuU0hlIQZk82NL9jHEqy802
         7Nww==
X-Gm-Message-State: AOAM532DZVSFJGR+mru4/Ig0YjM5ZkSt6e9JMGMiY3QGSncfGn3MTdIE
        UY4uIfR+a7p7LlbVkJUFrp3s2g==
X-Google-Smtp-Source: ABdhPJxyfY2skHNX0EzH+SvK1Ftr+4E95xGCkY+AUHxfLXuaNP8ZqaFebSt7JML9HJcvQyhPEOh1kA==
X-Received: by 2002:a5d:6da8:: with SMTP id u8mr5134612wrs.362.1644354514804;
        Tue, 08 Feb 2022 13:08:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:34 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Du Cheng <ducheng2@gmail.com>
Subject: [PATCH v2 04/19] fbcon: delete delayed loading code
Date:   Tue,  8 Feb 2022 22:08:09 +0100
Message-Id: <20220208210824.2238981-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

it was possible to load fbcon and fbdev drivers in any order, which
means that fbcon init had to handle the case where fbdev drivers where
already registered.

This is no longer possible, hence delete that code.

Note that the exit case is a bit more complex and will be done in a
separate patch.

Since I had to audit the entire fbcon load code I also spotted a wrong
function name in a comment in fbcon_startup(), which this patch also
fixes.

v2: Explain why we also fix the comment (Sam)

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Du Cheng <ducheng2@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b75e638cb83d..83f0223f5333 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -944,7 +944,7 @@ static const char *fbcon_startup(void)
 		return display_desc;
 	/*
 	 * Instead of blindly using registered_fb[0], we use info_idx, set by
-	 * fb_console_init();
+	 * fbcon_fb_registered();
 	 */
 	info = registered_fb[info_idx];
 	if (!info)
@@ -3299,17 +3299,6 @@ static void fbcon_start(void)
 		return;
 	}
 #endif
-
-	if (num_registered_fb) {
-		int i;
-
-		for_each_registered_fb(i) {
-			info_idx = i;
-			break;
-		}
-
-		do_fbcon_takeover(0);
-	}
 }
 
 static void fbcon_exit(void)
-- 
2.34.1

