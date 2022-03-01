Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8A4C9095
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiCAQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiCAQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:31 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7776DF90
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:46:49 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h16so19061568iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1DKkFkTD51crlgMGLdpYJpND0N6pwdsFJPVoE5cl6o=;
        b=jEPhltpGhYcqAq57XkAAn66Kov5OWMOzOGhPUapIU2W5R+8LDIKiQXjhzEK561SyQo
         6N+iLEMORuUO2QCZ/IA6jXaXN+R39vV/86n08B/6hwSkRM7Q3xFgIL56RbEZ8RT4NRcs
         4bPPlOQkCX9qDbVvKpfbtb5FaD0ef8AEeLLn9Aocksq7fKVAKk8VVFLeYzAWK77llleb
         9kW2am6M5Fd4C37wTrEXDi7wd2MwGNXaEQ6BT5FQrIRqtkjaWAm09bIGIKGnU2Pp7u9K
         iE+zqate6yY9iBSW2Lock8xbkvA3vojZ+Br9HhzRxdDiP2FU5uZj81qf5tN4G1Jh4E1G
         53Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1DKkFkTD51crlgMGLdpYJpND0N6pwdsFJPVoE5cl6o=;
        b=gJo+KdgmWZVIScx888+XaIME44H8mWtn9unNrpgMzbuugGv2ahaACGttbc7DHmyUhz
         j1w1kqiVQ3EfSdkUVJPFqHA3P2+8t4PJYGYPiBAuSSbasjB4bLEjj8jHHQyX+XAxa2ri
         V+uw6MSU3xqiyCjGu/XcNMzUqAaVV64k6NzoPsbLpDpnXrVJAG1gyFlw3hi7mvXOzIgE
         hVH8fWckR03WtQ8F5nMAFf9EdTx87ZnMmvHtvFF4gR/I3y2iMzzmZnsO2nMLMKwFF6V4
         vGrx9+nV9IwC/SnEpxeSvwrzjg0FkcNtpIR64zweVK6CTu42GLXxEUOwSv+eqoIpBhQu
         vINA==
X-Gm-Message-State: AOAM533lawMj1zReK6REdJIDKayffiBGPHMoPbb82Zk4JAeVqsAX/6j+
        l0IjGzhvOk3ETUvZV8jPmdA=
X-Google-Smtp-Source: ABdhPJwc3IPrO6b8RuyjrC3bbWDPNt8/BFUm757dn432bTjFTSza1QlncnWOpq0GGb7foTgAqGxYRw==
X-Received: by 2002:a05:6638:204d:b0:314:a290:48c with SMTP id t13-20020a056638204d00b00314a290048cmr22222271jaj.264.1646153209259;
        Tue, 01 Mar 2022 08:46:49 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:48 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/12] use dynamic-debug under drm.debug api
Date:   Tue,  1 Mar 2022 09:46:16 -0700
Message-Id: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

hi Jason, Greg, Daniel, DRM-everyone

drm.debug api provides ~23 macros to issue 10 categories of debug
messages, each enabled by a bit in /sys/module/drm/parameters/debug.
drm_debug_enabled(category) tests these bits at runtime; while cheap
individually, the costs accumulate.

Daniel,
I think this revision addresses most of your early review, a lot has
changed since.  Heres the link:
https://patchwork.freedesktop.org/patch/443989/

For CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this patchset obsoletes those
runtime tests (inside drm_*dbg) by wrapping the 2 fns in one of the
dynamic_func_call* Factory macros.  The config dependence is due to
the .data footprint cost of the tables; AMDGPU has ~4k callsites, at
56 bytes each.

This patchset creates entries in /proc/dynamic_debug/control for each
callsite, and each has .class_id = macros' category.  Those entries,
and a new query keyword, allow (1st):

  # 1=DRM_UT_KMS (iirc)
  #> echo "module drm class 1 +p  > /proc/dynamic_debug/control

Then equivalently:
  # except it also clears other flags
  #> echo 0x01 > /sys/module/drm/parameters/debug

series overview:

dyndbg:
 - fix a bug in dyndbg static_key toggling, @stable cc'd
 - adds support for distinct classes to dyndbg (new,unused feature)
 - add DECLARE_DYNAMIC_DEBUG_CLASSBITS macro and callbacks
   to implement bitmap -> classid sysfs knob
dyndbg:
 - drops exported fn: dynamic_debug_exec_queries()
   any potential users would just use macro, or a tweak on it.
 - improve info-msg to print both "old -> new" flags
drm:
 - adapts drm debug category to dyndbg.class_id
 - wraps drm_*dbg() in a dyndbg Factory macro to get NOOP optimized debugs
   this disconnects drm.debug sysfs knob
 - uses DECLARE_DYNAMIC_DEBUG_CLASSBITS macro
   this reconnects sysfs knob

This could be -v12, but the focus and subject has wandered a bit, and
patchwork CI had multiple different notions of the version.

Noteworthy changes:

- no tracefs stuff here, refocus

In contrast, the previous drm.debug approach:

- replaced drm_dbg & drm_devdbg with calls to pr_debug & dev_dbg
  this preserved the optional decorations: module:function:line:

- used DRM_UT_CORE => "drm:core:" prefix-string, cpp cat'd to formats
  this made sites selectable by matching to that format prefix

This version:

- .class_id is easier to explain, and no config/format-string diffs

- wraps drm_dbg & drm_devdbg callsites for jumplabel enablement
  efficiency was original goal.

- loses the optional decorations.
  drm has its own logmsg standards, doesn't need decorations slapped on
  later: could recast flags for drm specific decorations

This is based on 5.17-rc4, for no particular reason.

Its also here: in (dd-drm branch)
  ghlinux-ro	https://github.com/jimc/linux.git (fetch)


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

