Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89258B1B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiHEVzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbiHEVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE347B1F7;
        Fri,  5 Aug 2022 14:54:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h138so2830941iof.12;
        Fri, 05 Aug 2022 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j+hykMqdbmYFr1NqjZ89GQdbT5beT8R+gHdILha2zJU=;
        b=nxW91IqfGR0pfzM6UOrXM2Bhw3WEhj9ajlDXgcXsYmlnTjlxn0T7yhlldkgnIhKM+j
         RJLXxFSrD18FQ8ZF30z+F0RgUeUsa36uV31o+nAybfTtVpGw2BI96WeVGDMbVuqYFqAb
         sp1qL3/ZTTk0jDpmhrGA3cOrnrugx5C8rditN412Nf9EfVpVX1w/aqQukXyOpMiErs35
         2pZ45u9SIx8h3Dl3v2Xawk0btutGgC7zZjBY0ufPCCtEEOhbE/YZwzgvkxX+9Y4KQu1L
         KvTn8HRgBx3ajWNnRxEt7BgDEZTxWXuJ6IO1CWIJUCVYTAEEF3w3sNhJEbSizD5RxSWw
         gTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j+hykMqdbmYFr1NqjZ89GQdbT5beT8R+gHdILha2zJU=;
        b=JsunRNGpSeLmoEvKGezaFNmQaBNbZeJNa5nfwH3I4OX+/DpDO3MRJqBEhh4s1QmA6n
         h9w8SgF0iJdRMJGGkkbmbIPk8zhR4XHgYiJ/mEeHAkX4tAgj/YglPvBgdntEWfCJuc1g
         ZHuMXLUD1Bn1M6PFrB6KJzXHHPRGgVYEE18CERHJVfJj6FTDqo78xMVrbRiOuyYtuqY0
         T7YwBQSkqHeQjXS+vt9ermrvdpvba2gz4v+kGh7Wr3dcwKCauSfVxpY145xLx6CselAn
         huzwSGmZw6jw4ErnJy5pLQNcLO5bW9bDKMdS31SfjOOYm0jzF/v0KDKn9T7eWtPE73pT
         AkJg==
X-Gm-Message-State: ACgBeo1ipyIdrqpY5SqnpYFDjAGh/C+iU+KaEW87/jjSjNr9mHGjwaSk
        gzNeXOOYKNzjpOIztiVEqwzsTXW0i9BFYw==
X-Google-Smtp-Source: AA6agR6QBWed0lyVvHYNugDvJfD10jdKNkK5mER4rDMRc0ISAOo3qbMRaABZaYmS8HwhAblDRLO9hQ==
X-Received: by 2002:a05:6638:3d0d:b0:342:8b79:9484 with SMTP id cl13-20020a0566383d0d00b003428b799484mr4118742jab.274.1659736475770;
        Fri, 05 Aug 2022 14:54:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 14/33] dyndbg: add DECLARE_DYNDBG_CLASSMAP macro
Date:   Fri,  5 Aug 2022 15:53:36 -0600
Message-Id: <20220805215355.3509287-15-jim.cromie@gmail.com>
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

With DECLARE_DYNDBG_CLASSMAP modules can declare up to 31 classnames.
By doing so, they authorize dyndbg to manipulate class'd prdbgs (ie:
__pr_debug_cls, and soon drm_*dbg)

   :#> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control

The macro declares and initializes a static struct ddebug_class_map:

 - maps approved class-names to class_ids used in module,
   by array order. forex: DRM_UT_*
 - class-name vals allow validation of "class FOO" queries
   using macro is opt-in
 - enum class_map_type - determines interface, behavior

Each module has its own .class_id space, and only known class-names
will be authorized for a manipulation.  Only DRM stuff should know this:

  :#> echo class DRM_UT_CORE +p > control	# across all modules

pr_debugs (with default class_id) are still controllable as before.

DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, classes...) is::

 _var: name of the static struct var. user passes to module_param_cb()
       if they want a sysfs node.

 _maptype: this is hard-coded to DD_CLASS_TYPE_DISJOINT_BITS for now.

 _base: usually 0, it allows splitting 31 classes into subranges, so
 	that multiple classes / sysfs-nodes can share the module's
 	class-id space.

 classes: list of class_name strings, these are mapped to class-ids
 	  starting at _base.  This class-names list must have a
 	  corresponding ENUM, with SYMBOLS that match the literals,
 	  and 1st enum val = _base.

enum class_map_type has 4 values, on 2 factors::

 - classes are disjoint/independent vs relative/x<y/verbosity.
   disjoint is basis, verbosity by overlay.

 - input NUMBERS vs [+-]CLASS_NAMES
   uints, ideally hex.  vs  +DRM_UT_CORE,-DRM_UT_KMS

DD_CLASS_TYPE_DISJOINT_BITS: classes are separate, one per bit.
   expecting hex input. built for drm.debug, basis for other types.

