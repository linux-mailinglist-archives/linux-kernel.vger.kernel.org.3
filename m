Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF4583F41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiG1MwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiG1MwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA40712A9A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659012731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZpcro9+G+01bmRt12gASDtsXsCB4hr0At/KWhkZS28=;
        b=cqzl0ckouEXXx8zPeoUEjChSv6zndHAXqh9ADwCCEoxmOO8vhOlgVcdI9YPZPWXjWv7pDk
        JMvDGx9qxeVB8I5UZuTa8/RcfI2ZJrwrlui9SkhJvKK2M30pSNr9Cp8J4hPxhOZs2u48wt
        a2Gapxz3XxE8EUYnWh63OHx28Sj9ayw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-eKKZ2y_DOVqFKtYLZa3l-w-1; Thu, 28 Jul 2022 08:52:09 -0400
X-MC-Unique: eKKZ2y_DOVqFKtYLZa3l-w-1
Received: by mail-ej1-f71.google.com with SMTP id gb37-20020a170907962500b0072b820af09dso600165ejc.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZpcro9+G+01bmRt12gASDtsXsCB4hr0At/KWhkZS28=;
        b=m0m+hBizf2ST7hEUlAJimmJFSBnPefMEkd5/Nrgbv59+FXK7A2VbQzIXwkAOh3a6gE
         oQlH1sOJu1+oRYe+jaDevzQLN9Zv5X0KLddNyk+qKhMlcgMGncdKiWxBZCrjXUrhFjMr
         65lC7irDJ3bJ08iT16/8XjSXxCnGeVm3Tv/fhvQeIWJszuDVk7Z9N4yPFQfUjcfQcGK2
         anzImekKiwRfQy8aZEYcGAag9j5g0+iUDoIHVpu9rCq9dKBSx/BDWVivrA3OlBxbhyYp
         n4sLp7+LUkqwbSXnBuI0EUWLDaqeCToPhcAD1oe+V3DOQqoRm/b7BAggSeZm0tIGCHZ6
         ET3A==
X-Gm-Message-State: AJIora/mqtbM2oVbJmfVWw/AZ897nOOhDUxBxv+xCn+cd1D95TG233lt
        iuIQTSYjHEevcsCy6Wh9Wr4fWieUP7DHE/2zGdXCQ59ndlcwcNvp693q0FuMv/tnb9JltItvabv
        K8WBs6xMfVZ8lWwjRx9K8M0V2
X-Received: by 2002:a05:6402:2554:b0:43b:e4a3:2664 with SMTP id l20-20020a056402255400b0043be4a32664mr24268592edb.423.1659012728272;
        Thu, 28 Jul 2022 05:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v2WcS7jVOLwQKZRX606THN42iKJRukow+e5LJZWjx05BisPIpOGOY9bCZ4CwqSbMcn8oud6A==
X-Received: by 2002:a05:6402:2554:b0:43b:e4a3:2664 with SMTP id l20-20020a056402255400b0043be4a32664mr24268562edb.423.1659012727787;
        Thu, 28 Jul 2022 05:52:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id w20-20020a056402129400b0043cd42a3f28sm618868edv.95.2022.07.28.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:52:07 -0700 (PDT)
Message-ID: <39b47ca8-1d25-0e60-d326-ad627541fe36@redhat.com>
Date:   Thu, 28 Jul 2022 14:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <YssFjbveghDLNn4N@kroah.com>
 <55368a65-c536-93c7-c501-9f6086e308d2@redhat.com>
 <YuJ8Ah37WAHGTJlV@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YuJ8Ah37WAHGTJlV@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/28/22 14:07, Greg KH wrote:
