Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39EC4AACF4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 00:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381178AbiBEXCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 18:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiBEXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 18:02:00 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAEC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 15:01:58 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 31c0cf47-85f3-11ec-b20b-0050568c148b;
        Fri, 04 Feb 2022 19:46:49 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 37B32194B91;
        Fri,  4 Feb 2022 20:45:49 +0100 (CET)
Date:   Fri, 4 Feb 2022 20:45:46 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 15/21] fbcon: Consistently protect deferred_takeover with
 console_lock()
Message-ID: <Yf2CajIWrEEcA//9@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-16-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-16-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:46PM +0100, Daniel Vetter wrote:
> This shouldn't be a problem in practice since until we've actually
> taken over the console there's nothing we've registered with the
> console/vt subsystem, so the exit/unbind path that check this can't
> do the wrong thing. But it's confusing, so fix it by moving it a tad
> later.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Du Cheng <ducheng2@gmail.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>

It had helped me if the commitlog was explicit that the
deferred_takeover falg is moved to the worker function to reset it as
late as possible.

With the commit log updated:
Acked-by: Sam Ravnborg <sam@ravnborg.org>


> ---
>  drivers/video/fbdev/core/fbcon.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 496bc5f2133e..11b9f962af6f 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3247,6 +3247,9 @@ static void fbcon_register_existing_fbs(struct work_struct *work)
>  
>  	console_lock();
>  
> +	deferred_takeover = false;
> +	logo_shown = FBCON_LOGO_DONTSHOW;
> +
>  	for_each_registered_fb(i)
>  		fbcon_fb_registered(registered_fb[i]);
>  
> @@ -3264,8 +3267,6 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>  	pr_info("fbcon: Taking over console\n");
>  
>  	dummycon_unregister_output_notifier(&fbcon_output_nb);
> -	deferred_takeover = false;
> -	logo_shown = FBCON_LOGO_DONTSHOW;
>  
>  	/* We may get called in atomic context */
>  	schedule_work(&fbcon_deferred_takeover_work);
> -- 
> 2.33.0
