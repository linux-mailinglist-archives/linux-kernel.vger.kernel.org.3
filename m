Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86B47713A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhLPL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:59:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhLPL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:59:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 806BF21119;
        Thu, 16 Dec 2021 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639655963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nJzarjRsFddzwj2POsEoacem5ANxTsZ7S2fzYT8eUEo=;
        b=id2nOCfIN3woA+W6cfxxG04CE9jJOi6pd1WUKwGSFmLWkCoBNKC21a1tfjBb3RMKQrhTzx
        RiMhc1SGx7/Uz3RhzZt50PLUAZ6GzbXG6VwYUQoZCo8DvPZucC6MN/3S5/f3QiqozrPwBW
        FQsgjCptBaVsWp/u5aXxJgzb0Ddv6WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639655963;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nJzarjRsFddzwj2POsEoacem5ANxTsZ7S2fzYT8eUEo=;
        b=AWRA95QQqS0lxqTdvV3H+Znip1FnbOHjyzfP5/a7gXNmyhFVl4AdA/WvXZif8XQ4fG6j3B
        qrF7s/DNHLelaxAQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 32E6BA3B84;
        Thu, 16 Dec 2021 11:59:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     jani.nikula@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: remove circ_buf.h includes
Date:   Thu, 16 Dec 2021 12:59:20 +0100
Message-Id: <20211216115920.15981-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user of macros from that include was removed in 2018 by the
commit below.

Fixes: 6cc42152b02b ("drm/i915: Remove support for legacy debugfs crc interface")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/display/intel_pipe_crc.c | 1 -
 drivers/gpu/drm/i915/i915_irq.c               | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
index 8ac263f471be..9070935b0443 100644
--- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
+++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include <linux/circ_buf.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 5b98fb0532b5..e77f644d41e8 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -28,7 +28,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/circ_buf.h>
 #include <linux/slab.h>
 #include <linux/sysrq.h>
 
-- 
2.34.1

