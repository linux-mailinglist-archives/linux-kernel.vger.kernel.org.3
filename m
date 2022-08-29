Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80A5A44E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiH2IWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2IWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:22:01 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF715464E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:22:00 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id og21so14188077ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dAu938+Oc5mmzjcZqeDNo0n6Ic/OC5Iebo5+bvbeIlQ=;
        b=zOzYxOFNdpB2CiUn9SPnt2ILI5opV16eg92nCzud7ZZCfVHNnbr62DJNMEZUFMInCe
         pp5gQ/9sI1cGj1Qh7snCfvcLylC2lsDetSgcUZjuzNH/7FSpYLaV5FugRPU0RrT3YC2p
         DXqBqAqY4D09SFIDZFvPTByR7nEVaiCPViRwKXKtXDrCkyBYLOWeI4ArPlK6CEVlza+0
         186yogJgqoeAmhEJDi4EpbUeOJnyFRT11H3waB4f/u/bwdQOefqlbAYEcuouiOTabhs5
         +Z6YA1D271NW5my1751EN+2/cRup9A/Nxw5nh4ZDtQXQM8vTAztqRnUMoRk9kXbbfvTl
         Ct3Q==
X-Gm-Message-State: ACgBeo0Tf1LDiIsWc/1RW5VYoB0W8CuBhJoIbkSlcr9YcC4plZoOr5gD
        08jYtz8oTLcbTUy09IoRjNM=
X-Google-Smtp-Source: AA6agR4Ybr2UgIEU+qrHAzGwv5MpAVbR6OPx5lPWEIs541g91T5ruAA8qLZAUON8aPyJBiz2vvRqlQ==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr2951197ejb.725.1661761318644;
        Mon, 29 Aug 2022 01:21:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id fh10-20020a1709073a8a00b007307d099ed7sm4130572ejc.121.2022.08.29.01.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:21:58 -0700 (PDT)
Message-ID: <3746264c-adb1-80b4-02d2-13f0790fe322@kernel.org>
Date:   Mon, 29 Aug 2022 10:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tty/vt: Remove printable variable
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        nick black <dankamongmen@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
References: <20220826202419.198535-1-daniel.vetter@ffwll.ch>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220826202419.198535-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 08. 22, 22:24, Daniel Vetter wrote:
> Every since the 0.99.7A release when console_register() was introduced
> it's become impossible to call vt_console_print (called
> console_print() back then still) directly. Which means the
> initialization issue this variable protected against is no more.
> 
> Give it a send off with style and let it rest in peace.

FWIW:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

In hopes, nothing breaks.

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: nick black <dankamongmen@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Yangxi Xiang <xyangxi5@gmail.com>
> Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
>   drivers/tty/vt/vt.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ae9c926acd6f..4d29e4a17db7 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -157,7 +157,6 @@ static void set_palette(struct vc_data *vc);
>   
>   #define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
>   
> -static int printable;		/* Is console ready for printing? */
>   int default_utf8 = true;
>   module_param(default_utf8, int, S_IRUGO | S_IWUSR);
>   int global_cursor_default = -1;
> @@ -3085,8 +3084,6 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
>   	int kmsg_console;
>   
>   	/* console busy or not yet initialized */
> -	if (!printable)
> -		return;
>   	if (!spin_trylock(&printing_lock))
>   		return;
>   
> @@ -3537,7 +3534,6 @@ static int __init con_init(void)
>   	pr_info("Console: %s %s %dx%d\n",
>   		vc->vc_can_do_color ? "colour" : "mono",
>   		display_desc, vc->vc_cols, vc->vc_rows);
> -	printable = 1;
>   
>   	console_unlock();
>   

thanks,
-- 
js
suse labs

