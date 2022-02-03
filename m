Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF14A8418
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350636AbiBCMwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiBCMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:51:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F95C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 04:51:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e8so4953572wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=FUPIfszd+Y3hE4MXZ9LvXmC172Tu1YsDIDX0pVslV88=;
        b=SJbg68NvUvUz6JlqQSaxOonhT4mAOvcKWl24+3aeEkN/C1Eq4jUsGwuuNVnT5r4ShQ
         S4CCpbZnnReNr3hL8OgVf8+pJQP8m0GXazEV2XbfsHcM1B0QmoGYx8H2/uxUKFWlCYFG
         DcGR2UQ+XzHZwSvyV97uns+/wwZu3yj1ECS6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=FUPIfszd+Y3hE4MXZ9LvXmC172Tu1YsDIDX0pVslV88=;
        b=js8epN1NQttueHUgWTqn5KFcGHawg7fxTmo65BXwSDdvaZGoU5uOTtwpryQoNQ9uQm
         SAHPoibvzf0mgssmYxXmGsnulzMx/vK1CNfuyWJOoSqsyUJFGB6detPJbfwMSRoDg49i
         NmF7VbcoImE9oF/iroo/0yEOX8vNiuEBEhZRnjc8zKuM6k1w0M4OyVH+I7uN5fsatA44
         vOynMhujKRh0T3+dPJAh0AT0EJN+jYAvd5pt2h1OPokXY3rv6JU2PZnS3IrwvSz8wJ5+
         TS/kZaOq7foBBf3lJ8HbO17G4MDkpJU9K4LbT6pAIwHdyHoYU8PYTk5/ACEisESw314x
         Joxw==
X-Gm-Message-State: AOAM531TuXWDK0Q/wPExy8PDCHHbh5LMbPsXXXEQXOlc2mIBiYT4QnBS
        V0TygRCCZtCdzYalIVN3WNX6jw==
X-Google-Smtp-Source: ABdhPJzR42nAMyZ79Y6xhTnIHIKTFzdFNj0PSIWQX50mORQVSDsydvIvPCxezSwwDXLYrXyM95hc9Q==
X-Received: by 2002:a5d:5887:: with SMTP id n7mr29040764wrf.116.1643892716648;
        Thu, 03 Feb 2022 04:51:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v124sm7290459wme.30.2022.02.03.04.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:51:56 -0800 (PST)
Date:   Thu, 3 Feb 2022 13:51:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Yizhuo Zhai <yzhai003@ucr.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Message-ID: <YfvP6s+EByLAqL9K@phenom.ffwll.local>
Mail-Followup-To: Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>, Yizhuo Zhai <yzhai003@ucr.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xin Tan <tanxin.ctf@gmail.com>, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
 <20220202235811.1621017-1-yzhai003@ucr.edu>
 <Yft4qf3Hw7ntxc98@ravnborg.org>
 <d323261d-b123-27e5-b629-559ca892163d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d323261d-b123-27e5-b629-559ca892163d@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:18:30AM +0100, Helge Deller wrote:
> On 2/3/22 07:39, Sam Ravnborg wrote:
> > Hi Daniel,
> >
> > I assume you will take this.
> >
> > Patch is:
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 
> Acked-by: Helge Deller <deller@gmx.de>

Pushed to drm-misc-fixes, thanks for patch&review.
-Daniel

> 
> Helge
> 
> >
> > 	Sam
> >
> > On Wed, Feb 02, 2022 at 03:58:08PM -0800, Yizhuo Zhai wrote:
> >> In function do_fb_ioctl(), the "arg" is the type of unsigned long,
> >> and in "case FBIOBLANK:" this argument is casted into an int before
> >> passig to fb_blank(). In fb_blank(), the comparision
> >> if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
> >> "arg" is a large number, which is possible because it comes from
> >> the user input. Fix this by adding the check before the function
> >> call.
> >>
> >> Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
> >> ---
> >>  drivers/video/fbdev/core/fbmem.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> >> index 0fa7ede94fa6..13083ad8d751 100644
> >> --- a/drivers/video/fbdev/core/fbmem.c
> >> +++ b/drivers/video/fbdev/core/fbmem.c
> >> @@ -1160,6 +1160,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>  		ret = fbcon_set_con2fb_map_ioctl(argp);
> >>  		break;
> >>  	case FBIOBLANK:
> >> +		if (arg > FB_BLANK_POWERDOWN)
> >> +			return -EINVAL;
> >>  		console_lock();
> >>  		lock_fb_info(info);
> >>  		ret = fb_blank(info, arg);
> >> --
> >> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
