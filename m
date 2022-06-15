Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420B54CDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348378AbiFOQL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348390AbiFOQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECCC136321
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655309482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYwgKkQjGzy4vjuONVP2nbTWiQ6a3KB6AbIHQDB6eZ4=;
        b=T8WvCSkzj5R+hWzsgqFYyRDJp25HS/U0Hn/fqbutfv5linOTmI7VnaFD2+hZGJWQBQwa7f
        t2NhdZfcSNZMEX/TYNMkSHPtqZwV7f/S4nF701Tif1QlM6QnM3NhSPPvkXLGGwpQwQn+J3
        Jh97/bhJAU1s9HohURjqIKG8qt6lv80=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-RtfK8PZwOLW7ypdWD0KvXw-1; Wed, 15 Jun 2022 12:11:20 -0400
X-MC-Unique: RtfK8PZwOLW7ypdWD0KvXw-1
Received: by mail-ed1-f72.google.com with SMTP id f9-20020a056402354900b0042ded146259so8925771edd.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SYwgKkQjGzy4vjuONVP2nbTWiQ6a3KB6AbIHQDB6eZ4=;
        b=KFgrDqbb7OhNbw6/m//GBPD3aaV4/ayaXJCrQbKc2pH+1f9WIXKHJPlxG6rfSGXY5r
         JCOlaaXNxY3ahDfjgIQ5g16esX6l6mFcBXPS/czWkQ9fgHyaqWRMTm8wtYXTAM6pg2uY
         t8guGm1YHAwmbIekQ2C+g5/2o+hcHrwBRh+C4OBKNZxsvaWvYzQuybEHHCPGDY6wF4zz
         RVRmeW8wGwdGL8mtTgPQBk2OKs9LXNaIXrnR/qgIsDQ7no4/RMttQM7d4ibrJyPBbvoI
         Wyf/D/hfIJLLyQWqaPgxpqE0wyyOVZDSN8L+OICGFJj3KlsbzepfYjL3969J70qNmKsh
         tD0g==
X-Gm-Message-State: AJIora8PSWzcddZdPi1qFyrmA6+gqs8exk5SdKAvcWzIQ5V8X+s0mpwf
        ZUWQfvBVlQgo2pLey0Y7PMGpGh8UT+LyP0XpMTfjhcsJzdBURxF7DYdAkjDDVgtQCppd3C+rPlP
        2xJlaCja0crWbyvzau6ANcRju
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr632079edb.166.1655309479619;
        Wed, 15 Jun 2022 09:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAtdJfLowzWrTXaHYr/672zwCo8kH9O7E4MnmuGCakvRsxz/A0LCNz5NAEZ4eNEwjazTGy8w==
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr632068edb.166.1655309479499;
        Wed, 15 Jun 2022 09:11:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bq15-20020a056402214f00b0042ab2127051sm9677479edb.64.2022.06.15.09.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:11:18 -0700 (PDT)
Message-ID: <402d2059-d0ab-2229-870c-f511cd6f29ee@redhat.com>
Date:   Wed, 15 Jun 2022 18:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
 <bd21d5c6-ed5f-dd8c-f0bf-73f54ca8ee58@redhat.com>
 <YqiGocQ+vr9KjUHK@smile.fi.intel.com>
 <390cf16c-f07c-ebfc-08ad-25b242548953@redhat.com>
 <YqnHpXvZJEfhX21/@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YqnHpXvZJEfhX21/@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/15/22 13:51, Andy Shevchenko wrote:
> On Tue, Jun 14, 2022 at 05:49:22PM +0200, Hans de Goede wrote:
>> On 6/14/22 15:01, Andy Shevchenko wrote:
>>> On Tue, Jun 14, 2022 at 01:23:21PM +0200, Hans de Goede wrote:
>>>> On 6/13/22 18:08, Andy Shevchenko wrote:
> 
> ...
> 
>>> [   35.126397] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer reset
>>> [   35.126418] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
>>> [   35.126455] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
>>> [   35.126465] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer reset found
>>> [   35.126476] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer cs
>>> [   35.126485] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
>>> [   35.126538] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
>>> [   35.126548] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer cs found
>>> [   40.534107] tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
>>>
>>> (I put 5000 ms there to be sure)
>>>
>>>> I'm fine with going with this workaround patch to fix things.
>>
>> Ok, so I guess we should just apply this workaround patch to make
>> the error non fatal. Still would be good to dig a little deeper one
>> of these days and see what is going on here...
> 
> Can you give a formal tag?

Sure:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

