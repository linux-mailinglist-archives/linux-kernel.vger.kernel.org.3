Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF64C9777
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiCAVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiCAVEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262D16662F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646168643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwCm6HAyJrAYvXTnRc2PbVlW2m0OLPVQ/bg97TmXFeY=;
        b=CBraVGD838wdKu23FTg3o2iTgFFQFoJbJ68OAzQ5Sx1zWGY1/sMjK1Kt69Y3Z1VA14teRj
        BOTnV6BV20d30cWRnzSPuleeFLYu9zEwyC2uswi3h42irSOGDDJdeD7gE0rRr6Wjb1Wb17
        c41hAYTC1lzfQy2wVdpPw7uoZ6Bvlnc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-AW5mTfQ6OkW7Lb6WkZOPFw-1; Tue, 01 Mar 2022 16:04:02 -0500
X-MC-Unique: AW5mTfQ6OkW7Lb6WkZOPFw-1
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so7365741ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 13:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EwCm6HAyJrAYvXTnRc2PbVlW2m0OLPVQ/bg97TmXFeY=;
        b=UfGa2ov5b3fIFoApZfLlTDViO7Sn+sdSgLg8+JSz2VCGte89NhGyfNtOWXwPxSrmy8
         ZmZJprg1welV/+JZOphis4vU0wpCEceDjKO6o2aiEeU1dWs6lvvYlHscPGM9VVECMVSV
         1LAlG7k52+t3vZrFth9mxM1F61SjjOU5nHQb4Brgz/0ZudgD9iyRmzD+bwfS0xk/dmx7
         sU6n3/NfomVp/3h0009Y/r6g9jD7/iwU+gdFuMTDeEKpWPMihNEHYs2+Nb9h8KLu2r48
         iVgb7bbTISQp6RYztin3koXmd50w1jRvEArhR3jn+uTLsVzxDURdgvui5Lctg2zYDeXK
         XOpw==
X-Gm-Message-State: AOAM532aXgu9ofLeePFvsU9LwocHMkwINcexMBbQaUtXBgFBBWWJeFFC
        NktI1UCNt+gi6Y3L5M0MiY901NL2NvsYjRQ+ngc+NhwUKtW8G4g0B68g+88aWWXTrpjO75cx4n7
        A6O7DTCnzbGcLZPyDLmhZe7Hp
X-Received: by 2002:a17:907:2d0c:b0:6d6:f8ce:795b with SMTP id gs12-20020a1709072d0c00b006d6f8ce795bmr2864729ejc.54.1646168640836;
        Tue, 01 Mar 2022 13:04:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0RTvkFChTKb/q9VHrVf39kxe1ZV8LMhVilXAHXmtmj60uhFwOT7VSChcj27v1P+er0blTog==
X-Received: by 2002:a17:907:2d0c:b0:6d6:f8ce:795b with SMTP id gs12-20020a1709072d0c00b006d6f8ce795bmr2864713ejc.54.1646168640617;
        Tue, 01 Mar 2022 13:04:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id qh23-20020a170906ecb700b006d6e97b94aesm754300ejb.9.2022.03.01.13.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 13:04:00 -0800 (PST)
Message-ID: <7eb134f9-a633-70f4-0089-c864e5add4d2@redhat.com>
Date:   Tue, 1 Mar 2022 22:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] platform/surface: surfacepro3_button: don't load on
 amd variant
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sachi King <nakato@nakato.io>, Chen Yu <yu.c.chen@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211109081125.41410-1-nakato@nakato.io>
 <20211109081125.41410-2-nakato@nakato.io>
 <CAHp75Vcw-ARNZCRRJGzbQ7xc3ZB=98eFCuEFc4cj5W3vAj5EZw@mail.gmail.com>
 <Yh6Joy2HDnsuK6LN@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yh6Joy2HDnsuK6LN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 3/1/22 22:01, Dmitry Torokhov wrote:
> On Tue, Nov 09, 2021 at 11:12:34AM +0200, Andy Shevchenko wrote:
>> On Tue, Nov 9, 2021 at 10:11 AM Sachi King <nakato@nakato.io> wrote:
>>>
>>> The AMD variant of the Surface Laptop report 0 for their OEM platform
>>> revision.  The Surface devices that require the surfacepro3_button
>>> driver do not have the _DSM that gets the OEM platform revision.  If the
>>> method does not exist, load surfacepro3_button.
>>
>> ...
>>
>>>   * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
>>>   * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
>>> - * device by checking for the _DSM method and OEM Platform Revision.
>>> + * device by checking for the _DSM method and OEM Platform Revision DSM
>>> + * function.
>>
>> Not sure what this change means (not a native speaker).
>>
>> ...
>>
>>> -       dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
>>
>> I think this is useful to have.
>>
>> What about leaving it as is for debugging purposes and just replacing
>> the last test?
> 
> I agree it is nice to be able to print it for debug purposes, but it has
> to be fetched separately, as with the proposed change we are not reading
> it.
> 
> If I am understanding the change it wants to call acpi_dsm_check()
> to verify whether MSHW0040_DSM_GET_OMPR function exists at all (which is
> done by reading _DSM MSHW0040_DSM_UUID, revision MSHW0040_DSM_REVISION,
> function 0. Only if function 0 indicates that function
> MSHW0040_DSM_GET_OMPR is supported in this _DSM, we can read it to get
> the real version number, which can be 0.
> 
> Treating 0 as an invalid version as it was done in original change is
> wrong.
> 
> I propose we combine the old and new code, call acpi_dsm_check() and
> bail if it returns false, otherwise proceed to calling
> acpi_evaluate_dsm_typed() and dev_dbg() the version.
> 
> Sachi, are you going to update the patch? You do not need to adjust the
> surface driver as Hans is getting rid of it.

Right, for more info on that see:

https://lore.kernel.org/linux-input/20220224110241.9613-1-hdegoede@redhat.com/

Regards,

Hans

