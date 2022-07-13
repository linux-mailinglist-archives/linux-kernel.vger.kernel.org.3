Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370725732C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiGMJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiGMJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D79EEA9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9081661C63
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505FC341C8;
        Wed, 13 Jul 2022 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704621;
        bh=smG9F2RXMNXCU8+/rdRMph25oHjT7Q2WcPhpkWuHDgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7K0y2Z9Vs9n9sU15b+DrTXWHH58JYmo2jAunLW/rw5GihE1pJ/RFTReKKJi/f9yG
         uBpNNO7K7BzKqbIrHuLvMYV6mKtFa0zzNpsjk7VtUWiXwn6NFvKzNKds6GdPY81ODj
         S/bfgZ4h861narp4RQeYoO7IxDDVMotcyJl3B5ICckeg32oP7jPAyUtSxHO3gjWqsw
         PfUIfpQpr/EYE2Je0P5IG5lXOcSBwgjOt7J/Ah49rLc+4c1Fmv+FkBdaVH3XI5UCFO
         d7sT0aUK09aIRAA8huPew1Fb+xwP7ZT4h0Jd+qiEqSgYZ3DyN8XX1zWN6e5s4SWuRw
         CTqj0DXT8WOSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050LU-Lr;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] drm/i915/gt: describe the new tlb parameter at i915_vma_resource
Date:   Wed, 13 Jul 2022 10:30:04 +0100
Message-Id: <29c9a422328bc7c644dbc1e83a28f09e502d34d6.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657703926.git.mchehab@kernel.org>
References: <cover.1657703926.git.mchehab@kernel.org>
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

TLB cache invalidation can happen on two different situations:

1. synchronously, at __vma_put_pages();
2. asynchronously.

On the first case, TLB cache invalidation happens inside
__vma_put_pages(). So, no need to do it later on.

However, on the second case, the pages will keep in memory
until __i915_vma_evict() is called.

So, we need to store the TLB data at struct i915_vma_resource,
in order to do a TLB cache invalidation before allowing
userspace to re-use the same memory.

So, i915_vma_resource_unbind() has gained a new parameter
in order to store the TLB data at the second case.

Document it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_vma_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
index 5a67995ea5fe..4fe09ea0a825 100644
--- a/drivers/gpu/drm/i915/i915_vma_resource.c
+++ b/drivers/gpu/drm/i915/i915_vma_resource.c
@@ -216,6 +216,10 @@ i915_vma_resource_fence_notify(struct i915_sw_fence *fence,
 /**
  * i915_vma_resource_unbind - Unbind a vma resource
  * @vma_res: The vma resource to unbind.
+ * @tlb: pointer to vma->obj->mm.tlb associated with the resource
+ *	 to be stored at vma_res->tlb. When not-NULL, it will be used
+ *	 to do TLB cache invalidation before freeing a VMA resource.
+ *	 used only for async unbind.
  *
  * At this point this function does little more than publish a fence that
  * signals immediately unless signaling is held back.
-- 
2.36.1

