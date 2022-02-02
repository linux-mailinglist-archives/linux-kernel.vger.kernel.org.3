Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEF4AA6EF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 06:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbiBEFny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 00:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiBEFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 00:43:53 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32360C061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 21:43:53 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 8c6558ae-844d-11ec-ac19-0050568cd888;
        Wed, 02 Feb 2022 17:28:34 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id BB95A194B6F;
        Wed,  2 Feb 2022 18:27:27 +0100 (CET)
Date:   Wed, 2 Feb 2022 18:27:25 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: fbmem: Fix the implicit type casting
Message-ID: <Yfq+/dVOgDVbhjRJ@ravnborg.org>
References: <20220131065719.1552958-1-yzhai003@ucr.edu>
 <b1c1f68d-4620-2429-66bd-33d806d31457@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c1f68d-4620-2429-66bd-33d806d31457@gmx.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Tue, Feb 01, 2022 at 04:02:40PM +0100, Helge Deller wrote:
> On 1/31/22 07:57, Yizhuo Zhai wrote:
> > In function do_fb_ioctl(), the "arg" is the type of unsigned long,
> 
> yes, because it comes from the ioctl framework...
> 
> > and in "case FBIOBLANK:" this argument is casted into an int before
> > passig to fb_blank().
> 
> which makes sense IMHO.
> 
> > In fb_blank(), the comparision if (blank > FB_BLANK_POWERDOWN) would
> > be bypass if the original "arg" is a large number, which is possible
> > because it comes from the user input.
> 
> The main problem I see with your patch is that you change the behaviour.
> Let's assume someone passes in -1UL.
> With your patch applied, this means the -1 (which is e.g. 0xffffffff on 32bit)
> is converted to a positive integer and will be capped to FB_BLANK_POWERDOWN.
> Since most blank functions just check and react on specific values, you changed
> the behaviour that the screen now gets blanked at -1, while it wasn't before.
> 
> One could now argue, that it's undefined behaviour if people
> pass in wrong values, but anyway, it's different now.

We should just plug this hole and in case an illegal value is passed
then return -EINVAL.

Acceptable values are FB_BLANK_UNBLANK..FB_BLANK_POWERDOWN,
anything less than or greater than should result in -EINVAL.

We miss this kind or early checks in many places, and we see the effect
of this in some drivers where they do it locally for no good.

	Sam
