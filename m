Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E34C5053
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiBYVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiBYVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50467377F4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645823255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvGqJtN9GRyHDJ8eYvTsPxIQgcsa+BJ8JKlxjsJBThI=;
        b=GuNNZPsOki+yoNI2D/AphsMmqpqPmV5ICebVqquwP6stTgxQmTdq9jumV5Z4bEPypxEnly
        w+akmWo/Fq1DIOuuXJwt5j8C84/XAotQRIy3KOV4NktDkHfdU3VN6LHZy5qNeNdIk81ad2
        uWpshr3XbTBgnrSIaWl0YTSgPvvi8jc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-bRub5tmHPCq0trzAv_00FA-1; Fri, 25 Feb 2022 16:07:34 -0500
X-MC-Unique: bRub5tmHPCq0trzAv_00FA-1
Received: by mail-ej1-f69.google.com with SMTP id m4-20020a170906160400b006be3f85906eso3115811ejd.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BvGqJtN9GRyHDJ8eYvTsPxIQgcsa+BJ8JKlxjsJBThI=;
        b=fg6DxdTEE7EvBGqahn2PxbxEby2HKlLnmLwbrIz8n0AkcmVUKP3WuXIm2zKNHJIQE2
         RgvdfonSM2hfLdjxXCZGXZQ9WlD6XdUm9PVSw20y8q9JPrWgoM5mNC487kgcR1Aa/Wu4
         UzkJF92Xm/0Mu/+QSoUa3se7dkbvPVgcc93l4jTuLnlH/84iR0k+ZSKfItsG6uvJg9q1
         KUjQjaBBfkKx5v4hbyJK1BeYcMlqovNpbxFlSjltxZHqnRslLivM5JsqamATgRdO23w2
         UPSDui5c5Q+DyKvV2movA9OcUodb5DpRAtOyDobPEEcSi3KLQWH+gQ66f/OzONpcUuu0
         NnmA==
X-Gm-Message-State: AOAM533xLbRfz/6ymDSkOLxXTBurEK/Ihl53+vAL1POHHlCF8Tzkhp4w
        X4ICcWuALG0z6oP6UTxGB3CkyxTcppsAhADIfs2/TYBzFP45iUlaQyBOKlVIVyX74bwkfYPrvFw
        sLNbNmhX0oZ6jnjSd6kDOCvaI
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr9065812edd.224.1645823252815;
        Fri, 25 Feb 2022 13:07:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzJbFJsi4Y8WkhYp64AGhvD2ORKr+59bd3en5mnyF9yWankEg42A+FFbktW0NgEwW4BeOz7g==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr9065797edd.224.1645823252601;
        Fri, 25 Feb 2022 13:07:32 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id gj7-20020a170907740700b006cf57a6648esm1394110ejc.90.2022.02.25.13.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:07:32 -0800 (PST)
Message-ID: <ee9a51e2-1733-dcd5-7514-0b8d1c1fa430@redhat.com>
Date:   Fri, 25 Feb 2022 22:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
References: <20220225061113.223920-1-mario.limonciello@amd.com>
 <Yhj9Pdp/sHASmBw4@infradead.org>
 <BL1PR12MB5157D29423AE95EE32F00303E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <e65c4fbb-95d0-5c5a-2b15-414b519d3319@redhat.com>
 <BL1PR12MB5157D6984E5855701A9449E0E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157D6984E5855701A9449E0E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/25/22 17:19, Limonciello, Mario wrote:
> [Public]
> 
>> On 2/25/22 17:04, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>> On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
>>>>> This board definition was originally created for mobile devices to
>>>>> designate default link power managmeent policy to influence runtime
>>>>> power consumption.
>>>>>
>>>>> As this is interesting for more than just mobile designs, rename the
>>>>> board to `board_ahci_low_power` to make it clear it is about default
>>>>> policy.
>>>>
>>>> Is there any good reason to not just apply the policy to all devices
>>>> by default?
>>>
>>> That sure would make this all cleaner.
>>>
>>> I think Hans knows more of the history here than anyone else.  I had
>>> presumed there was some data loss scenarios with some of the older
>>> chipsets.
>>
>> When I first introduced this change there were reports of crashes and
>> data corruption caused by setting the policy to min_power, these were
>> tied to some motherboards and/or to some drives.
>>
>> This is the whole reason why I only enabled this on a subset of all the
>> AHCI chipsets.
>>
>> At least on devices with a chipset which is currently marked as
>> mobile, the motherboard specific issues could be fixed with a BIOS
>> update. But I doubt that similar BIOS fixes have also been rolled
>> out to all desktop boards (and have been applied by all users),
>> and I also don't know about older boards.
>>
>> So enabling this on all chipsets is definitely not without risks.
>>
> 
> This was before min_power_with_partial and min_power_with_dipm
> were introduced though right?

The issues where some laptops needed BIOS updates was with fedora
using min_power_with_dipm as default for mobile chipsets.

>  Maybe another way to look at this
> is to drop the policy min_power, which overall is dangerous.

Maybe, see above. I'm not going to block this if people want
to give this a try, but it is going to require someone keeping
a very close look at any issues popping up and we must be
prepared to roll-back the change if necessary.

Regards,

Hans



