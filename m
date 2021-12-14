Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8F473DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhLNHZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:25:18 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:61632 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhLNHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:25:17 -0500
DKIM-Signature: a=rsa-sha256;
        b=np0mnIbQZRcPL3ecjnxP5Ec/iyUJDD92KeXhYOR0YTWJJ2vqHBuyAo1rIPl1wP9fGMa3DhyiWZ/Pf9v7jceAIyFiPOQyq1Si/FMETPQmgHmjVZQrWmE3J+FAF8DS9MGTPXyZL8E7cQNIFIIOpItAJcZA/LnjLQGocKdwY3dvg3c=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=t2RMvbGFsTcBNEX0mFuf3aE1IjGCzIGg2vVVDrmznss=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id AAFDE7E019F;
        Tue, 14 Dec 2021 15:25:14 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     thinh.nguyen@synopsys.com
Cc:     akingchen@vivo.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        kernel@vivo.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: add sprs_ctrl_trans_quirk
Date:   Tue, 14 Dec 2021 15:25:05 +0800
Message-Id: <20211214072505.9576-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2b09270f-eb8f-08bd-2133-1a92a34921c2@synopsys.com>
References: <2b09270f-eb8f-08bd-2133-1a92a34921c2@synopsys.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJCQ0pWSEhCSRlOTxpPTU
        gZVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Tzo5GT5MTD0uDk4KNEgw
        MhJPCUhVSlVKTUhCT01NTEpOT0JDVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSUJLTDcG
X-HM-Tid: 0a7db7d4c810d999kuwsaafde7e019f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh:
> Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
>
>Can you explain the problem in more detail?

sure i will resend the  patch 
>
>> For example, TF card reader (aaaa:8816):
>> usb 1-1: new high-speed USB device number 2 using xhci-hcd
>> usb 1-1: device descriptor read/all, error -110
>> From the usb analyzer, always return NAK in the data phase.
>
>And how this change help to resolve this issue.

Some device are slow in responding to Control transfers. Scheduling mulitiple 
transactions in one microframe/frame can cause the devices to misbehave.
if this qurik is enabled, the host controller schedules transations for 
a Control transfer in defferent microframes/frame.

>
>Also note in the patch that this is for host mode.

yes, this is only for host mode
>
>>
>> Signed-off-by: Yaqin Pan <akingchen@xxxxxxxx>
>> ---
>> drivers/usb/dwc3/core.c | 4 ++++
>> drivers/usb/dwc3/core.h | 3 +++
>> 2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index ba74ad7f6995..93ac2c79a2c0 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1071,6 +1071,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>> * packet with Retry=1 & Nump != 0)
>> */
>> reg |= DWC3_GUCTL_HSTINAUTORETRY;
>> + if (dwc->sprs_ctrl_trans_quirk)
>> + reg |= DWC3_GUCTL_SPRSCTRLTRANSEN;
>>
>> dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
>> }
>> @@ -1377,6 +1379,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>
>> dwc->dis_split_quirk = device_property_read_bool(dev,
>> "snps,dis-split-quirk");
>> + dwc->sprs_ctrl_trans_quirk = device_property_read_bool(dev,
>> + "snps,sprs-ctrl-trans-quirk");
>
>Since you're adding a new device property, please add another patch to
>document it in Documentation/devicetree/bindings/usb
I will upload a patch serials for that
>
I will renew the patch,thanks~
Yaqin
