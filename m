Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76C4FF07B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiDMHYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiDMHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:24:43 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21614BFC4;
        Wed, 13 Apr 2022 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5u/yJFbxRgW2t+B3rx9C6wEYQQxVaCgfZ+ICC6Wpw7E=; b=F1JGwIlAUcDS//hyyFKjW7a6oE
        ARlYyQI3b9lAthrqyVgcEO/nk/zZNj+f/qgifQHe6Q7DfOdBI0NFygwfHo2jByyqYIfXn6KRSy5Vr
        b6uV8Rhf3MEtq8D7FpDJ5ZW8EVgizdUCTp7vM8TCjnyrDNJcoYbVJYo6VepK6oBrrVCGfokQahrkT
        1CAfQVQcO7h3r8IOiVm8lf37UsxZTpnqjDZSlAUh4zI57klIahz0ucgu8+eJ6hamXnuv+90JmWFgZ
        hl1oNcv/KJyHp5Ix9Yfu4JwoghGpVmO42PWiRfloNFGfef2zTB2cFV67uwD32wAt46C0VYhMhHkXj
        eXpE95YA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1neXKL-00083b-5h; Wed, 13 Apr 2022 10:22:09 +0300
Message-ID: <f403d196-352f-ee04-8568-d6600924af0f@kapsi.fi>
Date:   Wed, 13 Apr 2022 10:22:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/tegra: remove useless if check before kfree
Content-Language: en-US
To:     Bernard Zhao <zhaojunkui2008@126.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bernard@vivo.com
References: <20220413064618.23974-1-zhaojunkui2008@126.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20220413064618.23974-1-zhaojunkui2008@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 09:46, Bernard Zhao wrote:
> This patch remove useless if check before kfree.
> 
> Signed-off-by: Bernard Zhao <zhaojunkui2008@126.com>
> ---
>   drivers/gpu/drm/tegra/submit.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
> index 6d6dd8c35475..54ac31bc80f6 100644
> --- a/drivers/gpu/drm/tegra/submit.c
> +++ b/drivers/gpu/drm/tegra/submit.c
> @@ -639,8 +639,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
>   		kfree(job_data->used_mappings);
>   	}
>   
> -	if (job_data)
> -		kfree(job_data);
> +	kfree(job_data);
>   put_bo:
>   	gather_bo_put(&bo->base);
>   unlock:

(Same comment as for other patch.)

I personally dislike leaving the NULL checks off with calls to kfree. 
With the NULL check there, while reading the code it is obvious that the 
intention is that the value can be either a valid pointer or NULL. IMHO 
with C's type system/conventions we need this kind of contextual 
information to understand the code easily and avoid bugs.

Mikko
