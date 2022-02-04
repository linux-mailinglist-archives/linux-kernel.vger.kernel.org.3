Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659054AACEC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiBEWzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiBEWzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 17:55:14 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609ADC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 14:55:14 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 41731055-85f2-11ec-b20b-0050568c148b;
        Fri, 04 Feb 2022 19:40:06 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 17211194B8B;
        Fri,  4 Feb 2022 20:39:03 +0100 (CET)
Date:   Fri, 4 Feb 2022 20:39:00 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Zheyu Ma <zheyuma97@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 14/21] fbcon: use lock_fb_info in fbcon_open/release
Message-ID: <Yf2A1GN0Mg9aotUY@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-15-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-15-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:45PM +0100, Daniel Vetter wrote:
> Now we get to the real motiviation, because fbmem.c insists that
> that's the right lock for these.
> 
> Ofc fbcon.c has a lot more places where it probably should call
> lock_fb_info(). But looking at fbmem.c at least most of these seem to
> be protected by console_lock() too, which is probably what papers over
> any issues.
> 
> Note that this means we're shuffling around a bit the locking sections
> for some of the console takeover and unbind paths, but not all:
> - console binding/unbinding from the console layer never with
> lock_fb_info
> - unbind (as opposed to unlink) never bother with lock_fb_info
> 
> Also the real serialization against set_par and set_pan are still
> doing by wrapping the entire ioctl code in console_lock(). So this
> shuffling shouldn't be worse than what we had from a "can you trigger
> races?" pov, but it's at least clearer.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Du Cheng <ducheng2@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Zheyu Ma <zheyuma97@gmail.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>

Well, the patch does what the commit log says.
Acked-by: Sam Ravnborg <sam@ravnborg.org>
