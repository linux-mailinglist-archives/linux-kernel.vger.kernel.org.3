Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37005487247
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbiAGF3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAGF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:29:50 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98049C061245;
        Thu,  6 Jan 2022 21:29:50 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id b1so3830417ilj.2;
        Thu, 06 Jan 2022 21:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HE6rGl4+lTFmvO6USR2ILfrynKOlclK8dPgu7S7zjx4=;
        b=a/8NVQILS1Z0rPpJg3vXACkLCnhakIXxZp6n3duXgKfvjT8HZFx/KJHo6Ek2L/rLa0
         JX4ih/IOGrPScR1hhbs/QJLpS1+2t5vR9CVh+L3v5NvKvXt1TQ03Ei/ra2rAM5WGBgXd
         EVhHOUWb5ulJlsEcPxZz3ocXR5vCJ1bTVEwXLu1Ut4lxwk/HbTaioO4dzaQyeoY3AUBq
         s7Z7NwG45L1YnJ4i2aSMO+T8NRoJzhkJVUKBkZKCKCf+mzTDgkDL1ZpwhD4wPWcQdWMF
         oZ9xXj2J5m45GQnndGsiXcL3Pcxm8Grpgtb+5wfiuAfUAeKyEuc8D/ZOQcxfKnv3BQ+N
         lR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HE6rGl4+lTFmvO6USR2ILfrynKOlclK8dPgu7S7zjx4=;
        b=At6yTc3iHitlomqROwDcPB9TkeX+U6r0gDvuRqYLMwxRmVXK7lHdSLxHgZeEDQGBfQ
         WmbpTdph4gZooYrwK98HNjCP/ooMsNxCo2eFD/O6kTDSY9llKhFsrchsY2wUHastpD6F
         hvyZODdFeozyZnNyR3GlZBWP/akT/XRWQMv5yIogHSevjcXHmWO1iEMztzCH8iCom0u8
         LDa8HZ+H56iaulYoQseUX3mOzEh7WBtw4wpq+qQCTaQljcJoxLxgQiaLF9YjNutii/9t
         smrt7ryHZAyIqdfje6Jgl0EH84tmoYZWNeRwqXE5Z3wKhWhQNRs8i8Qrve9Z4R6QBjqb
         FO4g==
X-Gm-Message-State: AOAM5323NcbfOezz6vvnXm6aucQzb6HdWEZkSRuposWGDcXD/g3IivEM
        oGWzIxekNDl0094kpFi0YvY=
X-Google-Smtp-Source: ABdhPJzVRVEb5+ua7spdzukBh9MZssTqGLo4AVH1KFZsovhJMEbVb37fAvB6OQiouVHb83nK2gxmag==
X-Received: by 2002:a05:6e02:1cae:: with SMTP id x14mr29287416ill.237.1641533389790;
        Thu, 06 Jan 2022 21:29:49 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:29:49 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v11 00/19] dyndbg & drm.debug to tracefs
Date:   Thu,  6 Jan 2022 22:29:23 -0700
Message-Id: <20220107052942.1349447-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Jason, Steve, Greg, DRM-folks,

This patchset plumbs debug streams, from dynamic-debug, and from
drm.debug, into tracefs.  Enabling traffic is done on both source &
destination:

	# enable at source
	echo module usbcore +T > /proc/dynamic_debug/control
	# enable events into tracefs
	echo 1 > /sys/kernel/tracing/events/dyndbg/enable

	# enable at source
	echo 0x03 > /sys/module/drm/parameters/debug
	# enable events into tracefs
	echo 1 > /sys/kernel/tracing/events/drm/enable

This allows selectivity at the sources, and in principle, filtering at
tracefs (which is unaddressed, except for arg-passthru).


Here is v11, it differs subsantially from v10:

A: All tracefs action is via 4 new trace-events:

from dyndbg:
  pr_debug() sends trace_prdbg()
  dev_dbg()  sends trace_devdbg()
  both preserve args unchanged

similarly from drm:
  drm_dev_dbg() -> trace_drm_devdbg()
  drm_dbg()	-> trace_drm_dbg()
  again, args are captured unchanged.
  for some reason 3 other drm_vblank* events showed up, I dont know why.

These 4 events (not counting vblank) all capture the args unchanged;
ISTM full exposure of available info is best for filtering/triggering
purposes.


B: dynamic-debug gets proper .class_id, and query support (dyndbg:)

so that this is legal input:

   echo module drm class 3 +T > /proc/dynamic_debug/control

v10 used "format drm:core:", which worked, but required addition of
category string prefixes, and possible user-facing-changes issues.

New field is uint:4, big enough to fit DRMs enum drm_debug_category
(once it has been condensed). The name is .class_id, distinct from but
related to DRMs "category".

