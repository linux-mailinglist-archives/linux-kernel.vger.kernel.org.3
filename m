Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776F4D714A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 23:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiCLW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 17:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiCLW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 17:28:55 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB012AE3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 14:27:48 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id D544D603B9;
        Sat, 12 Mar 2022 22:27:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 927AA80011;
        Sat, 12 Mar 2022 22:27:45 +0000 (UTC)
Message-ID: <05dbfbd2670e2b28229d0ab96c1bd99787d4a187.camel@perches.com>
Subject: Re: [PATCH] drm/v3d: Use kvcalloc
From:   Joe Perches <joe@perches.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@oracle.com, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Mar 2022 14:27:44 -0800
In-Reply-To: <20220312152656.51625-1-harshit.m.mogalapalli@oracle.com>
References: <20220312152656.51625-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 927AA80011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: fpmtk5ye341iyaf6udwzfgyky1pez8ws
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18grHNWCCtKCR1M4ZlyWIVxGMpFIRxX0Fs=
X-HE-Tag: 1647124065-574508
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-12 at 07:26 -0800, Harshit Mogalapalli wrote:
> kvcalloc is same as kvmalloc_array + __GFP_ZERO.
[]
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
[]
> @@ -308,9 +308,8 @@ v3d_lookup_bos(struct drm_device *dev,
>  		return -EINVAL;
>  	}
>  
> -	job->bo = kvmalloc_array(job->bo_count,
> -				 sizeof(struct drm_gem_cma_object *),
> -				 GFP_KERNEL | __GFP_ZERO);
> +	job->bo = kvcalloc(job->bo_count, sizeof(struct drm_gem_cma_object *),
> +			   GFP_KERNEL);
>  	if (!job->bo) {
>  		DRM_DEBUG("Failed to allocate validated BO pointers\n");
>  		return -ENOMEM;

trivia:

The DRM_DEBUG could also be removed as the the alloc will do a
a dump_stack on failure.


