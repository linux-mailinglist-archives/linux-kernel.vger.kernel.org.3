Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA90D512CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbiD1H3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245235AbiD1H3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29F4F34B9B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651130779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Baw5AAynaYZhBtVAECa7lnldNyZZzfbq8GqHK16Ojp4=;
        b=eTPwoNVGXsfD7XL5MDd0hgjC0p0c/ydY2Ek8XlTjrqwunK8EV/3bmCV1Zgb1AnydhsjpTu
        LWPcSDdMZuZsOXLB1ahUq/huMmLxuiT1/LHYHnNOwE03sySJtFmiqc3Mn7YDyjLrJso497
        EJthh2fXrJOL3LAzW1R0cDvNhLmVRc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-5cFKtU6BMMm8v4l9jh7ndg-1; Thu, 28 Apr 2022 03:26:17 -0400
X-MC-Unique: 5cFKtU6BMMm8v4l9jh7ndg-1
Received: by mail-wr1-f71.google.com with SMTP id s8-20020adf9788000000b0020adb01dc25so1577918wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Baw5AAynaYZhBtVAECa7lnldNyZZzfbq8GqHK16Ojp4=;
        b=wUteh+dBgPuQVd7khK/DJlpi9aGQADahVbxSkzA+nWxhh6zhG0whN/3OEKj/YUoNQg
         BPKcypE8B2oLJ7gwvmpi4JPAx9rugzQb0h6acNNQjwVljrY7CiTU4Chzh/5SAEbvSkUJ
         WcZ4w4BMQAo+Sx/u9txfh2Bfga4XJ4Aaa5T8wGeLTdp1a+NtnnWXl4B4I1r4+pXFHORz
         /szCTT5mNYArCI3CzQOOQfQNnZeHIqpbIGFCI2H/zDf+R8FjR2F7phdrG/3gaFebDpcq
         eiJwjCTGcR46IxWd9MPK+DYzx8uwhzvnQYAZY4GSzMAn1twGtz+IDMCURKmpIW7wzsDq
         0WtA==
X-Gm-Message-State: AOAM531nqMMZuTJFDX44avVso0ItM2stQtuxGMD0ZZZ4zJO9jmw0Y+4g
        NEWRvy+bQpDgTsLHZMPGgmhoCuRTS8sS7Rkz5MjAdpWjK6IwPIvOMmDal8WJU3SKzOmsjfbfeWC
        a6cnxwU32nxkD9M08cp8JcIXi
X-Received: by 2002:a7b:c8d5:0:b0:392:b12e:fd11 with SMTP id f21-20020a7bc8d5000000b00392b12efd11mr29610292wml.96.1651130772052;
        Thu, 28 Apr 2022 00:26:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNXR7aPjPClAeL9yVwShDBwTTCIJfhAL5A0u1ugWtOkmKMV1lDCAZ9Yu5Tgd4bZgKDo6E2Qg==
X-Received: by 2002:a7b:c8d5:0:b0:392:b12e:fd11 with SMTP id f21-20020a7bc8d5000000b00392b12efd11mr29610274wml.96.1651130771783;
        Thu, 28 Apr 2022 00:26:11 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d6da4000000b0020a8c8d3e00sm16226202wrs.73.2022.04.28.00.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:26:11 -0700 (PDT)
Message-ID: <6f3b8d37-0a70-a035-e87b-5aa72926fff9@redhat.com>
Date:   Thu, 28 Apr 2022 09:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/display: Select DP helper for DRM_DP_AUX_CHARDEV
 and DRM_DP_CEC
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220427215528.237861-1-javierm@redhat.com>
 <46446e78-60a6-1b8c-1bb6-1c005489d58c@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <46446e78-60a6-1b8c-1bb6-1c005489d58c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for your feedback.

On 4/28/22 09:02, Thomas Zimmermann wrote:

[snip]

>> Changes in v2:
>> - Explain better the issue in the change description.
>> - Only select DRM_DISPLAY_DP_HELPER and not DRM_DISPLAY_HELPER.
>>
>>   drivers/gpu/drm/display/Kconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
>> index f84f1b0cd23f..9fe80c4e555c 100644
>> --- a/drivers/gpu/drm/display/Kconfig
>> +++ b/drivers/gpu/drm/display/Kconfig
>> @@ -32,6 +32,7 @@ config DRM_DISPLAY_HDMI_HELPER
>>   config DRM_DP_AUX_CHARDEV
>>   	bool "DRM DP AUX Interface"
>>   	depends on DRM
>> +	select DRM_DISPLAY_DP_HELPER
> 
> You cannot select DISPLAY_DP_HELPER without DISPLAY_HELPER.
>

That was my original thought as well and what did in v1, but then I noticed
that doing that it would force DRM_DISPLAY_HELPER to be set as built-in and
not allow to be built as a module.
 
> Can't you simply make it depend on DISPLAY_DP_HELPER.  The menu entry 
> will show up as soon as there's a driver that selcets DISPLAY_DP_HELPER.
>

I could but then that means that once won't be able to select these two config
options unless some enable symbol selects DRM_DISPLAY_DP_HELPER.

In my opinion, DRM_DP_AUX_CHARDEV and DRM_DP_CEC are different than all other
options that select DRM_DISPLAY_DP_HELPER, since those are drivers and want to
have both DRM_DISPLAY_DP_HELPER and DRM_DISPLAY_HELPER set.

But DRM_DP_AUX_CHARDEV and DRM_DP_CEC are just included in drm_display_helper.o
if enabled, and depend on symbols that are present if CONFIG_DRM_DISPLAY_DP_HELPER
is enabled. So just need the latter, if DRM_DISPLAY_HELPER is not enabled then it
will just be a no-op.

Having written that though I noticed that a "depends on DRM_DISPLAY_HELPER" makes
sense. If you agree I can add it and post a v3.

Now, pondering more about this issue, probably the most correct thing to do is for
the drivers that make use of the symbols exported by DRM_DP_{AUX_CHARDEV,CEC} to
select these. What do you think ?
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

