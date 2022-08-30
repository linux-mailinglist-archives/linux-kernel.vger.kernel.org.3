Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385645A655D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiH3Nph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiH3NpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:45:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8881A11C16A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:43:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so810384wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4DJawcmHJDXK/larmzbFcsxblDinNYvWhKtjvg3WYsE=;
        b=NezfSURzPSk6ZZckYTP5Ey/86r35sJ8o0R6U5GZ6U34lrn3+OwN1vMTPscLU25Kxlh
         iFif4+GWl6ROmPgoirU8vInFZiTAq4jiuNaj6hzDRRgxAX/gpgoTIva231WLIbNMlUYZ
         I8bvzWqjx6F5CDKnwTyhmX8kUDzLcrSyPHL1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4DJawcmHJDXK/larmzbFcsxblDinNYvWhKtjvg3WYsE=;
        b=gIYZCLPnIz49cCSXMXo7z5r6ro2gRccjCCz8xJCccDikujGV9YwtfxIBLKAqxrZyEQ
         TdcVgF+k9mUlU/DjOArxpN1OMkZSgFcwx2YIoYgmvoPowi22F1paoTIHmBKSe9sXWPCF
         X9T4bLQE3cOow8erbpgD4FPHp+0nV9eG4QzivNBj3CaGankFKDt8jPhUKdMOwZeh4l9w
         HXJaQDTsDLpr3vxeiVVr9Ez0sqtLnQvMCcohVIQ5ZvsULqajumQSC7nl0n0uNcF/aBEB
         Qoaz/3Y4rV58e/RcHQl6CCev5nb0kwrwURTfptI6PYDMLusDc3lfQES7OAmILmja5Vnr
         YPGw==
X-Gm-Message-State: ACgBeo0anZdqYuD0mKn8juTZ+LjzVVoIlNAbuEffbWBd3awt5mqR1sAg
        XFdhpRadLL66j/wHKqzlnQQgKn5XgCpdV+tM
X-Google-Smtp-Source: AA6agR42uGyLFvr7VwfI8PKUOEjVgy62XeoPV+pO67oUMX9x7WyQAogYCnLFV8idBlRmO3NhaooWRA==
X-Received: by 2002:a7b:c8c1:0:b0:3a5:bb57:e7a9 with SMTP id f1-20020a7bc8c1000000b003a5bb57e7a9mr9764114wml.18.1661866879992;
        Tue, 30 Aug 2022 06:41:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b003a8436e2a94sm8421146wmb.16.2022.08.30.06.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:41:19 -0700 (PDT)
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
Date:   Tue, 30 Aug 2022 15:41:17 +0200
Message-Id: <20220830134117.416003-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
References: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
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

