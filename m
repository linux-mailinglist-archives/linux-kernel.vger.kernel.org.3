Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999364619C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347776AbhK2Oli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:41:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:46852 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378911AbhK2Oje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:39:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="296786173"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="296786173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 06:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="653129914"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2021 06:33:43 -0800
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1636612118-32481-1-git-send-email-zhuyinbo@loongson.cn>
 <c330c58f-bb73-d439-d6fa-63eb9cba4313@loongson.cn>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3] usb: xhci: add LWP quirk for ensuring uPD720201 into
 D3 state after S5
Message-ID: <ffc49feb-2648-b94c-c4b5-ee24bd44d1de@linux.intel.com>
Date:   Mon, 29 Nov 2021 16:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c330c58f-bb73-d439-d6fa-63eb9cba4313@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2021 14.25, zhuyinbo wrote:
> 
> 在 2021/11/11 下午2:28, Yinbo Zhu 写道:
>> After S5, any pci device should into D3 state that if supported, but the
>> uPD720201 was not and cause OSPM power consumption is more higher that
>> S5 than S4. Due to that uPD720201 firmware behavior was unknown and the
>> _PS3 method wasn't implemented in ACPI table which can make device into
>> D3, I think xhci HCD can add a quirk ensure it into D3 state after S5
>> that is appropriate and this patch was to add the XHCI_LWP_QURIK and set
>> PCI_D3hot to uPD720201 pmsc register in xhci_pci_shutdown and
>> xhci_pci_remove to fix xhci power consumption issue.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v3:
>>         Add D3 set in xhci_pci_remove function.
>>
>>   drivers/usb/host/xhci-pci.c | 9 +++++++++
>>   drivers/usb/host/xhci.h     | 1 +
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 2c9f25c..6258a5a 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -265,6 +265,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>           pdev->device == 0x0014) {
>>           xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>>           xhci->quirks |= XHCI_ZERO_64B_REGS;
>> +        xhci->quirks |= XHCI_LWP_QUIRK;
>>       }
>>       if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
>>           pdev->device == 0x0015) {
>> @@ -466,6 +467,10 @@ static void xhci_pci_remove(struct pci_dev *dev)
>>           pci_set_power_state(dev, PCI_D3hot);
>>         usb_hcd_pci_remove(dev);
>> +
>> +    /* Workaround for decreasing power consumption after S5 */
>> +    if (xhci->quirks & XHCI_LWP_QUIRK)
>> +        pci_set_power_state(dev, PCI_D3hot);
>>   }
>>     #ifdef CONFIG_PM
>> @@ -610,6 +615,10 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>>       /* Yet another workaround for spurious wakeups at shutdown with HSW */
>>       if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
>>           pci_set_power_state(pdev, PCI_D3hot);
>> +
>> +    /* Workaround for decreasing power consumption after S5 */
>> +    if (xhci->quirks & XHCI_LWP_QUIRK)
>> +        pci_set_power_state(pdev, PCI_D3hot);
>>   }
>>   #endif /* CONFIG_PM */
>>   diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index dca6181..bcd70d1 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1899,6 +1899,7 @@ struct xhci_hcd {
>>   #define XHCI_SG_TRB_CACHE_SIZE_QUIRK    BIT_ULL(39)
>>   #define XHCI_NO_SOFT_RETRY    BIT_ULL(40)
>>   #define XHCI_BROKEN_D3COLD    BIT_ULL(41)
>> +#define XHCI_LWP_QUIRK        BIT_ULL(42)
>>         unsigned int        num_active_eps;
>>       unsigned int        limit_active_eps;
> 
> Hi all,
> 
> 
> Do you have any advice about my patch, if no any question, please you help me merge this patch to upstream.
> 

This will set any Renesas uPD720201 PCI controller to D3 at remove or shutdown.
Should this be limited to only those platforms with missing ACPI methods?

Would be better if we could avoid setting PCI D states directly in xhci driver.

Do you know the details why pci_disable_device() called by usb_hcd_pci_shutdown()
is not setting this right D state in this case? 
Is it just the missing _PS3 ACPI method described in the patch, or some other reason?

Is windows working? or is that not relevant in this case?
If not working, and product not yet on the market then fixing the ACPI firmware
would be solve both cases.

Thanks
-Mathias
 
