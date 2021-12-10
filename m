Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C446FE20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhLJJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:54:00 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46654 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230296AbhLJJx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:53:59 -0500
Received: from [10.180.13.84] (unknown [10.180.13.84])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxysjRIrNhgdIFAA--.12755S2;
        Fri, 10 Dec 2021 17:50:10 +0800 (CST)
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>,
        benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <d2e4a97a-b89b-eaf4-5aaf-89af22227746@loongson.cn>
Date:   Fri, 10 Dec 2021 17:50:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxysjRIrNhgdIFAA--.12755S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrykXr1UWF17Cry3tFyxKrg_yoWkGwbEkr
        4jgrs7Gr13Zrs7K3WftF4UXry7Ww42kF97Xw4xtw1SgF17Aws3G34kur9ak3W5GayxZF9x
        Krn0qrnayFnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/8 下午6:03, Oliver Neukum 写道:
> 
> On 08.12.21 10:39, Yinbo Zhu wrote:
>> The remote wake-up function is a regular function on usb hid device
>> and I think keeping it enabled by default will make usb application
>> more convenient. This patch is to enable remote wakeup function for
>> usb hid device.
>>
> Hi,
> 
> I am afraid we cannot do this. It will cause regression.
> Consider for example the case of laptops with touchscreens
> that will trigger a wake up when the laptop is closed.
> 
>      Regards
> 
>          Oliver
Hi oliver,


system ask that must it must be accped a acpi lid open event then system 
will always into resume state for laptop, otherwise, eventhough that 
system be wakeuped by other event then system will continue into suspend.

and for laptop usb wakeup that as general ask bios to enable usb wakeup 
then if need do more things to enable usb wakeup I think this usb wakeup 
function isn't friendly and inconveient, so enable it by default.
after add this patch, if want to use usb wakeup function it only need 
enable bios configure it think it is appropriate.

BRs,
Yinbo.
> 

