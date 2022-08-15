Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED259301A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiHONkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiHONkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C3E663EA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660570835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFznknxYVUIEfYgBOXexxkEEuynTrS8Oz/t2Nz94EIw=;
        b=dhsFPazmTXS4cEtebCTpeD0heOUfrKO7QHEc+yPAjOqvDxkW/KG1QO0RmEb0yYgd7v0vSQ
        bcCMg77Sgx7+l4G/UJD9O3gtkF5S013FW/CmK7DrS4OXjElxOt2iDbl17fZiEGpRTVVAXE
        NmiS2aEmOuvhNCVgu2HwyrGoJP77ci8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-8vOpApuNN_m8ywBBPyxZNA-1; Mon, 15 Aug 2022 09:40:34 -0400
X-MC-Unique: 8vOpApuNN_m8ywBBPyxZNA-1
Received: by mail-ed1-f70.google.com with SMTP id s21-20020a056402521500b00440e91f30easo4721652edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WFznknxYVUIEfYgBOXexxkEEuynTrS8Oz/t2Nz94EIw=;
        b=Q4cn6dpiRH83XhebH7Xs6AFZTyMZU3c3HsMeRBuHNib9zC/mvVmOWJFIsQLkm7zo2Q
         yTKm+h7jAZDMlfm4BBXVMOxYaHuHfBRX3OPozkkDFSmXrHEugQ5ZtujcWjDwgWgU00yg
         2XFtQ3lXlewSrYiqP8b0TA8oKNnfd+mXoSu99gIibiq3sa9tB/ak0wAjzoebY5b5aGUh
         Sv6ve8PHBGNrx86OLBVVk9MmDf2ktK8yV4Ihm5cmK/LpGVcetNvHEpthp7WYo5wZp9dM
         hQ6n0ejoW0ve6wm8Ii21X/J5Lr5nbabZUKe4s0RIGDgUfOfyq0H+SRLG/PoWD1Fz/8c1
         a+tA==
X-Gm-Message-State: ACgBeo0GoHKvyomZaoYrl2OjWcRbrdYvIROBPsCkMsNPQvdixKFgNCy7
        v5eDfFCUEGRyVi47MFZvmsq4oG9Q1WhcHHTZIJ+8CPrnNVfabMPCz5CaocNf2OERNqRV20ZIiwi
        Gjppy85Xqv6GjdOGHc1USmjOr
X-Received: by 2002:a17:907:6095:b0:731:87a0:b9e8 with SMTP id ht21-20020a170907609500b0073187a0b9e8mr10680395ejc.124.1660570832241;
        Mon, 15 Aug 2022 06:40:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5oZ7fArE1z6FU2jiWJzYS68Y0xeV9C+owuOUu+SUoYpcY6/WJu+7AZUENP6EKBs3mosb+cIw==
X-Received: by 2002:a17:907:6095:b0:731:87a0:b9e8 with SMTP id ht21-20020a170907609500b0073187a0b9e8mr10680387ejc.124.1660570832079;
        Mon, 15 Aug 2022 06:40:32 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s23-20020a508d17000000b0043d7923af6esm6625114eds.95.2022.08.15.06.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:40:31 -0700 (PDT)
Message-ID: <657998b3-0f26-9a66-8191-713715622c01@redhat.com>
Date:   Mon, 15 Aug 2022 15:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable
 method")
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220812222509.292692-1-luke@ljones.dev>
 <20220812222509.292692-2-luke@ljones.dev>
 <fc250b82-c7c7-9215-f3dd-be87e0a72edd@redhat.com>
In-Reply-To: <fc250b82-c7c7-9215-f3dd-be87e0a72edd@redhat.com>
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

Hi,

On 8/15/22 15:25, Hans de Goede wrote:
> Hi Luke,
> 
> On 8/13/22 00:25, Luke D. Jones wrote:
>> The dgpu_disable attribute was not documented, this adds the
>> required documentation.
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Thanks for the patch. Note that the Fixes tag should be above your
> signed-off-by and then the patch should otherwise have a normal
> subject + body. I've changed the commit msg to the following
> while merging this:
> 
> """
> platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute
>     
> The dgpu_disable attribute was not documented, this adds the
> required documentation.
>     
> Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> """

While merging this I noticed that this is also using spaces
instead of tabs for indentation, where as the rest of
the file is using tabs.

I've also fixed this up while merging, but next time
please make sure to use spaces.

I will make similar spaces -> tabs changes to patch 2/6 and 3/6

Regards,

Hans




>> ---
>>  Documentation/ABI/testing/sysfs-platform-asus-wmi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> index 04885738cf15..0f932fd60f4a 100644
>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> @@ -57,3 +57,12 @@ Description:
>>  			* 0 - default,
>>  			* 1 - overboost,
>>  			* 2 - silent
>> +
>> +What:          /sys/devices/platform/<platform>/dgpu_disable
>> +Date:          Aug 2022
>> +KernelVersion: 5.17
>> +Contact:       "Luke Jones" <luke@ljones.dev>
>> +Description:
>> +               Disable discrete GPU:
>> +                       * 0 - Enable dGPU,
>> +                       * 1 - Disable dGPU,
>> \ No newline at end of file
> 
> Next time please make sure the file always ends with a newline
> even in intermediate patches.
> 
> Regards,
> 
> Hans
> 
> 

