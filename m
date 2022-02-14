Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99954B4288
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiBNHIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:08:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiBNHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:08:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA585839A;
        Sun, 13 Feb 2022 23:08:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so140971edd.1;
        Sun, 13 Feb 2022 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bT6rvQckvjjqoQ/XD4T+3/+zVByG4H4VWI5uUBKOAg4=;
        b=HPn4S+tf8qOXyHQ5GU6E8u5bHjBSKm5IzPld4ZhfDFML1a+poKQibfGDvysgT7hOhf
         nqFFLgTxXhiCiVP8XWcGz54JAHJ7gd5yI90I7mAeLZOb18apwb3t4DL+VZldUZB5gO5P
         44q+bLKCrDFZkzbiECM4djYg9a1T6TlAdrDWxelvbD3XZ/+wVeaMzHi+n18libKQDXkR
         wpUTYEj2KhKlG8SWPVXVpE2VBweDTvQmZ3GzfmB+ptDb20CU8z0uEIywewyRZ54qNpTX
         OCva1p86LeH2mYN2ppeBYFuJgJIK8vUEdbXuUt6jkgrupsrh27a4K5dkvJydJfvhD5MD
         vsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bT6rvQckvjjqoQ/XD4T+3/+zVByG4H4VWI5uUBKOAg4=;
        b=pxxDKPITzWNVbMFW1g+e99vQnEJ513GpArLWaQ2MY3TRuOn0QqcqQJnZ/QlT+LVyA5
         cEEE4fLNjqq54/DCxWc6P+vCimpQ2g7U3QD1lPqv/xUnQytzkkTNFjjh5S0jIvXYTeVt
         WxpXoxsBB+9OEeX3oZP9eQnBnCCs0fsBGqiPK7Bxiqm+gzpUU7uyme5zbDILRbApt2dg
         3jhqKoPPuAy3Z9yZy4zskegU2gJhPCmCS4ffalC9iaIXj+vOAvG/KKrF6PNnotpGSf9u
         zjMrQqVpKPgyKnUtr1ZSYN0cXIOdAJIEymCopkYbjmK3cQGeIX0DgpcsOVYMih59NGec
         6tJg==
X-Gm-Message-State: AOAM532flGzmMkFRFiS5FOqMC4GqqiJeAob0/nFUUJZfxhcE1L+p3ZZ1
        Gf45i46epm39ETDB1knk3yg=
X-Google-Smtp-Source: ABdhPJx1Hoca/TwI6wHcpTR272SAt0DNLGixxwUD/8psz9wtNQ/AA9N812ZwSUSsT5muW/9SzKJpxA==
X-Received: by 2002:aa7:cdc1:: with SMTP id h1mr407580edw.398.1644822520764;
        Sun, 13 Feb 2022 23:08:40 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id j8sm626580edw.40.2022.02.13.23.08.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Feb 2022 23:08:40 -0800 (PST)
Subject: Re: [PATCH 0/3] drm: omapdrm: Fix excessive GEM buffers DMM/CMA usage
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <f517358f-fb6c-3343-5d3a-006bd459f6ba@gmail.com>
Date:   Mon, 14 Feb 2022 09:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle ping

On 19.01.22 г. 12:23 ч., Ivaylo Dimitrov wrote:
> This patch series fixes excessive DMM or CMA usage of GEM buffers leading to
> various runtime allocation failures. The series enables daily usage of devices
> without exausting limited resources like CMA or DMM space if GPU rendering is
> needed.
> 
> The first patch doesn't bring any functional changes, it just moves some
> TILER/DMM related code to a separate function, to simplify the review of the
> next two patches.
> 
> The second patch allows off-CPU rendering to non-scanout buffers. Without that
> patch, it is basically impossible to use the driver allocated GEM buffers on
> OMAP3 for anything else but a basic CPU rendered examples as if we want GPU
> rendering, we must allocate buffers as scanout buffers, which are CMA allocated.
> CMA soon gets fragmented and we start seeing allocation failures. Such failres
> in Xorg cannot be handeled gracefully, so the system is basically unusable.
> 
> Third patch fixes similar issue on OMAP4/5, where DMM/TILER spaces get
> fragmented with time, leading to allocation failures.
> 
> Series were tested on Motolola Droid4 and Nokia N900, with OMAP DDX and
> PVR EXA from https://github.com/maemo-leste/xf86-video-omap
> 
> Ivaylo Dimitrov (3):
>    drm: omapdrm: simplify omap_gem_pin
>    drm: omapdrm: Support exporting of non-contiguous GEM BOs
>    drm: omapdrm: Do no allocate non-scanout GEMs through DMM/TILER
> 
>   drivers/gpu/drm/omapdrm/omap_gem.c        | 198 +++++++++++++++++-------------
>   drivers/gpu/drm/omapdrm/omap_gem.h        |   3 +-
>   drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c |   5 +-
>   3 files changed, 116 insertions(+), 90 deletions(-)
> 
