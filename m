Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48164A4E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiAaS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350968AbiAaS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:29:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8466C06173D;
        Mon, 31 Jan 2022 10:29:09 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y15so28620794lfa.9;
        Mon, 31 Jan 2022 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qOOYqQyirhJ4gHyrf0pQn6wWDcf9SoG9lpkJduxhv4k=;
        b=cxtxBVJfaZ53YZqjv1zCKieiVOePdMVid12olZKkMqf4013+GlYyz+g479stJ3s1Iw
         bPLdtG7kphKcEoXRJMThS1JkynntZ9CZ4v8Ub0N/c6NcpJk2UgbAmxZbIOde+MbPalS0
         s68iETvNFwYmVSimrr5K33F5tK+25t9oWuLxARl690aL9rHQJzKQ3KbPxQDA6g38jE6w
         fUPZNftw+S4S7HttOvfn6iSwdxPPi3Ddgh7nl/8S3+G/h95wnNVxfq1wbweC6ZoHRWo/
         3qwEZOyoNXqsn9X1ixp5nCDFgdnA+oMZvtb2fYSXuoFrDMyeihtjl9wY2DzaEZVp+lUg
         /Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qOOYqQyirhJ4gHyrf0pQn6wWDcf9SoG9lpkJduxhv4k=;
        b=3PEeW6cGR2fi8Yq9//jAIwgl3mcu62A1unZPUsf1rpJ2D9ILOtOssQgiEZ1YiWZP/Z
         IRtWe0lqQtN081IfvsJ2XFMBSLzgQcJMCy8zHeeGdCFnD1vVEHXlr1sz8g3cPhB8R1Ei
         c7vHq6/yti2RH/W3XQtRiT2vfL0R6G4xFPTPPwMpwrI0XJw0oiI3Tj0wA2wIBKg17Q1e
         qp2GGnb5sib6lv5MsP9fzq8hq+IYTf7uVH2QZvM/W3CjF30HrElACYVNoGMNbezS+Jcm
         CQsSHb0QkozHonlRnJ4TZxEpHRy6TOL18cZgsRWk7LUaqx4i4tGH55NmyMi70wY51ARt
         bJLw==
X-Gm-Message-State: AOAM533nGkBj/eWwf+fD4oufNZlZOF7S7g3yQFoB3hU7uNOAxuGicXhC
        EUxbWSnYUXtQZuqXMBx1H/w=
X-Google-Smtp-Source: ABdhPJzgBn4YsT0MM8VrBY4KBgqjRFnemm3wEAwyeGfcRcpHOiEjYkpLJGEL27XmR1wbhKFaWTkp9w==
X-Received: by 2002:a05:6512:3f27:: with SMTP id y39mr17652645lfa.347.1643653748190;
        Mon, 31 Jan 2022 10:29:08 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.googlemail.com with ESMTPSA id t27sm2435829ljk.138.2022.01.31.10.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 10:29:07 -0800 (PST)
Message-ID: <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com>
Date:   Mon, 31 Jan 2022 21:29:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] PM: domains: Prevent power off for parent unless child is
 in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
References: <20220131113743.52265-1-ulf.hansson@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220131113743.52265-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2022 14:37, Ulf Hansson пишет:
> A PM domain managed by genpd may support multiple idlestates. During
> genpd_power_off() a genpd governor may be asked to select one of the
> idlestates based upon the dev PM QoS constraints, for example.
> 
> However, there is a problem with the behaviour around this in genpd. More
> precisely, a parent-domain is allowed to be powered off, no matter of what
> idlestate that has been selected for the child-domain.
> 
> So far, we have not received any reports about errors, possibly because
> there might not be platform with this hierarchical configuration, yet.
> Nevertheless, it seems reasonable to change the behaviour into preventing
> the parent-domain from being powered off, unless the deepest idlestate has
> been selected for the child-domain, so let's do that.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5db704f02e71..7f97c5cabdc2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -636,6 +636,17 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>  			atomic_read(&genpd->sd_count) > 0)
>  		return -EBUSY;
>  
> +	/*
> +	 * The children must be in their deepest states to allow the parent to
> +	 * be powered off. Note that, there's no need for additional locking, as
> +	 * powering on a child, requires the parent's lock to be acquired first.
> +	 */
> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +		struct generic_pm_domain *child = link->child;
> +		if (child->state_idx < child->state_count - 1)
> +			return -EBUSY;
> +	}
> +
>  	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>  		enum pm_qos_flags_status stat;
>  
> @@ -1073,6 +1084,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  	    || atomic_read(&genpd->sd_count) > 0)
>  		return;
>  
> +	/* Check that the children are in their deepest state. */
> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +		struct generic_pm_domain *child = link->child;
> +		if (child->state_idx < child->state_count - 1)
> +			return;
> +	}
> +
>  	/* Choose the deepest state when suspending */
>  	genpd->state_idx = genpd->state_count - 1;
>  	if (_genpd_power_off(genpd, false))

Hello Ulf,

Is this needed by a concrete SoC? It needs to be clarified in the commit
message, otherwise looks like this patch wasn't tested and it's unclear
whether this change is really needed.
