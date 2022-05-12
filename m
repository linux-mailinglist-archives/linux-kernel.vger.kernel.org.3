Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4A52462D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350576AbiELGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiELGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC77216842
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652338436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9qrallTCJWWrD1tmfcAYPYM1KeQaHZcmgYv8BoSEF0=;
        b=E+cb7wifLlN70FGYH43v1pQx4iEseTbRqUgopiuWcrvzcEuEqp3dWjihwDlJogNg8MX2PR
        XHzHtgg85SHT+uNLDW6Q4f1uOobWnHckH3XNofNpA4dO0funOBcIUlTTIGExpP3vtTCYHU
        4XiP7+cKgqkYOKLP8BjRmcbTGfsYpxo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-cpPjyf28M_ydHwh6nmRfdw-1; Thu, 12 May 2022 02:53:55 -0400
X-MC-Unique: cpPjyf28M_ydHwh6nmRfdw-1
Received: by mail-wm1-f70.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso3980306wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m9qrallTCJWWrD1tmfcAYPYM1KeQaHZcmgYv8BoSEF0=;
        b=XNipVAn8Y85jvM7FFwvrMmzEbQWvPdiq/03MmtJr7XBKJFLHwtgSN5tp5EwqgoqIPr
         bHo+GwurrWy5u8oSx0q0Lr1OJXXeP+Ry9gSCZhcH0pdQdkCAAQ4gJpfrjZKDFyVNTTvQ
         NFrwC+1HQzRBFqrCDv09B5SlVInqJ+qU3NE6FiFhQXaPWgxhpmWGW64qWuocIzUFDH1R
         sj4rWi9EjICmOayPbvME0Y4ro0ulqRt/acMKPs/Nnk3QZgrFECgu3gwy+GCzy7mlLv4F
         10cZogXRO4P+NJWffD5/FDgXDuAzBE8aaKePy7+1+1qUeAnAyaVbWIrzIwmMlP49RxoX
         uPdQ==
X-Gm-Message-State: AOAM5323D6Ap+YrdPpTAg2sm/ulWJAqmwO5yikP13FPrrEhFynGvKRGs
        ZA+UtqFK0DZfDR0UQ+Q3sz1UMSnjV/vTGMSKeKkDlZjcgkDGW+lyk9m24WC2cJ2NBUIk9FrFsWB
        BefVRk9ND0zjbhot3DBf4EXs+
X-Received: by 2002:a7b:c156:0:b0:395:b669:5c83 with SMTP id z22-20020a7bc156000000b00395b6695c83mr7053680wmi.141.1652338434241;
        Wed, 11 May 2022 23:53:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyXJf4J232MvrKUWbwaiPp3FGyyip+AF1RPM/uoHxObgWZHdaCGStWwSfjgtB8rwzUcpS15w==
X-Received: by 2002:a7b:c156:0:b0:395:b669:5c83 with SMTP id z22-20020a7bc156000000b00395b6695c83mr7053662wmi.141.1652338434040;
        Wed, 11 May 2022 23:53:54 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c480600b003942a244f40sm1640432wmo.25.2022.05.11.23.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 23:53:53 -0700 (PDT)
Message-ID: <a38b92c1-50d9-52df-43b4-a7576531419e@redhat.com>
Date:   Thu, 12 May 2022 08:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: Add 'modeset' module parameter
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220511181935.810735-1-lyude@redhat.com>
 <CADnq5_OWH-Bat3OyCmHz6hTE++7hPLXqqMgg2=Nk6HB_Qk61JA@mail.gmail.com>
 <beb6cbd2-445f-c864-3283-ebdacaed37ac@amd.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <beb6cbd2-445f-c864-3283-ebdacaed37ac@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 08:17, Christian König wrote:
> Am 11.05.22 um 20:36 schrieb Alex Deucher:
>> On Wed, May 11, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
>>> Many DRM drivers feature a 'modeset' argument, which can be used to
>>> enable/disable the entire driver (as opposed to passing nomodeset to the
>>> kernel, which would disable modesetting globally and make it difficult to
>>> load amdgpu afterwards). Apparently amdgpu is actually missing this
>>> however, so let's add it!
>> You can already do that by passing modprobe.blacklist=amdgpu on the
>> kernel command line.  I don't think we need another option to do that.
> 
> Yeah, this already came up multiple times and so far we have always 
> rejected it.
> 
> Stuffing that into drivers is not a good approach I think. If we want to 
> prevent some device from exposing it's display functionalities we should 
> rather push that into the drm layer.
>

Absolutely agree on this. I think what we want is a drm.modeset parameter
that would have more precedence than "nomodeset". Because the latter is a
built-in parameter and so it can't be disabled at runtime using sysfs.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

