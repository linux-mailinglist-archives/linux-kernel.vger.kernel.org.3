Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2285658606D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGaSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:51:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE496959A;
        Sun, 31 Jul 2022 11:51:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq11so9105401lfb.5;
        Sun, 31 Jul 2022 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BPufxihEl1ZxvR2qHTK7M69qWBoF8p5Z1If0kZuLz3c=;
        b=adx9ZEid+lzU0z00DjYW4MNDq5wwJbRoO/2yx+nqJ9iBxfdBpqlZ9kCbuAm2N/zLn5
         GqnCqXIPWUTOwau1JxKcBjavNYrFs3K2znfpEBNTNw9rMDl8ULAtZlP/wamHzmvMlvHd
         98CFoNPMfnFzCQ/S1zH9VxRXnvp6YG4if/KwxnNe1n4vFNSXt+9aKC3kPA5BbS8qmmXh
         26k5BnV/PDF7KuFRIt3XqPPVP73Cjg4ht0xZZP7ANwjka1b4GVC/WVFEdUmPZSrL0QGR
         sm4xHRB+K6lB3xSYg0UsF2FgRxWD7KRTep+J2h12fEQCAFvNX1YWtQNaj1aeJLDldt3O
         3Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BPufxihEl1ZxvR2qHTK7M69qWBoF8p5Z1If0kZuLz3c=;
        b=iqT7RUDUccpCXp75FSbUW7Tr5g8CrpdXRdGhy6oYNEpqNv1cST5QynmiOYoUpoDKNf
         1UeiutQsYGeTmWdv87a73ELSNPSfTLKpDZO2WSMaxMMI7wccWu6SzYAFbjVV6156ZtRg
         +or/3VT5/6lvFOo7s6Mxt/LZLbahFhOEFGnmu7lu819nN6URRZfyk5Os9IKSOMP+kJaO
         JQD4a8LCUFj3NJgKAjrfBYsKCFkoDVif7PvdtMABBfIz8t5A9Yj+e0EAl0d31f2IfJOy
         44qJ4TFpXk4+y2NDkG6ZXNAo2/5b7SLtkvXQWdJrg6hakbARzAvSbVULuNAtcp3T5iRN
         87dg==
X-Gm-Message-State: AJIora9I3xEzGvAc7X9F5Vyo3UsZ05ZOutyyKC4L4jnrg939neWRQhDz
        FRhppYZWWemw2B6gjlLVdFM=
X-Google-Smtp-Source: AGRyM1sdsLsoQ0rBhuEUsjIvk0l/hxioDbpNFKW38nE7+ArKMr3Wq6YACkVJCEE57ukhJSSp+3Nm8Q==
X-Received: by 2002:a05:6512:3342:b0:48a:c0b4:75f2 with SMTP id y2-20020a056512334200b0048ac0b475f2mr4525038lfd.170.1659293517181;
        Sun, 31 Jul 2022 11:51:57 -0700 (PDT)
Received: from [192.168.0.108] (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.googlemail.com with ESMTPSA id h13-20020a05651211cd00b0048a828b6b2dsm1419119lfr.182.2022.07.31.11.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 11:51:56 -0700 (PDT)
Message-ID: <6c839ba3-b671-76fb-95e1-94bf2f2da303@gmail.com>
Date:   Sun, 31 Jul 2022 21:51:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] iio: st_sensors: Retry ID verification on failure
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
 <20220731170057.2b8ac00e@jic23-huawei>
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <20220731170057.2b8ac00e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.7.2022 19.00, Jonathan Cameron wrote:
> On Sun, 24 Jul 2022 19:43:15 +0300
> Matti Lehtimäki <matti.lehtimaki@gmail.com> wrote:
> 
>> Some sensors do not always start fast enough to read a valid ID from
>> registers at first attempt. Let's retry at most 3 times with short sleep
>> in between to fix random timing issues.
>>
>> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> Hi Matti,
> 
> My gut feeling is this isn't in a fast path, so why not just wait
> for whatever the documented power up time of the sensor is?
> 
> I'd expect to see a sleep in st_sensors_power_enable() if one is
> required.

In the specification for the sensor (lis2hh12) I have on my device I
found that the maximum boot time of the sensor (starting from Vdd power
on) is defined as 20 ms. Not sure if the other sensors supported by the
driver have different values but based on checking a couple of
specifications I didn't find any bigger values so far.

>> +			msleep(20);
> How do we know 60msecs is long enough for all sensors?

Based on the specification for the sensor I have and also driver used in
Android kernel for my device (it uses a 3 x 20 ms loop) I think 20 ms is
a good value but to be sure a slightly longer might make sense. As
suggested in the other review comment by changing the regmap_read to
regmap_read_poll_timeout the function doesn't always need to wait at
least 20 ms in case first read doesn't provide the correct value, if a
suitable shorter poll interval is used (something like 1-10 ms).

However testing on my device has shown that I still need to have a loop
or at least a retry possibility because I have noticed a rare random
read error (-6, happens after some time not at first read) when reading
the id from the hardware. This could be due to for example internal
init failure of the sensor chip causing an internal reset. Because of
this read error regmap_read_poll_timeout returns with an error and
without retrying to read the id the sensor probe fails.

-Matti
