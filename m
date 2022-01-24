Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BE497A10
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbiAXIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242062AbiAXIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643012174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTLl4YJkeUuVgMvKnlcneMHmBiRgYGMhn5C09P+gXVg=;
        b=hPAoJF8no+GXgt5ZhElOugHzSMVV1gguIDimWXXMpiv7KljTBQaDBuxy9zGQCxcs9gW1EJ
        a0ChZ8/swvxd1+JsVxCJhTUQUB8kTajXRHTSDfX0L7LcMv1giNTTW8hX8CP1wJrIa1jKmK
        w3zlWFpZJB3ygeHwRZJ+Xya3AFzIjXI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-OcSjX6zjN5uWViM5VwZeEw-1; Mon, 24 Jan 2022 03:16:11 -0500
X-MC-Unique: OcSjX6zjN5uWViM5VwZeEw-1
Received: by mail-ej1-f70.google.com with SMTP id p16-20020a170906785000b006b5d9c3d47fso1755931ejm.21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZTLl4YJkeUuVgMvKnlcneMHmBiRgYGMhn5C09P+gXVg=;
        b=S/NhWfCkwnlkfR8XF+11DruHIDa6S3JoeEnbDLC0rtAj3beqMWVraQWSTtZ7BIo7ua
         pe5yoNZzsFkWhwJW+mGs3UYnJRr/k7anAjz0zUwJ4OaOv4HIstqeO+zP3TWJkfk7Lir5
         DiA7GKDIojRwILXBbpFAq5HxUL06N3nzAD5SdBpmdBdBxt/PqaNJTGqQ/dhrz9Ax7Mcu
         znpEanMKaF0aWXvQWikevn1CUDGf0y5tDHxzChbNh7dX0G9F0pcbOs8BdztrMuUyynCK
         LRns9D/XooXQ1PAOD5OsKTne6e0Gh5kIcgkEeGPykpkdMkPdkRyXLYlgevys8UpppEVA
         QU5w==
X-Gm-Message-State: AOAM532pAv54Pe0XSdDu3EZggr3epwpP/VoWSg7wbcNAkEMt4jGtjroO
        CO3eHiWFI/aq1cWxkT7VKpMP9H2BMwsTjET2kDV4XmCtRb9Dxc563HPSiZNTVN1I0KcSOA/kBHD
        WrCgw7Yzd4GLAypRzSFFzI4+w
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr11722207ejy.530.1643012170408;
        Mon, 24 Jan 2022 00:16:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOr3jOY+RTOMB2JqY3ZgFgnki6NWYqRSaiNL7SDrsnmX5TQlHJzM/4eGuy6YOS1RraAewSXw==
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr11722192ejy.530.1643012170213;
        Mon, 24 Jan 2022 00:16:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id r23sm948111eju.134.2022.01.24.00.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 00:16:09 -0800 (PST)
Message-ID: <7792513f-4f5a-d2b8-f142-ac14d97cda8f@redhat.com>
Date:   Mon, 24 Jan 2022 09:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [Patch 0/3] Staging: rtl8723bs: Fix codestyle errors and warnings
Content-Language: en-US
To:     Jagath Jog J <jagathjog1996@gmail.com>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net
Cc:     fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220124034456.8665-1-jagathjog1996@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220124034456.8665-1-jagathjog1996@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/24/22 04:44, Jagath Jog J wrote:
> This series fix the following errors/warnings:
> 
> -Placing { braces at the end of same line of if condition
> -Removed extra spaces in declaration
> -Placing necessary blank line after declaration

Thanks, series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

> 
> Jagath Jog J (3):
>   Staging: rtl8723bs: Placing opening { braces in previous line
>   Staging: rtl8723bs: Removed extra spaces between datatype and variable
>   Staging: rtl8723bs: Inserting blank line after declaration
> 
>  drivers/staging/rtl8723bs/core/rtw_cmd.c      | 54 +++++-----
>  drivers/staging/rtl8723bs/hal/hal_intf.c      |  5 +
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 98 ++++++-------------
>  3 files changed, 63 insertions(+), 94 deletions(-)
> 

