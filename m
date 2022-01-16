Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3B48FE2E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiAPRbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 12:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233486AbiAPRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 12:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642354273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D03birTDNthtuokM35HxhWu4RWwiiV5J6bchLjCqzyM=;
        b=e59POU46a1VgnI7jBo7z87HmxmO6qFio6+NbhtG8ANUEotlwPl8ltYGOVrFaxNEAlQd1Mb
        8jTmuJLL3LE+L1r34COP7Ipm/ANt/rfD/AB6ynhuFePShmO96/GkADubGbmuQ2Cal8mzph
        6qPWHDXHvAqqS1IgnbWbcvTHly75VsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-c1hbG1nwORqmTZbqw-taWg-1; Sun, 16 Jan 2022 12:31:12 -0500
X-MC-Unique: c1hbG1nwORqmTZbqw-taWg-1
Received: by mail-wm1-f70.google.com with SMTP id a68-20020a1c9847000000b00346939a2d7cso3083397wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 09:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D03birTDNthtuokM35HxhWu4RWwiiV5J6bchLjCqzyM=;
        b=0rXpkEJsav2iN31b5ykAoHtz9Ps56S0Apxm6+WyADF2CWbwq5V/+isr7BW1ZpqSvXg
         MME+4+24sJOLW5MQ8zbECe0txa/s2yPgSYJV2Y+1LNXS8Pq9y5PAqlcpDlIejF8XkOLj
         4R3xnuUiZqSrhAxDI9HhgZXOr1AWJylK2nji6iqccbJ69oQsTe+KiFSS5jUyxFq4ZMLn
         FbHxRJb/8X56bbdi1Xc2Fu6cBsHUf08YSzNTPgp9QtkC54R0cZSg5fJSf16szuM6D22c
         btq7G6drXDhf1ZEKy3J4PXX2uP/kb/t6WaLYaHVkCfEefISYK1fBi0TmVjzkeBNecbjf
         VqZQ==
X-Gm-Message-State: AOAM533LUVa8TUBF3rZDMtdEHdUaV/8ZEPI28BlsibTSH3EAaaePSrI+
        row+C3Lu0N2vgiSc3t1xpJgJ9kAePwuNQgoMqvjxwyBEUQ4fI7XGFTVCUxROxXNIzDuT4FugvDu
        um0f2we3/VaHAv7sWux/CdPru
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr3177326wmq.21.1642354271361;
        Sun, 16 Jan 2022 09:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSJdumjEc53BxBVOEvJjdjmPpTTlGOxKzkFTjtFwMhXc6FdLpZzZm4PZd7a/JeLYnNkaT95g==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr3177311wmq.21.1642354271166;
        Sun, 16 Jan 2022 09:31:11 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g12sm6262891wrd.30.2022.01.16.09.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 09:31:10 -0800 (PST)
Message-ID: <259abc88-58ac-9101-21a1-5130168fcdac@redhat.com>
Date:   Sun, 16 Jan 2022 18:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] drivers/firmware: Add missing platform_device_put() in
 sysfb_create_simplefb
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     bp@suse.de, daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tzimmermann@suse.de
References: <735d2b47-227f-f09d-ddd6-28bc82a066a5@redhat.com>
 <20220116121654.7730-1-linmq006@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220116121654.7730-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/22 13:16, Miaoqian Lin wrote:
> Add the missing platform_device_put() before return from
> sysfb_create_simplefb() in the error handling case.
> 
> Fixes: 8633ef8 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - Use goto label to avoid duplicating the error code logic.
> ---
>  drivers/firmware/sysfb_simplefb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

