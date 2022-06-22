Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4855480D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352819AbiFVK51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352295AbiFVK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F40863BBC6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655895443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEx6RR9u6uLbqK/LgDKdVdbCgDdwp3gQMsXD0yvxcro=;
        b=S15smui90HYz2cn7ZWkPx1Oemxun3eEgkVfn8PzB2881mEpQL3T8fArzJHFv5Wv5ivfflx
        PlfX8uHSfBus2Zqu9bzY8+fNNGQsfWtFqcY5OZGUbMBnVUq7gff229itydMNZJmI1/hibU
        v2AP+Lkbkb2J0z8IUYTTmhlaB1sQ7wE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-M95mBFhhMMeAw25YjAO4Lw-1; Wed, 22 Jun 2022 06:57:21 -0400
X-MC-Unique: M95mBFhhMMeAw25YjAO4Lw-1
Received: by mail-ej1-f70.google.com with SMTP id z7-20020a170906434700b007108b59c212so6202349ejm.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FEx6RR9u6uLbqK/LgDKdVdbCgDdwp3gQMsXD0yvxcro=;
        b=Yt5UXO8NfqTYDoop5UxlGoV/tHgj8MPIhcrVXBrHLb0QEPAeX6q6NAyT+N/vMBV7xH
         LzVglB7Mz6Ioki6GFkfBn4vhEkt9dYJzS7AhLSeDwxgMVUhNhbtQXf7e+gHD/C74egvr
         cEMK2Mqg8L24amNquJD+phtGJQDNeduc3OgugNMZVfRmE5BDKReCzcMSi7NJ+iy55G4z
         TNNtwZGgKy//ej0MN6XAAZ/80VUDSCFRWZ2/XgpSdtB7awx6fBYnLXx+wT+X1AU+5DD/
         0EoPBeurtM0mB8oQwb+NHeAuI7qOA1D8Uhw4AhNmUiIJanL6dBpJ3QiCLileKBrW/wHs
         J28w==
X-Gm-Message-State: AJIora8CfvvtJQEoV2q0ZtuMwDCOHY9ECOn8sP2rgFefll16Lzfo8t4U
        VqcWZCZEs3q3jfIuPuJJSegb2DYU0Chxa4owxYKibscsdwXlBgogahgkGM/53OBQXeUOHp1WM/Y
        /Bk1WF3zjl+MZrY+Uxv8pdwmB
X-Received: by 2002:aa7:c9d2:0:b0:42e:1776:63e0 with SMTP id i18-20020aa7c9d2000000b0042e177663e0mr3310549edt.185.1655895440381;
        Wed, 22 Jun 2022 03:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1srvKzbg0Aro3dvVdEoVceAX6KRLyzX1OU5HQBZtUJ/31YfxfER+4g7wqYOJU6d9XAqycsuBQ==
X-Received: by 2002:aa7:c9d2:0:b0:42e:1776:63e0 with SMTP id i18-20020aa7c9d2000000b0042e177663e0mr3310532edt.185.1655895440215;
        Wed, 22 Jun 2022 03:57:20 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.135.195])
        by smtp.gmail.com with ESMTPSA id us12-20020a170906bfcc00b00709e786c7b2sm9117490ejb.213.2022.06.22.03.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:57:19 -0700 (PDT)
Message-ID: <535573ff-aad7-8ba5-ce1d-7a1111400616@redhat.com>
Date:   Wed, 22 Jun 2022 12:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
Content-Language: en-US
To:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com>
 <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
 <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
 <CAPqSeKu9csK_u0S6MiRay_mvfYejUhKbb=wvJO7F_Z-JL6F7DA@mail.gmail.com>
 <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
 <89398c05-92c6-120d-ed51-ab62f1f404eb@message-id.googlemail.com>
 <19e590f1-e865-ad19-e9e4-df1f9274663c@redhat.com>
 <ad0e83af-b704-53b8-3963-b4dd53853f2b@message-id.googlemail.com>
 <3f3dfbad-9437-2c04-cf56-861649c117fd@redhat.com>
 <0bfb0325-0362-2d51-7f25-f389af4bfb68@message-id.googlemail.com>
 <d885a607-4db8-4c76-3931-627951a26ccd@message-id.googlemail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d885a607-4db8-4c76-3931-627951a26ccd@message-id.googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/21/22 19:54, Stefan Seyfried wrote:
> Hi Hans,
> 
> the patched ACPI video module DOES WORK.
> 
> I just managed to actually compile the unmodified source code m(
> After patching acpi_video.c, compiling and installing it so that it actually gets used, everything works fine now.

Great, that is good news. Thank you.

So if Kenneth can figure out why the i8042 filter is not working,
then we can hopefully fix this with my original series + the 2 extra
patches. And then this will be fixed without needing any DMI matches
and generic fixes are always better :)

Regards,

Hans




> 
> On 21.06.22 12:23, Stefan Seyfried wrote:
>> Hi Hans,
>>
>> On 21.06.22 11:26, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 6/20/22 20:10, Stefan Seyfried wrote:
>>>> Well, the non-working backlight is coming from the i915 driver, but as this is a very old Chipset (i855 GM) I'd rather be happy it works at all instead of complaining ;-)
>>>> (I have another machine of similar age, hp nc6000 with ati graphics, and there is no way getting it to work somewhat reliably at all)
>>>
>>> Ah right, you've got a panasonic + a native intel backlight device.
>>>
>>> We are going to need a quirk to (eventually also depending on other changes)
>>> disable the broken intel backlight device.
>>>
>>> But that won't fix the keys issue, at least not without an extra
>>> quirk just for that.
>>>
>>> I wonder if your machine supports the backlight control part of
>>> the ACPI video bus at all. If not that would explain why it is
>>> not reporting brightness keys and that would also give us a way
>>> to solve this without an extra quirk.
>>>
>>> And that would actually also avoid the need for a backlight
>>> quirk too.
>>>
>>> Can you pass "acpi_backlight=video" on the kernel commandline
>>> and see if a /sys/class/backlight/acpi_video0 device then
>>> shows up. If it does _not_ show up then indeed there is no
>>> ACPI backlight control at all.
>>
>> Nothing new shows up, just panasonic and intel_backlight as before.
>>
>>> In that case please give the attached patches a try on top
>>> of my last series.
>>
>> they do not fix the brightness keys for me.
> 
> YES they do fix it. I just need to actually use the patched module :-)
> 
>> I did not have time to put in some debugging and will be traveling for the rest of the week, but I'll take the toughbook with me and will try to debug this later ;-)
>>
>>> The acpi_video patch should fix your brightness keys then and
>>
>> apparently it does not :-(
> It does.
> 
> Thanks
>     Stefan

