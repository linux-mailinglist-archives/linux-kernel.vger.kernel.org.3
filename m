Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47CD4B8E67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiBPQpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:45:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiBPQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:45:17 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B163274CAB;
        Wed, 16 Feb 2022 08:45:02 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 2FA4F233773F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
 <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
 <20220215104920.GE31021@hu-pkondeti-hyd.qualcomm.com>
 <20220215170718.GF31021@hu-pkondeti-hyd.qualcomm.com>
 <70ebdb8c-1ea5-1a3e-046e-5e457f54726d@linux.intel.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f298147d-a5bc-754e-a1a2-0e37b6179b53@omp.ru>
Date:   Wed, 16 Feb 2022 19:44:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <70ebdb8c-1ea5-1a3e-046e-5e457f54726d@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 6:58 PM, Mathias Nyman wrote:

>>>>> The crash reports I have seen are pointing to
>>>>>
>>>>> usb_remove_hcd()->xhci_stop()->xhci_reset()
>>>>
>>>> Ok, so xhci_stop() and xhci_shutdown() both may call xhci_reset() with interrupts
>>>> disabled and spinlock held. In both these cases we're not that interested in the
>>>> outcome of xhci_reset().
>>>>
>>>> But during probe we call xhci_reset() with interrupts enabled without spinlock,
>>>> and here we really care about it succeeding.
>>>> I'm also guessing reset could take a longer time during probe due to possible recent
>>>> BIOS handover, or firmware loading etc.
>>>>
>>>> So how about passing a timeout value to xhci_reset()?
>>>> Give it 10 seconds during probe, and 250ms in the other cases.
>>>>
>>>
>>> Thanks for this suggestion.
>>>
>>> This sounds better compared to the quirks approach. xhci_resume() also seems
>>> to be calling xhci_reset() in the hibernation path, I believe we should treat
>>> this like probe()/startup case and give larger timeout.
>>>
>> I will test the below patch as per Mathias suggestion.
>>
>> Thanks,
>> Pavan
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index df3522d..031fe90 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -762,7 +762,7 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
>>  	}
>>  	pm_runtime_allow(xhci_to_hcd(xhci)->self.controller);
>>  	xhci->test_mode = 0;
>> -	return xhci_reset(xhci);
>> +	return xhci_reset(xhci, false);
> 
> Maybe just pass the timeout value directly to xhci_reset().
> Looks like readl_poll_timeout_atomic() uses u64 for timeout_us,
> makes sense to use the same.
> 
> Sergey also pointed out xhci_handshake() incorrectly uses a signed integer for timeouts.
> This could be changed to u64 as well.
> 
> I'll write a patch that does all above

   You mean I don't need to respin my xhci_handshake() patch?
   I'm happy to do that if that's a prevailing opinion. :-)

> -Mathias

MBR, Sergey
