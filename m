Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D25F4B6170
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiBODQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:16:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBODQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:16:12 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F1ADFC0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:16:04 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m22so13369393pfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bluBykRIiSTJNZD8TCQxil1bSJJGDYpHiwCAoIqV6+o=;
        b=KDTTrdDdUcvcCww9lKT48jqrXhbJgcRjCyzYnRiXDO+NaxBjNpuVNzHpaBAZ80Mt6p
         ubcdptWRlYjTgDO3zv86HQEJdh0sB33/BM4JjV/2UTDtDeucdH9ruSszLvkgiMGHoLAd
         ymQji2DiiP+mi/jU6XM9MRodeUVq2icLLGkfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bluBykRIiSTJNZD8TCQxil1bSJJGDYpHiwCAoIqV6+o=;
        b=27tg7Q6ElcAL+4qJeNVGpefh+KxlXH+S+xFrfCmxLuJThpIiJw2WZAzhcYDvaeYeg9
         shMNQlgl/CpJfucWi5f1f8qnoGk4szkn1S+TDmzGSsqZJaFOJcWSkaxr57ZcWtHDvqn5
         xMKkPkdkNszej4oZBiqSkYSHhKMgsSDuq3XQUclRRQbM3s1ZtEwBruIN9ghgiNYuGJ2k
         cZ8JPDPTA9nVWCs5TSAbmm7z9/H1oGNe3tokB3ZjR+W2n+Wcn/BSWc3PF6Sh1QNLPaLL
         1tEs0uTgtMexxn371gdTXAsk8Eq7ni2Habbi9boHNH3zcm75DAjqi5dyAud4HqiVC5vQ
         uaRA==
X-Gm-Message-State: AOAM533BcEPk9wVv7r9iKIOCE+YXousNZdYrltJVGaypqgHtu6bVvrEz
        GrOZYsHgaW37kIIU6qaAw6PGQg==
X-Google-Smtp-Source: ABdhPJx2/eiC2lvNFOg+YWokxgOc1KlCDz9e0huoC4ycR+2ezrz66lGuZNmu/iIHpYNjNIomPTlBxA==
X-Received: by 2002:a63:1655:: with SMTP id 21mr1825737pgw.498.1644894963702;
        Mon, 14 Feb 2022 19:16:03 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id o7sm569164pfw.114.2022.02.14.19.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 19:16:03 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:15:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andre Kalb <andre.kalb@sma.de>
Cc:     pmladek@suse.com, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        senozhatsky@chromium.org
Subject: Re: [PATCH v2] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <Ygsa7gfqlhZVWdDb@google.com>
References: <YgKSbe9d3haHKMid@alley>
 <YgpXWQqjfJBISG1v@pc6682>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpXWQqjfJBISG1v@pc6682>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/14 14:21), Andre Kalb wrote:
> +static void set_user_specified(struct console_cmdline *c, bool user_specified)
> +{
> +	if (!user_specified)
> +		return;
> +
> +	c->user_specified = true;
> +	console_set_on_cmdline = 1;
> +}

In original code we always set c->user_specified. Is it guaranteed that
->user_specified is properly initialized to 0? Maybe can do something like:

static void set_user_specified(struct console_cmdline *c, bool user_specified)
{
	c->user_specified = user_specified;

	if (!user_specified)
		return;

	console_set_on_cmdline = 1;
}