DD_CLASS_TYPE_DISJOINT_NAMES: input is a CSV of [+-]CLASS_NAMES,
   classes are independent, like DISJOINT

DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0-N.
   0 implies silence. use printk to break that.
   relative levels applied on bitmaps.

DD_CLASS_TYPE_LEVEL_NAMES: input is a CSV of [+-]CLASS_NAMES,
   names like: ERR,WARNING,NOTICE,INFO,DEBUG
   avoiding EMERG,ALERT,CRIT,ERR - no point.

NOTES:

The macro places the initialized struct ddebug_class_map into the
__dyndbg_classes section.  That draws a 'orphan' warning which we
handle in next commit.  The struct attributes are necessary:
__aligned(8) stopped null-ptr derefs (why?), __used is needed by drm
drivers, which declare class-maps, but don't also declare a
sysfs-param, and thus dont ref the classmap; __used insures that the
linkage is made, then the class-map is found at load-time.

While its possible to handle both NAMES and NUMBERS in the same
sys-interface, there is ambiguity to avoid, by disallowing them
together.  Later, if ambiguities are resolved, 2 new enums can permit
both inputs, on verbose & independent types separately, and authors
can select the interface they like.

The plan is to implement LEVELS in the callbacks, outside of
ddebug_exec_query(), which for simplicity will treat the CLASSES in
the map as disjoint.  The callbacks can see map-type, and apply ++/--
loops (or bitops) to force the relative meanings across the
class-bitmap.

RFC: That leaves 2 issues:

1. doing LEVELs in callbacks means that the native >control interface
doesn't enforce the LEVELS relationship, so you could confusingly have
V3 enabled, but V1 disabled.  OTOH, the control iface already allows
infinite tweaking of the underlying callsites; sysfs node readback can
only tell the user what they previously wrote.

2. All dyndbg >control reduces to a query/command, includes +/-, which
is at-root a kernel patching operation with +/- semantics.  And the
_NAMES handling exposes it to the user, making it API-adjacent.

And its not just >control where +/- gets used (which is settled), the
new place is with sysfs-nodes exposing _*_NAMES classes, and here its
subtly different.

_DISJOINT_NAMES: is simple, independent
_LEVEL_NAMES: masks-on bits 0 .. N-1, N..max off

  # turn on L3,L2,L1 others off
  echo +L3 > /sys/module/test_dynamic_debug/parameters/p_level_names

  # turn on L2,L1 others off
  echo -L3 > /sys/module/test_dynamic_debug/parameters/p_level_names

IOW, the - changes the threshold-on bitpos by 1.

Alternatively, we could treat the +/- as half-duplex, where -L3 turns
off L>2 (and ignores L1), and +L2 would turn on L<=2 (and ignore others).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. revised DD_CLASS_TYPE_{DISJOINT,LEVEL}_* names
. reorder-enum by necessity - _NAMES feature is extra.
---
 include/linux/dynamic_debug.h | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index cb4696c91901..71cdc8612257 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -56,6 +56,62 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
+enum class_map_type {
+	DD_CLASS_TYPE_DISJOINT_BITS,
+	/**
+	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, one per bit.
+	 * expecting hex input. Built for drm.debug, basis for other types.
+	 */
+	DD_CLASS_TYPE_LEVEL_NUM,
+	/**
+	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0-N.
+	 * N turns on just bits N-1 .. 0, so N=0 turns all bits off.
+	 */
+	DD_CLASS_TYPE_DISJOINT_NAMES,
+	/**
+	 * DD_CLASS_TYPE_DISJOINT_NAMES: input is a CSV of [+-]CLASS_NAMES,
+	 * classes are independent, like _DISJOINT_BITS.  Model user
+	 * would be /sys/module/drm/parameters/debug_categories.
+	 */
+	DD_CLASS_TYPE_LEVEL_NAMES,
+	/**
+	 * DD_CLASS_TYPE_LEVEL_NAMES: input is a CSV of [+-]CLASS_NAMES,
+	 * intended for names like: INFO,DEBUG,TRACE, with a module prefix
+	 * avoid EMERG,ALERT,CRIT,ERR,WARNING: they're not debug
+	 */
+};
+
+struct ddebug_class_map {
+	struct list_head link;
+	struct module *mod;
+	const char *mod_name;	/* needed for builtins */
+	const char **class_names;
+	const int length;
+	const int base;		/* index of 1st .class_id, allows split/shared space */
+	enum class_map_type map_type;
+};
+
+/**
+ * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_base:  offset of 1st class-name. splits .class_id space
+ * @classes: class-names used to control class'd prdbgs
+ */
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	static struct ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_classes") _var = {			\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.map_type = _maptype,					\
+		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.class_names = _var##_classnames,			\
+	}
+#define NUM_TYPE_ARGS(eltype, ...)				\
+        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
+
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
-- 
2.37.1

