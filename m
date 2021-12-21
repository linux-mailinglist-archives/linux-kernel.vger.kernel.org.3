Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEFB47C58B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhLURzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240727AbhLURzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640109318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YXqeevPDP+1UBV9Ug2JRSO8S/GdwQP1zLi0i9nvgv4=;
        b=G5O5jfUvVEaX12qPZzX0C20hqpUvD6hQMjm/KaffHH1arcnvBzdk0Arm+uHML4QFrnPlB6
        pehNABdPVxqdCwnKzoCI+LbsEDAmaiFYowGp6UVCZksveAZA6TGWldndpp7YvCNGt2M+pz
        8SjDInbg/ykno6EkDIisxJsZ14eoSRQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-OULt0kbOPBi0NkOtZUhuvg-1; Tue, 21 Dec 2021 12:55:17 -0500
X-MC-Unique: OULt0kbOPBi0NkOtZUhuvg-1
Received: by mail-ed1-f72.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so3389462edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3YXqeevPDP+1UBV9Ug2JRSO8S/GdwQP1zLi0i9nvgv4=;
        b=V9jZn1OIh/Pxr/q4tBeUQSO6s6Uj3/ePw+sKGJr/ZpO0dY4j+rOrU4dpcfzbbFUMg6
         WiPhSSn5wBp9+mCOutncCdkA1zp1VmjAfx0PRgxR4IJiMLdisGBcUBmcPoSwITdGM6cQ
         77FcCI2xctDvPat6SRgHpYv3hbiclpoeMwLYDPJul13jJHkEMyUHYBZSb+3mRv41KOxr
         psZzsLB+Ay1xnJMhPKJWZWzAR49e5+rZXedNrJVby7vZc1Ldb2K0bgp7vHAU+hZHopKP
         Niuh3uG4JDXwmH1EA/bCL/dQk+6I5dbmI4RvVpo4hSc/zjA3SELh0mDSAPhix1krvXfg
         jGhA==
X-Gm-Message-State: AOAM531AUrXUGoUxrErgJXOsD2pxYPrgxd4q3rK9YgL7Lv+c2HtRQRSR
        7/WQxh2QPMGgSLwHm9b6e4a01o5qor5yQqPmWEpL7ZhIIniCmTbiBvAw84FFnOROkXAze0mCZfJ
        QtOQZ07imxfeVnRYBSHZteWk3
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr3628955ejc.493.1640109316431;
        Tue, 21 Dec 2021 09:55:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhnjbZGpEfw35mdVtyznmcec6Y6z3XDoARgDffbwJy9dlBGOtX35DazYuz05u65b4NohlByw==
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr3628948ejc.493.1640109316280;
        Tue, 21 Dec 2021 09:55:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id c30sm956098ejj.190.2021.12.21.09.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:55:15 -0800 (PST)
Message-ID: <3d99e6ad-bf81-43b4-9970-b91aa78b44e6@redhat.com>
Date:   Tue, 21 Dec 2021 18:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform: x86: use resource_size() with res
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>, Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1639484316-75873-1-git-send-email-wangqing@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1639484316-75873-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/21 13:18, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> This should be (res->end - res->start + 1) here actually,
> use resource_size() derectly.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 9aae45a..57553f9
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -625,7 +625,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	}
>  
>  	gmux_data->iostart = res->start;
> -	gmux_data->iolen = res->end - res->start;
> +	gmux_data->iolen = resource_size(res);
>  
>  	if (gmux_data->iolen < GMUX_MIN_IO_LEN) {
>  		pr_err("gmux I/O region too small (%lu < %u)\n",
> 

