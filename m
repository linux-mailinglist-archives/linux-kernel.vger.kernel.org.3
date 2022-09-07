Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075135B07A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIGOzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIGOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786EDB531E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E613361957
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C091DC433D6;
        Wed,  7 Sep 2022 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662562443;
        bh=FnTuP15XLzFNLiYzDllSBtNOTSW5KL/gP6XWVJ3ejpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ohdn/uVYqN+mXpJ77/NZg/rgPYe7ewGTDztOmZITM6VaNb8GEYm9/cGMFt2/tN2di
         2kYrgbXRjDM1SlGRmyajY20ani3Fxqdl2BpREJzjos+HupAJGq+F8Wr1EvJ9qVLgL3
         /7Cvj2/vodNIOTEG60Q+aoMEXKhAQJBKdzBeDPPs=
Date:   Wed, 7 Sep 2022 16:54:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH v6 21/57] dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs
 nodes
Message-ID: <YxiwiO+Ni/CvAO5Q@kroah.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
 <20220904214134.408619-22-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904214134.408619-22-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 03:40:58PM -0600, Jim Cromie wrote:
> Demonstrate use of DECLARE_DYNDBG_CLASSMAP macro, and expose them as
> sysfs-nodes for testing.

Wait, why sysfs?

sysfs isn't for testing, why not use debugfs?


> 
> For each of the 4 class-map-types:
> 
>   - declare a class-map of that type,
>   - declare the enum corresponding to those class-names
>   - share _base across 0..30 range
>   - add a __pr_debug_cls() call for each class-name
>   - declare 2 sysnodes for each class-map
>     for 'p' flag, and future 'T' flag
> 
> These declarations create the following sysfs parameter interface:
> 
>   :#> pwd
>   /sys/module/test_dynamic_debug/parameters
>   :#> ls
>   T_disjoint_bits  T_disjoint_names  T_level_names  T_level_num  do_prints
>   p_disjoint_bits  p_disjoint_names  p_level_names  p_level_num

What is in these files?

For sysfs stuff, you need Documentation/ABI entries so that you can't
abuse sysfs.  With debugfs, you can do anything you want :)

thanks,

greg k-h
