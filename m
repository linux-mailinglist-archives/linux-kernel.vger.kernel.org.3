Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9B561531
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiF3IgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiF3IgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E10634BB6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656578167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKIypHOdVTcFtlxso2VOsZY4bkWEr8QjwiozENRnUpM=;
        b=eA0h/p1TrZuu3Pf296iE5phbOZA5Md3+kZ7eDqpUS3aAbKoCBVzAHozYPJ4NEUVyidWQB1
        K0sBTFsmuQ2TdPp4RekB4311z9YDi7WUQTtennVpxMolsrMvJIP1/VLRmFEhyU7sUBQaT6
        H/rF2cvsq1P0JKe8bIxNUdz5kNGYfks=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-pXgbPZs2P-KyimEzSWPzeg-1; Thu, 30 Jun 2022 04:36:05 -0400
X-MC-Unique: pXgbPZs2P-KyimEzSWPzeg-1
Received: by mail-ed1-f71.google.com with SMTP id i9-20020a05640242c900b004373cd1c4d5so12956557edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rKIypHOdVTcFtlxso2VOsZY4bkWEr8QjwiozENRnUpM=;
        b=RHqPJrZ1U+TRmZQpcG8ndnhX8rZdI2aUJk0vUzlwGxXatHXAzjayeckMQjfJiaqaDF
         m6TBRYKDHDzZqlXwE2vAH55INCzel5hAaxjZ9FZOUkCxWQG51NKXTTZJuoX7L6E/Uiq2
         tgKB6aysi2I+7QGkVB20NxHAKbpjClT9P2eEbbqRsTebP68Dkq5W0RoPXW/P2/NcaPPT
         6Rih8GDcrJKoHXAhP++XbkiLDGGJZWcxke4GZNdlT3nW3+oFudAWngpgeaKOYaLouhdO
         odQREOh0We1CtZIv8tHji+Lp0UE6UDXKIlSH2Vh8POcvW+gHLIZ5Dh0hhE7lBZ57IcFr
         rb2A==
X-Gm-Message-State: AJIora+HHLf2pzSYSRdNtLE2vF2+KpRm5trs+Z3ZkLxltI3cjckdgAgc
        dLEdym6f0cX2QU18UTF6gQ5lJR6dxUV1U2F1qYnxiHf8PfUFtSrfnNxVbP3YPLGLQJwKwFI94be
        fNkIW+hLvzewdqBCgBp2bsrIE
X-Received: by 2002:aa7:d29a:0:b0:435:705f:1319 with SMTP id w26-20020aa7d29a000000b00435705f1319mr10063661edq.54.1656578164631;
        Thu, 30 Jun 2022 01:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1so0Ae4Bo+O1UNcpbr1ULZ3TZ+0BfUuZCuoFIobnv2J5ZtmLbg990tysmV4x05jYbk2Rmi7uQ==
X-Received: by 2002:aa7:d29a:0:b0:435:705f:1319 with SMTP id w26-20020aa7d29a000000b00435705f1319mr10063648edq.54.1656578164454;
        Thu, 30 Jun 2022 01:36:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b007262b7afa05sm652632ejc.213.2022.06.30.01.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:36:04 -0700 (PDT)
Message-ID: <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
Date:   Thu, 30 Jun 2022 10:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com> <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/22 10:07, Andy Shevchenko wrote:
> On Thu, Jun 30, 2022 at 10:01 AM Lee Jones <lee.jones@linaro.org> wrote:
>> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
>>> On Wed, Jun 29, 2022 at 4:36 PM Lee Jones <lee.jones@linaro.org> wrote:
>>>> On Tue, 28 Jun 2022, Andy Shevchenko wrote:> > On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
>>>>>> On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> ...
> 
>>>>>>>  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
>>>>>>>  drivers/mfd/intel_soc_pmic_core.h |  25 -----
>>>>>>>  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
>>>>>>>  4 files changed, 157 insertions(+), 193 deletions(-)
>>>>>>>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
>>>>>>>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
>>>>>>
>>>>>> Can you submit this again with the -M flag please.
>>>>>
>>>>> This is done with this flag. Basically for the last several years I do my
>>>>> submissions with that flag.
>>>>
>>>> Odd.  I thought -M only showed diff for the changes.
>>>
>>> It's exactly what happens here in this patch. What did I miss?
>>>
>>> Note here is not renaming, but merging contents of one file (actually
>>> two files) into another. What you are talking about is probably -D,
>>> but AFAIR Git (at least that time) can't catch up deleted files from
>>> the mbox format. That's why I do not use -D for submissions.
>>
>> Ah yes, that's probably it then.
>>
>> From a quick look at the diff (I missed the 2 "--" at the end), it
>> looked like this was a rename.  In which case -M won't do anything
>> useful here.  I'll have to brain grep the differences instead.
> 
> Please do, it will be good to have this double checked.

Note that I already did a manual compare of the moved code blocks
to check that they were not changed before giving my Reviewed-by.

Regards,

Hans

