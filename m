Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207125867D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiHAKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiHAKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2E582B625
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659351226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6oMZ1ngcN2iV2C0KTwvDUmSDhfLcHnvhlKLoSOxlM9s=;
        b=eSAFK9/iLeOwG2OfipJdX1/No9oxftnFN2bqulLgfofh9g2IFBocK/Pzq0WK0MTpBXJTFo
        Mh7PbuaocP9wk5mGLOVOtKypF6UI0s6eC0yzcNZE1I/re1htev1Xcm7j2ixcDFad9F92tQ
        tTwPk9KnoG78obbExmFjwWuaQKkqnl0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-xDimvczXNzanqYpzYi9AHw-1; Mon, 01 Aug 2022 06:53:45 -0400
X-MC-Unique: xDimvczXNzanqYpzYi9AHw-1
Received: by mail-ej1-f70.google.com with SMTP id hq20-20020a1709073f1400b0072b9824f0a2so2908558ejc.23
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6oMZ1ngcN2iV2C0KTwvDUmSDhfLcHnvhlKLoSOxlM9s=;
        b=ZLiOLV9maAGUrGoxPgcNmMQzAgtTSqmFc2FmsBRU8ggHzmA+QrlyH42zt1DEDVMMtd
         AQ6mvqowJJ4Nt8s4PZcBMAWDrocsUzVGyNQ2IMaQrBKduCOqzoMC//2AcAn6e4dhJoZZ
         O0gNO9DGgj48Up5ilfeWwt3g/sDHSWrZN3ZiVrje7D26zZpxB1QawgxAvofD+DRLo0+/
         CaDukiNNcJkxwidQRXwRY0M5ntqA5iQSGgW+IKFzcoGT8CQil1oUdn+g7Ucb12jshZy4
         59OS5Mxdob+TF0Mg1WbJKj2T58iljM9PM5YarZhcnekxQ9bmLDlEfr9yf0hDyHrpTArV
         FZvA==
X-Gm-Message-State: ACgBeo00Kfi9e3oXFczDAmuk89noiziUJDbLSZ+QHdx7PD/Ij6rBWh9f
        GNkrtMWMZlty1CibDXjoxxomtVwGfRbXmFQclcGTUdhu3KXEKOAykUcpJ4HS16BERsbfumG4u/I
        wfArG0bsTsV+1k0MyQ+RMW+4/
X-Received: by 2002:a05:6402:293:b0:43d:3936:66b0 with SMTP id l19-20020a056402029300b0043d393666b0mr12165452edv.404.1659351224681;
        Mon, 01 Aug 2022 03:53:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4v21REXZZiy81ij60ciV0/X6jKp/4tw+S96NNbXWf8mOLtMFJ4o2n6PNK01n8t8O1PV5e+gg==
X-Received: by 2002:a05:6402:293:b0:43d:3936:66b0 with SMTP id l19-20020a056402029300b0043d393666b0mr12165435edv.404.1659351224482;
        Mon, 01 Aug 2022 03:53:44 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d986000000b0043bb8023caesm6561669eds.62.2022.08.01.03.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 03:53:43 -0700 (PDT)
Message-ID: <76186bb4-63ac-857f-f9f6-d020ca44c380@redhat.com>
Date:   Mon, 1 Aug 2022 12:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
 <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com>
 <CAHp75VduSG=BerPJo9phXJKWa-yu_uXbP+ifkax=3FUTE7et+Q@mail.gmail.com>
 <CAHp75VcmuVcA_heURNh96zBDtpeNvx0t9buDOxnWNoea2G1uDg@mail.gmail.com>
 <98f1509a-2386-7c8f-cf53-cdb93990aa74@redhat.com>
 <CAHp75VcYENL-LqJPzL4mY-cDkZ89m2MM=yRbs+_c4SjHMMvJ5g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcYENL-LqJPzL4mY-cDkZ89m2MM=yRbs+_c4SjHMMvJ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/22 12:38, Andy Shevchenko wrote:
> On Mon, Aug 1, 2022 at 11:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 8/1/22 11:29, Andy Shevchenko wrote:
>>> On Mon, Aug 1, 2022 at 11:14 AM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Mon, Aug 1, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>> On 7/31/22 22:12, Andy Shevchenko wrote:
> 
> ...
> 
>>>>> Note alternatively we could just move the pwm_add_table() to just before the "return 0",
>>>>> there is no strict ordering between adding the mfd devices and the pwm_add_table()
>>>>> (the pwm device only becomes available after the pwm-driver has bound to the mfd
>>>>> instantiated platform device which happens later).
>>>
>>> Just to be sure... How is it guaranteed that that happens later?
>>
>> Ah you are right, it could happen immediately if the driver is builtin and
>> has already registered (if the PWM driver is a module, as it is on Fedora,
>> then the driver will only bind once the module is loaded).
>>
>> Regardless there are no ordering guarantees between the probe() function of
>> intel_soc_pmic and the consumer of the PWM device, so the consumer must
>> be prepared to deal with the lookup not being present yet when its probe()
>> function runs (*).
> 
> Would be nice to have, but isn't it the issue with all lookup tables
> so far, e.g. consumers of GPIO ones are also affected the very same
> way?
> 
>> *) ATM this is actually an unsolved problem and this works only because the PMIC
>> drivers are builtin and i915, which consumes the PWM for backlight control
>> is a module. Swapping the order does not impact this.
> 
> Even so, I think we can't change order right now because the issue is
> much broader.

Ok, lets go with the original v2 1/10 patch then. In that case, you
may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to the original v2 1/10 patch.

Regards,

Hans

