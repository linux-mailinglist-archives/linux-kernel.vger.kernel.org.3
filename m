Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76D513396
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbiD1M1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiD1M1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:27:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72B3B2AB;
        Thu, 28 Apr 2022 05:24:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 38CD81F45510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651148655;
        bh=9kgLIa+utdQB/zPHzXQRA4FsgkMgjP2b5qJ10Q0wlug=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ktzQufS0NQMQ4RapDlaZcgeY9sznqkheimpjTBZ0tAKL9Qer2AgDtIGk3ap3bVDnZ
         ZOa5t+PcyzJvQdW4+ZIDCspWzVOQZjiNF6CYtvLiZPbHUOWbsnKQxVFS7CyEs3sih4
         BkN/8GN6wlaTOa19u0+BsLU8Mfmr441fE78lQ4uzyQtC12Qg6teJSJwhc3lfHdA5EX
         zsFL4c1YXazYlN0dis/MvimJEiaz7c/AOCm1rqEJSO4j2q+C54T5TXmL7Ad2fPkdro
         /b4Tk+So/KDVfJ66GF1z3ThQFpiYBowvv/6rvzIZcH41f9/d2TfXwtdD7LHod32Osy
         Q0P1M+sz3qIUg==
Message-ID: <c195573c-e7c7-a2dd-7f29-c6d4625fefdb@collabora.com>
Date:   Thu, 28 Apr 2022 17:24:04 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
 <YmUNnq5tH8mykNOF@kroah.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <YmUNnq5tH8mykNOF@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 1:43 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 15, 2022 at 10:08:15PM +0500, Muhammad Usama Anjum wrote:
>> +	i = 0;
>> +	list_for_each_entry(aag, &chromeos_acpi.groups, list) {
>> +		chromeos_acpi.dev_groups[i] = &aag->group;
>> +		i++;
>> +	}
>> +
>> +	ret = sysfs_create_groups(&dev->kobj, chromeos_acpi.dev_groups);
> 
> You have raced with userspace and lost here :(
> 
Sorry, What does it mean exactly?

> Use the default groups pointer in the platform driver for this, and use
> the is_visible() callback to know to show, or not show, the attribute
> instead of building up dynamic lists of attributes at runtime.  That
> will save you lots of crazy logic and housekeeping _AND_ userspace tools
> will work properly as well.
> 

Driver has the 2 kinds of attributes:

A) Attributes which are always there. For example, CHSW and HWIDs etc.
They can be easily shows via dev_groups pointer in platform driver.

B) Attribute groups which vary between 0 to N. N is platform dependent
and can be determined at runtime. For example, GPIO attribute group
which have 4 sub attributes in it:

Group GPIO.0 --> attributes GPIO.0, GPIO.1, GPIO.2 and GPIO.3
Group GPIO.1 --> attributes GPIO.0, GPIO.1, GPIO.2 and GPIO.3
...
Group GPIO.N --> attributes GPIO.0, GPIO.1, GPIO.2 and GPIO.3

My Chromebook has 2 GPIO attribute groups while I've found logs of a
Chromebook which has 7 GPIO groups.

Why these groups cannot be defined at compile time (Shortcomings):

1) We don't know the total GPIO groups.
Possible solution: Determine GPIO groups' number at run time and define
attributes at run time.

2) We cannot determine from attribute name that this group will be
visible or not as is_visible doesn't provide information about its group
name.
umode_t (*is_visible)(struct kobject *, struct attribute *, int);

3) In attribute.show functions, we only know about the attribute's name
and not the group's name. We cannot evaluate and show the attribute.
ssize_t (*show)(struct device *dev, struct device_attribute *attr, char
*buf);
Possible solution for 2) and 3):
Embed the group name into attribute name like:
attributes GPIO.0_GPIO.0, GPIO.0_GPIO.1, GPIO.0_GPIO.2 and GPIO.0_GPIO.3
attributes GPIO.1_GPIO.0, GPIO.1_GPIO.1, GPIO.2_GPIO.2 and GPIO.3_GPIO.3
But this is completely new ABI which we don't desire.

After looking at dependence on runtime values, can we keep the existing
version of the driver instead of trying to workout some other hybrid
solution?

> thanks,
> 
> greg k-h

-- 
Muhammad Usama Anjum
