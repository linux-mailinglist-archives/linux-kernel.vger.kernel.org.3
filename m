Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD34E3FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiCVNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiCVNx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:53:58 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [203.148.12.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6098595D;
        Tue, 22 Mar 2022 06:52:28 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 22 Mar
 2022 21:52:17 +0800
Received: from [10.29.8.49] (10.29.8.49) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 22 Mar
 2022 21:52:16 +0800
Message-ID: <08762dd0-7e73-4a0e-0962-a7c05f342ea6@zhaoxin.com>
Date:   Tue, 22 Mar 2022 21:52:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Content-Language: en-US
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
 <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
 <320584eb-ef89-3759-509c-e7e9cb10f983@zhaoxin.com>
 <YjCuOXRFZ8CjK9SD@rowland.harvard.edu>
 <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
In-Reply-To: <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.49]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 10:18, WeitaoWang-oc@zhaoxin.com wrote:
> On 2022/3/15 11:18, Alan Stern wrote:
>> On Tue, Mar 15, 2022 at 08:39:09PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>>> On 2022/3/14 10:24, Alan Stern wrote:
>>>>> +       t1 = ehci_readl(ehci, &ehci->regs->status);
>>>>> +       ehci_writel(ehci, t1 & STS_PCD, &ehci->regs->status);
>>>>> +       ehci_readl(ehci, &ehci->regs->status);
>>>>
>>>> You should not clear the STS_PCD bit.  What if some other port had a
>>>> status change at the same time?  Then because you cleared the
>>>> port-change-detect bit, the system would not realize that the other port
>>>> needed to be handled.
>>>
>>> I really didn't think about this case.
>>>
>>>> Leaving the STS_PCD bit turned on will cause the driver to do a little
>>>> extra work, but it shouldn't cause any harm.
>>>>
>>> I have encountered the following situation if EHCI runtime suspend is
>>> enabled by default.
>>>
>>>
>>>
>>> 1.Wake from system to disk and boot OS.
>>
>> You're talking about resuming after hibernation, right?
> 
> You're right.
>>> 2.EHCI will entry runtime suspend after enumerated by driver during boot
>>> phase of suspend to disk
>>
>> I'm not sure what you mean by "boot phase of suspend to disk".  This is
>> while the restore kernel is starting up at the beginning of resume from
>> hibernation, right?
>>
> You understood exactly what I was saying.
> 
> 
>>> 3.EHCI will be placed to freeze state and ehci_resume is called after image
>>> is loaded.
>>
>> ehci_resume is called to leave runtime suspend.  Going into the freeze
>> state doesn't require any changes.
>>
>>> 4.If PCD flag is set(caused by patch), then HCD_FLAG_RH_RUNNING will be set.
>>>
>>> 5.Pci_pm_freeze_noirq is called to check ehci root hub state and return
>>> value is -EBUSY. which will cause
>>>   quiesce phase of suspend to disk fail.
>>
>> You're talking about check_root_hub_suspended() in hcd-pci.c, right?
>>
> It's right.
>> You know, I'm not at all certain that the callbacks for freeze and
>> freeze_noirq should ever return anything other than 0.  It's okay for
>> them to call check_root_hub_suspended(), but they should ignore its
>> return value.
>>
>> Can you check if the patch below helps?
>>
>> Alan Stern
>>
>>
>> Index: usb-devel/drivers/usb/core/hcd-pci.c
>> ===================================================================
>> --- usb-devel.orig/drivers/usb/core/hcd-pci.c
>> +++ usb-devel/drivers/usb/core/hcd-pci.c
>> @@ -575,6 +575,12 @@ static int hcd_pci_resume(struct device
>>       return resume_common(dev, PM_EVENT_RESUME);
>>   }
>> +static int hcd_pci_freeze_check(struct device *dev)
>> +{
>> +    (void) check_root_hub_suspended(dev);
>> +    return 0;
>> +}
>> +
>>   static int hcd_pci_restore(struct device *dev)
>>   {
>>       return resume_common(dev, PM_EVENT_RESTORE);
>> @@ -586,6 +592,7 @@ static int hcd_pci_restore(struct device
>>   #define hcd_pci_suspend_noirq    NULL
>>   #define hcd_pci_resume_noirq    NULL
>>   #define hcd_pci_resume        NULL
>> +#define hcd_pci_freeze_check    NULL
>>   #define hcd_pci_restore        NULL
>>   #endif    /* CONFIG_PM_SLEEP */
>> @@ -616,8 +623,8 @@ const struct dev_pm_ops usb_hcd_pci_pm_o
>>       .suspend_noirq    = hcd_pci_suspend_noirq,
>>       .resume_noirq    = hcd_pci_resume_noirq,
>>       .resume        = hcd_pci_resume,
>> -    .freeze        = check_root_hub_suspended,
>> -    .freeze_noirq    = check_root_hub_suspended,
>> +    .freeze        = hcd_pci_freeze_check,
>> +    .freeze_noirq    = hcd_pci_freeze_check,
> 
> This patch can fix pci driver's fail check in freeze_noirq phase.
> 
> Restoring system state from a hibernation image can continue and success.
> 
> Weitao Wang

This patch seems work for our platform, but I don't know if there will
be side-effects for others. So I want to take your previous suggestion
and not to clear PCD, As ehci runtime suspend enabled at OS startup is
not a real requirement. I'll resubmit revised patch without the whitespace
damage.
Thanks for your great help.

Best Wishes
Weitao Wang
>>       .thaw_noirq    = NULL,
>>       .thaw        = NULL,
>>       .poweroff    = hcd_pci_suspend,
>> .
>>
