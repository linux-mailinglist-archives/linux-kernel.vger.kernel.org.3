Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5D495031
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiATOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351202AbiATOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642689176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPuayk7DGgimlXmWWU/Kaumg5LesFzzxr2Pf+6g42xY=;
        b=cOOuNyXU+stBKDjYK6G80HGbchswiyIQfjBNsjXKY5LepNHSWeGeq2jL0cBXPEaN1CPMvi
        x10L3jG+gsxb28kLjEv0ZEe8h5bcA+lJ0POE/23YyuSMs9ktZ6Z9uHkL6b7seeuecK4+tv
        c3cRXwSkJyc04R05IpQkUeLZh9uwcoE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-wcNdYObsNg-TbzuOhR3m1w-1; Thu, 20 Jan 2022 09:32:55 -0500
X-MC-Unique: wcNdYObsNg-TbzuOhR3m1w-1
Received: by mail-ed1-f70.google.com with SMTP id o10-20020a056402438a00b00403212b6b1aso6018096edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jPuayk7DGgimlXmWWU/Kaumg5LesFzzxr2Pf+6g42xY=;
        b=uycXzs6SFEYhoY8JT0eY9rEKzngd7AZgW+iIQzXPyErZRw5wafqy45pqyLoElNQFpp
         L2fUqCVJwJmNeoSClbTeYwlc1f+AjzWgB0PQsMuq7VREpIw7lpmAeo9uirpW5tPTkAQq
         akAcnN8gQWaqgQsKt2VEdH/DdHTHLL1otOioNGKQ91P5UmASKBFlthgZrVeGmby5ABjw
         zgOeZKIomLgLMoCzatVdjVG8CqjhQAdHL1Q12d9BTzKQwOiRtbrDlS/5F4iSOQXLj522
         v6N6QxyThq2DARd9nOFGH14xPm5G7AG2IwJtQ8t0LVoGFML0KLaf+JP9BBSx4SVeFdmw
         OOfw==
X-Gm-Message-State: AOAM533/D1oCcWdq/sWLT49ZF8/oeRVCrlrbh8guJY/lLiq94tBxmTEE
        W2mBgWO/LDYMBdIVJL+kfh3b6mmQtKUBjx8xRdCvwPzpAjceApilAmM03MF8ujbAf0jdGzn3Vfx
        nBKti1XvCh6ch7PlwJnFqgzwc
X-Received: by 2002:a17:907:3d91:: with SMTP id he17mr14437301ejc.622.1642689173716;
        Thu, 20 Jan 2022 06:32:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySnocBxUR99vTCzzZxpDykzAPeol+7jCbYORO7z/14B2A79sii/h2tGX/mROZQ2zMR6hngxQ==
X-Received: by 2002:a17:907:3d91:: with SMTP id he17mr14437269ejc.622.1642689173470;
        Thu, 20 Jan 2022 06:32:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id x31sm1397173ede.26.2022.01.20.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:32:53 -0800 (PST)
Message-ID: <59c27f72-5132-6c3d-1e74-6c1010c41178@redhat.com>
Date:   Thu, 20 Jan 2022 15:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 0/3] staging: rtl*: Check for NULL header value
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20220118193327.2822099-1-keescook@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220118193327.2822099-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/22 20:33, Kees Cook wrote:
> Hi,
> 
> When building with -Warray-bounds, the following warning is emitted:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./arch/x86/include/asm/page_32.h:22,
>                  from ./arch/x86/include/asm/page.h:14,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/rcupdate.h:27,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/sched/signal.h:5,
>                  from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
>                  from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
> In function 'memcpy',
>     inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
> ./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
>    41 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> 
> This is due to various paths to the memcpy() where the compile could
> see the destination buffer having a NULL value. This series fixes this
> by both eliminating cases where NULL returns were impossible and adding
> missing NULL checks where values were possible.
> 
> Thanks!

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the entire series.

Regards,

Hans




> -Kees
> 
> v1: https://lore.kernel.org/lkml/20220113002001.3498383-1-keescook@chromium.org/
> v2: https://lore.kernel.org/lkml/20220115042427.824542-1-keescook@chromium.org
> v3:
>  - fix paste-o causing build failures (0day)
> 
> 
> Kees Cook (3):
>   staging: r8188eu: Drop get_recvframe_data()
>   staging: rtl8723bs: Drop get_recvframe_data()
>   staging: rtl8712: Drop get_recvframe_data()
> 
>  drivers/staging/r8188eu/core/rtw_recv.c        |  6 +++++-
>  drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c  |  4 +---
>  drivers/staging/r8188eu/include/rtw_recv.h     |  9 ---------
>  drivers/staging/rtl8712/rtl871x_recv.c         |  4 ++--
>  drivers/staging/rtl8712/rtl871x_recv.h         |  8 --------
>  drivers/staging/rtl8723bs/core/rtw_recv.c      | 11 ++++++++---
>  drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c |  3 +--
>  drivers/staging/rtl8723bs/include/rtw_recv.h   | 11 -----------
>  8 files changed, 17 insertions(+), 39 deletions(-)
> 

