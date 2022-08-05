Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A058B015
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiHESyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHESyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C03861570F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659725689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDp276yUUX4Aq7Lw1Vcvvjg+TcgvBmhKuGUKBBWce3s=;
        b=iNUzGdz1QcIXNS0WWECDi/2s2k9tSX/hURql5QC9ERDqn+fM+Yj1JELbKu0+VnCqR6uON3
        wOq0YGaxbbAexUsEvu8MfHChwGsni0LqhLePAOuXuLyJ8hAnsxGG18ByJFR84Wbb5sh95D
        rcfV4eJHWxTSRArM3Wq+T38M2K2e3Rc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-er6JMh-ZORmHKsbzdR6h5g-1; Fri, 05 Aug 2022 14:54:48 -0400
X-MC-Unique: er6JMh-ZORmHKsbzdR6h5g-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso2069933edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BDp276yUUX4Aq7Lw1Vcvvjg+TcgvBmhKuGUKBBWce3s=;
        b=XX7BM14Rb8cu+aiJ+mJELHFMpD1JN7DMgS86E0zp5lsxzC+SxaNDaenMVGKVNI8h8i
         g1FVOf5gLCu/QT8SvBiYKMwlYBiGex0w1cziIeh0x28RWkdS+bULx3GTPrJdpwqTGUEh
         zTJflu9+OQFV46l6xZd8kcp78J4VAAeP36QhxMf7utzdu++a3efPr8i0mgb9eneDPBD/
         0tha/tqTMBYvABbzSD6eqa0ygeJBAbvYvidVuxCe1BArRjQXYijo6ppKEaCbGuRvtZeY
         ZUn8h2khCp2+R2lLylBbsNN6YuK2mZBKCrQM6HbMQKE/Sev8a4PzqIYazIcrhP1tpxRW
         Vf8w==
X-Gm-Message-State: ACgBeo0i3b/U3wuBpZeyo8F5PqAjck+6eJocV1hyB7aPhSr434Y22iUp
        xaK804R7q2NFqDTY/SHEIPU2TueCs1KxUpiXO52bbfEvrP8v8y1t71mc02mIfIRZs1PG93vKrv3
        EdXvnoaj0zId+YjBq6X9Yw2Rg
X-Received: by 2002:a05:6402:5510:b0:43a:76ff:b044 with SMTP id fi16-20020a056402551000b0043a76ffb044mr7952579edb.197.1659725687514;
        Fri, 05 Aug 2022 11:54:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6vSDUmuhy8SNVKrSUvHQBCekrCrZpuX/JqEMaS4y/X5mw8bYCugwAR6VtXtJYgmQagU0KKgw==
X-Received: by 2002:a05:6402:5510:b0:43a:76ff:b044 with SMTP id fi16-20020a056402551000b0043a76ffb044mr7952572edb.197.1659725687344;
        Fri, 05 Aug 2022 11:54:47 -0700 (PDT)
Received: from [192.168.43.127] ([109.38.137.199])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7d999000000b0043bc19efc15sm300898eds.28.2022.08.05.11.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:54:46 -0700 (PDT)
Message-ID: <a2d2b61e-87c0-ee39-ea4e-3c575da0a66c@redhat.com>
Date:   Fri, 5 Aug 2022 20:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] i2c: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <12042830.O9o76ZdvQC@kreacher>
 <1c7fa65d-47ab-b064-9087-648bcfbf4ab5@amd.com>
 <CAJZ5v0ie7B=GvhbfBsi7Zxu+=YzYKUqvUNs6dNZQfT3CRm=KPg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0ie7B=GvhbfBsi7Zxu+=YzYKUqvUNs6dNZQfT3CRm=KPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/5/22 19:08, Rafael J. Wysocki wrote:
> On Fri, Aug 5, 2022 at 6:59 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 8/5/2022 11:51, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
>>> use low-power S0 idle on the given platform than S3 (provided that
>>> the latter is supported) and it doesn't preclude using either of
>>> them (which of them will be used depends on the choices made by user
>>> space).
>>>
>>> Because of that, ACPI_FADT_LOW_POWER_S0 is generally not sufficient
>>> for making decisions in device drivers and so i2c_hid_acpi_probe()
>>> should not use it.
>>>
>>> Moreover, Linux always supports suspend-to-idle, so if a given
>>> device can wake up the system from suspend-to-idle, then it can be
>>> marked as wakeup capable unconditionally, so make that happen in
>>> i2c_hid_acpi_probe().
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> +Raul
>> +Hans
>> +KH
>>
>> Raul had a patch that was actually going to just tear out this code
>> entirely:
>> https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/
>>
>> As part of that patch series discussion another suggestion had
>> transpired
>> (https://patchwork.kernel.org/project/linux-input/patch/20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid/#24681016):
>>
>> ```
>> if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
>>             !adev->flags.power_manageable) {
>>                  device_set_wakeup_capable(dev, true);
>>                  device_set_wakeup_enable(dev, false);
>>          }
>> ```
>>
>> If this is being changed, maybe consider that suggestion to
>> check `adev->flags.power_manageable`.
> 
> Fair enough, I'll send a v2 with this check added.

Re-reading the original thread:
https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/T/#u

The conclusion there was that the :

                 device_set_wakeup_capable(dev, true);
                 device_set_wakeup_enable(dev, false);

Calls should be made conditional on the IRQ being
marked ExclusiveAndWake instead of the ACPI_FADT_LOW_POWER_S0
check.

Regards,

Hans

