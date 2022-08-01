Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31C586F52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiHARMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHARMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:12:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269A27B1A;
        Mon,  1 Aug 2022 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659373937; x=1690909937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DFXStBY5eMGiDbcr0wAufBmc0V3fo8FmbFKEExuiPpw=;
  b=k9RAcCju817eLDrdfkJqVdDM+YA0JWvXOhCmiG8oY3Bo9OztkKplGJuk
   qRzHwJMkir8ezM9mZ1Uoo7Gizky+zi7tKWufSDUgSZw5SIPExXenOoxST
   CjE/MWLGcNyKbg0S6jN2qedoiCXPd0qMorSf+Uyqgp0sgFGl2XDa94/wW
   +bkq9ecGK/zzbDwC9luxwAzi3tgbe2fjQ91U/VBy3q1uxv0k+HFKOTE2T
   r83auGFg1+2bgOWg3MkoYt8XJThfLHr3hjrRQizQYw4jvo8IWoPtoSwZp
   RURfnLN/iYatudW+ka+7partFi1d0bxosvHbSk9+05B3S1W9ar8Wnsij4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315030215"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="315030215"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:12:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="929632376"
Received: from nvishwa1-desk.sc.intel.com (HELO nvishwa1-DESK) ([172.25.29.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:12:16 -0700
Date:   Mon, 1 Aug 2022 10:11:53 -0700
From:   Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/userptr: remove redundation assignment to
 variable ret
Message-ID: <20220801171153.GI14039@nvishwa1-DESK>
References: <20220730122342.146475-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220730122342.146475-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 01:23:42PM +0100, Colin Ian King wrote:
>Variable ret is assigned a value that is never read; it is either
>being re-assigned during the following while-loop or after the loop.
>The assignmnt is redundant and can be removed.
>
>Cleans up clang scan build warning:
>drivers/gpu/drm/i915/gem/i915_gem_userptr.c:295:11: warning: Although
>the value stored to 'ret' is used in the enclosing expression, the
>value is never actually read from 'ret' [deadcode.DeadStores]
>
>Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>---
> drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
>index 8423df021b71..075aef875a07 100644
>--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
>+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
>@@ -292,7 +292,7 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
> 	if (!i915_gem_object_is_readonly(obj))
> 		gup_flags |= FOLL_WRITE;
>
>-	pinned = ret = 0;
>+	pinned = 0;
> 	while (pinned < num_pages) {
> 		ret = pin_user_pages_fast(obj->userptr.ptr + pinned * PAGE_SIZE,
> 					  num_pages - pinned, gup_flags,

LGTM.
Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

>-- 
>2.35.3
>
