Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F4546D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348808AbiFJTuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiFJTuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C3E61216F3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654890613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPEN2+6GBTplQEGdJ+UhLEf1ujCa0/31mjo/sh9x7JE=;
        b=V5z/PG4boqIf8I1p9QHYIdC5ih0WZqL5z3TMlN1aub++9zcpouLlt5t4cLo48k6egX6YnB
        SpySVl7MoJfKk2pgjt34Hc6+d8MHEUvZzzFZ39qzQsWj/fRjtqGei7ItM6uCz30/hsRGUB
        c2E6FwASrn4pIEOQ6TscbmUwOcD81a8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-FSnpa7XEPXefBOUpr0aghQ-1; Fri, 10 Jun 2022 15:50:09 -0400
X-MC-Unique: FSnpa7XEPXefBOUpr0aghQ-1
Received: by mail-ed1-f69.google.com with SMTP id m5-20020a056402430500b004319d8ba8afso128795edc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPEN2+6GBTplQEGdJ+UhLEf1ujCa0/31mjo/sh9x7JE=;
        b=jI5oL4Nc+9Ot7prtiByAjbQA6ZDRhTgn5TjYA2P2UaEU/9UDdaHi7iEXOMVS0+jloJ
         4CJcl79SwQvoz9t0Tw6STFb2DMTcYWztybTU5tIaN7jH17jyqZQtGGVUOmMh9B9WBTzU
         YzMbdyEhvKLoaJYblNtHcA5Bme9DObUJHKxM6TKVpnRbPXZW3bOjGnvIQsaZ1iGWvzqO
         Pg/AcSzUtOUntJRa9yts+g7uJhX93cq87aManfpy4iwskyRJU5druDPRWI3p/AR6/Gls
         D9Js6kYtfE/Ea7tA4kPuV36ei9sxXscSVQzS97k0X0yhMHj5imQiERE8PNgcBofND/4R
         Vgtw==
X-Gm-Message-State: AOAM532hiFAMhWqSi056UjWLfYis/FoZtPqsmDneX0qZlIAxJwr7Yx+9
        Xu7CW7tMQSdAN+C+KwBu1FL09C3icsqJDQk9BKxxTmc01jLduMqWLLFoFa6Y0F1M0zYlKYAUowL
        NXZ0zXBadL1juOuICBS3oLNdP
X-Received: by 2002:a05:6402:278d:b0:42e:d3d5:922e with SMTP id b13-20020a056402278d00b0042ed3d5922emr43611012ede.154.1654890608679;
        Fri, 10 Jun 2022 12:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzcjqTjxF7E/PeaEKAiLGWjdNRC1MeXM11qRdquwxo3NsorAcbB1qQhuTcHIore7XCxllX7Q==
X-Received: by 2002:a05:6402:278d:b0:42e:d3d5:922e with SMTP id b13-20020a056402278d00b0042ed3d5922emr43610993ede.154.1654890608469;
        Fri, 10 Jun 2022 12:50:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906140f00b006fec1a73e48sm144ejc.64.2022.06.10.12.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 12:50:07 -0700 (PDT)
Message-ID: <5477c090-1d8d-f5a6-a204-45cb5acb6e20@redhat.com>
Date:   Fri, 10 Jun 2022 21:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/1] Resolve WMI query failures on some devices
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     balalic.enver@gmail.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
References: <20220608212923.8585-1-jorge.lopez2@hp.com>
 <20220608212923.8585-2-jorge.lopez2@hp.com>
 <CAHp75VfPoranKhsHJo=8jJXXhdvqn4-x2E2UJa-Yxb_=tO3QDg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfPoranKhsHJo=8jJXXhdvqn4-x2E2UJa-Yxb_=tO3QDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/9/22 18:29, Andy Shevchenko wrote:
> On Wed, Jun 8, 2022 at 11:32 PM Jorge Lopez <jorgealtxwork@gmail.com> wrote:
>>
>> WMI queries fail on some devices where the ACPI method HWMC
>> unconditionally attempts to create Fields beyond the buffer
>> if the buffer is too small, this breaks essential features
>> such as power profiles:
>>
>>          CreateByteField (Arg1, 0x10, D008)
>>          CreateByteField (Arg1, 0x11, D009)
>>          CreateByteField (Arg1, 0x12, D010)
>>          CreateDWordField (Arg1, 0x10, D032)
>>          CreateField (Arg1, 0x80, 0x0400, D128)
>>
>> In cases where args->data had zero length, ACPI BIOS Error
>> (bug): AE_AML_BUFFER_LIMIT, Field [D008] at bit
>> offset/length 128/8 exceeds size of target Buffer (128 bits)
>> (20211217/dsopcode-198) was obtained.
>>
>> ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [D009] at bit
>> offset/length 136/8 exceeds size of target Buffer (136bits)
>> (20211217/dsopcode-198)
>>
>> The original code created a buffer size of 128 bytes regardless if
>> the WMI call required a smaller buffer or not.  This particular
>> behavior occurs in older BIOS and reproduced in OMEN laptops.  Newer
>> BIOS handles buffer sizes properly and meets the latest specification
>> requirements.  This is the reason why testing with a dynamically
>> allocated buffer did not uncover any failures with the test systems at
>> hand.
>>
>> This patch was tested on several OMEN, Elite, and Zbooks.  It was
>> confirmed the patch resolves HPWMI_FAN GET/SET calls in an OMEN
>> Laptop 15-ek0xxx.  No problems were reported when testing on several Elite
>> and Zbooks notebooks.
> 
> Perfect!
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Also needs a Fixes tag:
> 
> Fixes: 4b4967cbd268 ("platform/x86: hp-wmi: Changing bios_args.data to
> be dynamically allocated")
> 
> (I believe Hans can help you and add it on the fly)

Right, I've just merged this into my review-hans branch,
with the Fixes tag added. I'll also include this in my
first fixes pull-req for the 5.19 cycle.

Regards,

Hans


> 
>> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>>
>> ---
>> Based on the latest platform-drivers-x86.git/for-next
>> ---
>>  drivers/platform/x86/hp-wmi.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
>> index 0e9a25b56e0e..d3540dd62d06 100644
>> --- a/drivers/platform/x86/hp-wmi.c
>> +++ b/drivers/platform/x86/hp-wmi.c
>> @@ -290,14 +290,16 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
>>         struct bios_return *bios_return;
>>         union acpi_object *obj = NULL;
>>         struct bios_args *args = NULL;
>> -       int mid, actual_outsize, ret;
>> +       int mid, actual_insize, actual_outsize;
>>         size_t bios_args_size;
>> +       int ret;
>>
>>         mid = encode_outsize_for_pvsz(outsize);
>>         if (WARN_ON(mid < 0))
>>                 return mid;
>>
>> -       bios_args_size = struct_size(args, data, insize);
>> +       actual_insize = max(insize, 128);
>> +       bios_args_size = struct_size(args, data, actual_insize);
>>         args = kmalloc(bios_args_size, GFP_KERNEL);
>>         if (!args)
>>                 return -ENOMEM;
>> --
>> 2.25.1
>>
> 
> 

