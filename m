Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454D5560124
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiF2NTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiF2NTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9878205C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656508768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/s66TycFjsnf7M9dntoD1m3pIAIX19ahNx8L1rEelI=;
        b=XjLHdmGnPIxXw0mIltMsqidc1GQmZn0UN/NUV0b9Uva6JeUHjHT+le1MV1vhVQgs/zKr/t
        2u7M6HQLE1VWzxv3/A8d5LTYU64IIhWneU8oy2yxrr3zlU/m2XL/RCe9hp315aKs/3yEzq
        nkbdlFZTg2eEJ8FohgqB/exCn12q8wg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-9ptgYPngNtelIRF48qUe0Q-1; Wed, 29 Jun 2022 09:19:19 -0400
X-MC-Unique: 9ptgYPngNtelIRF48qUe0Q-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00435afb01d7fso11912312edd.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=w/s66TycFjsnf7M9dntoD1m3pIAIX19ahNx8L1rEelI=;
        b=rgA0JcXAJAxLb5BNByMnoqEAgISHexe1MSnWjV+LqIG6ZKah704WFH3rZMhPYZrrUl
         22oUrirmoddU3jESqhbMH0trxg+viWupdUMjNMovPonM12EMHwmpkMSNsGbJmDTduzrM
         iW2zU9U6tHeN81xl9SDLkH9mDTU+MTk8u+iuJXdZbp8a1C32dxvLUUR4lhZP9TqZGeer
         k86+5b6bsq30IediXBXkY5RWm0FUeTqxbO6KnaOoq2J10/lzx+B87nRH8L7K4tXXYoZi
         YXlJPPqTIq4sd7t4aaDFRogu1vpaGCLBpMdXDfClTq4zOcy0vNSciAz8xjLD84ALxqAB
         Urog==
X-Gm-Message-State: AJIora9f1r51B1tnMDejB1u5bXY8voHhn4mEQ3EKh883Z92ATGmLJuc1
        0yu/hGOHAU8qPacAMBGF+L3XtIYvGtJmEChgzw2pH12o4qXa73QGzoo1EV7KiJfTqFx4ZB4Fpkf
        Eny4MDxxMPRzUCw1ab/5y0Z1a
X-Received: by 2002:a05:6402:4493:b0:435:8dd5:c951 with SMTP id er19-20020a056402449300b004358dd5c951mr4139391edb.289.1656508758437;
        Wed, 29 Jun 2022 06:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twTQJGJJgyVQbYpHlavJOPVMXQgY0xgrdmtLCOwFYpKp/YM3lEygJQdErGFIQf2E50HvVzdw==
X-Received: by 2002:a05:6402:4493:b0:435:8dd5:c951 with SMTP id er19-20020a056402449300b004358dd5c951mr4139379edb.289.1656508758259;
        Wed, 29 Jun 2022 06:19:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b00722fadc4279sm7770242eje.124.2022.06.29.06.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:19:17 -0700 (PDT)
Message-ID: <807c2530-9382-9469-3e47-00770b3521bd@redhat.com>
Date:   Wed, 29 Jun 2022 15:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
 <YruJk4aAmFo/mihX@smile.fi.intel.com>
 <35153061-0d52-1c77-5921-e8ea0a662b3b@redhat.com>
In-Reply-To: <35153061-0d52-1c77-5921-e8ea0a662b3b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 15:18, Hans de Goede wrote:
> Hi,
> 
> On 6/29/22 01:06, Andy Shevchenko wrote:
>> On Mon, Jun 20, 2022 at 11:04:38AM +0200, Hans de Goede wrote:
>>> p.s.
>>>
>>> I've added this commit to my local tree, so that the next time I boot
>>> a device with a CRC PMIC it will get some testing.
>>
>> Have you had a chance to boot such device?
> 
> Not yet, but I've just put a new kernel on one of these devices
> and everything still works fine AFAICT:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

p.s.

This is for the entire series.

Regards,

Hans

