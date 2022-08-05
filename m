Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE058B176
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbiHEVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiHEVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9FE0D4;
        Fri,  5 Aug 2022 14:54:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e69so2855970iof.5;
        Fri, 05 Aug 2022 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dW/qowRKwpSX+eB9zQgpcFjLzbW7/9zpGPg2Go1FHeI=;
        b=pQqact85NoRb+xtdb4neqHJ2MSf9lwR+gCDz0zUVVjYSEELKbLwImAE6CSqgl+Q4XM
         /dOHKlBwUpeC9a8Kj6oBimwhLi3DHsK4O7zQm0pwLrcX3ZopEjW6HZIbh6YyUFVaafZr
         5szL5MQBQwSMH6R3xf437A6KKteGEzAGGiy7gbo8AlKfmlJRbUz1IBy9CwCiAbuPknfT
         e4D/JLSz4pesGI29pQZJh6dO5qlsWwfDg/FTM/7hrS1PjqPn4Ghoe084pBnGzOmJ/PYX
         0xmtTY4hBf2zQIPotw1GI23q+epE7LZx9a7RP/txZjlmC6Ra0OXTYFDlot7BqDZmDYEk
         VVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dW/qowRKwpSX+eB9zQgpcFjLzbW7/9zpGPg2Go1FHeI=;
        b=6wpuIIU7p1h9wI3qdptFuf+g7dfZmKDiPt2UrPzD47mcsdyCTIWRBTub6IjLzfXJPO
         v6EEDSikl4A8jcMMJ77Ra65GndIoqQynKjQaLwB5xEv5LRwepPrTOZYvbTkZu2g7sJ7j
         frX4J9vjcA9xjWVumhQIyZVZw6NsQcaW81EiL9HRHec69AlXa3wApU+zC7oFutTXbBb3
         k4RXqcS2sBdWwkIlct97c5zwZrsyQKCFZj8Gu+P3unG4mRw/vwQWGIaaHLXQ3FZ2i7VA
         WV5QtKcrAYnTBHqvoK5WydojHsDWSeQfHjCR7hZaNJMB9O8Z2UDiwR4kZv0IyTAo42/o
         iJLQ==
X-Gm-Message-State: ACgBeo1qj6pOyKr0KJ0ebqQX4Cj7k4A27oKPD3u2jXHVVrWjAwNVP/F7
        Ne4wm/EuhI2gV/ZYYX1g8t64VXEULR01hw==
X-Google-Smtp-Source: AA6agR6g0h/uRqkZBCEfyjVwXC4v1QUrTS31if9Ucl65W+giIN8r0CzRcZcoL+STwGJBx/6L7Fqtaw==
X-Received: by 2002:a05:6638:3792:b0:342:b241:13c2 with SMTP id w18-20020a056638379200b00342b24113c2mr3231037jal.257.1659736454304;
        Fri, 05 Aug 2022 14:54:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 02/33] dyndbg: fix module.dyndbg handling
Date:   Fri,  5 Aug 2022 15:53:24 -0600
Message-Id: <20220805215355.3509287-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

For CONFIG_DYNAMIC_DEBUG=N, the ddebug_dyndbg_module_param_cb()
stub-fn is too permissive:

bash-5.1# modprobe drm JUNKdyndbg
bash-5.1# modprobe drm dyndbgJUNK
[   42.933220] dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds
[   42.937484] ACPI: bus type drm_connector registered

This caused no ill effects, because unknown parameters are either
ignored by default with an "unknown parameter" warning, or ignored
because dyndbg allows its no-effect use on non-dyndbg builds.

But since the code has an explicit feedback message, it should be
issued accurately.  Fix with strcmp for exact param-name match.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: b48420c1d301 dynamic_debug: make dynamic-debug work for module initialization
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..f30b01aa9fa4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -201,7 +201,7 @@ static inline int ddebug_remove_module(const char *mod)
 static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 						const char *modname)
 {
-	if (strstr(param, "dyndbg")) {
+	if (!strcmp(param, "dyndbg")) {
 		/* avoid pr_warn(), which wants pr_fmt() fully defined */
 		printk(KERN_WARNING "dyndbg param is supported only in "
 			"CONFIG_DYNAMIC_DEBUG builds\n");
-- 
2.37.1

