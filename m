Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F51573070
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiGMINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426FE95FC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76085B81D5B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B7C385A2;
        Wed, 13 Jul 2022 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=bME4oJz6dR2dL+exdw8ZiepOjromIutAKbYd7CbWH1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0Ok75E1qOpSqD7A+Pl6xuMC5wXKTvxjMQUDYRMkuCPvxHd6xy+KSfcITt5p45Luy
         Iki8Zobqq25c91WZeLhbg7F2DEdB2mQla4e6mbuTaRY1WP4cWIifKQbOZpAgXYsv1s
         faElSYNBCaFtSnJognOL3HUhOI0yW1hEKdhL+F60mbpl6z47B/zcu6Gi7Ydd2s0ZtA
         TzSFr4KDeiBD5G2k14XixU+6AEmn7Ep3HoZcRiwTS3c8JehaVgydMjLFaPwMLoe+Gu
         ByAySK5ipHqr3wE1Z75dtio1CThV5TaOSTb91D4DINhuPBFSr95kwLNWKmqvEx5Y5A
         34+bkAKYeS57g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004ztY-Mb;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Nirmoy Das <nirmoy.das@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/39] drm/i915: i915_gem_region.h: fix i915_gem_apply_to_region_ops doc
Date:   Wed, 13 Jul 2022 09:12:07 +0100
Message-Id: <f197e0eccbde017dccbd31e72c892a102543cb90.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
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
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

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

