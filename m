Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32934D9776
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbiCOJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbiCOJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85A91DFB1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647335886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBh8J9NNu5Aw3QyuGmWU4/1j/LKSodlLKfBbUhGiIe0=;
        b=RlovcAp9zcTP+8UgZlq1s2wCX3weVIC8aco5LwvDMwJXQfB/tgeR2BkHaPMArvdSrU9eKG
        NQBokOIJ8Kqa6PfE7mBlkXHY8A6z4tKpYP61d1eZHeoW9aGZKkmRBXmVu7LuJg9xYawCGy
        nd/mqnVUXVwdVzpoPSb5odq6g49ay9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-GvFGFD5VOViMrEFzDWCA9w-1; Tue, 15 Mar 2022 05:18:05 -0400
X-MC-Unique: GvFGFD5VOViMrEFzDWCA9w-1
Received: by mail-wr1-f72.google.com with SMTP id 9-20020adf8009000000b00203d6cb4c60so215427wrk.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wBh8J9NNu5Aw3QyuGmWU4/1j/LKSodlLKfBbUhGiIe0=;
        b=egnxxQgar1olhoCNYtoBd3EAAMWmmiWlLBBDHXrVU9hMihdQRpOTmqONQz3UcSxA3Q
         xlPrqO0Lmz/gjOCcVS7HHpV+w14NnZmy/wxR6F2VSOf8dBb4ZGf8O6wd3LEzIqVVSr2b
         OJ0ZIIVcZ2USLPQPr4mpTK2aV7SJ2VEbxVU7IY+TufUvSIfMnBrTBtr7DHh8Q2Xd6CRL
         NUYYr6EhuoOA0usJdp08Kvk6uyfrXt5zO+9qPb8VJqL7d8ikTBAac7qljN2qk+xclDli
         r6LESbaLQ5kFwHc6/YV1gWDOHLaysZq3yCCDTLHjsJYrwfFUTNyPM0E5lDpj2Cp0yjEA
         HYtA==
X-Gm-Message-State: AOAM530W19S/Z3aISLNFyYIulS84asCi93nSMnJhpd/1t2xut4m8pS5c
        zuUOj7aWMMypD4It3zY9QjNX0byHAY91/S9G216IuaFRKc4YCmcoOKdoIoVIybn4hWdxBXOa0w2
        LBH8Kh31I+nyevcWXQpc4JE/q
X-Received: by 2002:adf:ee4b:0:b0:1f6:3413:282b with SMTP id w11-20020adfee4b000000b001f63413282bmr19502569wro.354.1647335883035;
        Tue, 15 Mar 2022 02:18:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziFUt0vjWLkTUV9oYH9rKLnYZc3d9TydrJ3H9L1hwi5ifBeuzXwpmzYV9LVn1GmGmVpcVktw==
X-Received: by 2002:adf:ee4b:0:b0:1f6:3413:282b with SMTP id w11-20020adfee4b000000b001f63413282bmr19502525wro.354.1647335882336;
        Tue, 15 Mar 2022 02:18:02 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m2-20020a1ca302000000b0038b6f235656sm1205577wme.19.2022.03.15.02.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 02:18:02 -0700 (PDT)
Message-ID: <08e81f07-99d2-62a3-8eea-b2c0432b4d18@redhat.com>
Date:   Tue, 15 Mar 2022 10:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] drm/solomon: Make DRM_SSD130X depends on MMU
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, maxime@cerno.tech
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220312063437.19160-1-yuehaibing@huawei.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220312063437.19160-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello YueHaibing,

Thanks for the patch.

On 3/12/22 07:34, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
>   Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && MMU [=n]
>   Selected by [m]:
>   - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m]
> 
> DRM_GEM_SHMEM_HELPER depends on MMU, DRM_SSD130X should also depends on MMU.
> 
> Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Indeed. All the DRM drivers that select DRM_GEM_SHMEM_HELPER depend on MMU.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

