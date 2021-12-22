Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAA47D192
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhLVMTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhLVMTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640175540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL61vxvdQEO5k/ykdSCycESvP1inlvyehpY4sAwws0I=;
        b=IomJKT4S3ijeXE4FkCIrwhzoV4RtRnhy6WaBFZMOFp1QGaVN77zr1lUekHgjccmItLL5zo
        MdbWjEpQ5jlmy9fmZ5EG9amlSQe8MUaLHGdpifvmttUM6MURQQ3Q2/Q9LoXpBA8/p+T3kc
        mTXziYuz8NJCESmHn2PTf6YdkYnCKLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-BYM7eRkvNFiNS8JZOtaOIg-1; Wed, 22 Dec 2021 07:18:59 -0500
X-MC-Unique: BYM7eRkvNFiNS8JZOtaOIg-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so2918440wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cL61vxvdQEO5k/ykdSCycESvP1inlvyehpY4sAwws0I=;
        b=UexQEP4I5Yg/nIOU89diXPF4SORWzIAnjYtkt020XVZmfniYU9rniIRjET3ScadhaY
         7fTrimY2YswuP253KVxkdZt4Kfl/Nb4Pv6P06+sSzx8I5ePbq0gH99ULOzVuyEN+pFdd
         gSX7UTTaD6dcwRJPB245R/Qp1WgZQBo/yOqD1hPP94jb0R9c5Q1OGZPJdmXVoPmfUho1
         Dxb5FTLKGvTSviVYkGXaKp2MVkWVaT/YG3lu/8EZ4jKCZR5Nl4+ln1ZMZeTtyfHZhY3i
         ooqWMszVmV2ZKEwJESwur3qDZR/M2fmlJvy2AUtGa/HsLjSHfHKnu3BDcqqZ7H2KFFaA
         tO0A==
X-Gm-Message-State: AOAM532zdzzOLJuPhfoDBoKUnlWIRjdZ4Ri5EIvn46whfN+vrrKF6H0c
        m+phmh9+9fiFhJ7+vpyWfhwRHKj2UWERMB+RahidcmPmTuX1GgGpw1JjjNJGeQQf24Myhiz6TY0
        WY6ZAufkQ2BRnyu2tOVhwIL0g
X-Received: by 2002:a05:600c:511c:: with SMTP id o28mr821312wms.96.1640175538758;
        Wed, 22 Dec 2021 04:18:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5r7kubxgz+bs8OZwuv5BmfKHiTBiEJEfqXxBgDH8xXoRJQUdklHrzHmZpeba3ojR02aUVTw==
X-Received: by 2002:a05:600c:511c:: with SMTP id o28mr821303wms.96.1640175538587;
        Wed, 22 Dec 2021 04:18:58 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h27sm5365676wmc.43.2021.12.22.04.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 04:18:58 -0800 (PST)
Message-ID: <7b07b437-2bc1-0194-233b-cc6d6c70cfd5@redhat.com>
Date:   Wed, 22 Dec 2021 13:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 03/10] drm/bochs: Replace module-init boiler-plate code
 with DRM helpers
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org
References: <20211222082831.196562-1-javierm@redhat.com>
 <20211222082831.196562-4-javierm@redhat.com>
 <20211222102135.fhtfkinp2u6yjwx3@sirius.home.kraxel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211222102135.fhtfkinp2u6yjwx3@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerd,

On 12/22/21 11:21, Gerd Hoffmann wrote:
> On Wed, Dec 22, 2021 at 09:28:24AM +0100, Javier Martinez Canillas wrote:
>> -static int __init bochs_init(void)
>> -{
>> -	if (drm_firmware_drivers_only() && bochs_modeset == -1)
>> -		return -EINVAL;
> 
> Also cleanup bochs_modeset?  I guess its not used any more after this
> patch ...
>

That's still used. It is passed as an argument to the macro:

drm_module_pci_driver_if_modeset(bochs_pci_driver, bochs_modeset);

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

