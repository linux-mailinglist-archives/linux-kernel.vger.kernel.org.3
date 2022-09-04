Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3105AC7C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiIDVpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiIDVoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E561303F8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p187so5653100iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NJv9roPGKnaMDb9Znbql4uMkywSuYywvt+PY8YTJJ6Q=;
        b=HhTTMF5cOvfQxdSZmrczdsrS6DcF+dXJ4prb+yfBwfEsbsV/l8CegD6fvYMQv45pnL
         Lf3KTZjPRQvn2olpOHp+kmaJ4oJHgCOfWsY3FUgvHVffh1+zc352thh9xXYlfcfH2jPd
         WHUvSV9qo/7iWc+93e5dgxNXp0BN7YD7iPq5mLd4Lp375zL2U7/g25FtP4jW0poI3Xy1
         BVe/2TTcrNFKPS3ucVYZJTTlomYi+IjWKzHykbLWJSIGsDYsRKCTeZerO4ouyzRs9apT
         ceUwHG+xksDXgJwO4SLD6ULb2vBG1qGluX6Fx9greabj7IG3dRz5uT820IrbROFlv4PW
         vTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NJv9roPGKnaMDb9Znbql4uMkywSuYywvt+PY8YTJJ6Q=;
        b=HqO74xy7VObjPWt0TOPO8AjwSrLcuwQOmbrJXskySc2jcCX2Cw0QnuGOYwlkXXv4Qo
         0R/cfidQXokdQNTgqgtaS0ruNai7W8FLRMz6enNVNIPUfXEYwyhIQyGj+CTvoX9exIvn
         BlIbNzEZttCXCWGXt7+0lrvw/v8JLKBbFgRrhqjXpgS03H+hAsEltri6fbwb1ckcNCTB
         L9aDpEWJV+jCsFQhFnzbXIjMjEeXs2GmdUFbaLWzv99KtAnDDuSj5BplfFKVo43/UxGV
         rtBuLrO+Mhw3rxRtCDZ3mUHMb5yKanRz0ZFX+YXuotckg+tz9FT8NZNwVBcrpCutn6Py
         L2kA==
X-Gm-Message-State: ACgBeo0Wk3JsX/k5PnLbdUJWyN16Dobg5J11BIndbSwXhQwWBmZBq1yO
        Ut/ERZJxNNzbc4Cc7g7xe+g=
X-Google-Smtp-Source: AA6agR4MY52KR1Bw1Ot+iK3sIpDRwZTCG1xc7RrkCdtaGzSPJBBL/OV4txxLoofl2HiIy/rTScLO/A==
X-Received: by 2002:a6b:1543:0:b0:688:6fcb:fa76 with SMTP id 64-20020a6b1543000000b006886fcbfa76mr21261370iov.60.1662327771514;
        Sun, 04 Sep 2022 14:42:51 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 43/57] dyndbg: add _index,_map to struct _ddebug
Date:   Sun,  4 Sep 2022 15:41:20 -0600
Message-Id: <20220904214134.408619-44-jim.cromie@gmail.com>
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

We now have 2 vectors of data: (__dyndbg, __dyndbg_sites), known to be
equal-length, with _ddebug.site connecting them, like rungs on a
ladder.  In order to drop _ddebug.site, we need to replace the
absolute ptr with a cheap relative-address computation:

   struct _ddebug_site *site = _ddebug_map_site(desc);

1st step: (done here)

add ._index, ._map fields, and initialize them in __debug_add_module()
to N (and = each other), where N is each element's position in the
builtins (or loaded-module).  Then _ddebug_map_site(desc) can compute
&descs[0], and then use container_of() to go up 1 struct.

RFC: Next steps: (outlined here, not done):

1. UPLINK:

Define 2 new header structs, with _uplink fields, pointing at _ddebug_info:

struct _ddebug_site_hdr {
       union {
       	     struct _ddebug_info _uplink*;
	     struct _ddebug_site __;  // sizeof this
	};
};

struct _ddebug_hdr {
       union {
       	     struct _ddebug_info _uplink*;
	     struct _ddebug __;  // sizeof this
	};
};

the union forces the allocation to be the bigger of the 2, with the
expectation that the pointer will always fit.

2. Reserve a record in front of the __dyndbg* sections.

can be done in {module,vmlinux}.lds.h, something like:

SECTIONS {
__dyndbg_sites : ALIGN(8) { *(.gnu.linkonce.dyndbg_site) *(__dyndbg_sites) }
__dyndbg       : ALIGN(8) { *(.gnu.linkonce.dyndbg)      *(__dyndbg) }
}
KEEP( *(.gnu.linkonce.__dyndbg_site) *(__dyndbg_sites))

3. specialize DYNAMIC_DEBUG_METADATA_CLS as DYNAMIC_DEBUG_TABLE.

This special macro version creates header records, and puts them into
.gnu.linkonce section.  Unusually (uniquely?), it is tacitly invoked
by dynamic_debug.h on behalf of all printk.h includers.  This can
result in multiple "declarations" in the same scope, so macro uses
__weak and/or __unused to suppress linkage & errors.

This created mumble-RELATIVE linkage errors in a few parts of the
kernel, I worked around this by just suppressing the declaration if
cflags includes -DDYNDBG_NO_TABLE.

The up-link is init'd in 2 cases:

The file static struct _ddebug_info builtins is initialized by
dynamic_debug_init(), with the 3 ELF sections addresses+lengths
composing the builtin dyndbg-state.  It will be able to also
initialize the header.UPLINK fields, as long as the storage space is
available.  Then rel_map() can rely upon it to provide the &site ref
for a callsite's desc*, if it is enabled.

Then at runtime (assuming initialization is correct):

 - use _index to get &descs[0]
 - container-of gets .UPLINK to &dyndbg_info
 - info->sites[_index]	- replaces .sites
 - info->sites[_map]	- allows de-duplicated vector position. M<N

But thats all talk; this patch just adds and initializes the index and
map fields.

._index:14 allows ~16k entries, more than enough for ~3k built-in
callsites, or ~4k in amdgpu (with dyn-drm-trc commitset).  It is
initialized in __ddebug_add_module(), a new refactorization.

ddebug_add_module() is called from kernel/module.c, that interface is
preserved.  It just passes 0 to inner fn when loading modules.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 3 +++
 lib/dynamic_debug.c           | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index c05148dab367..268e903b7c4e 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -31,6 +31,8 @@ struct _ddebug {
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
 	const unsigned lineno:16;
+	unsigned _index:14;
+	unsigned _map:14;
 #define CLS_BITS 6
 	unsigned int class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
@@ -60,6 +62,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
+
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f1f354efed5a..506a7e2e59d6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1344,6 +1344,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 			       const char *modname)
 {
 	struct ddebug_table *dt;
+	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
 	if (!di->num_descs) {
@@ -1364,6 +1365,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	 */
 	dt->mod_name = modname;
 	dt->ddebugs = di->descs;
+	dt->sites = di->sites;
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
@@ -1372,6 +1374,12 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	if (di->classes && di->num_classes)
 		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
 
+	for (i = 0; i < di->num_descs; i++) {
+		di->descs[i]._index = base + i;
+		v3pr_info(" %d %d %s.%s.%d\n", i, base, modname,
+			  di->descs[i].site->_function, di->descs[i].lineno);
+	}
+
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
-- 
2.37.2

