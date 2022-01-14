Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5E48E81A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiANKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbiANKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:10:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AEEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:10:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r28so14769907wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L+CN0gq3pLA6121ynnyAoFcRb1N4uFyFb+K1IzpWX/o=;
        b=Sxqfvyrg7X1JdLYtF4p7qZ9Lr/i6nC1UdCzXNxywNQGigjq+CXu96nOBxtzAMpVtDG
         MBCL6wEVeY7/2TpvwRdkENTR142OZemjnMcA679PtpRL7rQKOgTIvleawheeGfLM4akj
         +e+w6wK30D2BV+nx0sdUIayktQ4PZojXpBmUAz1lA4TMaa4wC/XX6ZPVKDdcP83a6n5c
         BDxjKAhvGOgQptQAk7FktsXGCsUImFhuMyBkLpoAcwTU9Rg5Q3RqVY6Ah7mVpj9CQMHS
         xqXYVe8ipNH2vERX5X58G1h/9PXJ4nSC1aO9lk612K69zrIHJLAoffCHoa5sZ4ujF76J
         ibeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L+CN0gq3pLA6121ynnyAoFcRb1N4uFyFb+K1IzpWX/o=;
        b=JWpNnp1Y65H1GWe/aOYOFKvZtTlQCv8rpDVwetB+g6zuKYhicC4Rs13TsmpF6xi5RM
         jeurU7yPjhYMHdhjhDEFKMlKQ/2EqVj5mnYWUUkLCIy2IGvD7kbgnBHwzptX9NU0FzeD
         w+VM1jmBzGJUCxwSbUMPdhVCQJuH1wG3j0Ut+pUsdiNFgIR5XIk8Klt4S/J2pTJYsxQU
         uCGbuVbRI+H8lhTKW6YkMORLnea+ZOOBC7ZK23PVm/sTGRi2H3PIteDuLAwu5h/EdZJv
         H0biDq55uZyGPX9N5FAK2TINgMdAHnm5f6ZA+UFqyVTPgzludhdXMmL2ukoOM6rXBdao
         zhvw==
X-Gm-Message-State: AOAM530Memtt4QtWNzNE+pgNrN288m7zp+U7S6bmlk7tuoJdrfYj37E1
        Jwc1PEhB4uGHzFw/lGhuZNo5mQ==
X-Google-Smtp-Source: ABdhPJwwmp3enXaurDy1M0y2dns9KYDg6m61xUfowYASjv4QdrVtXmbWWVc2AucaYUoYGfMi4PIGag==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr7765372wri.135.1642155004435;
        Fri, 14 Jan 2022 02:10:04 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id j13sm11345704wmq.11.2022.01.14.02.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 02:10:04 -0800 (PST)
Date:   Fri, 14 Jan 2022 10:10:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] pm / wakeup: simplify the output logic of
 pm_show_wakelocks()
Message-ID: <YeFL+g64SL3m/mVW@google.com>
References: <20220113184420.2504545-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113184420.2504545-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022, Greg Kroah-Hartman wrote:

> The buffer handling in pm_show_wakelocks() is tricky, and hopefully
> correct.  Ensure it really is correct by using sysfs_emit_at() which
> handles all of the tricky string handling logic in a PAGE_SIZE buffer
> for us automatically as this is a sysfs file being read from.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/power/wakelock.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index 105df4dfc783..52571dcad768 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -39,23 +39,20 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
>  {
>  	struct rb_node *node;
>  	struct wakelock *wl;
> -	char *str = buf;
> -	char *end = buf + PAGE_SIZE;
> +	int len = 0;
>  
>  	mutex_lock(&wakelocks_lock);
>  
>  	for (node = rb_first(&wakelocks_tree); node; node = rb_next(node)) {
>  		wl = rb_entry(node, struct wakelock, node);
>  		if (wl->ws->active == show_active)
> -			str += scnprintf(str, end - str, "%s ", wl->name);
> +			len += sysfs_emit_at(buf, len, "%s ", wl->name);
>  	}
> -	if (str > buf)
> -		str--;
>  
> -	str += scnprintf(str, end - str, "\n");
> +	len += sysfs_emit_at(buf, len, "\n");
>  
>  	mutex_unlock(&wakelocks_lock);
> -	return (str - buf);
> +	return len;
>  }
>  
>  #if CONFIG_PM_WAKELOCKS_LIMIT > 0

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
