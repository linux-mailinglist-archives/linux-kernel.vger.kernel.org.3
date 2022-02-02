Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC44A7BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347948AbiBBXpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiBBXpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:45:31 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D087C061714;
        Wed,  2 Feb 2022 15:45:31 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m9so1330919oia.12;
        Wed, 02 Feb 2022 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gmc7on1XdfmDVEczUvMEGVY41ykXlSf/a2fAN6R0muI=;
        b=brWQKsEDHGv7zN10fDqDD/i4dQdznMFXRz1wJgyWtfisav3Iu+2BaKC6k9hBlu7hpE
         KHiwQezaZeXjPEoXWAB9nBme7DPzx+O0TB7xtAepZzUdauBvv2sQFuJIWNW7Ieu9fdoN
         zTvMBYLkUQB1T8piBEpMpZ8VFc+X7tQf6fRN0imAoirf21LwsJ70QwZ5R3SNtdHfBaEm
         DHgXgrYXTccMIHPF0w56qGYVZFCK157tLyRmk9F0y1xUX3Hv+b42HMIW6lMNqHPFxUUq
         RRJcMxPHYu5MBMU067G2QFszcmv0bUKh3IV48hQhy2XtsYW66vEcv/SMqzFrmzgzgWZg
         o/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gmc7on1XdfmDVEczUvMEGVY41ykXlSf/a2fAN6R0muI=;
        b=WpxkSJKhuY+CjrHPPRBDPrhABDqG4haAMAnIrw6heev+FFV+EO4MZtxKrG7ttElzjT
         JD0lXpcKvEJK123qB3L/pJVVvkC+fc/6JwhTnJzVOtQXeZrOUsK8TpQb2KBwHNvQvApC
         XNWwj+3JVx0q2wpWXCWUDVdt+2sJ5qVkjMRjhCaYYBoID2V5+bRKS8DobO4oBFoT+JwY
         XJxvtTSUHhl7y4QIXhPqZPDNW9jxxbupXoqVhCwe4OM4WU25zgA3/Wt3uzVfLgmIJ1eL
         //htEPeVuLcjzLSaE1liKGMgEorqT4ZlbyzPINLT0QlpgaCMG8s916znxAAEieYtjCri
         Fkow==
X-Gm-Message-State: AOAM530g2ORD3RE3vs+gwTaE8w6x8nYBtPNitlrDyk7Zz1wXFJnVhNWT
        BNrSVa9QEjKgIekJQ4yD8UU=
X-Google-Smtp-Source: ABdhPJxa3hIoIva8oqb851CRPaOreRHKX0Nl2x/0mw/4Lm6YleBnvUwwVDU3jmz6lCVYeSGCV3b43Q==
X-Received: by 2002:a05:6808:1406:: with SMTP id w6mr6110634oiv.330.1643845530789;
        Wed, 02 Feb 2022 15:45:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k19sm17579735oot.41.2022.02.02.15.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 15:45:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
Date:   Wed, 2 Feb 2022 15:45:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] fbdev: fbmem: Fix the implicit type casting
Content-Language: en-US
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
 <20220202233402.1477864-1-yzhai003@ucr.edu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220202233402.1477864-1-yzhai003@ucr.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 15:33, Yizhuo Zhai wrote:
> In function do_fb_ioctl(), the "arg" is the type of unsigned long,
> and in "case FBIOBLANK:" this argument is casted into an int before
> passig to fb_blank(). In fb_blank(), the comparision
> if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
> "arg" is a large number, which is possible because it comes from
> the user input. Fix this by adding the check before the function
> call.
> 
> Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
> ---
>   drivers/video/fbdev/core/fbmem.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 0fa7ede94fa6..d5dec24c4d16 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1162,6 +1162,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>   	case FBIOBLANK:
>   		console_lock();
>   		lock_fb_info(info);
> +		if (arg > FB_BLANK_POWERDOWN) {
> +			unlock_fb_info(info);
> +			console_unlock();
> +			return -EINVAL;
> +		}

Is it really necessary to perform this check within the lock ?
arg is a passed in value, and FB_BLANK_POWERDOWN.
It seems to me that

	case FBIOBLANK:
		if (arg > FB_BLANK_POWERDOWN)
			return -EINVAL;
		console_lock();
		...

should be sufficient.

Sorry if I missed some previous discussion; this is the first time
I looked at this patch.

Guenter
