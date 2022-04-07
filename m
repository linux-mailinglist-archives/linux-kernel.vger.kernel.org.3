Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461824F71FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiDGCVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiDGCVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:21:51 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369512529B;
        Wed,  6 Apr 2022 19:19:52 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 7 Apr 2022
 10:19:51 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 7 Apr
 2022 10:19:50 +0800
Message-ID: <0470221e-0561-0c6f-1caf-9cf2f1679aa5@meizu.com>
Date:   Thu, 7 Apr 2022 10:19:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] s390: Simplify the calculation of variables
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <Ykq2H+POaGs0GHVU@osiris>
 <1649212651-32038-1-git-send-email-baihaowen@meizu.com>
 <Yk1TOpjLnmUcRQt3@osiris>
 <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/7/22 12:44 AM, Peter Oberparleiter 写道:
> On 06.04.2022 10:45, Heiko Carstens wrote:
>> On Wed, Apr 06, 2022 at 10:37:31AM +0800, Haowen Bai wrote:
>>> Fix the following coccicheck warnings:
>>> ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
>>>  !A || A && B is equivalent to !A || B
>>>
>>> I apply a readable version just to get rid of a warning.
>>>
>>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>>> ---
>>> V1->V2: apply a readable and simple version as suggestion.
>>>
>>>  arch/s390/include/asm/scsw.h | 47 ++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 32 insertions(+), 15 deletions(-)
>> [full quote below]
>>
>> Vineeth, Peter, could one of you please Review and or ACK the patch
>> below?
> This patch changes scsw->cmd access to scsw->tm access, which is
> incorrect, so I cannot ACK them as is.
>
> Also I'm somewhat torn on the general question if these functions should
> be changed:
>
> - the current implementation is unreadable => change it
> - the current implementation works => keep it
> - improvement patches like this one seem to appear regularly and consume
>   time in reviewing => change it
>
> If there was a new version that really improved readability, this would
> be really welcome. The problem is that the definition of readability is
> special for these functions: each of these functions implement a
> validity check based on text from the s390 Principles of Operations
> (PoP) document [1]. "Readable" for myself would mean: I can easily
> correlate the code to the text from the PoP so that I can spot errors or
> adjust code to changed text.
>
> I'm adding some examples how that could look like below. My question to
> the original author would be, if this is something they could implement,
> or if we'd rather do that at some point in time in the future by ourselves.
>
>>> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
>>> index a7c3ccf681da..b7e65f96de3c 100644
>>> --- a/arch/s390/include/asm/scsw.h
>>> +++ b/arch/s390/include/asm/scsw.h
>>> @@ -508,9 +508,13 @@ static inline int scsw_cmd_is_valid_zcc(union scsw *scsw)
>>>   */
>>>  static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
>>>  {
>>> -	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
>>> -	       !(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
>>> -	       (scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS);
>>> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
>>> +		return 0;
>>> +	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
>>> +		return 0;
>>> +	if (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS)
>>> +		return 1;
>>> +	return 0;
>>>  }
> Here's the PoP text that is the base for this function (note ECTL=E):
>
> "The E bit is meaningful whenever the subchannel is status pending with
> alert status either alone or together with primary status, secondary
> status, or both."
>
> A readable version for me would therefore contain code that can easily
> be matched against that text, e.g. something like:
>
> /* Must be status pending. */
> if (!(scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND))
>   return 0;
>
> /* Must have alert status. */
> if (!(scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS))
>   return 0;
>
> /* Must be alone or together with primary, secondary or both,
>  * => no intermediate status. */
> if (scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS)
>   return 0;
>
> return 1;
>
>>>  /**
>>> @@ -522,10 +526,15 @@ static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
>>>   */
>>>  static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
>>>  {
>>> -	return (scsw->cmd.fctl != 0) &&
>>> -	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
>>> -	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
>>> -		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
>>> +	if (!scsw->tm.fctl)
>>> +		return 0;
>>> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
>>> +		return 0;
>>> +	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
>>> +		return 1;
>>> +	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
>>> +		return 1;
>>> +	return 0;
>>>  }
> Here's the associated PoP text for this function (note: PNO=N)
>
> "The N bit is meaningful whenever the status-control field contains any
> of the indications listed below and at least one basic I/O function is
> also indicated at the subchannel:
> - Status pending with any combination of primary, secondary, or alert
>   status
> - Status pending alone
> - Status pending with intermediate status when the subchannel is also
>   suspended"
>
> Again a readable version could look like:
>
> /* Must indicate at least one I/O function. */
> if (!scsw->cmd.fctl)
>   return 0;
>
> /* Must be status pending. */
> if (!(scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND))
>   return 0;
>
> /* Can be status pending alone, or with any combination of primary,
>  * secondary and alert => no intermediate status. */
> if (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS))
>   return 1;
>
> /* If intermediate, must be suspended. */
> if (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)
>   return 1;
>
> return 0;
>
> The _tm_ functions below should be changed in the exact same way, while
> accessing the corresponding data fields in scsw->tm instead of scsw->cmd.
>
>>>  static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
>>>  static inline int scsw_tm_is_valid_pno(union scsw *scsw)
> [1] https://www.ibm.com/support/pages/zarchitecture-principles-operation
>
Dear Peter Oberparleiter

Well done. Thank you for your kindly and professional explain what we need to do best.

-- 
Haowen Bai

