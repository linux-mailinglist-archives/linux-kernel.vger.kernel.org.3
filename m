Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1373F5176B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiEBSqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiEBSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:45:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714345FA6;
        Mon,  2 May 2022 11:42:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so7741791ote.8;
        Mon, 02 May 2022 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cqi4vVQXIGfU3Kpez4pWPIJIfa1e4al0TZHE0imlKf0=;
        b=fXR8EUyboyQqVeqFyOtKKt+k0Z1M2EeOUFZaBAD/57OxHi8cEI+gMuO0SrKXdp84LG
         Yc2bJdlCuFA7k2HCZtNzujh3KQi+EH9UHmbpobhpHQgGoFCxO/G6XTWlSJ03cOLfv6Mn
         qxKP+9rjp2Yx4G/g5esHSy6f48ngZ6eaeq0uqHmRtemLmdM2g8JA8TWsVSXyaL1NxnEE
         a278nr9geQBDlX7F3rEo4HAWinKUs/McYgv+NBID5bFAJNldS933Ctvo25Fc/l+yco+p
         P1YHmmWFoO3FOVP7fh+Ly82QHan/ACgsTLJURXUavc+DkD+VFiUqVHjHkjP0m1iQKnjt
         C0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cqi4vVQXIGfU3Kpez4pWPIJIfa1e4al0TZHE0imlKf0=;
        b=vzHk4RY5+5YNg/ZWYji9Ma/lQSzEQDGGZk2ADqCiwXdvPNQzUcScFWC8fqRno5nqdK
         kMPhtmwmab9bOLQfxCiH7Wl509BaFFAMSHo/+hdTocbgQsTuk/23rrckudVi94uYz9ug
         tfKnDkSKjJmCwrWqC41RfJembzliKnFJ7l12KrMDfWI6UnYQxM9SDA5L+vVRBusmvxVh
         i9zb2j7/7gCe+2TFtye/1j3JQOAlynKQ/q9PkfC9heVwc2yXGNTczbQ1jpvBUCbL7ciL
         4iZYG0H0pIetSeBIZe7rsRMKc+NhciWqP+f7uOTHgl6oi2m5glcZ9YHB/ts8ETZQgJjc
         jCYw==
X-Gm-Message-State: AOAM531jK6BsmcrpgpG3LqVdaT6agxjZRR6A2z8WTEkHa8DA1nqc0VPi
        E/aghLjDbvR9IR+1DwKhPnw=
X-Google-Smtp-Source: ABdhPJxjR+hx+ESAS7kWYZHR2d0osRzxNkYTNtkyGqWIs5cgjajxU7wwYJ1tMCfgyXUbXnovfCl2Mw==
X-Received: by 2002:a05:6830:1af2:b0:606:22ca:9681 with SMTP id c18-20020a0568301af200b0060622ca9681mr1494683otd.43.1651516940697;
        Mon, 02 May 2022 11:42:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h22-20020a056808015600b00325cda1ff95sm2576607oie.20.2022.05.02.11.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:42:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <781e52a4-bb2c-514e-38b9-58086a4333d9@roeck-us.net>
Date:   Mon, 2 May 2022 11:42:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/7] hwmon: (nct6775) Convert to regmap, add i2c
 support
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <bc46d60e-7c89-ad05-780c-9e9fd19f788e@roeck-us.net>
 <2591481.aCYgfPdpt1@natalenko.name>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2591481.aCYgfPdpt1@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/22 23:06, Oleksandr Natalenko wrote:
> On středa 27. dubna 2022 15:37:07 CEST Guenter Roeck wrote:
>> Hi Zev,
>>
>> On 4/26/22 18:01, Zev Weiss wrote:
>>> Hello,
>>>
>>> This is v4 of my effort to add i2c support to the nct6775 hwmon
>>> driver.
>>>
>>
>> Thanks a lot for your effort.
>>
>> I applied patches 2..6 to hwmon-next. The first and the last
>> patch of the series will have to wait for DT maintainer approval.
> 
> For patches 2..6:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
Thanks, added.

Guenter
