Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD0512DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiD1IK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiD1IKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:10:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFEE54F9D;
        Thu, 28 Apr 2022 01:07:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id C5D1A1F45034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651133225;
        bh=gkofCbla6q/11zKU00zv0OsLH0Kg1dBauD7EEXXr8w4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=nIeU3RHTyPGIbfsEWhwWP2fVMUQQGuJtXlVD9kFzxnPfRWMhllRUjI6u8vypNIVN1
         eu5cHaG3n9ZXhp5V0x+Jf73SMqKL3ceJeaWwg/m5gnjeiUO1Lk3UuaB20pLNZryoDz
         XfhHxrUIAcPO/NxiDtUFBcV+SeCuArS5mWrsQTaxFQAEHs6+4Xak2qTkB/r9e3xVLF
         zirWf7yQjIrqAO3iiIzePtDqizqzGS0G3clZvhCHmq6HKa5jxswEmgUjt7W0zgvuzt
         5PZlEXA7u9a/1YAtHxNSnPF/XdiH0rnqPh8pD3XCcSFKgJQTOXdSu5tF19o5iqJ2Cx
         dY4T1R3CTKPVw==
Message-ID: <8acef982-0aec-aaf0-7e26-b02cf024cdf8@collabora.com>
Date:   Thu, 28 Apr 2022 13:06:48 +0500
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
> Use the default groups pointer in the platform driver for this, and use
> the is_visible() callback to know to show, or not show, the attribute
> instead of building up dynamic lists of attributes at runtime.  That
> will save you lots of crazy logic and housekeeping _AND_ userspace tools
> will work properly as well.
> 
Yeah, using dev_group pointer in platform driver makes it simple. We
need to define the attributes at compile time. At run time, we can only
make decision to show or not to show the attribute. This simplifies
logic for the static attributes which will always be there. But there
are some set of attributes which may be 1 to N depending upon the
platform such as GPIO.0, GPIO.2 .... and GPIO.N. I'm working on
overcoming this. Once this is done, the driver is going to be very simple.

> thanks,
> 
> greg k-h

-- 
Muhammad Usama Anjum
