Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B348411E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiADLot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:44:49 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52654 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232299AbiADLor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:44:47 -0500
Received: from [10.180.13.117] (unknown [10.180.13.117])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9MKM9Rh47UAAA--.2257S2;
        Tue, 04 Jan 2022 19:44:11 +0800 (CST)
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        Thinh.Nguyen@synopsys.com, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn, benjamin.tissoires@redhat.com,
        Thinh.Nguyen@synopsys.com, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
 <d2e4a97a-b89b-eaf4-5aaf-89af22227746@loongson.cn>
 <654e90fb-2f04-1f87-f56c-792757e140a0@suse.com>
 <8ed3dbee-c51c-db54-37b7-182d5a75fff8@loongson.cn>
 <78229065-61e6-3d61-8cf3-3c24c0f96ae2@suse.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <a3cffd50-ffb7-ce09-70ab-964e74669e68@loongson.cn>
Date:   Tue, 4 Jan 2022 19:44:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <78229065-61e6-3d61-8cf3-3c24c0f96ae2@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL9MKM9Rh47UAAA--.2257S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWxJF1rJw4xtFyftr17GFg_yoW5Jw43pa
        10yF409r4DZr9Ykrna9a1xXw15Kr10y3ZxGF90y348ZwsrAry0vr4aqrZY9anrXrs3Cr1Y
        v3y2qFy0va4kAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/16 下午8:42, Oliver Neukum 写道:
> 
> On 16.12.21 11:59, zhuyinbo wrote:
>>
>>
> Hi,
> 
> 
>> if you only talk about wakeup source you can think that usb-wakeup
>> source and acpi-lid wakeup source was different things. but if you
>> talk about laptop and distinguish lid and other event and you shoud
>> know the cannotation why system still continue sleep when lid closed
>> then system by other event wakeup. if you need test usb-wakeup for
>> laptop and that lid shouldn't be closed.
> I am sorry, I am not sure what you wish to say here. Could you rephrase it?
>>> from the default.
That connotation lid was closed represent human will not use laptop and 
system must keep it was sleep and even though the laptop was 
accidentally awakened.
>>>
>>> In general any HID device must have wakeup capability to be usable for
>>> selective suspend. You cannot draw conclusions from that.
>> you still can has wakeup capability, but it should be keep enabled by
>> default. because the hid device should be convenient for human,
> 
> Well, no. We are talking about a kernel default. That needs to be so that it
> always works on all systems. Convinience is secondary.
if system can doesn't consider lid open event and ignore the connotation 
about lid open event I think that system behavior is inappropriate. you 
don't think my patch was inapproriate that on some system doesn't 
consider lid open event.

In additon, if it doesn't include my patch and non-keyboard hid device 
doesn't make system wakeup by ohci. because ohci driver doesn't export 
wakeup property for usb slave device.
> 
> 
>> if you don't think so and I think HID definition is ridiculous.
> It does have its weaknesses, in particular with respect to differentiating
> between events for wakeups. But we cannot change it.
>>
>>
>> In addition, I had said that laptop usb wakeup was disabled in system
>> bios by default and if user want enable usb wakeup that was only by
>> configure bios and doesn't need enable wakeup node if my patch was
>> applied
> If you deviate from the default, you deviate. That is reducing the number of
> changes is worth little. The default must be above everything else safe.
> 
>      Regards
>          Oliver
bios and kernel was two sets of things and they should has their own 
indepdent configuration.  if bios enable usb wakeup but wakeup is still 
not work well. Do you think it is appropriate?

in additon, The keyboard device is enabled by default, and other hid 
devices should also be enabled. Otherwise, it will be treated differently.

> 

