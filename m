Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9294FE17F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354932AbiDLNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356412AbiDLND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FA0713CC8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649767544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZ33BjHrDwv5LDhGjdBOryVj91womQA/19SWnvr7iKo=;
        b=JToA5CBpMhbsVwOCmyGRE5/N5rv3xQWX7JF+fC83569ED4OwYTHne3sEvCKwx3bn1K+h5v
        r5g4RHju7MxBxMjpEA1S8ddRtKcjSAN0NTzDfSVwOWdmkrOtCSepXybEdWej2GpeLrFVrC
        cBh5XR9qnO3KcSxYZjo1RGB+w5xtcaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-7G2Zv_EdNz2pJtFj6H4zNg-1; Tue, 12 Apr 2022 08:45:43 -0400
X-MC-Unique: 7G2Zv_EdNz2pJtFj6H4zNg-1
Received: by mail-wr1-f71.google.com with SMTP id r10-20020adfc10a000000b00207a2c7bcf6so1416905wre.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tZ33BjHrDwv5LDhGjdBOryVj91womQA/19SWnvr7iKo=;
        b=u3O4n7+ddwpTNcAqxROHHfJBZ1KJCY80dNqpj/o3rkB/M6QnARUzIXOb3X9FD7Tlnm
         ZNPB/FFhwiqzhtbQcKFcN/B5Ygbz8IkVnLSQ7Hxn9kEW79JflTIzGxn3ZvwRdAC+SoIN
         nddUGTBjdPVQlfkfnH1CIOZNZ4jyqhgs8Jp+Bu/ssYt3kWrRfUJMb0DTa/AMqL3eSWey
         6ofMsnNkhO/k2/rcvs9Sy/bT6Hr76bEuIHabJG/CXAJakkZh3avEMM4+LtuzFWTcdE2f
         xlFLu6HS44/KPdzyt+z1RdSYxGUlRtdJtxoPqpqds0o9CUUlmuF5/HEsUfCkEU7D+8kp
         uhPQ==
X-Gm-Message-State: AOAM531aDDB2x2BzPPE9GEzcxeeATRIa/HZdkXKEKu5VOTWJNJHCrB4T
        tB4/GhekFTeL3XznrhH/HwgwP++C7OcKmj7lmA2OpAaQc1vBYwGYTpP3smSinf12iHFALx3+/aN
        pPlQJ8D/+QcIBgi/TWwXyamGJ
X-Received: by 2002:a5d:6b4c:0:b0:1e6:8ece:62e8 with SMTP id x12-20020a5d6b4c000000b001e68ece62e8mr29078280wrw.201.1649767541786;
        Tue, 12 Apr 2022 05:45:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUqWO+Fp2x3i5NTSt5YGXdfhi1f+8zoD8yvWBy27pRBGSkplwJquSYzx/QHYB7zw1nrfYm3Q==
X-Received: by 2002:a5d:6b4c:0:b0:1e6:8ece:62e8 with SMTP id x12-20020a5d6b4c000000b001e68ece62e8mr29078264wrw.201.1649767541566;
        Tue, 12 Apr 2022 05:45:41 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q16-20020a1ce910000000b0038eabd31749sm2641252wmc.32.2022.04.12.05.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:45:41 -0700 (PDT)
Message-ID: <eb49332b-876a-0bd6-cefe-863f03903745@redhat.com>
Date:   Tue, 12 Apr 2022 14:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-5-javierm@redhat.com>
 <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
 <4128b288-2b9a-f9cd-01f3-a1d50d3e10bb@redhat.com>
 <YlVgpHqqqFy43L37@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YlVgpHqqqFy43L37@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thanks for your feedback.

On 4/12/22 13:21, Andy Shevchenko wrote:
> On Tue, Apr 12, 2022 at 10:07:02AM +0200, Javier Martinez Canillas wrote:
>> On 4/12/22 09:23, Geert Uytterhoeven wrote:
>>> On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
>>> <javierm@redhat.com> wrote:
> 
> ...
> 
>>>> -       ssd130x->device_info = device_get_match_data(dev);
>>>> +
>>>> +       variant = (enum ssd130x_variants)device_get_match_data(dev);
>>>
>>> (uintptr_t), to avoid a cast from pointer to integer of different
>>> size warning.
>>>
>>
>> Indeed. The kernel test robot reported the same.
> 
> Not only because of this, but also with the non-NULL pointers I prefer the old
> style without ugly castings.
> 
> Instead, you may export the array (in the driver's namespace) and use
> &info[ID] pointer for the specific device info.
> 

That's a great idea! I'll do that in v3.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

