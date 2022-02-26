Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF904C569D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiBZPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiBZPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:32:12 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C378B288632;
        Sat, 26 Feb 2022 07:31:37 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so5919379otp.13;
        Sat, 26 Feb 2022 07:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uR+TR/89Sgmcwu10gd9ckPO/U6oMqFNESAt61DQB/qA=;
        b=MfuEZUbvnczYC+2uz0Du/3RliQOhfSFIcmR7rDHO7o1D8yBipd6o8XG7iVwrGoQZdv
         jIvyp23lUp74TPwiZKTPVPMNDoqNv/+aJSCzdX2wjN15i+/MLbpmUEQmEJc5bqGvyVqF
         nmc+Txr40MOmUQ3nQixIh+1FsXLBRaO35Hg6+zPeveRZJ7nhj1lku/0H6j2aaHv4ja9g
         r7/9Ivlrmx5VcI6Q/KkBO8MAS6yrWOXo0tMiGkBbZjBLpBcnp5cUqd0vo4Zo0FO+Wp7i
         Wm8y7HFYT3MVNSZCxqTiCINcqtAtAdQLgRrRrAEDPlGgRDNydS1eJ3uuysQD+osGt9h+
         9kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uR+TR/89Sgmcwu10gd9ckPO/U6oMqFNESAt61DQB/qA=;
        b=3U29x4FkMfpyeYk2PWuM9NTFkN0GW6JjFo2CoWVPLhkbn7rk8PiIG+Od4bPsb/ajmJ
         W2wASfEDnpt4smsw4B0g8fl2wpdPBeatN8BBnrAT0l9uo49QWoIJLYxQbA6OOcehooVd
         5HnGFZ/PoMGJ0asF//YtjFCWwn5dfarpMGLwAD83bKPUqdM/L9HWb6T65MXvTriDcguU
         jTnGr2u7k/NBamT9mOQLSJZ6gxmTSHUlcSxif6qkmyALDcXYp1mcd+FXCQyHlkGNRNtD
         nPDBzMutw+A0nt2DXpkMkI4HcsWUiqU8mX+xKkgIG4TsH5qAgzL0pwoBru3020bKsyCM
         sTOw==
X-Gm-Message-State: AOAM53345LnwcmEKfM84FmJKyqRun3Z5ojGDnwWyeXa5Qh9nA7ClPYKG
        BoQE6pSg/kmhos7tuV3X8XcxYXEeryA=
X-Google-Smtp-Source: ABdhPJzCdROY4m7EOLS/f4iKLCeT2JrHcg+x9Hp16AZfizQ+WHdSF5CVTRl27Eq4nTJxk+LgCh5Umw==
X-Received: by 2002:a9d:7f91:0:b0:5af:d53a:fdb3 with SMTP id t17-20020a9d7f91000000b005afd53afdb3mr2802416otp.274.1645889497130;
        Sat, 26 Feb 2022 07:31:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 67-20020aca0546000000b002d46e151b9bsm2943574oif.18.2022.02.26.07.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 07:31:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd9710d4-73a1-2b9d-7848-4c6291f6b2e1@roeck-us.net>
Date:   Sat, 26 Feb 2022 07:31:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hwmon: add driver for Aquacomputer Farbwerk 360
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220221102157.13574-1-savicaleksa83@gmail.com>
 <5fa0a22c-5f55-bd38-8d76-a4ea31898bca@roeck-us.net> <YhpCrNhjfb0E8rLn@fedora>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YhpCrNhjfb0E8rLn@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/26/22 07:09, Aleksa Savic wrote:
> Hi,
> 
> On Thu, Feb 24, 2022 at 11:57:47AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> On 2/21/22 02:21, Aleksa Savic wrote:
>>> This driver exposes hardware temperature sensors of the Aquacomputer
>>> Farbwerk 360 RGB controller, which communicates through a proprietary
>>> USB HID protocol.
>>>
>>> Four temperature sensors are available. If a sensor is not connected,
>>> it will report zeroes. Additionally, serial number and firmware version
>>> are exposed through debugfs.
>>>
>>> This driver has been tested on x86_64.
>>>
>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>
>> Unless I amm missing something, this driver is quite similar to the
>> d5next driver (drivers/hwmon/aquacomputer_d5next.c), except that there
>> are 4 instead of 1 temperature sensor, the sensor data is in a different place,
>> and there is _only_ temperature data. It should be quite straightforward
>> to merge the two drivers into one, so please  do that.
>>
>> Additional comment inline.
>>
>> Thanks,
>> Guenter
> 
> Yes, it's very similar, I based this one on that. I'll send a patch for
> the original driver. I also have code ready for Aquacomputer Octo (8 fans, 4
> temperature sensors, very similar to all this as well) with PWM write control
> support for the fans. And there is also WIP code for PWM and curve support for
> the D5 Next from contributors on my github repo, though we're working on that.
> 
> Considering that the driver would then contain support for more devices (the D5
> Next and the Farbwerk 360 for now), can it be renamed to just aquacomputer or
> something similar?
> 

We don't normally do that (because the Kconfig symbol is already established)
and just name the driver for the first chip (or, in this case, controller)
it supports.

Guenter
