Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF347A5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhLTIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhLTIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:19:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3106C061574;
        Mon, 20 Dec 2021 00:19:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so9423735pjw.2;
        Mon, 20 Dec 2021 00:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EnWZaMVaub9bhuoJRmTQ6iCKZ/plnA1dGYyz2w8wNeg=;
        b=GV0fGLWuAUCiC02QPyI+3zEM+kPGREQnUpDRLMmICxTXkbtIFZ2AB5CXMFgMP0cOqG
         qAr1ke0MGRzLRhQuJUr+GyM5v6G/eJ5tDKu3wEo8iotkZE2w9ImqMfgHuh4HKmqOFiGH
         0fR50tIYNnF9zC+A+1ela+NtdfYj9wNRfWpNQvxZCuSKNktgLuvcDnW/emkdANgPjsRF
         o6Bx/Q6qRID5HbVpZu4n+Z+zC7+Dac6+//Us+HK0sdVTEE6WLLdUlO8pyfJiuShWWgA5
         biVe8qVFD691mlCV4Gx5+dHrONEfSZZ+K4WKbfrYta9EiM9f6dIEFYYj9HuVdmsxmlyM
         4qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EnWZaMVaub9bhuoJRmTQ6iCKZ/plnA1dGYyz2w8wNeg=;
        b=uKdk+v4pq93qwt7fFGe7uKYy/SJ7WDKww3KYLV7fiCHyFn2BKNDVJtkjxwU0PR4L+1
         5kHbkMxDSZN90dErGrsQETAKaO5dWfTjYcUMGxY1kMLzj5sq7cItAN1X/+mKmwqv8oY+
         qoG8ot0csJzFFavnLjMcqrIKIit2KMrXiwQGBICo/CbgwWyEvy+mDXGrCpsXR200A9Vk
         Dhc6CwSqxezTZVkRUu/y/qrkxSNJFdJWAO7zEfnhR8cXZfE83xgWIiU39Fk1F5B/A/jU
         q0Jb7Inx+0rrJdVbNkB1gkcDgPhETEkpb+UDW4FOS4o4qn1VCsONAwUni7kh2VxuTx0z
         GhDg==
X-Gm-Message-State: AOAM530/Me8MNDnlog7MULhqD9AvwmTjAAsbncu0c+lHdNgUvCSOivpA
        rR43Qw4qwG2vJhKz3+S9QIU=
X-Google-Smtp-Source: ABdhPJwgkvVMmnEbIFrcZvx8hOqLQBi+JM2r6aklfpVaZ2uX6vk+jnsl6y+C7uMvPDQ94XBg2gUpJA==
X-Received: by 2002:a17:90a:b94c:: with SMTP id f12mr11773171pjw.211.1639988397288;
        Mon, 20 Dec 2021 00:19:57 -0800 (PST)
Received: from google.com ([2620:15c:202:201:3e2e:1228:8845:1f8d])
        by smtp.gmail.com with ESMTPSA id w8sm4486622pfu.162.2021.12.20.00.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:19:56 -0800 (PST)
Date:   Mon, 20 Dec 2021 00:19:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>,
        syzbot+9780d2b05ac158d32284@syzkaller.appspotmail.com,
        Dmitry Torokhov <dtor@insightbb.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: powermate: kill urb in the disconnect function
Message-ID: <YcA8qX3irdSSJnN+@google.com>
References: <20211219060241.4125076-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219060241.4125076-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On Sun, Dec 19, 2021 at 02:02:15PM +0800, Dongliang Mu wrote:
> In powermate_disconnect, powermate_pulse_led will invoke
> powermate_sync_state and submit one urb with pm as its context.
> If powermate disconnect before the execution of complete handler,
> the pm will become a dangling pointer and lead to UAF.
> 
> Fix this by calling usb_kill_urb(pm->config) in the disconnect function.
> Note that, the error handling error does not need to take care of this.

Unfortunately this analysis is not correct and adding usb_kill_urb()
does not really help, as while input device is registered there may be
new events coming into the driver that may cause config URB be submitted
again.

What actually happens is that call to usb_free_urb(pm->config) below
tries to properly shutdown and destroy URB, but unfortunately
powermate_config_complete() handler only uses urb->status to print error
message, and resubmits the URB that is about to be freed again.

The URB completion handler needs to check for -ESHUTDOWN (-108) and
other terminal error codes before attempting to resubmit the URB.

> 
> Reported-by: syzbot+9780d2b05ac158d32284@syzkaller.appspotmail.com
> Fixes: ba0acb5ee318901 ("Input: move USB miscellaneous devices under drivers/input/misc")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/input/misc/powermate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
> index c4e0e1886061..903993469fde 100644
> --- a/drivers/input/misc/powermate.c
> +++ b/drivers/input/misc/powermate.c
> @@ -424,6 +424,7 @@ static void powermate_disconnect(struct usb_interface *intf)
>  	if (pm) {
>  		pm->requires_update = 0;
>  		usb_kill_urb(pm->irq);
> +		usb_kill_urb(pm->config);
>  		input_unregister_device(pm->input);
>  		usb_free_urb(pm->irq);
>  		usb_free_urb(pm->config);
> -- 
> 2.25.1
> 

Thanks.

-- 
Dmitry
