Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1D5A3070
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbiHZUY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiHZUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:24:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD42AF4BA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:24:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j26so1411194wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4DJawcmHJDXK/larmzbFcsxblDinNYvWhKtjvg3WYsE=;
        b=C7B1XHqI0ZcRrjTFImvAPSWeCO8mbIfY/NZVpVEp6lzTyKYL2Yj7ZGrrlfBlPkOWNr
         cyp8PMIKRM5QcNYagLSQjfv6T1hdE3Y1HSHn72kqlXuBGm5AuF2upRD+Ad4Uz3NhSAsX
         WLr/yusg1P1Nsf6CdFldkc+iKGRN7B7mgjUIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4DJawcmHJDXK/larmzbFcsxblDinNYvWhKtjvg3WYsE=;
        b=jRr8EI8vYkw4S900ZR6VLMDcCtoi2QH/BkKYJnb9ZPnFAxf7bohgye9EO+otHMeCrl
         ShD51tqMPIhkvs5g8z4DAmf6NL2U5KsYQ7RSF7zdfTqSPuO3RwliypLjjXyfhb/NlG9h
         nmRqbkS+bGTZtQ2TxmpRsEcoqcDwxgxvS44p33pe/W/Pi1i9XJtVQj9agVH7ZCfam/Jb
         7aYNyUJLtqIVBP7vHQXGt1U1YBOAOGGSUxmultpz09iECfnBbPSwxg2vR3nw3ICXghnf
         GhYRveAMgSSvYhiXz1t9nS8VESweUAn58bBL6DQtMbjwNCjHGQCLKR9Y56/RvRbRKEr7
         fmYA==
X-Gm-Message-State: ACgBeo1esRwuhXYy5W9mN5g+PrxIexu6K2aqawk7Vj5kVaUy6XtJlgvv
        QLA0+Yfeho4nOYyZEAaB0bqxsBEM7iNv8Uir
X-Google-Smtp-Source: AA6agR5lSHWPtslgy1PrFiq+dwYPQZfa4Tp3P/IFJZ2of8xR+KDJ1cZOwXfycvVbtaiWWg8JyvE75A==
X-Received: by 2002:a05:600c:350:b0:3a5:3473:1c23 with SMTP id u16-20020a05600c035000b003a534731c23mr664134wmd.9.1661545462136;
        Fri, 26 Aug 2022 13:24:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b002252ec781f7sm613713wrr.8.2022.08.26.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 13:24:21 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        nick black <dankamongmen@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] tty/vt: Remove printable variable
Date:   Fri, 26 Aug 2022 22:24:19 +0200
Message-Id: <20220826202419.198535-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Every since the 0.99.7A release when console_register() was introduced
it's become impossible to call vt_console_print (called
console_print() back then still) directly. Which means the
initialization issue this variable protected against is no more.

Give it a send off with style and let it rest in peace.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: nick black <dankamongmen@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Yangxi Xiang <xyangxi5@gmail.com>
Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/tty/vt/vt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ae9c926acd6f..4d29e4a17db7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -157,7 +157,6 @@ static void set_palette(struct vc_data *vc);
 
 #define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
 
-static int printable;		/* Is console ready for printing? */
 int default_utf8 = true;
 module_param(default_utf8, int, S_IRUGO | S_IWUSR);
 int global_cursor_default = -1;
@@ -3085,8 +3084,6 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 	int kmsg_console;
 
 	/* console busy or not yet initialized */
-	if (!printable)
-		return;
 	if (!spin_trylock(&printing_lock))
 		return;
 
@@ -3537,7 +3534,6 @@ static int __init con_init(void)
 	pr_info("Console: %s %s %dx%d\n",
 		vc->vc_can_do_color ? "colour" : "mono",
 		display_desc, vc->vc_cols, vc->vc_rows);
-	printable = 1;
 
 	console_unlock();
 
-- 
2.37.2

