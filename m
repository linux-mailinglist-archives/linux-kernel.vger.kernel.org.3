Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36184C4A57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbiBYQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbiBYQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8E42556D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645805767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OEd/VtmTJwMrSGPhOxJTg9pxuU0lX+Y7uaWoPiMDHI=;
        b=dYA28GvOHcoyPVmeo6upNVASueVQlj0vd5XGzF9PwLD5sx0RPK0xHj9foSkUYcC+9qMN2F
        ztBXE+dd5uc65t03dsvMM2s/MeRMjZV7nssfUz+gOTktjI/NV9R/zYUiK1nRjNlZWDb4Ho
        UsMC+j5+E+2MskQ0GJXQOS7MdxHNdwc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-KBS0rr0pM3SlOpiKXQnKhw-1; Fri, 25 Feb 2022 11:16:06 -0500
X-MC-Unique: KBS0rr0pM3SlOpiKXQnKhw-1
Received: by mail-ed1-f72.google.com with SMTP id m12-20020a056402510c00b00413298c3c42so2529419edd.15
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3OEd/VtmTJwMrSGPhOxJTg9pxuU0lX+Y7uaWoPiMDHI=;
        b=SP5+ldqKDTNpM78u9bvJ50zd5zvyj70xxk4r/u/oJR2Y0YrPtiNjHGUdjOkAKbhRjl
         hEA3R77UUfBjRMYlLpSy1bELJaIF+5Lkrk7Dj0d1/8bENJ213VOUpaOlc4uNUTFV0GDv
         sJj+h3dElXIbgVZem6Y54GGCHXOWC4DFtUnVF/v/YHTk20S15pE6KmYPJgBfgPZI06uo
         +hb+972xrAYMeWUaiy5/Dm6/nXAQG4SG15lzp/zfapDPoDEWEwkFDY1XKEleyGuuJBjG
         vTH/sQu+LA6Vy03VSdGqmuq5gwkrRyohv0r4E4oYgg9Vsp7qlbra/X3NYBFIBx29jIMu
         ZTrw==
X-Gm-Message-State: AOAM5323MOjbe9k0M98rN+xQfIKt0FkhaThS/Z66cwA75qUuTa9EcjlK
        MVbvHKwRcPtJqZmfYK5MN38cVybIEhar0cORD2yw4AsgXBSULel62dBYc5W1aaXDrcb3T0M+TdW
        m8pTBzmkL/WSnKyMK9QQOPIvg
X-Received: by 2002:a17:906:d8dc:b0:6cf:d1d1:db25 with SMTP id re28-20020a170906d8dc00b006cfd1d1db25mr6673708ejb.285.1645805764847;
        Fri, 25 Feb 2022 08:16:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPMT+narGYqhLUuyTwbLAnY1OoMrWWhtWDKJmVqPtEW1vPN9oiz2mOUWtRBrRBFQDs0aYyKA==
X-Received: by 2002:a17:906:d8dc:b0:6cf:d1d1:db25 with SMTP id re28-20020a170906d8dc00b006cfd1d1db25mr6673693ejb.285.1645805764627;
        Fri, 25 Feb 2022 08:16:04 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm1539540edv.62.2022.02.25.08.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:16:04 -0800 (PST)
Message-ID: <e65c4fbb-95d0-5c5a-2b15-414b519d3319@redhat.com>
Date:   Fri, 25 Feb 2022 17:16:03 +0100
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157D29423AE95EE32F00303E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/25/22 17:04, Limonciello, Mario wrote:
> [Public]
> 
>> On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
>>> This board definition was originally created for mobile devices to
>>> designate default link power managmeent policy to influence runtime
>>> power consumption.
>>>
>>> As this is interesting for more than just mobile designs, rename the
>>> board to `board_ahci_low_power` to make it clear it is about default
>>> policy.
>>
>> Is there any good reason to not just apply the policy to all devices
>> by default?
> 
> That sure would make this all cleaner.
> 
> I think Hans knows more of the history here than anyone else.  I had
> presumed there was some data loss scenarios with some of the older
> chipsets.

When I first introduced this change there were reports of crashes and
data corruption caused by setting the policy to min_power, these were
tied to some motherboards and/or to some drives.

This is the whole reason why I only enabled this on a subset of all the
AHCI chipsets.

At least on devices with a chipset which is currently marked as
mobile, the motherboard specific issues could be fixed with a BIOS
update. But I doubt that similar BIOS fixes have also been rolled
out to all desktop boards (and have been applied by all users),
and I also don't know about older boards.

So enabling this on all chipsets is definitely not without risks.

Regards,

Hans




> 
> Hans?
> 

