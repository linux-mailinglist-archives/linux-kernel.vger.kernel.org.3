Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259364D9B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbiCOMkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348211AbiCOMkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:40:31 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095630F53;
        Tue, 15 Mar 2022 05:39:17 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 15 Mar
 2022 20:39:12 +0800
Received: from [10.29.8.53] (10.29.8.53) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 15 Mar
 2022 20:39:10 +0800
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
 <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Message-ID: <320584eb-ef89-3759-509c-e7e9cb10f983@zhaoxin.com>
Date:   Tue, 15 Mar 2022 20:39:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.53]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/14 10:24, Alan Stern wrote:
> On Mon, Mar 14, 2022 at 03:35:37PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>> In zhaoxin platform, some ehci projects will latch a wakeup signal
>> internal when plug in a device on port during system S0. This wakeup
>> signal will turn on when ehci runtime suspend, which will trigger a
>> system control interrupt that will resume ehci back to D0. As no
>> device connect, ehci will be set to runtime suspend and turn on the
>> internal latched wakeup signal again. It will cause a suspend-resume
>> loop and generate system control interrupt continuously.
>>
>> Fixed this issue by clear wakeup signal latched in ehci internal when
>> ehci resume callback is called.
>>
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>> ---
>>   drivers/usb/host/ehci-hcd.c | 26 ++++++++++++++++++++++++++
>>   drivers/usb/host/ehci-pci.c |  4 ++++
>>   drivers/usb/host/ehci.h     |  1 +
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
>> index 3d82e0b..e4840ef 100644
>> --- a/drivers/usb/host/ehci-hcd.c
>> +++ b/drivers/usb/host/ehci-hcd.c
>> @@ -1103,6 +1103,30 @@ static void ehci_remove_device(struct usb_hcd *hcd,
>> struct usb_device *udev)
>>
>>   #ifdef CONFIG_PM
>>
>> +/* Clear wakeup signal locked in zhaoxin platform when device plug in. */
>> +static void ehci_zx_wakeup_clear(struct ehci_hcd *ehci)
>> +{
>> +       u32 __iomem     *reg = &ehci->regs->port_status[4];
>> +       u32     t1 = ehci_readl(ehci, reg);
> 
> The "t1" in this line should start in the same column as the "*reg" in
> the line above, to match the style of other variable declarations in
> this file (see ehci_init() as an example).
> 
>> +
>> +       t1 &= (u32)~0xf0000;
>> +       t1 |= PORT_TEST_FORCE;
>> +       ehci_writel(ehci, t1, reg);
>> +       t1 = ehci_readl(ehci, reg);
>> +       msleep(1);
>> +       t1 &= (u32)~0xf0000;
>> +       ehci_writel(ehci, t1, reg);
>> +       ehci_readl(ehci, reg);
>> +       msleep(1);
>> +       t1 = ehci_readl(ehci, reg);
>> +       ehci_writel(ehci, t1 | PORT_CSC, reg);
>> +       ehci_readl(ehci, reg);
>> +       udelay(500);
>> +       t1 = ehci_readl(ehci, &ehci->regs->status);
>> +       ehci_writel(ehci, t1 & STS_PCD, &ehci->regs->status);
>> +       ehci_readl(ehci, &ehci->regs->status);
> 
> You should not clear the STS_PCD bit.  What if some other port had a
> status change at the same time?  Then because you cleared the
> port-change-detect bit, the system would not realize that the other port
> needed to be handled.

I really didn't think about this case.

> Leaving the STS_PCD bit turned on will cause the driver to do a little
> extra work, but it shouldn't cause any harm.
> 
I have encountered the following situation if EHCI runtime suspend is 
enabled by default.



1.Wake from system to disk and boot OS.

2.EHCI will entry runtime suspend after enumerated by driver during boot 
phase of suspend to disk


3.EHCI will be placed to freeze state and ehci_resume is called after 
image is loaded.


4.If PCD flag is set(caused by patch), then HCD_FLAG_RH_RUNNING will be set.


5.Pci_pm_freeze_noirq is called to check ehci root hub state and return 
value is -EBUSY. which will cause
  quiesce phase of suspend to disk fail.



However,EHCI runtime suspend is default disabled by kernel, user can 
enable runtime suspend after boot into OS.
  So I guess turning on suspend during startup is not a real requirement 
and I will take your advice.

Weitao Wang
>> +}
>> +
>>   /* suspend/resume, section 4.3 */
>>
>>   /* These routines handle the generic parts of controller suspend/resume */
>> @@ -1154,6 +1178,8 @@ int ehci_resume(struct usb_hcd *hcd, bool force_reset)
>>          if (ehci->shutdown)
>>                  return 0;               /* Controller is dead */
>>
>> +       if (ehci->zx_wakeup_clear == 1)
> 
> You don't need to check that the value is equal to 1.  Treat this
> more like a Boolean flag and just write:
> 
> 	if (ehci->zx_wakeup_clear)
> 
> Also, to make the flag's meaning more obvious, you might want to name
> it "zx_wakeup_clear_needed" or "zx_clear_latched_wakeup".
> 
> Otherwise this patch looks okay.  Please submit a revised version,
> without the whitespace damage.
> 
> Alan Stern

Okay,I will take your advice
Weitao Wang

> 
>> +               ehci_zx_wakeup_clear(ehci);
>>          /*
>>           * If CF is still set and reset isn't forced
>>           * then we maintained suspend power.
>> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
>> index e87cf3a..a5e27de 100644
>> --- a/drivers/usb/host/ehci-pci.c
>> +++ b/drivers/usb/host/ehci-pci.c
>> @@ -222,6 +222,10 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>>                          ehci->has_synopsys_hc_bug = 1;
>>                  }
>>                  break;
>> +       case PCI_VENDOR_ID_ZHAOXIN:
>> +               if (pdev->device == 0x3104 && (pdev->revision & 0xf0) ==
>> 0x90)
>> +                       ehci->zx_wakeup_clear = 1;
>> +               break;
>>          }
>>
>>          /* optional debug port, normally in the first BAR */
>> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
>> index fdd073c..712fdd0 100644
>> --- a/drivers/usb/host/ehci.h
>> +++ b/drivers/usb/host/ehci.h
>> @@ -220,6 +220,7 @@ struct ehci_hcd {                   /* one per
>> controller */
>>          unsigned                imx28_write_fix:1; /* For Freescale i.MX28
>> */
>>          unsigned                spurious_oc:1;
>>          unsigned                is_aspeed:1;
>> +       unsigned                zx_wakeup_clear:1;
>>
>>          /* required for usb32 quirk */
>>          #define OHCI_CTRL_HCFS          (3 << 6)
>> -- 
>> 2.7.4
> .
> 
