Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3579487DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiAGVBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiAGVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:01:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076CC061574;
        Fri,  7 Jan 2022 13:01:36 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x7so19851246lfu.8;
        Fri, 07 Jan 2022 13:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYsF1MlT+oLQPwSGSddilNMw95xcZJ7HznnO1uWFm8I=;
        b=LqPRfxLi7DqJd/HOUZ4XQQZr8ti7zG35Z3qK0sVpES24j5Upfyf0FtmjG+/v1/c8xo
         FQ6TNwCDfycxtsS46VnAWtXF4bQoBY4ZrzcHWoN9SDLz8d1R4jMlZVJYVLtlR9H22BNt
         IPXPe53nvH8iIFC5uc2u/jeeVahF+dmZzGcDNftD9+JJ99D+O5u8GBth4ZbM4UQL3LfL
         R2MvPUsqS9FNw5xaBA1rdWSJx0UM/T/KMpn+W5JB9k3515exOAN6eLyqc+hOeIThG2GZ
         W/x+ZpA473eJ2KqUEuClza6+0fc3t3Ii3TuO8kStStDuZziYeTCkR+Fr8cpUUV9NsKjD
         tfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYsF1MlT+oLQPwSGSddilNMw95xcZJ7HznnO1uWFm8I=;
        b=jA+3IspSDB/oANuZiddJXWdRMUdhqwCD7q6xNkX7Hyv+rTQWuPrzkH9+zC8Vpztzsg
         swgd06PBV77PqSfC7R5YqsEYGD3B0yHAndoIqjfffaDO9+N5aZTFpFxLtVIEoJ7Itby0
         qAW2gY1pWUf3OCubum3F532mn1lKYYycok29H4nCpgkIhAtwzUAqeEaeNRMETrGQEJR6
         bo+CkPDglcaH3Z7jjIiQiyEjzKasPsp6JnCL5O4nBHKT2AXc12mJbpAGj18RYqq8VHEW
         1ydlBzjN8U8Ox5HsYz5/dlDTA/7KvEZvMfAYJafaXZKS70t2CQckmNuamXj3DPogJhZe
         /O7w==
X-Gm-Message-State: AOAM531z84G8RwIqINnZWLPTwxMCZHBLivKvAwsWsgVPDgIKdV2TmuHn
        6q65SsKsCYjdeCrSl14pibc=
X-Google-Smtp-Source: ABdhPJwRvJP9mJ8cEjfVRCF5EIlJvc6FB1T2y3fbShFHTpOnWBVuSA8ajnjQadoPfpau2lk6IYBodQ==
X-Received: by 2002:a19:380e:: with SMTP id f14mr57642917lfa.612.1641589294390;
        Fri, 07 Jan 2022 13:01:34 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id i7sm712214lfu.175.2022.01.07.13.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:01:33 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id DCFD75A0020; Sat,  8 Jan 2022 00:01:32 +0300 (MSK)
Date:   Sat, 8 Jan 2022 00:01:32 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, sfr@canb.auug.org.au,
        legion@kernel.org, sashal@kernel.org, chris.hyser@oracle.com,
        ccross@google.com, pcc@google.com, dave@stgolabs.net,
        caoxiaofeng@yulong.com, david@redhat.com, pintu.ping@gmail.com,
        vbabka@suse.cz, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] sysinfo: include availram field in sysinfo struct
Message-ID: <YdiqLKS5Sv9eWwu2@grain>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:37:34PM +0530, Pintu Kumar wrote:
> The sysinfo member does not have any "available ram" field and
> the bufferram field is not much helpful either, to get a rough
> estimate of available ram needed for allocation.
> 
> One needs to parse MemAvailable field separately from /proc/meminfo
> to get this info instead of directly getting if from sysinfo itself.

Who exactly needs this change? Do you have some application for which
parsing /proc/meminfo is a hot path so it needs this information via
sysinfo interface?

Don't get me wrong please but such extension really need a strong
justification because they are part of UAPI and there is not that much
space left in sysinfo structure. We will _have_ to live with this new
field forever so I propose to not introduce anything new here until
we have no other choise or parsing meminfo become a really bottleneck.

> diff --git a/kernel/sys.c b/kernel/sys.c
> index ecc4cf0..7059515 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2671,6 +2671,7 @@ static int do_sysinfo(struct sysinfo *info)
>  	info->freeram <<= bitcount;
>  	info->sharedram <<= bitcount;
>  	info->bufferram <<= bitcount;
> +	info->availram <<= bitcount;
>  	info->totalswap <<= bitcount;
>  	info->freeswap <<= bitcount;
>  	info->totalhigh <<= bitcount;
> @@ -2700,6 +2701,7 @@ struct compat_sysinfo {
>  	u32 freeram;
>  	u32 sharedram;
>  	u32 bufferram;
> +	u32 availram;

If only I'm not missing something ovious, this is part of UAPI as well.
