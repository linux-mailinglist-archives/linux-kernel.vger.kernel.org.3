Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C517E58B1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiHEV4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiHEVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:03 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178E7B79F;
        Fri,  5 Aug 2022 14:54:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o2so2848774iof.8;
        Fri, 05 Aug 2022 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T7Gv4hwZzTdpj2N7T4svMFG77jA8WU8rV9TsGh2u6B0=;
        b=DjCGd7nja7GLoKs/YEi+AypGd/X5RUZGGqxDmaVd6Ctsnq6XlGUVNUtvQyQJ/w8ejL
         pZ7HppMOc0bnl8TstfhIQgOAyWPXRR+4KnI/LumnfLg5LQ2p7ucvrwj3RD3UE6Nqy/l8
         65NtEWs5YCTXHe58FpUirbUlfw69LWASsPbeV2MQZXNhwNO7rDaZEDU2eS3I1W6qvAJn
         kaBxgCvuGWYxhtv44ILt5Ei88UZauIudeV3qaEOW7BcnWe0lp5cwMuja93PlcWYM9p4u
         PGvF3xS9gVgb4jDLgtRqZyQpMz+4eB9SSWkfPHFL6dfZ8OD5XWLDteNzMQg8vIKXGYfj
         hH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T7Gv4hwZzTdpj2N7T4svMFG77jA8WU8rV9TsGh2u6B0=;
        b=kHIavjf0GCXxRgB8L8WypmiD+gYHzqOeiq8gYQm/DplByvyi9I8pp/ptje5O9ivznj
         1xJCs/HMS3r4Leb0kt/rYf8LAIZGNG1NgiF/b0VU71T4QwXkvYfACpkCiZb22jVLDaOV
         3r+hxbm6FtzMQXF9jxI2qL00u5WFn66BkVVf2EY8FcvIxRHeqhVuQcpegR+uoDJPhOqM
         7CMTEX3ovOjX2D/osq0HryW/PRPi0yjUz7Ib84O5zdfC0E4ENL4ChDXhse20kzRN5PjH
         A7qsUlPolxHpTTCFPd9u4p8Jmc4lGPIClWupfgTIPIQQnfqProwqQIrXBPmaNAAnQSRT
         aPSw==
X-Gm-Message-State: ACgBeo2YRcHWA6xOjSruVwjtgozslmZBu6dBVEhChlu08bjs6R4R8H2f
        l3xqAS2iJE3lrSihuXIuuIWylCWTo4TGYg==
X-Google-Smtp-Source: AA6agR6ZuhPO2oFawvVRsW7GJ9C/KsGqggvTjGHRxhiW0IA8Nx9Nnyq3ipyOdpphdUyK/Rp71ztUcA==
X-Received: by 2002:a05:6638:300e:b0:335:c73c:3d25 with SMTP id r14-20020a056638300e00b00335c73c3d25mr3886676jak.77.1659736476898;
        Fri, 05 Aug 2022 14:54:36 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 15/33] kernel/module: add __dyndbg_classes section
Date:   Fri,  5 Aug 2022 15:53:37 -0600
Message-Id: <20220805215355.3509287-16-jim.cromie@gmail.com>
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

Add __dyndbg_classes section, using __dyndbg as a model. Use it:

vmlinux.lds.h:

KEEP the new section, which also silences orphan section warning on
loadable modules.  Add (__start_/__stop_)__dyndbg_classes linker
symbols for the c externs (below).

kernel/module/main.c:
- fill new fields in find_module_sections(), using section_objs()
- extend callchain prototypes
  to pass classes, length
  load_module(): pass new info to dynamic_debug_setup()
  dynamic_debug_setup(): new params, pass through to ddebug_add_module()

dynamic_debug.c:
- add externs to the linker symbols.

ddebug_add_module():
- It currently builds a debug_table, and *will* find and attach classes.

dynamic_debug_init():
- add class fields to the _ddebug_info cursor var: di.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 3 +++
 include/linux/dynamic_debug.h     | 2 ++
 kernel/module/main.c              | 2 ++
 lib/dynamic_debug.c               | 7 +++++++
 4 files changed, 14 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7515a465ec03..9b8bd5504ad9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -345,6 +345,9 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
+	__start___dyndbg_classes = .;					\
+	KEEP(*(__dyndbg_classes))					\
+	__stop___dyndbg_classes = .;					\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 71cdc8612257..46ed10682e87 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -115,7 +115,9 @@ struct ddebug_class_map {
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
+	struct ddebug_class_map *classes;
 	unsigned int num_descs;
+	unsigned int num_classes;
 };
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index cfe10356793d..f68f331c867d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2095,6 +2095,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 	info->dyndbg.descs = section_objs(info, "__dyndbg",
 					sizeof(*info->dyndbg.descs), &info->dyndbg.num_descs);
+	info->dyndbg.classes = section_objs(info, "__dyndbg_classes",
+					sizeof(*info->dyndbg.classes), &info->dyndbg.num_classes);
 
 	return 0;
 }
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 457ce936191a..0d6cb6b258bd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -41,6 +41,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct ddebug_class_map __start___dyndbg_classes[];
+extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -1079,7 +1081,9 @@ static int __init dynamic_debug_init(void)
 
 	struct _ddebug_info di = {
 		.descs = __start___dyndbg,
+		.classes = __start___dyndbg_classes,
 		.num_descs = __stop___dyndbg - __start___dyndbg,
+		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
 	};
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
@@ -1122,6 +1126,9 @@ static int __init dynamic_debug_init(void)
 		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((i * sizeof(struct _ddebug)) >> 10));
 
+	if (di.num_classes)
+		v2pr_info("  %d builtin ddebug class-maps\n", di.num_classes);
+
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
 	 * While this has already been done for known boot params, it
-- 
2.37.1

