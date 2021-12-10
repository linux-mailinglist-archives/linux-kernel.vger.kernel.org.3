Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2E46FDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhLJJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:31:43 -0500
Received: from mail.loongson.cn ([114.242.206.163]:40784 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232385AbhLJJbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:31:41 -0500
Received: from [10.180.13.84] (unknown [10.180.13.84])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxqsiDHbNhktAFAA--.12340S2;
        Fri, 10 Dec 2021 17:27:40 +0800 (CST)
Subject: Re: [PATCH v1 2/2] usb: core: enable remote wakeup function for usb
 controller
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <1638956391-20149-2-git-send-email-zhuyinbo@loongson.cn>
 <YbEsCSwYLgQefQxU@rowland.harvard.edu>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <fbd46e52-054c-8aea-2f06-3af74c95e5e0@loongson.cn>
Date:   Fri, 10 Dec 2021 17:27:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YbEsCSwYLgQefQxU@rowland.harvard.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxqsiDHbNhktAFAA--.12340S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1UAF4fXr48XrW3tF4ruFg_yoW5uFW7pa
        y8JF1rKr4UXrWFkrsrur95Gw13Ga1vya4rCas7A34qg3srA340kr95tr43tayDXrZ8uF4F
        q3y8WFy8W3WUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/12/9 ÉÏÎç6:04, Alan Stern Ð´µÀ:
> On Wed, Dec 08, 2021 at 05:39:51PM +0800, Yinbo Zhu wrote:
>> The remote wake up function is a regular function on usb device and
>> I think keeping it enabled by default will make the usb application
>> more convenient and usb device remote wake up function keep enabled
>> that ask usb controller remote wake up was enabled at first.
>>
>> This patch only enable wake up on usb root hub device, among which,
> 
> You say the patch only affects root hub devices, but this doesn't appear
> to be true.
> 
>> usb3.0 root hub doesn't be set wakeup node property but use command
>> USB_INTRF_FUNC_SUSPEND to enable remote wake up function.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   drivers/usb/core/hub.c | 20 ++++++++++++++++++--
>>   include/linux/usb.h    |  4 +++-
>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 86658a8..cb4b956 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2509,6 +2509,8 @@ static void set_usb_port_removable(struct usb_device *udev)
>>    */
>>   int usb_new_device(struct usb_device *udev)
>>   {
>> +	struct usb_host_config *config;
>> +	int ncfg;
>>   	int err;
>>   
>>   	if (udev->parent) {
>> @@ -2540,6 +2542,18 @@ int usb_new_device(struct usb_device *udev)
>>   	udev->dev.devt = MKDEV(USB_DEVICE_MAJOR,
>>   			(((udev->bus->busnum-1) * 128) + (udev->devnum-1)));
>>   
>> +	for (ncfg = 0; ncfg < udev->descriptor.bNumConfigurations; ncfg++) {
>> +		config = &udev->config[ncfg];
>> +		if ((config->desc.bmAttributes & (1 << 5)) == 0)
>> +			break;
>> +		if (ncfg + 1 == udev->descriptor.bNumConfigurations) {
>> +			err = usb_enable_remote_wakeup(udev);
>> +			if (err)
>> +				dev_dbg(&udev->dev,
>> +				      "won't remote wakeup, err %d\n", err);
>> +		}
>> +	}
> 
> I don't see anything in there which treats root hubs differently from
> other devices.
> 
Hi Alan Stern,

You can find following code, non-root-hub had removed Wakeup sysfs 
attributes and disabled wakeup and root-hub had added wakeup sysfs 
attibutes before call usb_new_device, so this patch was only enabled
remote wakeup for root-hub device.
int usb_new_device(struct usb_device *udev)
{
         if (udev->parent) {
                 /* Initialize non-root-hub device wakeup to disabled;
                  * device (un)configuration controls wakeup capable
                  * sysfs power/wakeup controls wakeup enabled/disabled
                  */
                 device_init_wakeup(&udev->dev, 0);
         }

> Besides, enabling wakeup for root hubs is generally a bad idea.  Suppose
> you closed a laptop's lid and then unplugged a USB device -- with wakeup
> enabled, the unplug would cause the laptop to wake up again without your
> knowledge.
> 
> Alan Stern
when closed laptop's lid and then unplugged a non-hid usb device it 
doesn't cause laptop to wakeup. and if that usb device is hid type and 
cause laptop into wakeup state then system will continue into suspend 
state becuase system ask that need accepted a acpi lid open event.
and for laptop usb wakeup that as general ask bios to enable usb wakeup 
then if need do more things to enable usb wakeup I think this usb wakeup 
function isn't friendly and inconveient, so enable it by default.
after add this patch, if want to use usb wakeup function it only need 
enable bios configure it think it is appropriate.

BRs,
Yinbo.
> 

