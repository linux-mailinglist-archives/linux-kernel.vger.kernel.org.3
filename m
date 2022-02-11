Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E04B1B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbiBKB0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:26:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbiBKB0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:26:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BED267F;
        Thu, 10 Feb 2022 17:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0095CE25E4;
        Fri, 11 Feb 2022 01:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B3C004E1;
        Fri, 11 Feb 2022 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644542779;
        bh=RIkLyIEnDnAtAvgTMBO+mKp45fPhtgteavEWXrg4euw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aB890eTXzZCpBszQDfR46CLeerYfBHc5bLDOkAywlVEA1WljJIWndIonbdQAIba26
         xG113oP2lThwHHoe3M83ctVw/pUHspye+lYttVTGEciEE2qKeAGQt44DX6MWPK76bC
         4bZ8cY/axNQM1EhhtLpK2pntYohJevqYDVeVvtfsH7p2kD769D1r9BY/9qwzgqILWH
         9T7CxFLnujhP2sBHaTeXDX5N9xS8K6GbyialzD4zrGZUz7UbVP8LMbXNoU0eR/VpOi
         gMM1QtiUldaL3aWS5FPDP+KW+DUfS/OGszuunc33ihXBpbbiqy0yewrE2xupzGc9Mi
         W+nVS9hpc6EHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A8E2E5C0165; Thu, 10 Feb 2022 17:26:18 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:26:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     daniel@ffwll.ch, deller@gmx.de, sam@ravnborg.org,
        linux@roeck-us.net, willy@infradead.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pmenzel@molgen.mpg.de
Subject: Re: [PATCH linux-next] video: fbdev: fbmem: fix pointer reference to
 null device field
Message-ID: <20220211012618.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220210065824.368355-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210065824.368355-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:58:24PM +0800, Zhouyi Zhou wrote:
> In function do_remove_conflicting_framebuffers, if device is NULL, there
> will be null pointer reference. The patch add a check to the if expression.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Dear Linux folks
> 
> I discover this bug in the PowerPC VM provided by
> Open source lab of Oregon State University:
> 
> https://lkml.org/lkml/2022/2/8/1145
> 
> I found that the root cause of null device field is in offb_init_fb:
> info = framebuffer_alloc(sizeof(u32) * 16, NULL);
> 
> I have tested the patch in the PowerPC VM. Hope my patch can be correct.

This looks plausible to me, but I am quite unfamiliar with this code.

						Thanx, Paul

> Many Thanks
> Zhouyi
> --
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 34d6bb1bf82e..422b1fc01722 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1579,7 +1579,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  			 * If it's not a platform device, at least print a warning. A
>  			 * fix would add code to remove the device from the system.
>  			 */
> -			if (dev_is_platform(device)) {
> +			if (device && dev_is_platform(device)) {
>  				registered_fb[i]->forced_out = true;
>  				platform_device_unregister(to_platform_device(device));
>  			} else {
> -- 
> 2.25.1
> 
