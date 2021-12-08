Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975D46CD42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhLHFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:48:28 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45714 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhLHFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:48:27 -0500
Received: by mail-ed1-f52.google.com with SMTP id y12so4376620eda.12;
        Tue, 07 Dec 2021 21:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CjIKlAOQxW9e6blvv396Ckg6IdH6kNyZWhthx9zLlnI=;
        b=X8iU1KRYulHEdCON39gsDy77gxUCSJeqnjeArijJxPImK680dqKUgjMsP82YAw+y8H
         A0iG9ZcUFSDbl8PQYSUXDz4UqjrPYNrp4nqArJZmEjELr/9JMVaMmJoP+hIx4alLlrXS
         zluobNd0ZZmGFhswNdBO5bJze9vKj6XVvSIvotwQNMR1SeqkbYxmTjUr/Z+xQC8mFi2X
         LoYiCNfMJPdJTKH19OoyuqSFLPe3kLJ+qcIoQKZGLAuyatiaMF2wWAx54rq6gelkQtmh
         i7boqKWM3QBNDeW0j7pRn4QaECq8NED2W/5OyEojeQJVtXxXj+SkiOaWNXZ9Gx1u1cFv
         fJwQ==
X-Gm-Message-State: AOAM531OoWX+XQlBVGMHkSeUWSTxqLREZnqHo4CiI0sRXQZwHGT6wvwi
        G8iXe4yEOBZLiJvfmQ1Xwv8t6OxiiTI=
X-Google-Smtp-Source: ABdhPJzorWDstgVENbNVHLizBSMyZRKNSxhBBUSOGCTq0JTzT226rSdx6ncB7MGTk1fSyxc26U1NHw==
X-Received: by 2002:a05:6402:51cb:: with SMTP id r11mr16086368edd.150.1638942294757;
        Tue, 07 Dec 2021 21:44:54 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id hb10sm845525ejc.9.2021.12.07.21.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 21:44:54 -0800 (PST)
Message-ID: <3f96b310-74eb-5247-2ec3-bba9213e194d@kernel.org>
Date:   Wed, 8 Dec 2021 06:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tty: serial: return appropriate error on failure
Content-Language: en-US
To:     Vihas Mak <makvihas@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211207221741.50422-1-makvihas@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211207221741.50422-1-makvihas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 12. 21, 23:17, Vihas Mak wrote:
> when a user with CAP_SYS_ADMIN disabled calls ioctl (TIOCSSERIAL),
> uart_set_info() returns 0 instead of -EPERM and the user remains unware
> about what went wrong. Fix this.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215205
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
>   drivers/tty/serial/serial_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 61e3dd022..c204bdecc 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -960,7 +960,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>   		uport->fifosize = new_info->xmit_fifo_size;
>   
>    check_and_exit:
> -	retval = 0;
> +	retval = retval < 0 ? retval : 0;

This is wrong IMO. See:
https://bugzilla.kernel.org/show_bug.cgi?id=215205#c1

>   	if (uport->type == PORT_UNKNOWN)
>   		goto exit;
>   	if (tty_port_initialized(port)) {
> 


-- 
js
suse labs
