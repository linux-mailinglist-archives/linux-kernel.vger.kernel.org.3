Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D104AF542
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiBIPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiBIPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D66EC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644420662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPpvyB7McdG+sCGO6qQRcD8vYFMWX9f+Cg4663yTg2s=;
        b=a8KbDlb4GGIEg9Cjf8Zl80Fpvi0/d8HvroNARdOX76rbAFY9QAEHiwUeqrFpfOJ5OoqQil
        Hg/mKf1+rXxw7qo3j3C06HtwoW7mg1FRgfwGIJGvADgOnQYJIIeyr02QIAkWW7SjNF21zD
        K1TqjYHfKaUlYx3uyAMfL1e28iHiOk4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-rfBKSsnbM2iAJtxzjSRhpQ-1; Wed, 09 Feb 2022 10:31:01 -0500
X-MC-Unique: rfBKSsnbM2iAJtxzjSRhpQ-1
Received: by mail-wr1-f70.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so1253866wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WPpvyB7McdG+sCGO6qQRcD8vYFMWX9f+Cg4663yTg2s=;
        b=Xq/Z16Fhcg3ImTX72hlyMbJW6sojcYG9orFJNhU42lsj3w2BpejuIZaPQpr8wPIoXR
         UeuyfJwNE3jZocB8S1l5O9ym22VMWdKi2PfTQOftt8mmMtkrEOh40Lxz5ty7dtxcxFrI
         oA3JpZ6a1C0d9Sob60drLzRzxxMO3XjmsRMOi1JM9ioo1EZN+hFV+e77ns426RYTPRkW
         ta5XQfn+zBDRblhputzf+sWceqXbsW6r4XCLVroNcvOmPhVZxCQs/Ihk7F8H5enKOcBC
         sKXaxzjsXtqzpBWosao5xdiEnEcU7pnIk9B8wCp5jLlnfAiyHT0qWNZlFdLgz8xCidvQ
         x8+g==
X-Gm-Message-State: AOAM532T8RB8fo5viv/aSuwgdPOrZTBbaZSZsGaTlX2PnQy8RUTBmMOl
        /b/D6edHcj/sZHGEeWo2Z5KJgnQbRuEvrQDDokRwfVQIk9bV1sUPBETZpnEubPdq/MGYQ9OsZWP
        07fLDI7ekQ7tmeyxIrrT9grsW
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr2557998wrq.6.1644420659910;
        Wed, 09 Feb 2022 07:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUJ460salQYs6rWREOZPwbsIL73KBkIAP9a0luO40gtQzhT1NgjwQDGKwNSlhfORRzFqslOg==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr2557983wrq.6.1644420659724;
        Wed, 09 Feb 2022 07:30:59 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c8sm6408714wmq.39.2022.02.09.07.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:30:59 -0800 (PST)
Message-ID: <3b6fe640-47e5-8765-3a09-8f9f2f0a6329@redhat.com>
Date:   Wed, 9 Feb 2022 16:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/7] drm/format-helper: Add drm_fb_{xrgb8888,
 gray8}_to_mono_reversed()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-3-javierm@redhat.com>
 <6df9c28d-968d-ff16-988e-8e88e4734e49@suse.de>
 <f75a1544-5a3e-e49f-7eab-5dd5c72584b9@redhat.com>
 <d5fc654c-643a-7b20-85f1-54169a3aa889@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d5fc654c-643a-7b20-85f1-54169a3aa889@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 16:21, Thomas Zimmermann wrote:

[snip]

>>
>> It could be taken from this patch-set anyways if someone wants to wire the
>> needed support for R8.
> 
> I think, policy is to not keep unused code around.
>

Ok, I'll drop it then. We can include it again when adding R8 formats.
 
[snip]

>>> If might be faster to allocate both buffers in one step and set the
>>> pointers into the allocated buffer.
>>>
>>
>> Not sure I got this. Do you mean to have a single buffer with length
>> linepixels + len_src32 and point src32 and gray8 to the same buffer ?
> 
> That's the idea. I don't know the exact overhead for kalloc(), but at 
> least the in userspace, malloc() in hot code paths is not a good idea. 
> There's usually some searching for free space involved.
>

Sure, let's do it in one allocation then and I'll add some comments to
make easier for people to follow the code.
 
> In the long term, we could add a field in struct drm_framebuffer to keep 
> such buffers around for reuse.
> 
>>
>>>> +
>>>> +	/*
>>>> +	 * For damage handling, it is possible that only parts of the source
>>>> +	 * buffer is copied and this could lead to start and end pixels that
>>>> +	 * are not aligned to multiple of 8.
>>>> +	 *
>>>> +	 * Calculate if the start and end pixels are not aligned and set the
>>>> +	 * offsets for the reversed mono line conversion function to adjust.
>>>> +	 */
>>>> +	start_offset = clip->x1 % 8;
>>>> +	end_offset = clip->x2 % 8;
>>>
>>> end_len, again. If you have 1 single bit set in the final byte, the
>>> offset is 0, but the length is 1.
>>>
>>
>> Agreed, will change it too.
> 
> Feel free to add my
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks!

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

