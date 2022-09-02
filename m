Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DE5AB803
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIBSMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIBSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:12:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B5106D9C;
        Fri,  2 Sep 2022 11:12:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f24so2634802plr.1;
        Fri, 02 Sep 2022 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qXSasRBrbour0DrsSR74a0zFIaNcb92JbMh4N3aL/kk=;
        b=C6krQAkmnZUXAZUOemiCFBIp9svy4FoRuDZAaY8WLKWUHUT4blV3Qvv/QPscBe0DfX
         EeLXAJY5vlW7UYtwsiCVK1ML+s/KgwQezy+eKOxOWJMUrllqxTNJv1lox5esLSjYiSv5
         HICoGgGhv2maNaoE9+ZQG0UhzQSq6HDzJ5vcuWBuUJEiSVA/qRUuPOeJFJQ2RbZJ9e58
         tMXZI+cE53KqxgoiywdaQ8eR7OOYnMi1j4TfyqWFaa77xPyfaaL8msmnfQqGGGk6DTWP
         MHl5i6HdkYQKruQHr3qTB85j4aqIXNsVXF+8T5ciRpdU38Z3/wlvDA/jLGoLVThK4xSp
         HdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qXSasRBrbour0DrsSR74a0zFIaNcb92JbMh4N3aL/kk=;
        b=6WFWu97xmXmhBJYq9p3BDHRvNEbYDiSdD7tbccXjtGQbiDzi52oLzkLw7VAeseehcF
         p8QQtvjGQgJ55tCF33Vxww39tVo0Zlc1E3myyRbV4JKnTvmeTXQHhsm7XmGIBwPLGoKN
         TsfNoJf4q8+wReu18m93JhHg6GZ5gtV4VmXfZIdTwZzgSTA6pk8+aJ43MvJWfw/TnfDk
         uEqSPcUpsPG14BSPEiIfFg6krVcgQzhhnGMq82EScsksSHppsO60nSkViaYSuHkUJON3
         sjBiYJEPcDEiZ++3FPYIZ8roVRuMc8acthf4M6WxEL7xOkjW40sNbXJ2Shwljsue228s
         5l/A==
X-Gm-Message-State: ACgBeo2ws3+T+l7cl9xs5k49n9UbjrXw5Gbw4P1s0DpBX6FTCvGsfrqK
        ZOEbhdbsbtLR6z7nb2+ojP4=
X-Google-Smtp-Source: AA6agR7oSpGsec3utVnjIXVkhP+SLTmGHlFdC1QX6zt+RkmXC275Y+Q+LembaNt84cTdLMWkknEN2A==
X-Received: by 2002:a17:902:d4c4:b0:172:f328:e474 with SMTP id o4-20020a170902d4c400b00172f328e474mr36902644plg.144.1662142368939;
        Fri, 02 Sep 2022 11:12:48 -0700 (PDT)
Received: from biggie ([103.230.148.184])
        by smtp.gmail.com with ESMTPSA id z4-20020a626504000000b005375a574846sm2123232pfb.125.2022.09.02.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:12:48 -0700 (PDT)
Date:   Fri, 2 Sep 2022 23:42:41 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        hdanton@sina.com
Subject: Re: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called
 if write is in progress
Message-ID: <YxJHmYDMtmzaHWQG@biggie>
References: <20220814142543.24910-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814142543.24910-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 07:55:42PM +0530, Gautam Menghani wrote:
> The warning "URB submitted while active" is reported if the function
> send_packet() in imon.c is called if a write is already is in progress.
> Add a check to return -EBUSY in case a write is already is in progress.
> Also, mark tx.busy as false after transmission is completed.
> 
> Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> Cc: hdanton@sina.com
> Suggested-by: hdanton@sina.com
> Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  drivers/media/rc/imon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> index 735b925da998..a5b997c2c7e2 100644
> --- a/drivers/media/rc/imon.c
> +++ b/drivers/media/rc/imon.c
> @@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
>  	int retval = 0;
>  	struct usb_ctrlrequest *control_req = NULL;
>  
> +	if (ictx->tx.busy)
> +		return -EBUSY;
>  	/* Check if we need to use control or interrupt urb */
>  	if (!ictx->tx_control) {
>  		pipe = usb_sndintpipe(ictx->usbdev_intf0,
> @@ -654,6 +656,7 @@ static int send_packet(struct imon_context *ictx)
>  			pr_err_ratelimited("task interrupted\n");
>  		}
>  		mutex_lock(&ictx->lock);
> +		ictx->tx.busy = false;
>  
>  		retval = ictx->tx.status;
>  		if (retval)
> -- 
> 2.34.1
> 
Hi,

Please review the above fix and let me know if any changes are needed.

Thanks,
Gautam
