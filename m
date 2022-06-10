Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53D546213
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiFJJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348962AbiFJJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB36254039
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654853021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ui+GefT7glVYbZJx7tAzYAgsijo4mtXjq2iJjZnCAk0=;
        b=VwiEIxe/LaExm6l2og1pbF5h542CfsUbeaCks3VXGwCXMuri4GoOLcGYT7NYJiHxON0kbF
        N52CeSOpi7/at0/StowzFU8+kVk/IN/nAti+lkk3oCThaK31fSeS1zPE7BG02REVvqwXGz
        DuXY7lOLypFxDE0DFFuHtqzSll0OGc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-HElekXG8NDesHqXHYvh66Q-1; Fri, 10 Jun 2022 05:23:40 -0400
X-MC-Unique: HElekXG8NDesHqXHYvh66Q-1
Received: by mail-wm1-f72.google.com with SMTP id k34-20020a05600c1ca200b0039c7db490c8so632496wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ui+GefT7glVYbZJx7tAzYAgsijo4mtXjq2iJjZnCAk0=;
        b=jmpA14cSZuxUc88gMna1q0BLExG6yptRUqk9D+39w5VijiGZyFAwvTh12ieSMF5N2o
         /gOyc58OzDK1gP1ENJu5YDOO6cYiD2Bua/O/jJa3y/qOh6XVul2vtptTabbHqkgtZ28t
         T4bkBZflmLeXH8xhPkz3AAr84c+4hwb8nP3JZwWA1IlBKMEfLLSwrRisyqjjzMtQ8d4p
         3jbTKTCog0LinoreE2n978egNUWumx5ynPvpTn2ahQjKtDjm6AZ9jYFlfy12ajoY376E
         Gjpv+32lyBWVvGF77DL11BvDFivd0BFXb5o717BWsoP800OKMIef+gzckVxi/OEZR8xB
         B5Qg==
X-Gm-Message-State: AOAM530MfS603+gi5SYXOHa9JvGBc2gQiVu9InNxx/U0QSvspQcNMZbq
        ip9FXoohuNA1qAemgPyw7Okn1vo3xuK9bm9x4qrNO+wuaqLnxZ4sfqSlbGLBqgHo7qQuRm28JWu
        s9Ga6kh8XjdwIyObkN7MkC2O4
X-Received: by 2002:a05:600c:1e2a:b0:39c:51f8:80d4 with SMTP id ay42-20020a05600c1e2a00b0039c51f880d4mr7909009wmb.192.1654853018894;
        Fri, 10 Jun 2022 02:23:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzors8lrVCLvoMtZbR/XO1Cue4ykhrTN0Lh/orNjpsTm7XBIYzUbhU/YNQRJll7iilJG9sY3A==
X-Received: by 2002:a05:600c:1e2a:b0:39c:51f8:80d4 with SMTP id ay42-20020a05600c1e2a00b0039c51f880d4mr7908984wmb.192.1654853018625;
        Fri, 10 Jun 2022 02:23:38 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c255000b0039c4b518df4sm2814684wma.5.2022.06.10.02.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:23:38 -0700 (PDT)
Message-ID: <3babc5cc-2f03-4b25-1cb3-82f039e3c40d@redhat.com>
Date:   Fri, 10 Jun 2022 11:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220610144958.5b90e8d3@canb.auug.org.au>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220610144958.5b90e8d3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 6/10/22 06:49, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drm-misc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/firmware/efi/sysfb_efi.c:29:10: fatal error: asm/efi.h: No such file or directory
>    29 | #include <asm/efi.h>
>       |          ^~~~~~~~~~~
>

I noticed that this header include is not necessary so I posted [0] to
just drop it, and mentioned the build error too with your Reported-by.
 
> Caused by commit
> 
>   fa0e256450f2 ("fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled")
>

I posted a revert [1] for this but for a different reason (since after
[0] I believe the issue in powerpc should be fixed), which is that the
patch led to linking errors on arches that don't define a screen_info.

[0]: https://lkml.org/lkml/2022/6/10/323
[1]: https://lkml.org/lkml/2022/6/10/316

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