> On Thu, Jul 28, 2022 at 01:57:25PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/10/22 18:59, Greg KH wrote:
>>> On Sun, Jul 10, 2022 at 09:00:11AM -0700, Jithu Joseph wrote:
>>>> Existing implementation limits IFS images to be loaded only from
>>>> a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.
>>>
>>> That was by design, why is this suddenly not acceptable?
>>>
>>>> But there are situations where there may be multiple scan files
>>>> that can be run on a particular system stored in /lib/firmware/intel/ifs
>>>
>>> Again, this was by design.
>>>
>>>> E.g.
>>>> 1. Because test contents are larger than the memory reserved for IFS by BIOS
>>>
>>> What does the BIOS have to do with this?
>>>
>>>> 2. To provide increased test coverage
>>>
>>> Test coverage of what?
>>>
>>>> 3. Custom test files to debug certain specific issues in the field
>>>
>>> Why can't you rename the existing file?
>>>
>>>> Renaming each of these to ff-mm-ss.scan and then loading might be
>>>> possible in some environments. But on systems where /lib is read-only
>>>> this is not a practical solution.
>>>
>>> What system puts /lib/ as read-only that you want to have loading
>>> hardware firmware?  That kind of defeats the security implications of
>>> having a read-only /lib/, right?
>>>
>>>> Modify the semantics of the driver file
>>>> /sys/devices/virtual/misc/intel_ifs_0/reload such that,
>>>> it interprets the input as the filename to be loaded.
>>>
>>> So you are now going to allow any file to be read from the system, in an
>>> unknown filesystem namespace, by this driver?
>>
>> @Intel folks to me this is the big blocker which needs to be solved before
>> we can move forward with figuring out how to allow loading multiple
>> different sets of test patterns through IFS.
>>
>> Which in turn is required to remove the broken marking...
>>
>> How about echoing a suffix to be appended to the default filename to
>> the reload attribute? This suffix would then need to be sanity checked
>> to only contain [a-z][0-9] (we don't want '/' but it seems better to
>> limit this further) to avoid directory traversal attacks. 
>>
>> (and echoing an empty suffix can be used to force reloading the
>> default test-patterns after a linux-firmware pkg upgrade)
>>
>> This way we avoid the allowing user to load an arbitrary file issue.
>>
>> Greg, would using a suffix appended to the default filename be
>> acceptable to you as a solution to solving the load arbitrary
>> file issue?
> 
> Not really, a suffix doesn't protect much at all.

?

Currently the driver will always load:

/lib/firmware/intel/ifs/%02x-%02x-%02x.scan

with the "%02x" bits being fixed parts of the CPU model.

My suggestion is to make it:

/lib/firmware/intel/ifs/%02x-%02x-%02x%s.scan

Where the "%s" bit can be supplied by userspace, but it may
only contain [a-z] and [0-9] so no '/' (or other special chars)
so that an attacker cannot use directory traversal to get a file
from below the /lib/firmware/intel/ifs/ dir.

This means that an attacker can only cause a bad file to be
loaded if they have write access to /lib/firmware/intel/ifs/  at
which point they can also just replace the default file. So I
don't see how just allowing userspace to just add a suffix
is a possible problem. Where as the previous arbitrary filename
approach obviously was a problem ?

> This really feels like a "test the product in the factory" type of
> option that someone seems to want to do without just renaming the
> firmware file.  Why this is unique from all other firmware file loading
> in the kernel needs to really be explained here in order to even
> consider justifying this type of change.

First of all I really wish some of the Intel folks would elaborate
more on why multiple test-pattern files are necessary. Ping
anyone@intel, you have all been very quiet in this thread which
is not helpful (not helpful at all really).

Speculating myself as far as I understand IFS is not for factory
tests but for testing in the fields since big cloud vendors have
found that sometimes there are hard to catch CPU defects which
they only find out by running statistics which show that certain
tasks only crash when run on machine a, socket b, core c.

IFS allows them to periodically run a set of CPU selftests to
detect CPU defects (which may sometimes also only show up
over time). AFAIK the multiple test-pattern files thing is
necessary now because it is not possible to put all
possible tests on a single file due to size constraints of
the special RAM into which the test-patterns are loaded.

So the default firmware file will contain a set of defaiult
tests. But there will also be e.g. a special file which
only exercises the avx512 parts of a core, but then more
thoroughly. Again this is all speculation from my side, but
this is my understanding of this all.

Regards,

Hans

