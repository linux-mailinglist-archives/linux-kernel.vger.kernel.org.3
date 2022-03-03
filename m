Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651824CC4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiCCSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiCCSMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A851A3607;
        Thu,  3 Mar 2022 10:11:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11775B824C9;
        Thu,  3 Mar 2022 18:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93A6C004E1;
        Thu,  3 Mar 2022 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646331102;
        bh=vBvtniS14pc6skRP4v+SZ9dikE7hTS9c8Ik6/oxilws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3GyHI42VExg7lPhY2UU7c66P6HfWqGOz/RFFC12XDX84pF3EGsBGbXKThREoTRVS
         ZVHaDn9uNoO3ylEtVK2a8XkIEsXtIQWWqoXVgowzmSMAoAE+iteU74ICvmDy2PJ0H1
         DTPk48ro2GqmiPRSlRibKgtVghIOyag4xnbDZWOJ1v2ax2v6TeXPnGLNiA1ByY/5YL
         mT/FVqz8wp99PJlMTV+koZFxgoY/6kaqwhc3MGDD6rPV09RSb4d+mBCj53I0ESNYA6
         YQU1HEPJnz1Q5epWvJ+ZzOfa002ZLQ0EQEUSBR2a8aN77gEWRvag3lLceJVh2QOaUT
         2gDFH1vPEN6dg==
Date:   Thu, 3 Mar 2022 12:19:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/display: Fix Wstringop-overflow warnings
 in dc_link_dp.c
Message-ID: <20220303181957.GA1731711@embeddedor>
References: <20220303172503.GA1731116@embeddedor>
 <202203030937.5BFE3EF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202203030937.5BFE3EF@keescook>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:43:28AM -0800, Kees Cook wrote:
> On Thu, Mar 03, 2022 at 11:25:03AM -0600, Gustavo A. R. Silva wrote:
> > Fix the following Wstringop-overflow warnings when building with GCC-11:
> > 
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:493:17: warning: ‘dp_decide_lane_settings’ accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
> 
> Can you "show your work" a little more here? I don't actually see the
> what is getting fixed:
> 
> enum dc_lane_count {
> 	...
>         LANE_COUNT_FOUR = 4,
> 	...
>         LANE_COUNT_DP_MAX = LANE_COUNT_FOUR
> };
> 
> struct link_training_settings {
> 	...
>         union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX];
> };
> 
> void dp_hw_to_dpcd_lane_settings(
> 		...
> 		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
> {
> 	...
> }
> 
> static enum link_training_result dpia_training_cr_transparent(
> 		...
>                 struct link_training_settings *lt_settings)
> {
> 	...
>                 dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
>                                 lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
> 	...
> }
> 
> Everything looks to be the correct size?

Yep; this fix is similar to the one for intel_pm.c in this

	commit e7c6e405e171fb33990a12ecfd14e6500d9e5cf2

where the array size of 8 seems to be fine for all the
struct members related (pri_latency, spr_latency, cur_latency
and skl_latency):

drivers/gpu/drm/i915/i915_drv.h:465:struct drm_i915_private {
...

drivers/gpu/drm/i915/i915_drv.h-739-    struct {

...
drivers/gpu/drm/i915/i915_drv.h-745-            /* primary */
drivers/gpu/drm/i915/i915_drv.h-746-            u16 pri_latency[5];
drivers/gpu/drm/i915/i915_drv.h-747-            /* sprite */
drivers/gpu/drm/i915/i915_drv.h-748-            u16 spr_latency[5];
drivers/gpu/drm/i915/i915_drv.h-749-            /* cursor */
drivers/gpu/drm/i915/i915_drv.h-750-            u16 cur_latency[5];
drivers/gpu/drm/i915/i915_drv.h-751-            /*
drivers/gpu/drm/i915/i915_drv.h-752-             * Raw watermark memory latency values
drivers/gpu/drm/i915/i915_drv.h-753-             * for SKL for all 8 levels
drivers/gpu/drm/i915/i915_drv.h-754-             * in 1us units.
drivers/gpu/drm/i915/i915_drv.h-755-             */
drivers/gpu/drm/i915/i915_drv.h-756-            u16 skl_latency[8];

...
drivers/gpu/drm/i915/i915_drv.h-773-    } wm;
...
}

however GCC warns about accessing bytes beyond the limits, and turning the
argument declarations into pointers (removing the over-specified array
size from the argument declaration) silence the warnings.

--
Gustavo
