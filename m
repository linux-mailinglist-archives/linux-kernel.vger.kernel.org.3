Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4B4B2741
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbiBKNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbiBKNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:35:02 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE61E3;
        Fri, 11 Feb 2022 05:34:59 -0800 (PST)
Received: from [192.168.0.7] (ip5f5aebe1.dynamic.kabel-deutschland.de [95.90.235.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3735261EA1927;
        Fri, 11 Feb 2022 14:34:56 +0100 (CET)
Message-ID: <74bc6234-1b95-7a0a-6ee7-b27fb80a12d4@molgen.mpg.de>
Date:   Fri, 11 Feb 2022 14:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH linux-next] video: fbdev: fbmem: fix pointer reference to
 null device field
Content-Language: en-US
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
References: <20220210065824.368355-1-zhouzhouyi@gmail.com>
Cc:     daniel@ffwll.ch, deller@gmx.de, sam@ravnborg.org,
        linux@roeck-us.net, willy@infradead.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rcu@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220210065824.368355-1-zhouzhouyi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Zhouyi,


Am 10.02.22 um 07:58 schrieb Zhouyi Zhou:
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
> 
> Many Thanks
> Zhouyi
> --
>   drivers/video/fbdev/core/fbmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 34d6bb1bf82e..422b1fc01722 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1579,7 +1579,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>   			 * If it's not a platform device, at least print a warning. A
>   			 * fix would add code to remove the device from the system.
>   			 */
> -			if (dev_is_platform(device)) {
> +			if (device && dev_is_platform(device)) {
>   				registered_fb[i]->forced_out = true;
>   				platform_device_unregister(to_platform_device(device));
>   			} else {

Looks reasonable.

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: Please note, this should be unrelated to my problem though, as I 
didn’t use linux-next. (Let’s continue in the other thread though.)
