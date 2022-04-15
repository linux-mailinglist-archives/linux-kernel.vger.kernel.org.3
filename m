Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857C5027FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiDOKII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352120AbiDOKIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:08:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6469157E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:05:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so13329676lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3bPZ/57wkOzXUeVbdrpb2yRMsao/hRXkHHvgI0MANKk=;
        b=kElByGo2IoedNfGnE2cZcLVPTVjK2UCWKdN87D6dViUUxOUff7l1/vPg+ZNT/zSxRC
         khbLbPeDzufZCJHNVhOB0Kv/4sAzVYBjMhpQEpXmtMohWCmzDeVHYewrH4NXQW2cnrRC
         1TNkQ7TCXY6ck4WcBIMXN4g9xiJTkTMAvoJ9C5X8P/cSWJVISPk8u10sUCC6oPCpBZfx
         tHKYCXQWpgzYXt3E2drudncvyvkkeqG0Dd91QNiUbXv3Uyw9NwloWfWK6N2A+OUDOkU1
         c5d5JvHq/xyLu75EJS3wPRGbevU1Vcxwi5jFKn71vpfFRbD4nVu/2KEnJ/IBdJ4IhmJg
         1A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3bPZ/57wkOzXUeVbdrpb2yRMsao/hRXkHHvgI0MANKk=;
        b=HuI7d8EZ268H1yEXzbYP8xq69o5hkm0W2MlybptGpJziXfqYHLYRQTxe3IwrmN9YCo
         3zpv664O5oErCm7PTOgPxR2FIsN3udmkNIwucARnwH3+cNQbM4hLh8g8uAtTCbE3G8OM
         dmz9JwLnepUk98s9FpgOfy/+ykoJTeUtYORDGBzgUGB2MKZZASBFISJKZOi1qeHU9Lh1
         cle9ST58dX7+1Kz1NdRGG0GEKDORig5n6kFq8Q6dZCLPlPifAyHXLLwAiP3M5yFWsSQw
         s/LbgUmvl+rsKqv5KodDnJxQzcsX3BgrmgEaWDAmqOLqMf0ExhC8Ku+53SCEN2VhuQs1
         zFng==
X-Gm-Message-State: AOAM530iX871r9p7jUq2BzrEkk3BsXWFZ1PP3+KOjMkEK7qj3ouAbDmt
        vjz+txV7qUDJCxMG3MGPY5s=
X-Google-Smtp-Source: ABdhPJyjVd4rtR6Bjb/C8iblfrbGe544Fs3ujvYDVQYhCwQ6WGVTei+TFMsEsUoTdRkLe/bDvzEXNw==
X-Received: by 2002:a05:6512:32c7:b0:44a:762:27e4 with SMTP id f7-20020a05651232c700b0044a076227e4mr4687202lfg.401.1650017133014;
        Fri, 15 Apr 2022 03:05:33 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e7d14000000b0024b44fb9a9esm237038ljc.51.2022.04.15.03.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 03:05:32 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] virtio: Solution to restrict memory access under
 Xen using xen-virtio DMA ops layer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <YlkhsH4zqly/BykB@infradead.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <251e957d-03f9-8ee6-789d-517417c95aff@gmail.com>
Date:   Fri, 15 Apr 2022 13:04:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YlkhsH4zqly/BykB@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.04.22 10:41, Christoph Hellwig wrote:

Hello Christoph

> I can only see three out of 6 patches on the linux-arm-kernel list,
> which makes reviewing this impossible.


Oops, I will add linux-arm-kernel. I blindly followed what 
get_maintainer.pl suggested for each patch plus added manually some Xen 
folks,
but, indeed, the first three patches add the base of this enabling work.


> Also please Cc me directly
> on any series doing crazy things with dma ops.  Thanks!

yes, sure.


-- 
Regards,

Oleksandr Tyshchenko

