Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF758909C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiHCQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiHCQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:38:22 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F095AC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=68z9jyjknoySiaFxXXmGG4Vo8VW1dA2XzXu+STPvC0I=;
        b=QKKsqiFmmiNka2518t1sQHjj4pHlOGmU0AUh8gEQHlPr8pqX+P5e8QaUFUoe/pKvsOb3eJEinNarG
         0nWVGZnHpIMglOFI//RWXz0lF3nnThsl/OnMPSPk8ZWDtGqbkj5jIeqge/pvJ80QICdomvFUcNJETO
         yVRB8HIi23m+Hc8V2hTZ/OSDuJzumQDFOQRhpSxS1yJ4hrdTpIm19SgjbmtDvGhWgzn1TnGpK8O0cA
         rz8IIf0Qs5GLMPXvB06CwQb6oOJtllWcFgSTV3d1TBgROXBdx0QPM0lDR4XdXg/uJFwxJ/zcgMFIlM
         LCZqbB9aGyFCBOH2Z3oDAjZ3PLEWXag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=68z9jyjknoySiaFxXXmGG4Vo8VW1dA2XzXu+STPvC0I=;
        b=2iLl/ltvNnB/jcCTDDWYBHrZmGlI4rKbldzAPNHaOgVHSoml3mSZv6Qk5te2QAPhQk+itOoGySlzC
         1/gPbFjAA==
X-HalOne-Cookie: b64f77903176371c8467822ef5ec63017d31e85c
X-HalOne-ID: ad6a4b58-134a-11ed-be81-d0431ea8bb03
Received: from mailproxy3.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id ad6a4b58-134a-11ed-be81-d0431ea8bb03;
        Wed, 03 Aug 2022 16:38:17 +0000 (UTC)
Date:   Wed, 3 Aug 2022 18:38:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v7 0/5] drm: rename CMA helpers to DMA
 helpers
Message-ID: <YuqkeDmV0nFVhYuG@ravnborg.org>
References: <20220802000405.949236-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802000405.949236-1-dakr@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Tue, Aug 02, 2022 at 02:04:00AM +0200, Danilo Krummrich wrote:
> This patch series renames all CMA helpers to DMA helpers - considering the
> hierarchy of APIs (mm/cma -> dma -> gem/fb dma helpers) calling them DMA
> helpers seems to be more applicable.
> 
> Additionally, commit e57924d4ae80 ("drm/doc: Task to rename CMA helpers")
> requests to rename the CMA helpers and implies that people seem to be confused
> about the naming.
> 
> The patches are compile-time tested building a x86_64 kernel with
> `make allyesconfig && make drivers/gpu/drm`.
> 
> Changes in v2:
>   - Fixed up comments for consistent memory/address classification
>     (DMA-contiguous)
>   - Added a patch to rename struct drm_gem_dma_object.{paddr => dma_addr}
> 
> Changes in v3:
>   - Use a ccoccinelle script for
>     "drm/gem: rename struct drm_gem_dma_object.{paddr => dma_addr}" for fixing
>     up missing drivers and compile-test on x86_64, arm and arm64.
> 
> Changes in v4:
>   - Rebased all patches on drm-misc/drm-misc-next.
> 
> Changes in v5:
>   - Rebase of v4, meanwhile some merge conflicts came up on
>     drm-misc/drm-misc-next.
> 
> Changes in v6:
>   - Added a patch to remove unused include occurances of drm_fb_cma_helper.h
>     in various drivers.
> 
> Changes in v7:
>   - Fix `select DRM_KMS_{CMA => DMA}_HELPER` and
>         `select DRM_GEM_{CMA => DMA}_HELPER` in
>     drivers/gpu/drm/logicvc/Kconfig and drivers/gpu/drm/mxsfb/Kconfig which
>     slipped through in a rebase.
>   - Another rebase.
> 
> Danilo Krummrich (5):
>   drm/fb: remove unused includes of drm_fb_cma_helper.h
>   drm/fb: rename FB CMA helpers to FB DMA helpers
>   drm/gem: rename GEM CMA helpers to GEM DMA helpers
>   drm/gem: rename struct drm_gem_dma_object.{paddr => dma_addr}
>   drm/todo: remove task to rename CMA helpers

Thanks for looking into this task!
The patches are now applied to drm-misc (drm-misc-next).

	Sam
