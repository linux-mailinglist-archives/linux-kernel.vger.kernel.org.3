Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE75B47706F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhLPLlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:41:00 -0500
Received: from mail.loongson.cn ([114.242.206.163]:39940 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229845AbhLPLk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:40:59 -0500
Received: from [10.180.13.92] (unknown [10.180.13.92])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxHNy8JbthNGwBAA--.3500S2;
        Thu, 16 Dec 2021 19:40:45 +0800 (CST)
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        Thinh.Nguyen@synopsys.com, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        rajatja@google.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <YbCdTaGSKak1cdSh@kroah.com>
 <cc535d3d-6dcd-e69c-24e7-df54ce63c381@loongson.cn>
 <YbMvyK111M/ZVRJG@kroah.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <fd08de9d-ab77-bec0-eb30-31803563ac42@loongson.cn>
Date:   Thu, 16 Dec 2021 19:40:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YbMvyK111M/ZVRJG@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxHNy8JbthNGwBAA--.3500S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45Xw17Kr4rur17tFyxXwb_yoW8Xr4xp3
        y8A3Z7Kr4DAr9a9wnavr18Kw1ayr4kZ34fZr18A340k3s0va4SyrZ3KFZ8ua4DXr4fXF15
        Xw4jgry3Za4rAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/10 下午6:45, Greg Kroah-Hartman 写道:
> On Fri, Dec 10, 2021 at 05:54:33PM +0800, zhuyinbo wrote:
>>
>>
>> 在 2021/12/8 下午7:55, Greg Kroah-Hartman 写道:
>>> On Wed, Dec 08, 2021 at 05:39:50PM +0800, Yinbo Zhu wrote:
>>>> The remote wake-up function is a regular function on usb hid device
>>>> and I think keeping it enabled by default will make usb application
>>>> more convenient. This patch is to enable remote wakeup function for
>>>> usb hid device.
>>>
>>> How many devices did you test this on?
>>>
>>> As Oliver said, this will cause problems, there's a reason no operating
>>> system does this :(
>>>
>>> sorry,
>>>
>>> greg k-h
>> Hi greg,
>>
>> About that oliver said that I had expained, and I add this change was
>> according that usb device whether support remote wakeup and if it support
>> wakeup then to enabled it so I think it should be okay for all hid device.
> 
> Again, what devices did you test this on?
Hi greg k-h

mouse device and keyboard device. in hid code that keyboad was enabled 
on wakeup node by default.
> 
> And look at other operating systems, as I said, there is a reason that
> no one does this.
System should be do that. otherwise that lid open event was no make 
sense.  and you need know the order that after lid open then system will 
be wakeup then system will accept lid open event by input subsystem .

in addition, whatever that usb wakeup was disabled in bios by default 
even though after apply my patch.
> 
> thanks,
> 
> greg k-h
> 

