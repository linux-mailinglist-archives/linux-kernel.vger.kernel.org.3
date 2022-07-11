Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A2570B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiGKU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678354A804
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561D061642
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA016C341C8;
        Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571124;
        bh=o2iriqr9yGWd6meVOtOwBCMeiBhrD3lI1NVS6cm0Kmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLT6S5V3wpeb0ALSjTIoMWeqhQ6ejsrrlvZ8WVJT5r4tJ5Rl9d+N9pV1TnMFigJ4B
         vt9x8lHKg4dzcpkz4jc/moK8YEp4XfBi6eN0VtE31STGN92PCC6j2rlCBnhnmVuk83
         hrpRdNe8fuKgDpfBL5YmNOW1+IXpACRU6BZju0rYBAvQXrp8u3+JSyjMfSE0sX7MtU
         dvru0K5hMWY1dHb6LaZrjg1YYYSbIsdW1kn7lFIUvxky1XWgQDZOa8aHCqn0zmW3JQ
         gfnXqGPII7fIyACS/9x5VFyVFU1YZ+kin5r4tiJ/tbkL1Mpnk4m6NK99C7AHo6NVzE
         8f+CMKKIiANWQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e8F-Kg;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Nirmoy Das <nirmoy.das@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/32] drm/i915: i915_gem_region.h: fix i915_gem_apply_to_region_ops doc
Date:   Mon, 11 Jul 2022 21:25:01 +0100
Message-Id: <d422b77a1d40e815e6e84dcb0f7be9097efffe36.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc markup for i915_gem_apply_to_region_ops() has some
issues:

1. The field should be marked as @process_obj;
2. The callback parameters aren't document properly, as sphinx
   will consider them to be placed at the wrong place.

Fix (1) and change the way the parameters are described, using
a list, in order for it to be properly parsed during documentation
build time.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_region.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.h b/drivers/gpu/drm/i915/gem/i915_gem_region.h
index 2dfcc41c0170..b0134bf4b1b7 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_region.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_region.h
@@ -22,9 +22,11 @@ struct i915_gem_apply_to_region;
  */
 struct i915_gem_apply_to_region_ops {
 	/**
-	 * process_obj - Process the current object
-	 * @apply: Embed this for private data.
-	 * @obj: The current object.
+	 * @process_obj: Callback function to process the current object
+	 * it requires two arguments:
+	 *
+	 * - @apply: Embed this for private data.
+	 * - @obj: The current object.
 	 *
 	 * Note that if this function is part of a ww transaction, and
 	 * if returns -EDEADLK for one of the objects, it may be
-- 
2.36.1

