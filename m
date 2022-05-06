Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478E51D531
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390811AbiEFKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380183AbiEFKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:13:22 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35335DA76
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651831778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOWS0SnhxRabwY6CwSlygo4KQpWmdUPaH/DQE5P2/XI=;
        b=D6Pia7uv+35KUHkaTsFEvRZ59ZpSbdOsOMeZZ0NeaGQlevJmAAe6mQpM1Yla/LMThY2CA1
        V1SVEyhXHVMhh1aWAMQoHyuo76SakSApJRIuhg5zpH7WaXIfcjyCvsFjqLOaCdBUqYfaKr
        V2iG45vkwFFOMpTWZEfsJ4s8X5ioFFE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-K-U8VNYKNHS85VTlDxxJiA-1; Fri, 06 May 2022 06:09:37 -0400
X-MC-Unique: K-U8VNYKNHS85VTlDxxJiA-1
Received: by mail-ej1-f72.google.com with SMTP id hq12-20020a1709073f0c00b006f48c335617so4101087ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uOWS0SnhxRabwY6CwSlygo4KQpWmdUPaH/DQE5P2/XI=;
        b=CXGB01hMtY3oIPKpaXOkxcuDZUVwSGJrlIe3/t+vvf21sqh3p3I01hvcTB0kE24a5g
         Dcyv5eP+n+FTUcLald+R5yRD0rIn4pJkg319Knjq4VT2u2vBQaCcxEJcYHz+M6qPJTy5
         G7HhtZJfMw9/ZCT/XoL1sAPHDExXMTc7UBVX/o+dDvQLL0H5Xp8Ln1e5+KEEI+Ji8wv1
         TGFT259VmkXuRr+heRODvhaJv0bmRvWsY0lMEw94YFseopnIKqfBN6v2qRfCSI7RzgaQ
         lj5c9VU9mpXU1T4Hj+ndxqYBd6cfLu6iR16TateDShmfoeolNL6juC9fLF1SnHOW7fKN
         0PjQ==
X-Gm-Message-State: AOAM533b4Lwy8FFsp3Q053bqFv5126unlimqZGGv0f+RadWl8qxMz4vg
        y4Ls69ZeWFCbyBqCgBbHMs2WkRixIGhDNIzwppF69h0KKb0yzspdsDz9guTeUVmU5TlwHRSNezd
        wltsCv25yAlpV93WXzhE0tpUJ
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr2282901ejy.220.1651831776702;
        Fri, 06 May 2022 03:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJCeVRmWyEZTm9ZJfhD1PzXGshg/VEIDhqyZ0BJ2r04TAomRD8A1X8M7WiQc0hhUNe+7GJKQ==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr2282891ejy.220.1651831776549;
        Fri, 06 May 2022 03:09:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907a21800b006f3ef214e2bsm1752975ejc.145.2022.05.06.03.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:09:35 -0700 (PDT)
Message-ID: <69b622c0-550b-f562-eb1e-7614e97acc25@redhat.com>
Date:   Fri, 6 May 2022 12:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
 thinkpad_acpi: quirk_btusb_bug can be static
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202205031944.EP1ElC1B-lkp@intel.com>
 <YnEPbSO2rBJq37Ez@74ccfaeec2ea>
 <BL1PR12MB5157478736D9C5E82B4D9B1DE2C09@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157478736D9C5E82B4D9B1DE2C09@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/22 15:07, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: kernel test robot <lkp@intel.com>
>> Sent: Tuesday, May 3, 2022 06:18
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: kbuild-all@lists.01.org; Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>; Hans de Goede
>> <hdegoede@redhat.com>; linux-kernel@vger.kernel.org
>> Subject: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
>> thinkpad_acpi: quirk_btusb_bug can be static
>>
>> drivers/platform/x86/thinkpad_acpi.c:317:20: warning: symbol
>> 'quirk_btusb_bug' was not declared. Should it be static?
>>
>> Fixes: 25eecc2ff6cc ("platform/x86: thinkpad_acpi: Convert btusb DMI list to
>> quirks")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: kernel test robot <lkp@intel.com>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, since the original patch was still in my review-hans
branch (and not yet in for-next) I've squashed this fix into
the original patch.

Regards,

Hans





> 
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c
>> b/drivers/platform/x86/thinkpad_acpi.c
>> index aed17d32ed84b..eefa22e86ae10 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -314,7 +314,7 @@ struct quirk_entry {
>>  	bool btusb_bug;
>>  };
>>
>> -struct quirk_entry quirk_btusb_bug = {
>> +static struct quirk_entry quirk_btusb_bug = {
>>  	.btusb_bug = true,
>>  };
>>
> 

