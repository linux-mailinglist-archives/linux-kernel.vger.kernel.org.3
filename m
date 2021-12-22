Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6A47D639
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbhLVSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhLVSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:06:35 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA10C061574;
        Wed, 22 Dec 2021 10:06:35 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id a11so3064301qkh.13;
        Wed, 22 Dec 2021 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IUZayHygg/mHpZzE7EAxAghOLCJTijtqipp9PGT47+U=;
        b=bqVx9BCR37xZNXgEKB56O0oZgBjdFFjGErC0uGOngxzLrmmCPWwGEIt6s5AVSRGov+
         IQh5WYYIhYQdMWJKzKFiODKFKNC7QiF3i3BeLctybd2CZbNzy+6jId+4pjQCMpe9BGhj
         ojG4O2n51+D2uTGwDWNVfdDnYHIk0PSAu2XRqkn3KGc1rHx/Q7faFwVDu3l+X8c/Q7uj
         RddZ8oWAlCHnpn7zvF3eJ/ctZsUs6Eg69G1lKmigvXw/ZA+4lxtHtayIRaUtkfCjfm2q
         qWZFmo2uadWEPE9puzxZFkweM6/Vg/sON5gTQ2v+q8gCJRJNC7swIAnNqnOPAvB0P92G
         J7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUZayHygg/mHpZzE7EAxAghOLCJTijtqipp9PGT47+U=;
        b=vWXArdUkna5tg6KdbjyTfg6gK0KieoNi5Vx6HMISCCB2qEG9z5uRCTx6eBlCpPbJ5f
         5x6fkJFybp17h8OfWEyMjEfx5pnyBdN1F8pl5dr7zf3nlIGHZUgNBgjhUOc5xWFRgI3t
         iaCv38I9Gflgb5JWH+lmfF1jdmczV8DP8KzBF/5G/osQjjw9g1gxerpzVl70/RLMk+YE
         iPDXwnzM8QHOVqzWwP79u5sHi4ghDUZP5NoYS4v+Z6pcoX/c155+ym6WBeOibl651fvm
         rTgpYv34EDUJgar/WVTljvrpzj9cypyzgMUyN1mzIK4MERBGM0rZtb1v1ByVXuTjlt56
         JNGA==
X-Gm-Message-State: AOAM532XdvkBhWpyLEAjDJBhuEJN+s6nE4d9ONMcpAlVQr1hzZ8VJb7z
        g6J40AiEIs/3GIH0J7+fZXmp1EeV2Z0=
X-Google-Smtp-Source: ABdhPJyyb5QxaoGblgSYlfwszpUwXqy8N6b5TGF4KRVGRLop2kK4/Y5RIDB/PsqMXmig4YO916eL7w==
X-Received: by 2002:a05:620a:2588:: with SMTP id x8mr2874325qko.292.1640196394934;
        Wed, 22 Dec 2021 10:06:34 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id y5sm1790258qkp.103.2021.12.22.10.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 10:06:34 -0800 (PST)
Subject: Re: [PATCH] of: unittest: Fix out of bounds array access when id < 0
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221092830.680839-1-yinxiujiang@kylinos.cn>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <96165b43-4be2-644c-dfc9-42173fcfc775@gmail.com>
Date:   Wed, 22 Dec 2021 12:06:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221092830.680839-1-yinxiujiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 4:28 AM, Yin Xiujiang wrote:
> In of_unittest_untrack_overlay if id is less than 0 then
> overlay_id_bits will be out of bounds. And it is also mentioned
> in bugzilla as a bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=214867
> 
> Fix this bug by tiggering WARN_ON()

This patch is just papering over the underlying problems.

The tracking of overlay ids in unittest.c depends on some
expectations of the expected range of values of id to be
tracked.  The resulting implementation is a bit fragile.
Let me take a look at whether I can create an alternate
implementation of id tracking.

-Frank

> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>  drivers/of/unittest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 5b85a2a3792a..094f9f4444d0 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1907,7 +1907,7 @@ static int overlay_first_id = -1;
>  
>  static long of_unittest_overlay_tracked(int id)
>  {
> -	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
> +	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS || id < 0))
>  		return 0;
>  	return overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id);
>  }
> @@ -1918,7 +1918,7 @@ static void of_unittest_track_overlay(int id)
>  		overlay_first_id = id;
>  	id -= overlay_first_id;
>  
> -	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
> +	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS || id < 0))
>  		return;
>  	overlay_id_bits[BIT_WORD(id)] |= BIT_MASK(id);
>  }
> @@ -1928,7 +1928,7 @@ static void of_unittest_untrack_overlay(int id)
>  	if (overlay_first_id < 0)
>  		return;
>  	id -= overlay_first_id;
> -	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
> +	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS || id < 0))
>  		return;
>  	overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
>  }
> 

