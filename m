Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B685A66A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiH3Ovk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiH3Ovg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:51:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072221037D2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:51:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id u18so1890949wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc;
        bh=Mu2WuN1UBLVgxsG5PQfNNp6YWfgQO7bTyIokirnc4Lc=;
        b=ZIoSsk14sjaGoG8r1ZCCUrsZ/xGHcf15KxEkmp/WBogpg++WrEi0y6frFFvYTnCSzJ
         barG5SjMlCxZolK9GOALGfNDeEp+KTk1YcxPaBjVBbr/kSJgC0GxTI8ZJhdXYG3+I1U0
         GUIbqvFkvv17K5S5bSmZLmFwK17pZeEgfHPTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc;
        bh=Mu2WuN1UBLVgxsG5PQfNNp6YWfgQO7bTyIokirnc4Lc=;
        b=4VkQigHvvRuKEfE7qpqAWTjCWYSWz5elgdIED/qbsP6oslD2ofBuKx3GOOawtMGBT/
         BzJjvVdM6KSiX0cy9rIGrPzN5JJUo1+yVi9aijyIVwAvPsyLnwCKg9nAEV+ZCjc/p7KY
         K2DrPa6xk0RC6kZKHlV4inBKQPeIw5NcXeq82WSN2RUyQNUrAtDkApf6xiSsrauEU4v8
         /FnMEid9iV5UwmscnrZWvgZkYD/raimJDygxfi6SudOpd0GOBxP012+yi2Upz+W7iPVW
         N+L2qXk/32RQGl+D58UPuLF/04ayiZxXtCPoVoE8ExehC5qKVzCe0WT149koPJRA1JCC
         qkGQ==
X-Gm-Message-State: ACgBeo3bnruTOX3s9WS+/VUkGsOtZa5lcO16clei3bN+KqtC86Ye3tjn
        YMC1Tv81hg6wOwiNRT3tr3PmVniMa8+183XD
X-Google-Smtp-Source: AA6agR6cYSwvnY+wIA5clnVjqWa7b0Lv7yqs8VdXHj0BT3qDJbv/UWSK3xDfakNtYnq9enHsl2kgJw==
X-Received: by 2002:adf:eb10:0:b0:225:70d5:e994 with SMTP id s16-20020adfeb10000000b0022570d5e994mr9046215wrn.425.1661871092386;
        Tue, 30 Aug 2022 07:51:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b002253fd19a6asm11557392wrh.18.2022.08.30.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:51:31 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:51:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        nick black <dankamongmen@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: Re: [PATCH] tty/vt: Remove printable variable
Message-ID: <Yw4j8Vs+Kx7ftaWX@phenom.ffwll.local>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        nick black <dankamongmen@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
References: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
 <20220830134117.416003-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830134117.416003-1-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 03:41:17PM +0200, Daniel Vetter wrote:
> Every since the 0.99.7A release when console_register() was introduced
> it's become impossible to call vt_console_print (called
> console_print() back then still) directly. Which means the
> initialization issue this variable protected against is no more.
> 
> Give it a send off with style and let it rest in peace.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: nick black <dankamongmen@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Yangxi Xiang <xyangxi5@gmail.com>
> Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Please disregard this, sent it accidentally instead of v2 of "tty/vt: Add
console_lock check to vt_console_print()".
-Daniel

> ---
>  drivers/tty/vt/vt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ae9c926acd6f..4d29e4a17db7 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -157,7 +157,6 @@ static void set_palette(struct vc_data *vc);
>  
>  #define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
>  
> -static int printable;		/* Is console ready for printing? */
>  int default_utf8 = true;
>  module_param(default_utf8, int, S_IRUGO | S_IWUSR);
>  int global_cursor_default = -1;
> @@ -3085,8 +3084,6 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
>  	int kmsg_console;
>  
>  	/* console busy or not yet initialized */
> -	if (!printable)
> -		return;
>  	if (!spin_trylock(&printing_lock))
>  		return;
>  
> @@ -3537,7 +3534,6 @@ static int __init con_init(void)
>  	pr_info("Console: %s %s %dx%d\n",
>  		vc->vc_can_do_color ? "colour" : "mono",
>  		display_desc, vc->vc_cols, vc->vc_rows);
> -	printable = 1;
>  
>  	console_unlock();
>  
> -- 
> 2.37.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
