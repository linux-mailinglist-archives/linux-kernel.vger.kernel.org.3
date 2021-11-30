Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D305463E43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbhK3TAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbhK3TAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:00:46 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:57:26 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k2so43086690lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nwpZgGmQ5ALmjpN1leDuBf91wJZekYXv4KJ/1++WwDE=;
        b=bpu7XPqKR/UBhAjgQL433xaTphjoT/opwc4z628rx5k0ELVKKhL4MLNCI0RR4MbxB9
         sw13AMmRau2Qp1zmzzBphSMADZKsJQCyNmPT0vFwi9aJKoSNdAXobDbqbGszyTtmz7Kr
         d+HuWINElx9UroI5i/v1msLxJ5pIGb5+SClvmYPhtX/Rj4jh9QVkI1MhY1zOg0IAzk6O
         s+dAG0oOt6fpVMpPEEHBxgIoEkAJUkim+yzV/4dwTfGmtXLt+q8m/KgfvOsaaRJCTxMd
         0TUcx2lXqKjNTgXA+g7lQei9JFQId+vIpCZ0MIfT4/mYyFm4wlXocMRGAruza2UQu5T7
         fwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nwpZgGmQ5ALmjpN1leDuBf91wJZekYXv4KJ/1++WwDE=;
        b=C+diyeexQAd/ElwdI3AfVIaIW16fi2GsLP+IGVlI7z2+ggLeRKEaPXFnduPFVOGTlj
         zrTn1kCq4CHxDZ/hysNOePkgDTDFwyf7oIYzwJuTf3ru/fER/l/pO7fIKJyxmRorkWEr
         SG9hx+Vhk35BGu6putprcv1bcu76/21LIBAyhdQL/YsMoBoqz4ISJeyx4vCbV7hfBjZr
         jSPjgwFeWns6qKpKs5JElIXNmW4Z5rDYSCEcWmyjo7egapBea0TV4+QnOunqQEemiTyL
         BgpDUbBFP1Q/sQ2rA8exLEMpzgT7ziG+GwBXLVlT/mNAzWTZttaQj34R8KFTH/qoKNza
         I4Ag==
X-Gm-Message-State: AOAM531xabTW374GVd0qwqgKz9Yt0AesjMoQCPo35CSOMhhBnQqX0rxm
        2uXp+QdLc4ehW9SOxxR4zaA=
X-Google-Smtp-Source: ABdhPJwRRD9/dfXd34F05JxqeKjDTQ8jAApBvYS2CDM7kLtu9nSiYZivr1DmFNmYpCIdBJCbL/LpAA==
X-Received: by 2002:a05:651c:1a4:: with SMTP id c4mr748038ljn.3.1638298644549;
        Tue, 30 Nov 2021 10:57:24 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id h17sm2032330lfj.160.2021.11.30.10.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 10:57:24 -0800 (PST)
Message-ID: <851b57b9-79ac-e7a1-a61a-6f36a5d9d77a@gmail.com>
Date:   Tue, 30 Nov 2021 21:57:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next] staging: rtl8192e: rtllib_module: fix missing
 free_netdev() on error in alloc_rtllib()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org
References: <20211130034007.779351-1-yangyingliang@huawei.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211130034007.779351-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 06:40, Yang Yingliang wrote:
> Add the missing free_netdev() before return from alloc_rtllib()
> in the error handling case.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/staging/rtl8192e/rtllib_module.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index 64d9feee1f39..18d898714c5c 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>   
>   	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
>   	if (!ieee->pHTInfo)
> -		return NULL;
> +		goto failed;
>   
>   	HTUpdateDefaultSetting(ieee);
>   	HTInitializeHTInfo(ieee);
> 

Good catch!

There are 2 more possible leaks, tho. rtllib_networks_allocate() and 
rtllib_softmac_init() should be unwinded too.

For some odd reason rtllib_softmac_init() does not return an error in 
case of allocation failure, but it should be fixed. I think, it worth to 
fix whole error handling in one patch




With regards,
Pavel Skripkin
