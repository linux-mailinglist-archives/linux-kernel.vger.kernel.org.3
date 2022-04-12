Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53044FE1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356055AbiDLNIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356702AbiDLND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A28A113F2C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649767673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMp2oMMI19CzMX6iZstGkcYLomzwrXcccsJxHhfXPhs=;
        b=Vv0RjNhXo/LGNqdDqpjSpu4e7WoEv57/I6JlpspI3GHhU/VIRsgOHAkhigJxCvxOWPQNCu
        zL4K+ZE+ET76Aq0bFR4IDeViZU7+m3sQlTFIdJQJ02B2uJuvqTvPE0xE01CP3QU+XlRtdc
        vVAU1ol/5hYvSDeik44AumjtgDPiYUM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-Rx3jMNbWN_KBdxNC2wfOWQ-1; Tue, 12 Apr 2022 08:47:52 -0400
X-MC-Unique: Rx3jMNbWN_KBdxNC2wfOWQ-1
Received: by mail-wm1-f70.google.com with SMTP id f12-20020a05600c154c00b0038ea9ed0a4aso1240409wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FMp2oMMI19CzMX6iZstGkcYLomzwrXcccsJxHhfXPhs=;
        b=GJJP/VoFYvLq2hyNF74XOn6ADjeo5iZa4fnAAvKqeSBE/Re5kBKpOANOwIC+QYY+56
         xMYh38r+CYLApHRyajiC5DqtLbVwcYt4X7cSo7Tl8qeH5mC8TRA1DKnkwtOjoXefqnsI
         rPIv8navPfWwbwTmf9arFbAfWtr0aQefZqFZrjbGkNW2tESsHvlIyxKdnptqt8VVwhoG
         ybgIccRX0ZIEDW8CLBmzjNSLHz2KDhZC/9uR++uTg7G7y2OcC0rsfYhz7+dw7Jg+ae6H
         BnXAj9UZ3a+8t0anG7I3RCDfnZUArAl2MuEgtEaN49N/zFR2vB9Rilods6OpfFhVzhQ6
         tzKQ==
X-Gm-Message-State: AOAM530xHH6zIsmF1zN+jiyne8zqnsEZi6Zpw+RqZc1UaZXaybE9pKlS
        qs/e0xCMdnE3/sff4uHkBqbZbzNtS4HilRCBv1LptApQUybyGMzMxkvTeJV5Om8acmi6kBum+8C
        xmGkvJpgJDv4LGe/D/wyGYiSj
X-Received: by 2002:a05:600c:1e11:b0:38c:b316:e6f5 with SMTP id ay17-20020a05600c1e1100b0038cb316e6f5mr3957218wmb.93.1649767671357;
        Tue, 12 Apr 2022 05:47:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSkWhDIignmxXyAnDO0ScbN/QuD6EP6hkvM1u+QuSX0qwvbJHTPBW68CS/aavtXCIxO1Rnvw==
X-Received: by 2002:a05:600c:1e11:b0:38c:b316:e6f5 with SMTP id ay17-20020a05600c1e1100b0038cb316e6f5mr3957202wmb.93.1649767671079;
        Tue, 12 Apr 2022 05:47:51 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d64e7000000b00204a13925dcsm31349422wri.11.2022.04.12.05.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:47:50 -0700 (PDT)
Message-ID: <dd918de6-aaf3-a9d1-0504-4b6a3f3d4e9c@redhat.com>
Date:   Tue, 12 Apr 2022 14:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-5-javierm@redhat.com>
 <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
 <4128b288-2b9a-f9cd-01f3-a1d50d3e10bb@redhat.com>
 <YlVgpHqqqFy43L37@smile.fi.intel.com> <YlVg8PE6SBzhmqjI@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YlVg8PE6SBzhmqjI@smile.fi.intel.com>
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

On 4/12/22 13:22, Andy Shevchenko wrote:
> On Tue, Apr 12, 2022 at 02:21:08PM +0300, Andy Shevchenko wrote:
>> On Tue, Apr 12, 2022 at 10:07:02AM +0200, Javier Martinez Canillas wrote:
>>> On 4/12/22 09:23, Geert Uytterhoeven wrote:
>>>> On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
>>>> <javierm@redhat.com> wrote:
> 
> ...
> 
>>>>> -       ssd130x->device_info = device_get_match_data(dev);
>>>>> +
>>>>> +       variant = (enum ssd130x_variants)device_get_match_data(dev);
>>>>
>>>> (uintptr_t), to avoid a cast from pointer to integer of different
>>>> size warning.
>>>>
>>>
>>> Indeed. The kernel test robot reported the same.
>>
>> Not only because of this, but also with the non-NULL pointers I prefer the old
>> style without ugly castings.
>>
>> Instead, you may export the array (in the driver's namespace) and use
>> &info[ID] pointer for the specific device info.
> 
> Note that device_get_match_data() has no clue if the data is absent or
> data == (void *)0.
>

Yep, we could make the enum start at 1 and check for !variant but that's
something that will also be prevented by your suggestion to just use the
&info[ID] instead.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

