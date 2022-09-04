Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA875AC708
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiIDVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiIDVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EACE2C64E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h78so5628223iof.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5Pcy7SEXmziNMuvuaPrrGzNbNpmap+iXZUcd2i8OvCY=;
        b=GB9PW2F6Q86MU59eDr4MyMDq35GvNA/Jg6eGCzAQ+7KsoRzAAGQZzPwH/dw5FsI2O2
         3lRJv+1hZh1L7J0X5r+/gJmZ/p+S01FMLMk12jtIdbQdXgJQ5HUhVxyOwaVdwGYVI3Oz
         yjqdX503u6uH34EL0ic6GiF8HRbIhCOXLCJO9nVVYQl1dCp+lnEx6muhaf01/usDbzPU
         ZZzM26A2bAzM2xcI/xnYhnCbRLdj88A3HAOOSNyOx2yCAv4FEaJnA3vSTNlpS3Zj1ziY
         Be6DgpqOnB5C2e1LiZ39wPFC92RfVb0RqUf1pyPHHTI99OqApEkJoA3tEi/tTJOeGG06
         rZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5Pcy7SEXmziNMuvuaPrrGzNbNpmap+iXZUcd2i8OvCY=;
        b=lXb8GqsS1TfS19kA+HDv/IIEePK+R9WBQFopgNgvR6iVcv2mFmYSNyOWH4TCFEC+HI
         OYr7yyc+6I1OfIpZOgUjl0AMQv+ryGuDqtYaXMELzo7Vu9tOpPNbKhILstlB2KyZrGdK
         5GCr/C/cDDdDc2MXLlaDE/79EUTWG8SnvAPa7aZLEoCetZP3vLmZT+AHHzinvi73hdCj
         pwBNzs2Agp1UBpqxs4+/fO9MolCJUzp/QlIabgbdBP8S7xqtsqsmO95YMgeTNhWW/yJ1
         li/PYU6HkreGIVzjgwAUoUWtwhaAVJIsPJZ9I34t9YQeKO31ERy+RhIlhEatpp9Q+upk
         xRUw==
X-Gm-Message-State: ACgBeo34gtRrIHo6qM8uDLUYZ406dUI1K/8QR7/QWldY/cwMwYSB/K+q
        zRUy2SSVmrgwcY2OrmwGblM=
X-Google-Smtp-Source: AA6agR6EECGaIhMrD6/ftIKIMo5ApfTHYgvzkKs19vbQldr38XY5/ivWSJIIjhhS6BH5Fg18Gldhsw==
X-Received: by 2002:a6b:e816:0:b0:688:c999:d08c with SMTP id f22-20020a6be816000000b00688c999d08cmr22221392ioh.100.1662327743569;
        Sun, 04 Sep 2022 14:42:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 14/57] dyndbg: add DECLARE_DYNDBG_CLASSMAP macro
Date:   Sun,  4 Sep 2022 15:40:51 -0600
Message-Id: <20220904214134.408619-15-jim.cromie@gmail.com>
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

Using DECLARE_DYNDBG_CLASSMAP, modules can declare up to 31 classnames.
By doing so, they authorize dyndbg to manipulate class'd prdbgs (ie:
__pr_debug_cls, and soon drm_*dbg), ala::

   :#> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control

The macro declares and initializes a static struct ddebug_class_map::

 - maps approved class-names to class_ids used in module,
   by array order. forex: DRM_UT_*
 - class-name vals allow validation of "class FOO" queries
   using macro is opt-in
 - enum class_map_type - determines interface, behavior

Each module has its own class-type and class_id space, and only known
class-names will be authorized for a manipulation.  Only DRM modules
should know and respont to this:

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
__dyndbg_classes section.  That draws an 'orphan' warning which we
handle in the next commit.  The struct attributes are necessary:
__aligned(8) fixed null-ptr derefs, and __used is needed by drm
drivers, which declare class-maps, but don't also declare a
sysfs-param, and thus dont ref the classmap.  The __used insures that
the linkage is made, then the class-map is found at load-time.

While its possible to handle both NAMES and NUMBERS in the same
sys-interface, there is ambiguity to avoid, by disallowing them
together.  Later, if ambiguities are resolved, 2 new enums can permit
both inputs, on verbose & independent types separately, and authors
can select the interface style they like.

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
. reorder-enum - _NAMES feature is extra.
---
 include/linux/dynamic_debug.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 3c9690da44d9..98dbf1d49984 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -56,6 +56,61 @@ struct _ddebug {
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
+	 * classes are independent, like _DISJOINT_BITS.
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
2.37.2

