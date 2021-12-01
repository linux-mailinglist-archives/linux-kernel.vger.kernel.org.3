Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317764656B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhLATpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhLATpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:45:43 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77125C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:42:21 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id a24so22769338qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8qO7om+4nzmjVjsLMIjPrTYZn6f70uApjbAzAFnAII=;
        b=WXUZqXTCL8KfwqinPOWIo0VazQNtMfkW6ZzGdxJJv5rt9/w8YZ2aOfLPn3ofIT+eta
         /6bYu4nAMTND/1lOvYXyvq0W/rA/J8fSEQph0jN1BhUDkKCU18UK8vYuHuYrK+FNkgfs
         TzVF/wkrzogBYmlJT5pApHunknHtH6H5/cpoWzi2/r9oUp4F8vrFTXb+t6oaCBMYGBHA
         RbJ68/noDvr+IZhPTWpFRGRQP5tKUC5t5ZYj0DVJKddtd1Vrhr7/9mO+poeChLTgxhfV
         znimU5VNCObWYB2NeaBxezk5qxa397FuwUxBB2VH6gtf+SF3L4m8Eaoy1qA40cJb0lHF
         C3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=l8qO7om+4nzmjVjsLMIjPrTYZn6f70uApjbAzAFnAII=;
        b=E3Km+hewDT4Zalj3a/1UYG/RdrPhgyObuOzIDUF/PioUU5PIg9vtlWP8Qrc/tU5rlR
         EeFmapBlsZ2IJ5WlAng22VYhvbqDgrWTlfnfYH4w7y8wYa8cHRs9ifmGzmuwZ/klSEul
         cpppyz4ttxJOysQCwBv0zgu9e5mlbbvic9ZtjfXATDTE4/ncpWaZHGyOcQIqVqlLazyY
         Y+KqfEF5KZcGHPnuxORj58hpOOLD42nXzaiGWYgmblF/CGi8pd74Ig0Fx8nYMHEU4d0E
         c778mN07Go9O/7SPh+ALd0ADaRjAwjtk0odM1P4CB64azTaIWT8YpxBIP99APe19uYJY
         ldlQ==
X-Gm-Message-State: AOAM5326KrdQsYZnhp9uECi3mrtG6k4+eFPW/QLYtf6bg9+Zaz8A3+e1
        tQuRtdD2amVG4+Vvpp2QOKRs8yiluw==
X-Google-Smtp-Source: ABdhPJw0B5Dubc1lv639hbPOVNk7NjlHQE8JRIwKZNoWQhvu1ueaJjXoBP5afRGTBY71eqD9GZl2dQ==
X-Received: by 2002:a05:6214:dc2:: with SMTP id 2mr8536953qvt.39.1638387740549;
        Wed, 01 Dec 2021 11:42:20 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x15sm379714qko.82.2021.12.01.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:42:20 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:b0fd:aad1:1fcc:32a6])
        by serve.minyard.net (Postfix) with ESMTPSA id 0DF0C1800B9;
        Wed,  1 Dec 2021 19:42:19 +0000 (UTC)
Date:   Wed, 1 Dec 2021 13:42:17 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi/watchdog: Constify ident
Message-ID: <20211201194217.GI15676@minyard.net>
Reply-To: minyard@acm.org
References: <20211128220154.32927-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128220154.32927-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 11:01:54PM +0100, Rikard Falkeborn wrote:
> ident is not modified and can be made const to allow the compiler to put
> it in read-only memory.

In my queue for next release.  Thanks.

-corey

> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 883b4a341012..0604abdd249a 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -668,7 +668,7 @@ static int ipmi_heartbeat(void)
>  	return rv;
>  }
>  
> -static struct watchdog_info ident = {
> +static const struct watchdog_info ident = {
>  	.options	= 0,	/* WDIOF_SETTIMEOUT, */
>  	.firmware_version = 1,
>  	.identity	= "IPMI"
> -- 
> 2.34.1
> 
