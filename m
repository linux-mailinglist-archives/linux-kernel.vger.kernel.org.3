Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E610557036E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiGKM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F2C02A957
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657544163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kt5/cjcKZ2gRwWekh9fqy7LIWEf6ib/V3LQ9qeWBy+M=;
        b=DFfnaYj/0boBPfYunZHEM9dKgQ9/VW30omSNgPp3b18sHtU3FUMpBaBdsE+iqXN/KURoQ1
        dIzy8XXQ67QnLL6Ls5oEms7ejAn1miKItPKTkm2IEqF6RnTSTA2s5tG9YEl0WJ6IlWUBL5
        3uWbOQm4nHYBNfNOfvpQHVV5LUm5P9Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-irYFcxxzMiyCjhJYjh6Rog-1; Mon, 11 Jul 2022 08:55:56 -0400
X-MC-Unique: irYFcxxzMiyCjhJYjh6Rog-1
Received: by mail-ed1-f72.google.com with SMTP id c9-20020a05640227c900b0043ad14b1fa0so1988424ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kt5/cjcKZ2gRwWekh9fqy7LIWEf6ib/V3LQ9qeWBy+M=;
        b=Mrvc2LUZBhgiMD5ivtQm6ux/02avZdBeOaJ6WX624lvg8LjrOBz3hCbc7ON9HA2m4c
         4v4oRqid3jzwydg1VL197Oa7KR7ss2AzTo2n8nkPA7PfJKKlIp2W0dgg78UTRSFi1FZ0
         ExSVfZZpcfkfM1eJ01uV+fKVjhUHbvqFoxpuZ00ozf8sMJq1QfXSpM1BJz4kSdyK6S9c
         N93UQ05CUQonOOoYyGDouuHQsEFKZ/qkyyaj8xvd63/TAT99UtE1tDfiOd4DZwIqZDDu
         7MfjDVdUGVFY6UiYLWhOOmVcsyA5KQkapl02RVhLOI1/69Rc6sUMQjbEsxAo1F9t51va
         fM1g==
X-Gm-Message-State: AJIora+P28FP3jKuynJtJxkwj2YCYVhURTfVMOLHUAVGRpLb9MDxvfDl
        WrYfMWE5XnopAXfBDCm1KdVRWG1AaVgJqQuCza3hCLavM8qgMAbDkIX+EeJlrIsyNL0+BdqAvog
        p40m3DoFleZJuH8HiytcCgqfP
X-Received: by 2002:a05:6402:2553:b0:43a:caa2:4956 with SMTP id l19-20020a056402255300b0043acaa24956mr10907660edb.406.1657544155316;
        Mon, 11 Jul 2022 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tNqb7ZLkvusDSgn+rhuE3nnCzlnbhFr6wBS7PtlTl+WaJMGyDfPSkmDo3kuHbEDzZ/cgVouw==
X-Received: by 2002:a05:6402:2553:b0:43a:caa2:4956 with SMTP id l19-20020a056402255300b0043acaa24956mr10907638edb.406.1657544155092;
        Mon, 11 Jul 2022 05:55:55 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cb1-20020a0564020b6100b0043a6dc3c4b0sm4300219edb.41.2022.07.11.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:55:54 -0700 (PDT)
Message-ID: <e84a2cb3-ea2f-6ce4-aba8-4026b3e6bedd@redhat.com>
Date:   Mon, 11 Jul 2022 14:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] Input: i8042 - add TUXEDO devices to i8042 quirk
 tables for partial fix
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-3-wse@tuxedocomputers.com>
 <37a7e536-252a-c8a9-1412-37d3f2052a6d@redhat.com>
 <c5a7fa10-7b6a-fa0d-622e-4392fda1ee93@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c5a7fa10-7b6a-fa0d-622e-4392fda1ee93@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 7/11/22 14:45, Werner Sembach wrote:
> Hi,
> 
> On 7/8/22 21:39, Hans de Goede wrote:
>> Hi,
>>
>> On 7/8/22 18:10, Werner Sembach wrote:
>>> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
>>> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
>>> have an external PS/2 port so this can safely be set for all of them.
>>>
>>> I'm not entirely sure if every device listed really needs all four quirks,
>>> but after testing and production use. No negative effects could be
>>> observed when setting all four.
>>>
>>> Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
>>> and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
>>> boot and sometimes also after resume. However both are required for the
>>> keyboard to not fail completely sometimes after boot or resume.
>> Hmm, the very laggy bit does not sound good. Have you looked into other
>> solutions, e.g. what happens if you use just nomux without any of the
>> other 3 options ?
> 
> I tried a lot of combinations, but it was some time ago.
> 
> iirc: at least nomux and reset are required and both individually cause the lagging.
> 
> So the issue is not fixed by just using a different set of quirks.

Hmm, ok. So given that this seems to be the best we can do
the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/input/serio/i8042-x86ia64io.h | 28 +++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
>>> index 5204a7dd61d4..9dc0266e5168 100644
>>> --- a/drivers/input/serio/i8042-x86ia64io.h
>>> +++ b/drivers/input/serio/i8042-x86ia64io.h
>>> @@ -1107,6 +1107,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>>           .driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>>>                       SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>>>       },
>>> +    {
>>> +        /*
>>> +         * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
>>> +         * the keyboard very laggy for ~5 seconds after boot and
>>> +         * sometimes also after resume.
>>> +         * However both are required for the keyboard to not fail
>>> +         * completely sometimes after boot or resume.
>>> +         */
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
>>> +        },
>>> +        .driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>>> +                    SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>>> +    },
>>>       {
>>>           .matches = {
>>>               DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>>> @@ -1114,6 +1128,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>>           .driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>>>                       SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>>>       },
>>> +    {
>>> +        /*
>>> +         * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
>>> +         * the keyboard very laggy for ~5 seconds after boot and
>>> +         * sometimes also after resume.
>>> +         * However both are required for the keyboard to not fail
>>> +         * completely sometimes after boot or resume.
>>> +         */
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_BOARD_NAME, "NHxxRZQ"),
>>> +        },
>>> +        .driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>>> +                    SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>>> +    },
>>>       {
>>>           .matches = {
>>>               DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> 

