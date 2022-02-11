Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDA4B254A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349862AbiBKMLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:11:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiBKMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46610E56
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644581490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbeS5Q0QdhSeqbBe2L7Sp2F6l+GpdK7iWbNe2W3yu0w=;
        b=Jkk5JIUtiTJQ91JlidV11G+xGEvtzGNzpGHKfueu9qRFskfvcuBwAYnP7K2ULgYJsBiAtQ
        yClh4gzwRfWiv4DgZZzGLEMNjDxSwRxC6CcM+p82FEql4cKpAVOpTSEy/D/+tMDWSSy5cO
        5AMhE7pVIuzVp2L/7iT1VFn0FPWmOdw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-ulDAMFvoNGiL8c9GirKmnw-1; Fri, 11 Feb 2022 07:11:29 -0500
X-MC-Unique: ulDAMFvoNGiL8c9GirKmnw-1
Received: by mail-wr1-f69.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso3804666wrv.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbeS5Q0QdhSeqbBe2L7Sp2F6l+GpdK7iWbNe2W3yu0w=;
        b=yBzgqEJNs9L0vOx9P5mc6KkZAdqcsciZhNVJUp55TA6wmMiJ0wmVpwShHoc7072e8u
         ikxCDz5VxE1T0XUNt7ltLzdcOFg5JJ/cc6hT1b9seWyXbpRG7VW8B237WbZfQBWqQRlj
         wwE7QdmAPPS2KOK6BujFUonp2rI2y8ndeTnMbE6ImIz3bDbvRFra7kbdIjCb1XIaAwj1
         3lNjczyr96nOzke91rCtIP6jSxvaau2Y+MjgUVcn6KYrXEAtVFpDycBYLop/q4/5RGqA
         qe9W7NrpakAEZ1FVRqjUVwFnAJ0JNj227z8HHd5XZhqtU1B9chdoo+15JRVsB28SP3Uz
         UTQA==
X-Gm-Message-State: AOAM5336XO+LV1KkJOWjecYyX3h6OlHmKrTvcoZXTknDmQKi36kzME1h
        KT0BGM3LKZ0HW5lQHax+lY7UORwsQi/LMirO47QvZCFgt54wj8aXISNePkn+1wqvRej7KkKhy07
        zeoYZknxZzpCPBBRkJmgQA19T
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr1244665wrq.2.1644581487722;
        Fri, 11 Feb 2022 04:11:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySb3y5ME4crlsH+b8xOVBwDu7OcH0jhhdufGAdmsHfpAHWgWr7LCf0VAonkSs7ThGU8Oo4sg==
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr1244650wrq.2.1644581487542;
        Fri, 11 Feb 2022 04:11:27 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v9sm9980052wrw.84.2022.02.11.04.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:11:27 -0800 (PST)
Message-ID: <431f26fb-5943-eb58-9ad5-eda787966ad2@redhat.com>
Date:   Fri, 11 Feb 2022 13:11:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de> <87pmnt7gm3.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87pmnt7gm3.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jani,

On 2/11/22 13:05, Jani Nikula wrote:

[snip]

>>>> I don't see why a while loop would be an improvement here TBH.
>>>
>>> Less letters to parse when reading the code.
>>
>> It's a simple refactoring of code that has worked well so far. Let's 
>> leave it as-is for now.
> 
> IMO *always* prefer a for loop over while or do-while.
> 
> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> instantly know how many times you're going to loop, at a glance. Not so
> with with the alternatives, which should be used sparingly.
> 
> And yes, the do-while suggested above is buggy, and you actually need to
> stop and think to see why.
>

Absolutely agree.

These format conversion helpers are not trivial to read and understand (at
least for me). In my opinion the code should be written in a way that ease
readability and make as robust and less error prone as possible.
 
> 
> BR,
> Jani.
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

