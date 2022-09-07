Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF55B0805
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIGPIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiIGPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845FAB530A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09B1161934
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C37C433D7;
        Wed,  7 Sep 2022 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662563319;
        bh=Mx0jPGtZh9KvHJBXC3DHP2hFP5jcs+G6XteAFAWh5CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oblWhgsO9Emx5t58TgoBHwCAfEnh9f3kgA3t8244JcZe//QinXf9lm0yHywCt0zdx
         BCQad5AvvhmDGmJbdVs5KE0D532+jb0IFykXbujP2bvqem4jFzXKV0UZSPG12naGxS
         k3nzgVSEyUrhVPJP6b4wNHVFZbeEx0LD4062s2yQ=
Date:   Wed, 7 Sep 2022 17:08:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH v6 00/57] DYNDBG: opt-in class'd debug for modules, use
 in drm.
Message-ID: <Yxiz9HsBusNAad3Z@kroah.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 03:40:37PM -0600, Jim Cromie wrote:
> hi Greg, Jason, DRM-folk, Steven,
> 
> If Im not too late for linux-next in this cycle, heres V6.  Diffs are minor:
> 
>  - rebased onto e47eb90a0a9a (tag: next-20220901, linux-next/master)
>    gets past Kconfig conflict, same for drm-tip.
>  - uint debug_level, not ulong.  to fit nouveau.
>  - -1 on param-read-back, to match prev write val.
>  - added back tracefs parts, missing from -V5
>    updated for tracing/events: Add __vstring() and __assign_vstr() helper macros
>    no decorations-lite in TP_printk, do it right later.
>  - commit-msg tweaks
> 
> Theres also new RFC stuff with the potential to reduce the size of the
> __dyndbgs section by 20%.  Not ready for prime time, or linux-next,
> but I hope compelling.
> 
> FEATURE DESCRIPTION
> 
> dyndbg provides DECLARE_DYNAMIC_DEBUG_CLASSMAP() which allows module
> authors to declare "good" class-names, of 4 types.
> 
>   DYNAMIC_DEBUG_CLASSMAP(drm_debug_classes,
>   			DD_CLASS_TYPE_DISJOINT_BITS, offset,
>                         "DRM_UT_CORE",
>                         "DRM_UT_DRIVER",
>                         "DRM_UT_KMS",
>                         "DRM_UT_PRIME",
>                         "DRM_UT_ATOMIC",
>                         "DRM_UT_VBL",
>                         "DRM_UT_STATE",
>                         "DRM_UT_LEASE",
>                         "DRM_UT_DP",
>                         "DRM_UT_DRMRES");
> 
> That usage authorizes dyndbg to set class'd pr_debugs accordingly:
> 
>   echo class DRM_UT_CORE +p > /proc/dynamic_debug/control
>   echo class DRM_UT_KMS  +p > /proc/dynamic_debug/control
> 
> Because the DRM modules declare the same classes, they each authorize
> dyndbg with the same classnames, which allows dyndbg to effect changes
> to its selected class'd prdbgs.
> 
> Opting in by using the macro effectively privatizes the limited
> 63-classes available per module; only modules which share classnames
> must coordinate their use of the common range, and they can
> independently use the remaining id-space.
> 
> Other dyndbg filtering pertains too, so single sites can be selected.
> 
> 
> 4 DD_CLASS_TYPE_*_*s determine 2 behaviors:
> 
>   DISJOINT	bits are independent, like drm.debug categories
>   LEVELs	3>2, turns on level-2, like nouveau debug-levels
>   NUM/BITS	numeric input, bitmap if disjoint, else 0-32.
>   NAMES		accept proper names, like DRM_UT_CORE
> 
> Dyndbg provides param-callbacks which enforce those behaviors:
> 
>   # DISJOINT_BITS
>   echo 0x03 > /sys/module/drm/parameters/debug
> 
>   # LEVEL_NUM
>   echo 3 > /sys/module/drm/nouveau/debug-mumble*
> 
>   # DISJOINT_NAMES
>   echo +DRM_UT_CORE,+DRM_UT_KMS,-DRM_UT_DRIVER > /sys/module/drm/parameters/debug_categories
> 
>   # LEVEL_NAMES
>   echo NV_TRACE > /sys/module/nouveau/parameters/debug-mumble*
> 
> That design choice is allowed cuz verbosity is always attached to a
> (user visible) interface, and theres no reason not to put the
> implementation there (in the callback).  It also considerably
> simplifies things; ddebug_change can treat class_id's as disjoint,
> period.
> 

I've applied the first 21 patches in this series to my
driver-core-testing branch, and if 0-day doesn't blow up on it, I'll
move it to my -next branch tomorrow and it will get a wider testing
range in the linux-next releases.

Feel free to rebase the rest of the series on top of my tree and
resubmit after addressing Daniel's comments.

thanks,

greg k-h
