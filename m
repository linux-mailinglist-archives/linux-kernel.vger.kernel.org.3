Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2547F6A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhLZLmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:42:09 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35852
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhLZLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:42:08 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4EA713F1A2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640518927;
        bh=zpufh2CvDreLRGLAtAqhzvft20fCH3VnJaLHlSd4UR0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=L/dtw7tMWFL9sxm1fUGYtZVH+t+1a4Zlkr/9nlkIWRCRZYURRRrpNqHLni2XjfXLr
         mw4aU6ILcHAq1VuLOz1pce5FUEIGospKmKeOUZHfqueMfODO5IEdDkJHtA02uPr5tr
         Qx4NQ5rhoDdENkkQ+MqLfGPch7q8524r9w2JpPEXeegPpbQT1QNrq1xAWeBF91BQWN
         ibJLBgERjXZGwx5svPxOebFqw12zM/wiapeSl2FUGckYNequoLbp9tsEIyD+tMWoWu
         s7HxCt3+DwETETZr5bMQKglK9s/aleUMrOCXs8SDwwQIYuJy+Yup1ZpnKxmPdw6QYT
         JtsG8m+THdOXw==
Received: by mail-lj1-f198.google.com with SMTP id 83-20020a2e0956000000b0022d68f4a68aso3771555ljj.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zpufh2CvDreLRGLAtAqhzvft20fCH3VnJaLHlSd4UR0=;
        b=WVlQuZXBlC22hxX5c9UdX8Pwym1PO1rAUZAsykpemtFwwMwvMyj2rX2Df8HCPgwKn0
         9OCFr5uAM3fMxvEuAel5q8JJ4FL/48v+YApiDy/O0iPNiHl7LU968MUpLZBGcW44hhSU
         RxS3RTW75Xi2Gf9IUv/j3RnVZSv38nORVwvON1TSYseB69idMngZbTGm1VX1s1qgQX31
         IQgk9IY6PX4MQBGVe3CqKZNAtv3H/ptWiOuDKmMH48vzMz6ICFh/lS8h+BzotNT+5QhH
         o4gE6N7jq8Yq8TIIF2ETdC/KXhNQHRbeYCmd94RQdZSy8uxoaLPV7zH0BawcuYbvsT2/
         goqw==
X-Gm-Message-State: AOAM531HmwMOJQCLvX8tskizXe2esUzy57gmYvnPpsO/Md/DEiS9oLQz
        K2mTUvAlLHpofNBYE9pqbRudkA3qIa+kGn8bXswFn9N5RAZTHw6Tz0sImud//AShpdxMOshfzXd
        9X77LpkZC0jJkL6Yo3hZwhAgWdxMHCb543J2QkfbBzg==
X-Received: by 2002:ac2:5ca4:: with SMTP id e4mr12065782lfq.263.1640518924089;
        Sun, 26 Dec 2021 03:42:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf3Z942vTSDQmm1sp07odWHNvAxPgacPmaUNEMbB5aL3o/oAnNG7bI6KMlewbiw8o7NSZOnQ==
X-Received: by 2002:ac2:5ca4:: with SMTP id e4mr12065721lfq.263.1640518922401;
        Sun, 26 Dec 2021 03:42:02 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a12sm1040004ljp.59.2021.12.26.03.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 03:42:01 -0800 (PST)
Message-ID: <3d0af5ae-0510-8610-dfc2-b8e5ff682959@canonical.com>
Date:   Sun, 26 Dec 2021 12:42:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH resend] uapi: fix linux/nfc.h userspace compilation errors
Content-Language: en-US
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20170220181613.GB11185@altlinux.org>
 <20211225234229.GA5025@altlinux.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211225234229.GA5025@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/12/2021 00:42, Dmitry V. Levin wrote:
> Replace sa_family_t with __kernel_sa_family_t to fix the following
> linux/nfc.h userspace compilation errors:
> 
> /usr/include/linux/nfc.h:266:2: error: unknown type name 'sa_family_t'
>   sa_family_t sa_family;
> /usr/include/linux/nfc.h:274:2: error: unknown type name 'sa_family_t'
>   sa_family_t sa_family;
> 
> Link: https://lore.kernel.org/lkml/20170220181613.GB11185@altlinux.org/

Please skip the link. There will be link added for current patch which
leads to this discussion. There was no discussion in 2017.

> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  The patch was submitted almost 5 years ago, and I was under impression
>  that it was applied among others of this kind, but, apparently,
>  it's still relevant.
> 
>  include/uapi/linux/nfc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/nfc.h b/include/uapi/linux/nfc.h
> index f6e3c8c9c744..aadad43d943a 100644
> --- a/include/uapi/linux/nfc.h
> +++ b/include/uapi/linux/nfc.h
> @@ -263,7 +263,7 @@ enum nfc_sdp_attr {
>  #define NFC_SE_ENABLED  0x1
>  
>  struct sockaddr_nfc {
> -	sa_family_t sa_family;
> +	__kernel_sa_family_t sa_family;

include/uapi/linux/nfc.h includes linux/socket.h which defines typedef:
  __kernel_sa_family_t    sa_family_t;
so how exactly the build is being fixed? How to reproduce it?

Best regards,
Krzysztof