This also includes _CLS name & arg extensions of the Factory macros
that implement dyndbgs jump-label/NOOP optimizations.


C: integration of dyndbg into drm.debug (drm_print:)

The purpose here (and originally) is to avoid drm_debug_enabled()
runtime costs, and to put a more flexible substrate underneath the
sysfs bitmap api.  Ive made it CONFIG dependent, since each _ddebug is
56 bytes, and i915 & amdgpu have ~1700 & ~3800 callsites respectively,
of which 127 & ~2k are plain pr_debugs.

1. We shrink enum drm_debug_category to fit in 4 bits, at nominal
   cost of BIT(category) at runtime, which dyndbg will avoid anyway.

2. Add the trace_drm_*dbg() events

3. insert macro indirection, and use it to wrap drm_*dbg()s in
   dyndbg's _no_desc_ Factory macro.

4. add __drm_debug_enabled (optimized to true) to use behind jumplabel.

5. use _CLS extension of _no_desc_ Factory macro
   this makes cls available to initialize _ddebug.class_id

6. alter drm_*dbg, replacing category with struct _ddebug *desc.
   desc.class_id is category
   desc.flags allows selection of PRINTK or TRACE or both

7. propagate struct _ddebug *desc thru trace_drm_*dbg()
   make all of _ddebug available for filtering

8. add sysfs bitmap to dyndbg, use it to implement drm.debug


D: The "flight-recorder" special instance was unneeded, and is gone:

this handles it generically:

    mkdir instances/flightrec
    echo 1 > instances/flightrec/events/drm/enable
    echo module autopilot +T >/proc/dynamic_debug/control

v10 is here:
https://lore.kernel.org/lkml/20211105192637.2370737-1-jim.cromie@gmail.com/

patches 1-3 are from:
  https://lore.kernel.org/lkml/20200721141105.16034-1-vincent.whitchurch@axis.com/

this patchset addresses goals of:
  https://patchwork.freedesktop.org/series/78133/
  https://lore.kernel.org/lkml/3706af20bc64a320ff8f3ff8950738b988f4bdf5.1636452784.git.quic_saipraka@quicinc.com/


Jim Cromie (19):

1st 3 are basically direct from <vincent.whitchurch@axis.com>
execpt I dropped his printk:dyndbg event:
  dyndbg: add _DPRINTK_FLAGS_ENABLED
  dyndbg: add _DPRINTK_FLAGS_TRACE
  dyndbg: add write-to-tracefs code

add 2 events, and record args (could be squashed)
  dyndbg: add trace-events for pr_debug, dev_dbg
  dyndbg: add desc, dev fields to event record

add field, selection mechanisms, and CLS extensions to Factory macros
  dyndbg: add class_id to callsites

make category fit in .class_id:
  drm_print: condense enum drm_debug_category

repeat trace event addition:
  drm_print: add trace_drm_dbg, trace_drm_devdbg events

kconfig+Make-flag:
  drm_print: add CONFIG_DRM_USE_DYNDBG

macro indirection:
  drm_print: interpose drm_dev_dbg, __drm_dbg with forwarding macros

add >control entries for ~4660 drm.debug callsites:
  drm_print: wrap drm_dev_dbg in _dynamic_func_call_no_desc
  drm_print: wrap drm_dbg in _dynamic_func_call_no_desc

prep:
  drm_print: refine drm_debug_enabled for dyndbg+jump-label

drive-by:
  drm_print: prefer bare printk KERN_DEBUG on generic fn

get .class_id initialized at compile.
  drm_print: use _dynamic_func_call_no_desc_cls

need this to selectively trace/print:
  drm_print: add struct _ddebug desc to drm_dbg, drm_dev_dbg

propagate arg upgrade of HEAD~1 into trace-events:
  drm_print: add struct _ddebug *desc to trace-drm-*() params

add and use sysfs bitmap support:
  dyndbg: add DEFINE_DYNAMIC_DEBUG_CLASSBITS macro and callbacks
  drm_print: use DEFINE_DYNAMIC_DEBUG_CLASSBITS for drm.debug

 .../admin-guide/dynamic-debug-howto.rst       |  12 +
 drivers/gpu/drm/Kconfig                       |  12 +
 drivers/gpu/drm/drm_print.c                   |  66 +++--
 include/drm/drm_print.h                       |  80 +++--
 include/linux/dynamic_debug.h                 | 101 ++++++-
 include/trace/events/drm.h                    |  68 +++++
 include/trace/events/dyndbg.h                 |  74 +++++
 lib/dynamic_debug.c                           | 273 +++++++++++++++---
 8 files changed, 601 insertions(+), 85 deletions(-)
 create mode 100644 include/trace/events/drm.h
 create mode 100644 include/trace/events/dyndbg.h

-- 
2.33.1

