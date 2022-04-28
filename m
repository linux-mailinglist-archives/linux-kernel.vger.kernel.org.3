Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73D512D61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiD1H4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiD1H4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B81E5D9F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651132376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwpLwYRRl15FISsOjXyGpPG6h0phY4GTTlpFR9suoQg=;
        b=NN6yJnvM33yuTekllCPuiQonV9kJ7Vv0amFz3Vam8gok+/u6gEpzVETXKwJ/qq+fxxzivo
        ZwFl3NkXul6AvaDLpVoPFRCFzT+9q9Gx5BEJtSujo9cleHxShCLj8bBbk6DD7rm8hFFZji
        goK9PaP2Uu+nj8OR89K8md40tXgqozU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-OzjKI7QaOGmnqJCm7bWPYw-1; Thu, 28 Apr 2022 03:52:55 -0400
X-MC-Unique: OzjKI7QaOGmnqJCm7bWPYw-1
Received: by mail-wm1-f69.google.com with SMTP id n37-20020a05600c502500b0038fdc1394c6so1591574wmr.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fwpLwYRRl15FISsOjXyGpPG6h0phY4GTTlpFR9suoQg=;
        b=QuQ0bdBE7hGIzZ/7fe7uEf5OKbIFxFNquS85XNbL6vaqR7PpqjfJyacBxYGYUZPuE8
         K5BTBpWODPYzdg9Q+SP0fcYKk30mIWb2g3fBd38CF8rSlv540o+zD7QIMAkJkbTDhdm8
         ApIfF/l7HN9Mw6gpJ9E238z/O50grEwDpg5cyEscUDOTZq7RZigek7K+kZ+DySjKd01u
         nckK0EHndqTzG0FN09F6I2HCd7xWbshbL4PU53/daNdtzaNh+vFYyvhQQpQ92zOaxz+G
         D6fdF1PwVirAfQklMEEkxVZTHI6oBQLz/j+rpzv8D0DVrGm+RTIZMqu8aRBRugrgvBiZ
         xLlw==
X-Gm-Message-State: AOAM533qGWQCGm1Kcqnpgca1spCWLPqaLHjN3ASjl+hpz/22oDsePKq8
        1m9+MLrAk9SWRR88Wy4QeC2wo+LCmmWKi9tCPk1Zu0GlCjDV2VSmBIWiRm8R9qBVD8f4DxPMsZz
        Hp7BxIiZzsnWClr0MVjl3IHxI
X-Received: by 2002:adf:db05:0:b0:20a:dbf1:fdf8 with SMTP id s5-20020adfdb05000000b0020adbf1fdf8mr14784253wri.404.1651132374001;
        Thu, 28 Apr 2022 00:52:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4nP57a8g94sEy+weZhg736sd16pvG88YCpRY4VbB3lBBzq0jKK+zIIYv2kWADbstM5n+KNA==
X-Received: by 2002:adf:db05:0:b0:20a:dbf1:fdf8 with SMTP id s5-20020adfdb05000000b0020adbf1fdf8mr14784239wri.404.1651132373697;
        Thu, 28 Apr 2022 00:52:53 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b00393faf12859sm3826617wmi.18.2022.04.28.00.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:52:53 -0700 (PDT)
Message-ID: <1d456654-6d06-ef35-b9a0-519db7d5b35e@redhat.com>
Date:   Thu, 28 Apr 2022 09:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/display: Select DP helper for DRM_DP_AUX_CHARDEV
 and DRM_DP_CEC
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20220427215528.237861-1-javierm@redhat.com>
 <46446e78-60a6-1b8c-1bb6-1c005489d58c@suse.de>
 <6f3b8d37-0a70-a035-e87b-5aa72926fff9@redhat.com>
 <af31d343-202b-ffaa-c6a9-b20247938dfd@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <af31d343-202b-ffaa-c6a9-b20247938dfd@suse.de>
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

On 4/28/22 09:45, Thomas Zimmermann wrote:

[snip]

>>> You cannot select DISPLAY_DP_HELPER without DISPLAY_HELPER.
>>>
>>
>> That was my original thought as well and what did in v1, but then I noticed
>> that doing that it would force DRM_DISPLAY_HELPER to be set as built-in and
>> not allow to be built as a module.
> 
> It was a rhetorical only. I didn't mean to actually set DISPLAY_HELPER.
> 

Ah, sorry for misunderstanding.

>>   
>>> Can't you simply make it depend on DISPLAY_DP_HELPER.  The menu entry
>>> will show up as soon as there's a driver that selcets DISPLAY_DP_HELPER.
>>>
>>
>> I could but then that means that once won't be able to select these two config
>> options unless some enable symbol selects DRM_DISPLAY_DP_HELPER.
>>
>> In my opinion, DRM_DP_AUX_CHARDEV and DRM_DP_CEC are different than all other
>> options that select DRM_DISPLAY_DP_HELPER, since those are drivers and want to
>> have both DRM_DISPLAY_DP_HELPER and DRM_DISPLAY_HELPER set.
>>
>> But DRM_DP_AUX_CHARDEV and DRM_DP_CEC are just included in drm_display_helper.o
>> if enabled, and depend on symbols that are present if CONFIG_DRM_DISPLAY_DP_HELPER
>> is enabled. So just need the latter, if DRM_DISPLAY_HELPER is not enabled then it
>> will just be a no-op.
>>
>> Having written that though I noticed that a "depends on DRM_DISPLAY_HELPER" makes
>> sense. If you agree I can add it and post a v3.
> 
> Yes please.  These options enable features of the DP code. If there's no 
> driver with DP, it doesn't make sense to allow them.
> 
> I know that there could be an odd situation where userspace might not 
> have DP, but still wants the chardev file of aux bus.  But that 
> situation existed already when the code was located within KMS helpers.
> 

Agreed.

>>
>> Now, pondering more about this issue, probably the most correct thing to do is for
>> the drivers that make use of the symbols exported by DRM_DP_{AUX_CHARDEV,CEC} to
>> select these. What do you think ?
> 
> That's not considered good style. Select should not be used for anything 
> that is user-configurable. [1]
>

Right. So giving even more thought to this, now I think that we should just include
drm_dp_aux_dev.o, drm_dp_cec.o (and probably drm_dp_aux_bus.o?) unconditionally to
drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER).

After all, these are not big objects and drm_display_helper can now be built as module.

I don't see that much value to have separate user-configurable config options...

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

