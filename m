Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7554B96E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiBQDsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:48:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBQDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:48:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6302C0506
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:36 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id a26so2204793iot.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WX6MJz/RVmu5KU05M8p6pw0cbdiL13QxNy+cJ91otYI=;
        b=d4W6T2hoWi2DLEPWhP29U01f7jjXpO4/jxusulpHAFgBnZJxEhulxoG73pLteKLv37
         A6Kn/eoMG2/dmrz3GmCi0UlCls1b1zotKBOdUG+LGBu8tRssVfmRMz9hYnOjFhHdZYX1
         rTGjsGMetAi3icEEes4488Yy9smVgBBYU+F2k5ckupGqYYYeFYUJkqTGvLku1cfzL4+E
         HL6Ocww7mMvh1aDzPezp19by7fjpAYeDzGTAqepvgPqUHaZMs2ZjcbKmjJ1gN+FFcmLL
         bH5y1D488kTn3eBtI+ilfKEqDsC5nLMbIwgkUVFbKaxulzzRCyFlfucOa2JHpjKRZdit
         ABYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WX6MJz/RVmu5KU05M8p6pw0cbdiL13QxNy+cJ91otYI=;
        b=3c7IT/TWLOsz7dA26tbVWua0xezag6LrlAYxgEnB1X8Uz1yRHNSzzKtI211aoARsg4
         qv8an8Gr9F1R6JiqEokKIO8dFOT5hJehoWNNfoDwGPg10gb65FxjeTXmW4IYrSuPaF4F
         IEAkTatXNbV4XVZZjg6QKav0KcYdfniKDc57zD84rPaQ5guUdLZ68FLIDQjxsXpduG6u
         FBtfvDjGCd6ZwTQ6F6auhDgeznYCHnLJ0mWrPt4cvkovQHbj1WFFoWvToxILuJBnG7bR
         OqZwQHDXVlx4OWBIdwrDLo0VJdmfw6Px9E0137WdtAelGYCYrjCZp+MY4j5RPqHPaItu
         yYHQ==
X-Gm-Message-State: AOAM530Z3iBatU42mH2fEKywoPb4j3WktSzwr7Gl+uRkoZWxxGKVBXnR
        Qb7xEwoTzDPgT58trMdSFqc=
X-Google-Smtp-Source: ABdhPJxyyYVp2cpU+u+Brn6vc+Sa2k3avtGDvXSzA1PMgl1XvLDtup0SaBDOqBlcJQLSAvD+iRZDHw==
X-Received: by 2002:a02:7163:0:b0:314:3b74:525a with SMTP id n35-20020a027163000000b003143b74525amr701416jaf.260.1645069715755;
        Wed, 16 Feb 2022 19:48:35 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:35 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/12] use dynamic-debug under drm.debug api
Date:   Wed, 16 Feb 2022 20:48:16 -0700
Message-Id: <20220217034829.64395-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
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

drm.debug api provides ~23 macros to issue 10 categories of debug
messages, each enabled by a bit in /sys/module/drm/parameters/debug.
drm_debug_enabled(category) tests these bits at runtime; while cheap
individually, the costs accumulate.

For CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this patchset obsoletes those
runtime tests (inside drm_*dbg) by wrapping the 2 fns in one of the
dynamic_func_call* Factory macros.  The config dependence is due to
the .data footprint cost of the tables; AMDGPU has ~4k callsites, at
56 bytes each.

This creates entries in /proc/dynamic_debug/control for each callsite,
and each has .class_id = macros'-category.  This, and a new query
keyword, allow (1st):

  # 1=DRM_UT_KMS (iirc)
  #> echo "module drm class 1 +p  > /proc/dynamic_debug/control

Then equivalently:
  # except it also clears other flags
  #> echo 0x01 > /sys/module/drm/parameters/debug

dyndbg:
 - fixes a bug in dyndbg static_key toggling, @stable cc'd
 - adds support for distinct classes to dyndbg (new,unused feature)
 - add DECLARE_DYNAMIC_DEBUG_CLASSBITS macro and callbacks
   to implement bitmap -> classid sysfs knob
dyndbg:
 - drops exported fn: dynamic_debug_exec_queries()
   any potential users would just use macro, or a tweak on it.
 - improve info-msg to print both "old -> new" flags
drm:
 - adapts drm to use that support (link category to class_id)
 - wraps drm_*dbg() in a dyndbg Factory macro to get NOOP optimized debugs
   this disconnects drm.debug sysfs knob
 - uses DECLARE_DYNAMIC_DEBUG_CLASSBITS macro
   this reconnects sysfs knob

This could be -v12, but the focus and subject has wandered a bit, and
patchwork CI had multiple different notions of the version.
Noteworthy changes:

- no tracefs stuff here, refocus
  split out already, needs maturation, more attention.
  its competing with a diet plan, to reduce 56 bytes/callsite. RFC.

Previous drm.debug approach:

- avoided drm_dbg & drm_devdbg by splicing in pr_debug & dev_dbg
  this preserved the optional decorations: module:function:line:

- used DRM_UT_CORE => "drm:core:" prefix-string, cpp cat'd to formats
  this made sites selectable by matching to that format prefix

This version:

- .class_id is easier to explain, and no config/format-string diffs

- wraps drm_dbg & drm_devdbg callsites for jumplabel enablement
  efficiency was original goal.

- loses the optional decorations.
  drm has its own logmsg standards, doesnt need decorations slapped on
  later: could recast flags for drm specific decorations

This is based on 5.17-rc4

Its also here: in (dd-drm branch)
  ghlinux-ro	https://github.com/jimc/linux.git (fetch)

I'll push further fixes there as they come.

Jim Cromie (13):
  dyndbg: fix static_branch manipulation @stable
  dyndbg: add class_id field and query support
  dyndbg: add DEFINE_DYNAMIC_DEBUG_CLASSBITS macro and callbacks
  dyndbg: drop EXPORTed dynamic_debug_exec_queries
  dyndbg: improve change-info to have old and new
  dyndbg: abstract dyndbg_site_is_printing
  drm_print: condense enum drm_debug_category
  drm_print: interpose drm_*dbg with forwarding macros
  drm_print: wrap drm_*_dbg in dyndbg jumplabel
  drm_print: refine drm_debug_enabled for dyndbg+jump-label
  drm_print: prefer bare printk KERN_DEBUG on generic fn
  drm_print: add _ddebug desc to drm_*dbg prototypes
  drm_print: use DEFINE_DYNAMIC_DEBUG_CLASSBITS for drm.debug

 .../admin-guide/dynamic-debug-howto.rst       |   7 +
 drivers/gpu/drm/Kconfig                       |  12 ++
 drivers/gpu/drm/Makefile                      |   2 +
 drivers/gpu/drm/drm_print.c                   |  56 ++++---
 include/drm/drm_print.h                       |  80 +++++++---
 include/linux/dynamic_debug.h                 | 113 +++++++++++---
 lib/dynamic_debug.c                           | 140 ++++++++++++++----
 7 files changed, 323 insertions(+), 87 deletions(-)

-- 
2.35.1

