Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57D58E066
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbiHITob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbiHITn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:43:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED826572;
        Tue,  9 Aug 2022 12:43:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so12273602pgc.12;
        Tue, 09 Aug 2022 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=nHDRknKkSxBf5+yxWGf1TayINvpuh1YnMsi4TGI5L64=;
        b=lPLNxLCIX1dwtCnrB9EVgaGgZ0kfoSlR7Lzq5TksRxAT6RbMZF7upqWuXEUbx5DWI+
         LWNEth7+Xh5uWJKhSta+2lJrg0YcB03xDPRCYAil2HABXwqGWWyghvsDRc/6cxDkoSHj
         xjZcBnq5GeeshdMUdUCKgtvN/sKsENokj/a4C1sLyRoWFdBBSflFD7jwvdadF77UW9uL
         ME6QZeEuGjGkDiZH5eDPnqIzMc5/3smeCDpoWuS73feGVRbqpvgZvn4pjZLDWtbEnjWB
         MNkS4DytYBFJvI7ufEDOg1jjw8IkzBtBp/ImSyn56vKSIB4slVkFn5ufDBlFRSCSjr6c
         g4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=nHDRknKkSxBf5+yxWGf1TayINvpuh1YnMsi4TGI5L64=;
        b=6lYOj29dZnTp8b1z7Mh6NB221cyHHh9w6W2CSOERkrIdXxcwn3DdFS7ZxHDpmtaHrI
         fsoZZYLtGFnVrFNbUinAQ+P2L7K8UAtFz/xBYa3mGrV0mACTz1/eDQGLbmGCsJTHdGvs
         w3Guh2srfou1jWmP9vlntq8ErVYd8IXm/eLdxAqGraU+503gJFyzpZOlArbdP8hffH5k
         BuNYDfzxJiBI/0zHnVa3fuy68BHGrhAwpPkWjBSBwaVY5XPxsCqyfWmGWgW+zhJ5XnMd
         U/VzjRD1xkjYQu2Xobtp6ZJPp6tghJSeY1HmHoRO3t3pmVdAEZmfCSuYXPCWeJ/zo3aq
         Hazw==
X-Gm-Message-State: ACgBeo3bq+n36HVBkM+jPHPO5XrxexAQDPleJfjfzZuyzAsQKTinPKNo
        NseOaEJhn5gT/TnmoEf7/RQ=
X-Google-Smtp-Source: AA6agR62P4yfUsDnyBdYd0rvlFO2PQLOfIoZuXbrinTjsSQUQXH9GtfIrD9ZA45qpzIadoh6nbfPtA==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:666a with SMTP id t2-20020a056a0021c200b0052bff44666amr24416045pfj.83.1660074236466;
        Tue, 09 Aug 2022 12:43:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1-20020a655a01000000b0041a5e8dedaasm8270435pgs.92.2022.08.09.12.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:43:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df5eaddd-4d41-348e-9d60-b302815f2970@roeck-us.net>
Date:   Tue, 9 Aug 2022 12:43:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
 <20220807083438.qqe3mzp43aytxbcl@pengutronix.de>
 <CAHp75VdYrnb8k72TFhB9eKDtyj_pm1gDqL+sDYixkuYy0Xb_Pw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
In-Reply-To: <CAHp75VdYrnb8k72TFhB9eKDtyj_pm1gDqL+sDYixkuYy0Xb_Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/22 02:20, Andy Shevchenko wrote:
> On Sun, Aug 7, 2022 at 10:38 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
>> at a quick glance this looks nice. I wonder if it makes sense to split
>> the patch. For example the change
>>
>> -       ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
>> +       ctx->pwm = devm_pwm_get(dev, NULL);
>>
>> could stand alone. Also I think this change is the relevant part in
>> patch #1 that makes patches #2 and #3 possible.
> 
> True.
> 
>> When this patch doesn't get split, the series needs some coordination,
>> as patch #1 is for hwmon and patches #2 and #3 are for pwm.
>>
>> Splitting the series into:
>>
>>          hwmon: (pwm-fan) Use of devm_pwm_get() instead of devm_of_pwm_get()
>>          pwm: core: Get rid of unused devm_of_pwm_get()
>>          pwm: core: Make of_pwm_get() static
>>
>> for pwm and the remainder of this patch for hwmon might make application
>> of the changes here easier to coordinate.
> 
> Either way it will need the hwmon maintainer ACKs or alike.
> Since we have (plenty of) time I will wait a bit for hwmon maintainers
> to react. Guenter, what would you prefer?
> 

I have a substantial number of patches pending for the pwm-fan driver.
Some of those will conflict with this patch. I'll have to spend more time
to be able to understand the implications.

Guenter
