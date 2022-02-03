Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFCA4AA704
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 07:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbiBEGBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 01:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344783AbiBEGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 01:01:44 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCCEC061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:01:42 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 5edcb8cc-8532-11ec-b20b-0050568c148b;
        Thu, 03 Feb 2022 20:46:32 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 4BF6A194B90;
        Thu,  3 Feb 2022 21:45:32 +0100 (CET)
Date:   Thu, 3 Feb 2022 21:45:29 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 06/21] fbcon: delete delayed loading code
Message-ID: <Yfw+6VUOX6xcf664@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-7-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-7-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jan 31, 2022 at 10:05:37PM +0100, Daniel Vetter wrote:
> Before
> 
> commit 6104c37094e729f3d4ce65797002112735d49cd1
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Tue Aug 1 17:32:07 2017 +0200
> 
>     fbcon: Make fbcon a built-time depency for fbdev
> 
> it was possible to load fbcon and fbdev drivers in any order, which
> means that fbcon init had to handle the case where fbdev drivers where
> already registered.
> 
> This is no longer possible, hence delete that code.
> 
> Note that the exit case is a bit more complex and will be done in a
> separate patch.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Du Cheng <ducheng2@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 8f971de35885..814b648e8f09 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -942,7 +942,7 @@ static const char *fbcon_startup(void)
>  		return display_desc;
>  	/*
>  	 * Instead of blindly using registered_fb[0], we use info_idx, set by
> -	 * fb_console_init();
> +	 * fbcon_fb_registered();
>  	 */
This comment change looks like it does not belong in this patch.
Also, the comment is wrong as info_idx is set in several places.
Like set_con2fb_map(), fbcon_remap_all(), and more.

Though it is not set by fb_console_init - so partly OK.

With the comment adjustment dropped.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

at least the code deletion looked OK, I failed to follow all the logic.
So would be good if someone else could ack it too.

	Sam



>  	info = registered_fb[info_idx];
>  	if (!info)
> @@ -3316,17 +3316,6 @@ static void fbcon_start(void)
>  		return;
>  	}
>  #endif
> -
> -	if (num_registered_fb) {
> -		int i;
> -
> -		for_each_registered_fb(i) {
> -			info_idx = i;
> -			break;
> -		}
> -
> -		do_fbcon_takeover(0);
> -	}
>  }
>  
>  static void fbcon_exit(void)
> -- 
> 2.33.0
