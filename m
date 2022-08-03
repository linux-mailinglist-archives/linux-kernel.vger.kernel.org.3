Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108C8588CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiHCNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiHCNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:17:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DF2620;
        Wed,  3 Aug 2022 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659532626;
        bh=ijNK7+C9GwS9hFV217KdcR0mCCJXat/+dfi5+nWW7vo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KLVfhmUjZcW3w4VVKGLmouP9njA7VWHE6LDLlretIi4CWpeqvljsQs4OIYhSui5y7
         co7ZGz0fmvsmOc2va97EEApaFTc7hgUeLgpg1NqE9WUMj2iF18u0XQr7wAn7Vr4Sbu
         T0kYE8NLmLHg5KUC+F1pJqwnhtM0IRmJZc1oRFZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.66]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1nLJKy2l1G-016xYA; Wed, 03
 Aug 2022 15:17:06 +0200
Message-ID: <d7fb3369-ef7f-8d8f-48bc-fe7cd61047b5@gmx.de>
Date:   Wed, 3 Aug 2022 15:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] video: fbdev: arkfb: Fix a divide-by-zero bug in
 ark_set_pixclock()
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>,
        Ondrej Zajicek <santiago@crfreenet.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220803092313.2492371-1-zheyuma97@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220803092313.2492371-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQljVW+9U2quFOlICL5iuL0qQsxBfhrJ/SOcJDuXBcLxgtkcRMq
 N1VzQHqvyDjpI6ZUU9HAzKo0RYEGAybibieBpH9UP/PHT/WmA65wdyZPcC209YI0xARz1P9
 8BC3NMOMCSRe5ZJKsl6BltUUK3igg4tp3m6nn6MtiSYM106YPdcnxqsMRv51MPKVQ8L5fmn
 dA0M5ojv7+gYY3RYcWUJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4IFC4aVW08=:HnCeX4OCRi/TeYynLI1xBD
 zZKE9O64nRYUapljhlHNsnE428kIdlgmS5NUXtlqstdQ3i6oLaDzRL37vQBkWyMsGgjIG7B3r
 AEHXoy9i5/08pmUOKJc6i6EtNz5775Fyq93zNu1BFKNOZ9vSV0gJuqGn16ZcaybNUR1yQuIvL
 eJ3RIhqxunXfkLNyApuzq6XgcEP3QD/Ez+xLIJQ7sjLSgGpBjsHdfBS7jssqs7Op2LnWNFFdD
 TBLVB1WBKvkJukLv3z/hyQifCRCTKcCc7znZxF3DUSFUjnqIM2WxhzqAEzWgADwT48eCIGGLI
 zh23v7XvmTHtSBoYLk0sImX1V673Zzpc+ZqkRyDJbVhvEp/gEeQcYL80L0zkPNQP1iGjXyy2j
 YIOQFdBJLdVcSJLO/xnJ3RYiDCLgZ8BOgR5R05A9Slvqcqxj5LjFfvDPMv5ATnGntEIrnnEgj
 i3lBt92pV1hHqsxv+OH4J1yGhPC0gFlJaMicyDZOLFS5I/tCiYM10JLYJUa8c2/Y3kMuR11yL
 0rl08NyM/g2OYXneYh5HJiN0oUF0gB9yQ8v6McItgQcTYj8A2yK9DCx5Bh1b/HwAHZsAmJO3b
 MKf8zxQZ+8psG641SzPenI4g10fwqYv5w5ctR0lmrpNW6e8Xwf7w6BlOAaddoRt+4pu0vwpnl
 ehwv5kDgoRKJbfeAPLsziUC6wW1gBBSN3Psj4d4qDqqGLp2RsJx6OIP22Cm5bnZgaWv84LHxC
 9TIujyV9WwCy1AcKD7kbF3ZungYAxpv3QaftNTguBsr2Crp8NJJCrF/pSvN5Ph3zEuILscDIb
 one6vqUdIQrjC1wpWRNS1YShHnlHtokbNlZdOJjmoZQHcHjCLZF3QBgPmhJh92VcVxe0uK6g4
 1tWwV7y+1JyT6mdHw5A6k50sim/AinXXXujzqusU/ak+wpvZ8B38BJrUIlQSaTfPoDDYFV45/
 rYNt6dIWIDSdXh30U1dP6gg+jS/LRAdqX5kByxSfEP2Ntrbe4StmT84eOBoljJEfecBZB6EqW
 EEFjsm1ak+T7JqzbluMEYohOeTxFplQa3xrK3g7wH1oE1X+Xdo+TFejfeaJgvJ1Dz35pO2TGA
 nU0OXeBV3AtABBKgLTLYOppGaoDv05E91gpo/TVIV52bFe0ToBStaHFQg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 11:23, Zheyu Ma wrote:
> Since the user can control the arguments of the ioctl() from the user
> space, under special arguments that may result in a divide-by-zero bug
> in:
>   drivers/video/fbdev/arkfb.c:784: ark_set_pixclock(info, (hdiv * info->=
var.pixclock) / hmul);
> with hdiv=3D1, pixclock=3D1 and hmul=3D2 you end up with (1*1)/2 =3D (in=
t) 0.
> and then in:
>   drivers/video/fbdev/arkfb.c:504: rv =3D dac_set_freq(par->dac, 0, 1000=
000000 / pixclock);
> we'll get a division-by-zero.
>
> The following log can reveal it:
>
> divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> RIP: 0010:ark_set_pixclock drivers/video/fbdev/arkfb.c:504 [inline]
> RIP: 0010:arkfb_set_par+0x10fc/0x24c0 drivers/video/fbdev/arkfb.c:784
> Call Trace:
>  fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1034
>  do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1110
>  fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1189
>
> Fix this by checking the argument of ark_set_pixclock() first.
>
> Fixes: 681e14730c73 ("arkfb: new framebuffer driver for ARK Logic cards"=
)
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

applied to fbdev git tree.

Thanks!
Helge

> ---
>  drivers/video/fbdev/arkfb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> index eb3e47c58c5f..ed76ddc7df3d 100644
> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -781,7 +781,12 @@ static int arkfb_set_par(struct fb_info *info)
>  		return -EINVAL;
>  	}
>
> -	ark_set_pixclock(info, (hdiv * info->var.pixclock) / hmul);
> +	value =3D (hdiv * info->var.pixclock) / hmul;
> +	if (!value) {
> +		fb_dbg(info, "invalid pixclock\n");
> +		value =3D 1;
> +	}
> +	ark_set_pixclock(info, value);
>  	svga_set_timings(par->state.vgabase, &ark_timing_regs, &(info->var), h=
mul, hdiv,
>  			 (info->var.vmode & FB_VMODE_DOUBLE)     ? 2 : 1,
>  			 (info->var.vmode & FB_VMODE_INTERLACED) ? 2 : 1,

