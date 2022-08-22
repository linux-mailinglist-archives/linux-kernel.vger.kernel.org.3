Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F759C989
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiHVUFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiHVUFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:05:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F14056E;
        Mon, 22 Aug 2022 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661198740;
        bh=vnTzmyaFvZ087BHDz5AGmvLkPA9Da9cTNk4rgkJoGPE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hBC6xyYHOiolsUgVklqA2opRLxWVGXJ8M71BDXFtHLJeI2yZS0vu+7MjeSm7arQ+5
         Ccxe2WA7EPgt/6lp0Hj6FNyaOwJuWNN/BIcRPO78WpJJJ6fjDaKmBjjcT2BbGcKCfJ
         KWIhHwz+QxWXGe5C0czenQXCmWUb0x5Ebq18c2LE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.222]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1obTQZ0gV5-00CvOr; Mon, 22
 Aug 2022 22:05:40 +0200
Message-ID: <e8e54b67-e434-9ee2-1999-1f447eb48d44@gmx.de>
Date:   Mon, 22 Aug 2022 22:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] fb_pm2: Add a check to avoid potential divide by zero
 error
Content-Language: en-US
To:     Letu Ren <fantasquex@gmail.com>, baihaowen@meizu.com
Cc:     zheyuma97@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220818104425.35573-1-fantasquex@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220818104425.35573-1-fantasquex@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GYyNvmTHGj7uficlN2aApE0D9+4tmU3SK4jihi9LJHTBUOAgnF0
 s4pAOskwSY1dOioQLPhpS7FGZnkgHbWP2ytfJZdMLPnOcN8tyrejsu/pYyTwEwcJh0/3AOx
 x1bpTQd54A5oS1UX6qFMtzOL0Gz/ZY4R8uskJWFyQOm2YkANar4/PAMdcKBIWKgEwmPeqOh
 wDSmZCGXTdvkR6he8tQCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bsYpdumw9Io=:ke2+CLJvE4rul6vP6sTu04
 j0JaWN5Huzks4LMGlF5vHkIESHyXXYfg1jib71577QLs5NeASdHLU3pz/MPnmwACAQ4W5tYeO
 VhH/01clEt22QRg8Oz6/L1IrOyT1+b6N0yOIfOFGu/xcIy2fmdGXzDIppuHE9OG1wfb2upcOH
 qKs4g6WXJzjGOXc3au9ZY0TwxfIuUnSzFStoWzcAmKuyHji+Y2kWGHch0/tGJz9rl4odfYgr6
 S/cjEUObZe98lgZ89p+SVAu1x3HA0BRaGRmz0O3I7bmKe5xv3JY6/Z0uNpzizjKHnRwCZQ5so
 ccL0LY1nJ2k8SL04FZBcqDVU6BzkJotD28whoFPFFWF5mjI5xybSxBm7HEt6tGAeTjz4o7q+F
 WV51w/66ATKqrlso/D2XWvNLLHVemFXMvcp3+cR8QbIqeZn+9BIAgnHAPWSyV6ydPq26nMgVL
 /aiXUTP5NplJiGz+l4rAWjf/odT8cym0XmZ4QFnbf5wTe5sT3AVGNqzgJOG4VuTfkSAaYNOrp
 FcpV8Ddd7RSAYlUwNvKB/h3XM3g4QR1Nlj3TuPm+tn+WIcg40LzpFf6b6QG5Mq7Xtgpy3v9fb
 wt1YaM+AWotVnYY7JYyvNFajsq5lIz+g5oVrOIOx2PKMn+yLslyufvJJCXul+SvC3qbSnpZx7
 bKQb+VN1ZaFr+iClQAKxS1lz3qBPEVX1oIjIFZbunjsBD1ec4IjDinE8nQisLT1KTahcYWaTC
 ZrMmVusvATbLE+27Eozc1VjTUdOxsIii01EHiJCrzqateBHcMuQ+F4uh0DfATytc0psR5w21s
 tOB9d7WeNvWFqBafYL21FRhXRa3O18rbJb147UeyUlbX9WzYmC4eIx4XlGIvvhBIImjNN43z2
 +Xa3TS+H/rukAZWYKtY7Anko/sFH2wXJDU25bG4MT7+jpm4UjPnjK44H/ycEEo2TWq4IPTusM
 c/WpM4g2eF+U09iLrD/vmzX9o6AHMieDqsosfmxp4n54zFQ6p/s4VKCeryFZrRAEvzzVJU9zj
 KU486KHxdQWlcXJOkOvAn0WMSxdSi8ollIa+0y6HhAeCWGBv07Q75rWEZ3EBP1FPUQoVsJvqZ
 mtQqUIJXPGBAgj38qORnrQrHycol5FoYyu8jSTD1xzifYArGnmUvfp4Lw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 12:44, Letu Ren wrote:
> In `do_fb_ioctl()` of fbmem.c, if cmd is FBIOPUT_VSCREENINFO, var will b=
e
> copied from user, then go through `fb_set_var()` and
> `info->fbops->fb_check_var()` which could may be `pm2fb_check_var()`.
> Along the path, `var->pixclock` won't be modified. This function checks
> whether reciprocal of `var->pixclock` is too high. If `var->pixclock` is
> zero, there will be a divide by zero error. So, it is necessary to check
> whether denominator is zero to avoid crash. As this bug is found by
> Syzkaller, logs are listed below.
>
> divide error in pm2fb_check_var
> Call Trace:
>  <TASK>
>  fb_set_var+0x367/0xeb0 drivers/video/fbdev/core/fbmem.c:1015
>  do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1110
>  fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1189
>
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Signed-off-by: Letu Ren <fantasquex@gmail.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/pm2fb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
> index d3be2c64f1c0..8fd79deb1e2a 100644
> --- a/drivers/video/fbdev/pm2fb.c
> +++ b/drivers/video/fbdev/pm2fb.c
> @@ -617,6 +617,11 @@ static int pm2fb_check_var(struct fb_var_screeninfo=
 *var, struct fb_info *info)
>  		return -EINVAL;
>  	}
>
> +	if (!var->pixclock) {
> +		DPRINTK("pixclock is zero\n");
> +		return -EINVAL;
> +	}
> +
>  	if (PICOS2KHZ(var->pixclock) > PM2_MAX_PIXCLOCK) {
>  		DPRINTK("pixclock too high (%ldKHz)\n",
>  			PICOS2KHZ(var->pixclock));

