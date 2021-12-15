Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE31475326
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbhLOGtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:49:07 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46917 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhLOGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:49:06 -0500
Received: by mail-ed1-f43.google.com with SMTP id y13so70783637edd.13;
        Tue, 14 Dec 2021 22:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5c4Y2EZIe2jTzIgDwq+5ULEM5PC+1wAhegx/cChmgDA=;
        b=y+X4oL8dYNWTVOCLi9tAmoH9AV8+QHvskj197Vxi8sDno1UAsN78g6e2j6FAH9SItg
         QfSZLOklNyvelxwyCQYd8QQ7XDuTz7vXOqwnDMcpZjTK/a/orDl4cX3AjwTMt3er/xgO
         UCT1PiTrdgsX9EgZF8lecciHymRSD0wHUNo1ku02fJUp2AOqR0vj1an+HmugHaHozmW7
         S2NG3H5ASPdyHfSF60hdytIeAH72xt3mP0qjqkxyOQqkTbqsv0eCUIl32z8J0gnRmhWl
         4RorE7TA9jiEycv0CQgi/oJY3/OSFc0V4wuD+2LAOZbbtR03oQNGWkjv2JW66rWqbma/
         0Wuw==
X-Gm-Message-State: AOAM531JhrWd2NnuNCBRu6xfYGUXD9NdU0vh1ckNFVeMGEBlII+92SK4
        2Q1YlSbF6GixFqAiAzt8af8=
X-Google-Smtp-Source: ABdhPJyriWwORnVntwdo6aVlHnp8hfkLwlO/XGAJQkPjX7l4/X9i08gGHm5/S0C5dC4T6U4jZ1dWww==
X-Received: by 2002:aa7:d80d:: with SMTP id v13mr12964158edq.7.1639550945669;
        Tue, 14 Dec 2021 22:49:05 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 23sm305145ejg.213.2021.12.14.22.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 22:49:05 -0800 (PST)
Message-ID: <3fc784f1-5985-1553-c39f-8472cb63b1af@kernel.org>
Date:   Wed, 15 Dec 2021 07:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] tty: rpmsg: Fix race condition releasing tty port
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211214170646.25775-1-arnaud.pouliquen@foss.st.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211214170646.25775-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

much better IMO.

On 14. 12. 21, 18:06, Arnaud Pouliquen wrote:
> In current implementation the tty_port struct is part of the
> rpmsg_tty_port structure.The issue is that the rpmsg_tty_port structure is
> freed on rpmsg_tty_remove but also referenced in the tty_struct.
> Its release is not predictable due to workqueues.
> 
> For instance following ftrace shows that rpmsg_tty_close is called after
> rpmsg_tty_release_cport:
...
> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> index dae2a4e44f38..69272ad92266 100644
> --- a/drivers/tty/rpmsg_tty.c
> +++ b/drivers/tty/rpmsg_tty.c
> @@ -53,9 +53,19 @@ static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>   
>   	tty->driver_data = cport;
>   
> +	tty_port_get(&cport->port);

Can't this fail? Like when racing with removal?

>   	return tty_port_install(&cport->port, driver, tty);
>   }
...
>   static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
> @@ -139,6 +156,8 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
>   
>   static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
>   {
> +	tty_port_destroy(&cport->port);
> +

You should not call tty_port_destroy when you use refcounting. The port 
is already destroyed when ->destruct() is called. (It has currently no 
bad effect calling it twice on a port though.)

> @@ -146,7 +165,17 @@ static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
>   	kfree(cport);
>   }
>   
> -static const struct tty_port_operations rpmsg_tty_port_ops = { };
> +static void rpmsg_tty_destruct_port(struct tty_port *port)
> +{
> +	struct rpmsg_tty_port *cport = container_of(port, struct rpmsg_tty_port, port);
> +
> +	rpmsg_tty_release_cport(cport);
> +}
> +
> +static const struct tty_port_operations rpmsg_tty_port_ops = {
> +	.destruct = rpmsg_tty_destruct_port,
> +};
> +
>   
>   static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>   {
> @@ -179,7 +208,6 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>   	return 0;
>   
>   err_destroy:
> -	tty_port_destroy(&cport->port);
>   	rpmsg_tty_release_cport(cport);

Couldn't you just put the port here? And inline rpmsg_tty_release_cport 
into the new rpmsg_tty_destruct_port?

thanks,
-- 
js
suse labs
