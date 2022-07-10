Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5E56CFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGJPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 469F0E003
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657468018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPYVKIx9+vkBBxCA3VpGwrUiwn2ACrXmzlpvp/uFY4A=;
        b=R807I60nyuallpl+ZBpqv5I11FwFreMmT5BiDDJYFwCkXntW2PfMqeeCBoWjyq18H0fQff
        Jhkm9vF6JzDf6Gvmuu51IoL6wFecqFbu8Tpgh8xWtRDsLeRO29m5HU12zoseFnX8qwxrtm
        FJOPRDGy8ef9ZsKEw3rSf9a5KYKj3HQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-71ZHy4INNQGo76U0JTgqQA-1; Sun, 10 Jul 2022 11:46:57 -0400
X-MC-Unique: 71ZHy4INNQGo76U0JTgqQA-1
Received: by mail-ed1-f72.google.com with SMTP id bs1-20020a056402304100b0043ad1e84611so502513edb.15
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=VPYVKIx9+vkBBxCA3VpGwrUiwn2ACrXmzlpvp/uFY4A=;
        b=EbAJ9Ic4+528Iw/gNG4vDDeB3pkOMn4/WJLYK9ShghmAkT89vUA3OaJ3JL+p6N1kU1
         ZKy1+XazUeAaDBVwUwXxwTTfsNMv0ZALc1ckOyvtXsmZbjurVM4s44p2ob9D2KeAWCOh
         yEh7gGTDDmWM8aQWk3ZLj+yPKxuyOS2s+eXYS7MSBuhsZ+GYdjdhnkmFgW0/LoYgzNpG
         G6KeDhO923QbmHkPn+VV96Gc/9bH7zMbGl9W3uJXy6PhDMR/suskeLTriNpD5xVOICU6
         f4WGShh6O4ioSjm+9i/Gut6h1f2RPjmTqbzHa3HTaNP70R8uKuB1vx6kHLlgUut3R9Gf
         wSmQ==
X-Gm-Message-State: AJIora8nUB7Hqeghb2QGAaz9l/EUiWLhfUTF/zVAVtdKtIaEQCZnvJJo
        GvrEgcAYN2wWhYNIeo5mywIrbSqldkCc/wd546EQM4szlmhYH61mk60OFi+Ku77vOjLnADOy3xn
        PMO9oqyi8O3WNBqHpoUoBWcXK
X-Received: by 2002:a17:906:b1c1:b0:726:b009:4b63 with SMTP id bv1-20020a170906b1c100b00726b0094b63mr14618444ejb.24.1657468016056;
        Sun, 10 Jul 2022 08:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4udJzq5lowtdTThnyvA4QbL00JloyCK6+SIag0ljVhpHv2TdMV8zc8+X1zL3W+z9u6Q+Dpg==
X-Received: by 2002:a17:906:b1c1:b0:726:b009:4b63 with SMTP id bv1-20020a170906b1c100b00726b0094b63mr14618430ejb.24.1657468015882;
        Sun, 10 Jul 2022 08:46:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id p20-20020a056402155400b0043a896048basm2911115edx.85.2022.07.10.08.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:46:55 -0700 (PDT)
Message-ID: <be4d90b2-b7d2-9f9b-7a2b-55da21c97840@redhat.com>
Date:   Sun, 10 Jul 2022 17:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add key mappings
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Misaka19465 <misaka19465@olddoctor.net>, corentin.chary@gmail.com,
        markgross@kernel.org
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710113727.281634-1-misaka19465@olddoctor.net>
 <1e8d2cb2-8417-d9aa-72dc-6e698771979e@redhat.com>
In-Reply-To: <1e8d2cb2-8417-d9aa-72dc-6e698771979e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/10/22 17:34, Hans de Goede wrote:
> Hi,
> 
> On 7/10/22 13:37, Misaka19465 wrote:
>> On laptops like ASUS TUF Gaming A15, which have hotkeys to start Armoury
>> Crate or AURA Sync, these hotkeys are unavailable. This patch add
>> mappings for them.
>>
>> Signed-off-by: Misaka19465 <misaka19465@olddoctor.net>
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

I just noticed that this patch submission is not using your real name
in "<Firstname> <Lastname>" format as required by the kernel submission
guidelines:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Since this is a very trivial patch I'm going to keep it in my
tree anyways, but for future kernel submissions please use your
real name.

Regards,

Hans




>> ---
>>  drivers/platform/x86/asus-nb-wmi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>> index 57a07db65..478dd300b 100644
>> --- a/drivers/platform/x86/asus-nb-wmi.c
>> +++ b/drivers/platform/x86/asus-nb-wmi.c
>> @@ -522,6 +522,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>>  	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
>>  	{ KE_KEY, 0x32, { KEY_MUTE } },
>>  	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
>> +	{ KE_KEY, 0x38, { KEY_PROG3 } }, /* Armoury Crate */
>>  	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
>>  	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
>>  	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */
>> @@ -574,6 +575,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>>  	{ KE_KEY, 0xA5, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + TV + HDMI */
>>  	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
>>  	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
>> +	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
>>  	{ KE_KEY, 0xB5, { KEY_CALC } },
>>  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },

