Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4A57BD29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiGTRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGTRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:48:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9852DF8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:48:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x91so24754668ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SZl3qX0LM9cd6eczZTP4tcvjVJ6Givuz0Tqtszlu9H0=;
        b=U13Jza77l6NjL8EvG5WCVxr3nyVQcvJyxXj8Z4nVZMj09m2X/+ACIxCRdKj4DW12uR
         UGubrBdXaBqXs1FkU7FGZJvt4qrqDXFCBgHEF/GQpJZ3MZ2yqZnt/mw7twUCVF7hBb9K
         iYzxl7FKWOVd9VdAgTXT39tVVyfN045T6UdO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SZl3qX0LM9cd6eczZTP4tcvjVJ6Givuz0Tqtszlu9H0=;
        b=NyBP8nyXy1va4eVtqmH8R9Hq86PHdCQU7sPxHslfaKFbN+ow3QLeDL3jYNIkm8GUNB
         NQS3T7ihQ+zJLqjbnXdNKBi2e4V54wEeY3w92XebIgjLQhOmD/M3/Sqc/LxOjgN+1vov
         IPTtG4lb8RVA1LigMW8LB2tTEUOPlTBnxT0qGrO3jXI2Oh31Tue75w2abWJC6WSzloBc
         mUHOkb4kydzPuMyQbOv3n5xfL4/GGEOWcLQYGG+MxsKtfUWlpnpz+7WT5dfaHyDRY4Wk
         f3SjftyAWPH1x76dkd9mVHu4/e5g4trzm+vX/61vHidlxhk8tCTOSZsjdsRbj+/E1spZ
         iF3Q==
X-Gm-Message-State: AJIora+brR+eTOZsDHXdVDxJGx1hFIFxBNwXVbi7Tmx7TKtVs7aqZgfq
        y+qHwdV56cKfKjL8AhJuP5Ijt/yBg+rpQQ==
X-Google-Smtp-Source: AGRyM1tB9bsQQyqjf8NKoKr2D5bj1ypFQHJvRSBpdPoNp913zxjGBj1fm/UQnXJDZSQiD0TDhMDR1w==
X-Received: by 2002:a05:6402:354c:b0:43a:dc59:657 with SMTP id f12-20020a056402354c00b0043adc590657mr51070822edd.405.1658339292807;
        Wed, 20 Jul 2022 10:48:12 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:d58e])
        by smtp.gmail.com with ESMTPSA id lx23-20020a170906af1700b0072b11cb485asm8036351ejb.208.2022.07.20.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:48:12 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:48:11 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v3 1/2] printk: console: Create console= parser that supports
 named options
Message-ID: <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658339046.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in the next patch, and for future changes like the
proposed sync/nothread named options. This avoids having to use sigils
like "/" to get different semantic meaning for different parts of the
option string, and helps to make things more human readable and
easily extensible.

There are no functional changes for existing console= users.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/printk/printk.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b49c6ff6dca0..6094f773ad4a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2368,6 +2368,30 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
+static void parse_console_cmdline_options(struct console_cmdline *c,
+					  char *options)
+{
+	bool seen_serial_opts = false;
+	char *key;
+
+	while ((key = strsep(&options, ",")) != NULL) {
+		char *value;
+
+		value = strchr(key, ':');
+		if (value)
+			*(value++) = '\0';
+
+		if (!seen_serial_opts && isdigit(key[0]) && !value) {
+			seen_serial_opts = true;
+			c->options = key;
+			continue;
+		}
+
+		pr_err("ignoring invalid console option: '%s%s%s'\n", key,
+		       value ? ":" : "", value ?: "");
+	}
+}
+
 static int __add_preferred_console(char *name, int idx, char *options,
 				   char *brl_options, bool user_specified)
 {
@@ -2393,7 +2417,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	if (!brl_options)
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
-	c->options = options;
+	parse_console_cmdline_options(c, options);
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
 
-- 
2.37.1

