Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74119514225
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354386AbiD2GHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbiD2GHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:07:19 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42922B899A;
        Thu, 28 Apr 2022 23:04:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y63so7584622oia.7;
        Thu, 28 Apr 2022 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language
         :from:to:cc:references:subject:in-reply-to:content-transfer-encoding;
        bh=X/KcFNZhAHoZ1H6Tr4WvcjaMczJznMSErZBotqKY3jk=;
        b=PxhNjBOw2ylbQzoWSUcKoIuVMYGb/l6sxtEDteNu6AO+5YMtyA256PNa3JlRIRzM+L
         ijSIySGeJpUHMeXZTKHsagxc/ujgW+UfOit8Xhfp0WtlPe/tGMEsbntzX149xTm+Ewic
         njMJr3IjP6E8YT38D97JampAL4qtJ7h7T36pulJNSiy9qSxN10NFsKStjF3H/oHT33QK
         E/RoWon0gJ6V5OC1x6Ukk7545Tn3PzgVRsSC7Q/gedvTBhSbDewSG9jdr+f6ndDW4HAG
         8O6LZm2d5LwL7k1kwdzVrSVIt7fWf+QpJ2iyi0OeYDSc9rT25u5SSLRKE1O3FEguyZ02
         zqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=X/KcFNZhAHoZ1H6Tr4WvcjaMczJznMSErZBotqKY3jk=;
        b=WrvkiuecLdZ8EAiE82+QKzFX3Fzt/7H3LgeaHLWQTGV4mVVuTMIKP1bKV+MmvTL4e6
         ZB+VWQaN60aq6zL0zL822cGU+tPvCVfIorrbYtKqyl8xr+K0aGhxtXXS3eWrJWoP12ah
         lTHeXgpff1HjQWiq2xnQwa1K+tnEUAeHdonCQSm2Ja75ppOaC60salvw6h5lizMZSeJa
         VE6PUWeWBsg2MF6ZyZSEG3R7fiH2G48thdziZya7kgd9uDOzj0EaMPVbGhTToUTu/GGh
         2Ts5b/hqJq3eJv9ZTGeHl25BdjuE339eePvTKR8KKqm2lZi/IxzVT0ImrvX7XOrZn+kG
         CD0A==
X-Gm-Message-State: AOAM530k+Mrff2+b1tU+VfMVzmI7Jb6NerRmPgqa0snCdVAHxZ85Q8WU
        vt3mA64hvJ19iaOgC+qhyzo=
X-Google-Smtp-Source: ABdhPJwnRWg5pq2rb86Qc8RTFC94blcskTiFA5sttrDQRIupMO1KOk3leXNWAUY1RnkOtxc0Psq7lQ==
X-Received: by 2002:a05:6808:1912:b0:325:74c4:35e3 with SMTP id bf18-20020a056808191200b0032574c435e3mr788022oib.61.1651212241626;
        Thu, 28 Apr 2022 23:04:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a8-20020a4ad5c8000000b0035eb4e5a6c6sm429034oot.28.2022.04.28.23.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:04:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <59e91f45-7263-eb41-4b47-db217af54910@roeck-us.net>
Date:   Thu, 28 Apr 2022 23:03:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <f79a8edf-36d4-02af-da8f-32b4e491bd47@roeck-us.net>
 <e0b57c7587dded38a92411994f353b3d@fabmicro.ru>
 <e4d1a6c8-1afd-671e-76bf-b5bde9dc282f@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
In-Reply-To: <e4d1a6c8-1afd-671e-76bf-b5bde9dc282f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 22:32, Guenter Roeck wrote:
> On 4/28/22 17:28, Ruslan Zalata wrote:
>> Thank you Guenter for your valuable time.
>>
>> I have added update_interval option (it's in ms units, right?) and fixed all other issues you pointed to. Will test it on real hardware and send third version of the patch for review.
>>
>> Regarding IRQ. Alternatively the driver would need to sit and poll conversion ready bit in a loop which might cause a much worse load on system, is not it ? Anyway, the real problem with this piece of hardware is that there's no "conversion ready bit" provided, the only way to know data ready status is to receive an interrupt.
>>
> 
> Not necessarily. The data does not have to be "current", after all,
> if the hardware is able to continuously convert. If not, the question
> is how long a conversion takes. If it doesn't take too long, it would
> be better to initiate a conversion and then wait for the completion.
> 
>> I think it still needs a semaphore/seqlock to synchronize conversions and reads. I.e. two consequent reads should not return same old value. Although it's not an issue in my case, but could be a problem for others.
>>
> Why ? That happens for almost all hwmon devices. They will all report
> the most recent conversion value. Some of them can take seconds
> to complete a new conversion, so the reported value is always "old"
> for a given defition of old (ie any time smaller than a conversion
> interval).
> 
> Sigh. Looks like I'll have to dig up the documentation and read about
> the ADC myself.
> 

I did, for both A13 and A20. The ADC supports continuous mode. That
means it can be configured accordingly, and reading the ADC value
just returns the most recent conversion value. There is absolutely
no need to keep reading the conversion values using interrupts.

Also,

+struct lradc_variant {
+	u32 bits;
+	u32 resolution;
+	u32 vref;
+};

is unnecessary because the values are the same for both supported chips.
That means that defines can and should be used. Yes, I can see that
A83T uses a different voltage, but even that doesn't need a structure -
the voltage can be set in struct sun4i_lradc_data if/when needed,
and the resolution and number of bits is still the same.

Guenter
