Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEB4AAD41
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 01:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348322AbiBFAnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 19:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbiBFAnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 19:43:47 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7FC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 16:43:47 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 3e0f2c91-8538-11ec-ac19-0050568cd888;
        Thu, 03 Feb 2022 21:28:34 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 42F4D194B78;
        Thu,  3 Feb 2022 22:27:34 +0100 (CET)
Date:   Thu, 3 Feb 2022 22:27:31 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qing Wang <wangqing@vivo.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 07/21] fbdev/sysfs: Fix locking
Message-ID: <YfxIw83tbU4lrpKj@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-8-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-8-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:38PM +0100, Daniel Vetter wrote:
> fb_set_var requires we hold the fb_info lock. Or at least this now
> matches what the ioctl does ...
> 
> Note that ps3fb and sh_mobile_lcdcfb are busted in different ways here,
> but I will not fix them up.
> 
> Also in practice this isn't a big deal, because really variable fbdev
> state is actually protected by console_lock (because fbcon just
> doesn't bother with lock_fb_info() at all), and lock_fb_info
> protecting anything is really just a neat lie. But that's a much
> bigger fish to fry.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Qing Wang <wangqing@vivo.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
