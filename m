Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B950D517778
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387143AbiEBTgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbiEBTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAA7462CE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651519961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbzfCdBFw8cpcp6GNfnwnh69uQicOecp+JCBFEKL4KQ=;
        b=OiwaSpa/rDS5UkPfPkv9+wu4T8oKZrZkd+Mt2vWIRwTGoL0nKneqyNj4OD+YRUrh1juCEa
        yRKXvQ7R6XYSgzu4GYcjk0CHZMS7o+5T0t6Nr5Ia7oEz9/epWXSKeFMwxtQ/8+J/yEa9hl
        Gknz0vD0EV3xrectoWjdoxuN2jvcDKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-dK5EIoJlMqq8gOoRz9wfdQ-1; Mon, 02 May 2022 15:32:39 -0400
X-MC-Unique: dK5EIoJlMqq8gOoRz9wfdQ-1
Received: by mail-wr1-f71.google.com with SMTP id v29-20020adfa1dd000000b0020ad932b7c0so5611240wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nbzfCdBFw8cpcp6GNfnwnh69uQicOecp+JCBFEKL4KQ=;
        b=LJN6CNTg1ozWJ7+LxUQjp25sgp+tDR1OinklQiDNFt27YmSz4Nev/zj7H+nyiJo18x
         v5QSbgnkz29m3qEzEhFSeQO1Ya7uQgbFmSKDlj3NwaBQ1ZOAjz2DULhZQ8eB2b2ljdfT
         X1Z9+br2v7ke4Us7I6GB75HR8lpYG19MY65zXc2em8od+RHjzEIDO/Jiw0J6VC9gJU0w
         0uDYWeZdkRJWlyH2Rw7Xw8nGNbILXQSWgtoDg0aFcfXNrXHmZSJrE6WHEyhYHpRVZSqm
         qSfboxtVxTg9Lnur/PvJDo6w9AMyr62bPMEs6oHSll/9S5OP8hhCyhhqrdvmBBEOGTS/
         EwmQ==
X-Gm-Message-State: AOAM532BOiUX0sdOaBFpXINnGQW9pwrNCeMX0wMVRCEDLRTu2zLzwCPp
        FefHJNkJWa4knPCiTUonxJ+ddkZVpdBuVM6Aq2PN0EGr7ZW83qB76mSUfrdBqSXuHFgT0+3aYI4
        0cI0gXPamybNN1oxYSOgtqeO+
X-Received: by 2002:a05:6000:1f91:b0:20c:54e5:fbbb with SMTP id bw17-20020a0560001f9100b0020c54e5fbbbmr9326949wrb.557.1651519957824;
        Mon, 02 May 2022 12:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVs7B+6rPqXsNNGufzXcbZnvxHD2Rc2poBCZFUtJFhTChFFutVIbK6j6FDqD2fufd2ssjz+A==
X-Received: by 2002:a05:6000:1f91:b0:20c:54e5:fbbb with SMTP id bw17-20020a0560001f9100b0020c54e5fbbbmr9326938wrb.557.1651519957563;
        Mon, 02 May 2022 12:32:37 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a25-20020adfb519000000b0020c5253d920sm10135342wrd.108.2022.05.02.12.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 12:32:37 -0700 (PDT)
Message-ID: <5691bc75-4085-d70d-a0ad-2dc450065c81@redhat.com>
Date:   Mon, 2 May 2022 21:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-4-javierm@redhat.com>
 <YnAEDlikr+d8cvy4@pendragon.ideasonboard.com>
 <9556f080-d309-f396-6d28-1190bc94cc38@redhat.com>
 <YnAcj9O3l/qLc5ss@pendragon.ideasonboard.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnAcj9O3l/qLc5ss@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On 5/2/22 20:01, Laurent Pinchart wrote:
> Hi Javier,

[snip]

>>>> +	fb_helper->firmware = firmware;
>>>
>>> I'd get rid of the local variable and write
>>>
>>
>> I actually considered that but then decided to add a local variable to
>> have both options set in the same place, since I thought that would be
>> easier to read and also consistent with how preferred_bpp is handled.
>>
>> Maybe I could go the other way around and rework patch 2/3 to also not
>> require a preferred_bpp local variable ? That patch won't be as small
>> as it's now though. -- 
> 
> Up to you, or you could ignore the comment, it's minor. If you want to
> keep the variable, you could also make it const, it's a good practice to
> show it isn't intended to be modified.
> 

Right. I'll also do the same for the preferred_bpp variable in patch 2/3
if I choose to keep them in v3.

Thanks again for your feedback and comments!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

