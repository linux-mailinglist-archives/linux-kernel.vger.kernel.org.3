Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C725A5AC7C1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiIDVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiIDVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:45:23 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D2C30F53
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:43:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l16so3889318ilj.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=enn6xVuYphe+hXVPoV5iWIYr1g8ASji6MTEr9zuj34c=;
        b=MHZ+j5vq+DgcrRYUNssA/mQhOIh3IuE7Zq+aUJb41YdzWZC9PSDSIhOvEQ3TdCICX5
         WTCvmLp7RobRHWpiQpug9Ise55wiJ4uYADB3QCMYatUnEHE8Jziwms0gNLdJzSy1SzKa
         weVrPvvMaJPWqT6SfVFtUwOQv+sOyCuhrhi/oJW7xApjkbYa3ldckzG68imOVm76KV+m
         Xwjrlq1ZQVkjBcKsJbOYdKGeSdp/d/LglobU+D8HgN3Kz9AvMJF9xfzvrS0x23RcYOMb
         o7tMHOwXqEMULGc4tCi168zLZkAoPrmdiBkQzY7FRbs0xD1GH/Ij8ZhWMXzT0upfwrl7
         rC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=enn6xVuYphe+hXVPoV5iWIYr1g8ASji6MTEr9zuj34c=;
        b=voXIalhND1PVrKyliNAGLhRCZqP1dIgxSarh4mUzBCyLdtsXCMLswyBoKGL4ndY18M
         odM++oA1qwZy4SdTsxPhjsswg4Q8UgNrZO4d8jJ4RxST6oMNXBpuj/65YQe1kh5Ix2Od
         xx5OQKJ/u6HFvmdPJAsNiH8CRZslWnXwpAZ9WfljMyeoItD540VT6XQ6IX+I8Hi94GSv
         FUMoOqANSS5DAX40lKkjB4gUfVRjmPu77hl6TthykFoUi3C8FbxYIQ/cYSLp3xJwhid2
         pZmMXDOHYywtcQh6vPWth3VfkPtIvqzPWKNwp/YLVcla45eZVMfoM+O7rkDTBCC+y42i
         UC6Q==
X-Gm-Message-State: ACgBeo2PyjGfnFkco54p39BtQGF2zqNc6pS/sGp5/fy8eP/oHe8EO38z
        0qvUvzwl8lE2KfmvT22SbAQ=
X-Google-Smtp-Source: AA6agR5YpuT8Q9JQCumSZI1qIIDzfmGUPYBDoLNXJiZ6x9bW2LfTNC3WN5DzbhXOp2lE4bQ4o8fKCA==
X-Received: by 2002:a05:6e02:1605:b0:2ed:be80:59ae with SMTP id t5-20020a056e02160500b002edbe8059aemr7558764ilu.319.1662327783877;
        Sun, 04 Sep 2022 14:43:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:43:03 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 56/57] dyndbg: work ddebug_map_site
Date:   Sun,  4 Sep 2022 15:41:33 -0600
Message-Id: <20220904214134.408619-57-jim.cromie@gmail.com>
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

attempt container-of, broken, missing use of uplink... took that out.

ptr computations are naive, and wrong.

Deeper prob is lack of _ddebug_vec, with header and descs in same struct.
maybe.

builtin_state looks right in debugger
---
 lib/dynamic_debug.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 194367bc13fb..11fea1f818a7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -173,8 +173,25 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-static inline struct _ddebug_site * _ddebug_map_site(const struct _ddebug *desc)
+/*
+ * mapping from desc to site is multi-step:
+ * - _index back to &descs[0]
+ * - container-of to get header struct above
+ * - ._uplink field, pointing to _ddebug_info (for builtins, loadables)
+ * - di->sites[desc->_map]
+ */
+static struct _ddebug_site * _ddebug_map_site(const struct _ddebug *desc)
 {
+	struct _ddebug_info *di;
+	struct _ddebug const *d0 = desc - desc->_index * sizeof(struct _ddebug);
+
+	di = (struct _ddebug_info *) d0;
+
+	v3pr_info("map_site idx:%d map:%d %s.%s  di:%px site:%px ds:%px\n",
+		  desc->_index, desc->_map,
+		  desc->site->_modname, desc->site->_function,
+		  di, desc->site, &di->sites[desc->_map]);
+
 	return desc->site;
 }
 #define _desc_field(desc, _fld)	(desc ? (_ddebug_map_site(desc)->_fld) : "_na_")
@@ -866,7 +883,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	return buf;
 }
 
-static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
+char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
 	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
 		return __dynamic_emit_prefix(desc, buf);
-- 
2.37.2

