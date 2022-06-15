Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016154CBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbiFOOxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiFOOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:53:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC470255B5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:53:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so11509874pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZC/vAUwnt16cnIDHnHVWxxFjsEFG6NHxlu49GtEvBqg=;
        b=FxJ4f3JGU5spOZCkifs9tv0qoQ3LMnq5o4+rI2EaouvetSY9lDrkFUeVDQvtuk6JZZ
         XqHh2TG31+MkWQsXnwoz6i67O2tuP6CUmTje8lnlUZlXcvcBAls9N2/cmw+NJjtPYrU/
         rlqYw+GNZULfYg0TvWJF7ztJkkFtTLQkIVlMCLQIAypwJskIADulcM0/5JPfqhfcPLaz
         T90zVdFXbFyhdb5+gcduX4wkiMPWiBIc993mdZUVr0/mxbTA66rV80I1NCMvfrTv4/zv
         UMVTHfGSZNEJ0QTKbVAOhEQfeRQc1F5lH81Q3BL8j05K25DcgtcYSVqUaenalkJuuzWa
         rVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZC/vAUwnt16cnIDHnHVWxxFjsEFG6NHxlu49GtEvBqg=;
        b=VFT7gESOFitsGEq8yzjGtzmLJoidHp2Gx2vZDun7/IMWQMWpSrndxfwjzjbyGYpsY4
         xbEuOWaImR+BoJmEgcmFpLyO2r82OW2OdMLnkPO7Id6oxc+Tqq8rTEDC02MQ9KuSlMvj
         EZtmnRbLkRP81W8RKKT7bpvlHRe8tsKJttSbnAPHC5R4YvAxm9TkX2xOZt1H8NKUh4qN
         2COTxG3sKoLoslhRMt7dnNdtCzwHdStcI77lZJWSXe7TXGBK9yXIRyuXO0pl6VOFEzNk
         m/fukrUDtRLI2e7e4POEhxL1HesdsxRZaG8hSPpkH4aar/9lygBJySts/Lzk9E0shmNh
         BAJw==
X-Gm-Message-State: AJIora/fwkTlBkoNEoE6Y7rLw9Y3ttSPw7eu55UZVDsgLwbND6LHw4mL
        U3QZsjOnEM8cuSSj0wRUKm78cw==
X-Google-Smtp-Source: AGRyM1uEZlmej3FRRSuBGwHjEpYnuEbnQJqaWyjuatDenHh+Y1t2tmMKCCvBjzWtqei8aSIcfieojQ==
X-Received: by 2002:a17:902:e746:b0:164:1974:e46c with SMTP id p6-20020a170902e74600b001641974e46cmr9975019plf.139.1655304825255;
        Wed, 15 Jun 2022 07:53:45 -0700 (PDT)
Received: from [10.4.220.81] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id e129-20020a636987000000b00408a3724b38sm4243427pgc.76.2022.06.15.07.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:53:44 -0700 (PDT)
Message-ID: <e815f04d-2646-05d2-ef96-7cd050ebc31c@bytedance.com>
Date:   Wed, 15 Jun 2022 22:53:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-iocost: fix lagging in-flight IOs detection
Content-Language: en-US
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220603092024.49273-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220603092024.49273-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, friendly ping...

Thanks.

On 2022/6/3 17:20, Chengming Zhou wrote:
> Since latency Qos detection doesn't account for IOs which
> are in-flight for longer than a period, we detect them by
> comparing vdone against period start. If lagging behind
> IOs from past periods, don't increase vrate, but don't let
> cmds which take a very long time pin lagging for too long.
> 
> The current code compares vdone against (vnow - period_vtime),
> which is thought to be the period start. But the earliest
> period start should be (vnow - period_vtime - margins.target).
> 
> And we will slide forward vtime and vdone on each period timer,
> so we can't depend on vtime to check if the iocg has pinned
> lagging for longer than MAX_LAGGING_PERIODS.
> 
> This patch adds lagging_periods in iocg to record how long
> the iocg has pinned lagging, will not be thought as lagging
> if longer than MAX_LAGGING_PERIODS.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v2:
>  - add lagging_periods to check very long lagging iocg.
> ---
>  block/blk-iocost.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 33a11ba971ea..998bb38ffb37 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -541,6 +541,8 @@ struct ioc_gq {
>  	u64				indebt_since;
>  	u64				indelay_since;
>  
> +	int				lagging_periods;
> +
>  	/* this iocg's depth in the hierarchy and ancestors including self */
>  	int				level;
>  	struct ioc_gq			*ancestors[];
> @@ -2257,10 +2259,13 @@ static void ioc_timer_fn(struct timer_list *timer)
>  		if ((ppm_rthr != MILLION || ppm_wthr != MILLION) &&
>  		    !atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
>  		    time_after64(vtime, vdone) &&
> -		    time_after64(vtime, now.vnow -
> -				 MAX_LAGGING_PERIODS * period_vtime) &&
> -		    time_before64(vdone, now.vnow - period_vtime))
> -			nr_lagging++;
> +		    time_before64(vdone, ioc->period_at_vtime - ioc->margins.target)) {
> +			if (iocg->lagging_periods < MAX_LAGGING_PERIODS) {
> +				nr_lagging++;
> +				iocg->lagging_periods++;
> +			}
> +		} else if (iocg->lagging_periods)
> +			iocg->lagging_periods = 0;
>  
>  		/*
>  		 * Determine absolute usage factoring in in-flight IOs to avoid
