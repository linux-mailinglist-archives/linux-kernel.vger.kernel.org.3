Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC774586715
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHAJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiHAJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C68F23BEB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659347525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Afp8FUD7Ek0MnxgDfmSmKaUslh6+V7F3FKE45E7vdmo=;
        b=iCK4V6VDe1V5lbJkg+u5wJZKonO110i6Phw4mfyDYTvg2Ogr1Xxc8+6hAKlVnpKaVdBHZ7
        WVAXS/NOfFe2UaS5UIZ32niFgdO6Kv9Av5+1XCBCBS8NXw+QjsmWPqNwavLxlltztf4vQO
        VGjWys79t/PhDoQ0Ra0gT9NIi9pU9L8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-d5f5IE1VNqOGNsdrEiCbZA-1; Mon, 01 Aug 2022 05:52:03 -0400
X-MC-Unique: d5f5IE1VNqOGNsdrEiCbZA-1
Received: by mail-ed1-f70.google.com with SMTP id o2-20020a056402438200b0043d552deb2aso3090030edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Afp8FUD7Ek0MnxgDfmSmKaUslh6+V7F3FKE45E7vdmo=;
        b=tB3moQZPXez8MNbT5gHz8w+WOfO1xq4r4glqNTU2HVeo1cjRgUlCFoHUjjzGqvCYrk
         YzxUBD+ri+XyVsL6nuQDoCHQ3jfpeca90efoC+LhJL+Al1SV23atOajsqM3O2dzWwZhA
         sHK/QlW5ZkyiwvxrVmvJZ1GL4KhU4inufo+rQOEHI84SA8ppOLgJqIvs0k5OZZlTimcv
         IS7vAMiwjFNEtOcHAID8xbnekJ8VA/cv/A6XYg9fd81yVRJBRITKjpZT5trxl4oRDyb9
         DwxL9CyhjB3DajQPsi9efzaWrEpASUJ0drlky0YUlrfQD8RAU6kOaJzQzJ5xLcn8CGQF
         7fFg==
X-Gm-Message-State: ACgBeo2trcB5pR5xSNOYojdFZhTCwOes8sDqbEsJtVi7v3+QOtAUQIBB
        gqpXBeXbKJIPYeJOTMsDWdOfGI5dbzL6sBThZjVyQ8b+IngKvPTMem3q2sQrhPlfLbjkVrpWYbs
        1p5ZHspv/qaD7v38htUuQ3Pdu
X-Received: by 2002:a17:907:7355:b0:730:664f:91f with SMTP id dq21-20020a170907735500b00730664f091fmr5115008ejc.400.1659347522606;
        Mon, 01 Aug 2022 02:52:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SQtruoNhBR6V/BXnzhRLsdRU6Xb86uCpbkBUw9/AS9qvmfy7ushvoU0TM6vW30Teb4XaCrw==
X-Received: by 2002:a17:907:7355:b0:730:664f:91f with SMTP id dq21-20020a170907735500b00730664f091fmr5114995ejc.400.1659347522428;
        Mon, 01 Aug 2022 02:52:02 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id fg7-20020a1709069c4700b007304d084c5esm1890371ejc.166.2022.08.01.02.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 02:52:01 -0700 (PDT)
Message-ID: <98f1509a-2386-7c8f-cf53-cdb93990aa74@redhat.com>
Date:   Mon, 1 Aug 2022 11:52:00 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcmuVcA_heURNh96zBDtpeNvx0t9buDOxnWNoea2G1uDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/22 11:29, Andy Shevchenko wrote:
> On Mon, Aug 1, 2022 at 11:14 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Aug 1, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 7/31/22 22:12, Andy Shevchenko wrote:
> 
> ...
> 
>>>>  err_del_irq_chip:
>>>> +     pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
>>>>       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
>>>>       return ret;
>>>
>>> Note alternatively we could just move the pwm_add_table() to just before the "return 0",
>>> there is no strict ordering between adding the mfd devices and the pwm_add_table()
>>> (the pwm device only becomes available after the pwm-driver has bound to the mfd
>>> instantiated platform device which happens later).
> 
> Just to be sure... How is it guaranteed that that happens later?

Ah you are right, it could happen immediately if the driver is builtin and
has already registered (if the PWM driver is a module, as it is on Fedora,
then the driver will only bind once the module is loaded).

Regardless there are no ordering guarantees between the probe() function of
intel_soc_pmic and the consumer of the PWM device, so the consumer must
be prepared to deal with the lookup not being present yet when its probe()
function runs (*).

Regards,

Hans


*) ATM this is actually an unsolved problem and this works only because the PMIC
drivers are builtin and i915, which consumes the PWM for backlight control
is a module. Swapping the order does not impact this.

