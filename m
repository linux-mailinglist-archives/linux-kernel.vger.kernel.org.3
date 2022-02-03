Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BCA4A7D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348759AbiBCBHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiBCBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:07:40 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037CC06173E;
        Wed,  2 Feb 2022 17:07:40 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id e81so1662733oia.6;
        Wed, 02 Feb 2022 17:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3/2gr7P7TIioSsDPZqtUEHSC/S0NWVJIhuBQUzqg5s8=;
        b=n9WlvJIYgvnX5s9E2Jwr/ZPDLPuRFfX3txro5PAcZTzBjBh0xUsP8cPSVLQ/pQ6ESt
         uQ5JMbpx7srsQ1m3zPmv2LdQVFGhqAVMbluoK2+Lu9BjrEg3KnwXdxCDtTCinJQUUg2e
         OvJg7W9ExztLW0R4M0wsdRENlZTxqVkoGf3qvQXozC4WdGO1hRToBOoOkJrnlhlPbfiZ
         3NoXmk3WVZvrMV0794ZbVKexYgfoESZPoe5t80LEHEuqShhI//Bltoo8HSBTAFYzlLFM
         91dn4kzlMX/UrbOyZ9CeVAlpyDonFUmTD2lDGihP31yZM4u9lHywW0Slsk4bu1j+7Lw1
         SxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3/2gr7P7TIioSsDPZqtUEHSC/S0NWVJIhuBQUzqg5s8=;
        b=I9Xg7Qtp1uNvZTFMm10JSAWRY8hrTdv6s5NMCxXOpH0Xc/9CJ7+hLz91V8QmAW77zo
         0hKy7Q+9Vj9celRJlVO4si/ik8pmN6b45bZHKVMeUDlvnyKmAcex8AaN/3ssUExEQmGT
         K9iMbGKmViSxK1l69vt602Ij/YojqjDbZGMZEXPQ+Dr0CNqpFl/GpXR8C1ZfFw4jv+6d
         Ja4XmguKcJpppE4XFw9Q6Nl1S4Zw9Can/x9mlmfRRPymESuGfNOxpMFFsEHlPVUdGxNe
         dQD/ePPLShSfDzbtfTswrSnvu3uktmGSFVPwlGQOyYlRl1dsC5TSt7CsKmSEvd41aR1O
         tXKw==
X-Gm-Message-State: AOAM532NmX5e1ejTePK8PJaMGbrmNA3EbT4J/T2xqhe/u3DssArHQtq8
        WZBST2pFoOkKlb238OA9Tdw=
X-Google-Smtp-Source: ABdhPJxv07d1xSlLJoA8oCdawgQbico73dhVB2TOBe+Cu76BVRLpQ2jagVv5QaP8K81yyFA+0SLWsw==
X-Received: by 2002:a05:6808:d4f:: with SMTP id w15mr6402342oik.42.1643850459390;
        Wed, 02 Feb 2022 17:07:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m26sm15033837ooa.36.2022.02.02.17.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 17:07:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Feb 2022 17:07:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Message-ID: <20220203010737.GB2544812@roeck-us.net>
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
 <20220202235811.1621017-1-yzhai003@ucr.edu>
 <20220202235811.1621017-2-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202235811.1621017-2-yzhai003@ucr.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:58:09PM -0800, Yizhuo Zhai wrote:
> In function do_fb_ioctl(), the "arg" is the type of unsigned long,
> and in "case FBIOBLANK:" this argument is casted into an int before
> passig to fb_blank(). In fb_blank(), the comparision
> if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
> "arg" is a large number, which is possible because it comes from
> the user input. Fix this by adding the check before the function
> call.
> 
> Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

On a side note, change logs would be useful.

Guenter

> ---
>  drivers/video/fbdev/core/fbmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 0fa7ede94fa6..13083ad8d751 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1160,6 +1160,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		ret = fbcon_set_con2fb_map_ioctl(argp);
>  		break;
>  	case FBIOBLANK:
> +		if (arg > FB_BLANK_POWERDOWN)
> +			return -EINVAL;
>  		console_lock();
>  		lock_fb_info(info);
>  		ret = fb_blank(info, arg);
> -- 
> 2.25.1
> 
