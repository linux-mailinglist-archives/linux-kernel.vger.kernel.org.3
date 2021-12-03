Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384C74672A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbhLCHhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:37:08 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:39269 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243710AbhLCHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:37:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638516824; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=N7DGyEQzTk8fyCInGXk90E25CG4IDDnUIzPL/8K1MqQ=; b=mJL8RimOzT5USwmHGa8V1/pCZSV9a9BlDn9VHQBN7g/uRHP4Jef2FfKYtRh6SobvDWDtyGJa
 BIfoF1TuDU6p/HZ3lXvyWJY8msdhxJ7XM6cGwbtMdfjGr41yJiQ6oZ6gavYLm0/Z1yovkSGY
 GLPsXzfRJ/j3YKooadzo4F5x7hA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61a9c857df12ba53c4a8ab01 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 07:33:43
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01F95C43616; Fri,  3 Dec 2021 07:33:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.110.103.27] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 525F1C4338F;
        Fri,  3 Dec 2021 07:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 525F1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] usb: gadget: f_fs: Wake up IO thread during disconnect
To:     John Keeping <john@metanate.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com
References: <20211201100205.25448-1-quic_wcheng@quicinc.com>
 <YaelpmsJXmhTY4A0@donbot> <Yajc5f3LDm+dSji/@donbot>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <dcfb2b21-6ae8-6921-663d-85cb71f3f5ae@codeaurora.org>
Date:   Thu, 2 Dec 2021 23:33:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <Yajc5f3LDm+dSji/@donbot>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 12/2/2021 6:49 AM, John Keeping wrote:
> On Wed, Dec 01, 2021 at 04:41:10PM +0000, John Keeping wrote:
>> On Wed, Dec 01, 2021 at 02:02:05AM -0800, Wesley Cheng wrote:
>>> During device disconnect or composition unbind, applications should be
>>> notified that the endpoints are no longer enabled, so that it can take
>>> the proper actions to handle its IO threads.  Otherwise, they can be
>>> left waiting for endpoints until EPs are re-enabled.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>  drivers/usb/gadget/function/f_fs.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>>> index 3c584da9118c..0b0747d96378 100644
>>> --- a/drivers/usb/gadget/function/f_fs.c
>>> +++ b/drivers/usb/gadget/function/f_fs.c
>>> @@ -957,10 +957,12 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
>>>  		if (file->f_flags & O_NONBLOCK)
>>>  			return -EAGAIN;
>>>  
>>> -		ret = wait_event_interruptible(
>>> -				epfile->ffs->wait, (ep = epfile->ep));
>>> +		ret = wait_event_interruptible(epfile->ffs->wait,
>>> +				(ep = epfile->ep) || !epfile->ffs->func);
> 
> I looked at this again, and doesn't this totally break the wait
> condition?
> 
> epfile->ep is set to non-null in ffs_func_eps_enable() which is called
> from ffs_func_set_alt() just after ffs->func is set to non-null, and
> then those are also set back to null at the same time.
> 
> So the condition boils down to a || !a and this never blocks.  Or am I
> missing something?

Thanks for the feedback.  Hmm...yes, I get what you're saying.  The
EPfiles and func is basically being set/cleared together, so the above
change wouldn't be any different than checking for ep != epfile->ep.
Let me see if there's another way we can address the issue this change
is trying to resolve.

> 
>>>  		if (ret)
>>>  			return -EINTR;
>>> +		if (!epfile->ffs->func)
>>> +			return -ENODEV;
>>
>> This seems strange - we are inside the case where the endpoint is not
>> initially enabled, if we're returning ENODEV here shouldn't that happen
>> in all cases?
>>
>> Beyond that, there is no locking for accessing ffs->func here;
>> modification happens in gadget callbacks so it's guarded by the gadget
>> core (the existing case in ffs_ep0_ioctl() looks suspicious as well).
>>
>> But I can't see why this change is necessary - there are event
>> notifications through ep0 when this happens, as can be seen in the hunk
>> below from the ffs_event_add(ffs, FUNCTIONFS_DISABLE) line.  If
>> userspace cares about this, then it can read the events from ep0.
>>
In short, the change is basically trying to resolve an issue in an
application that has a separate thread handling the IO ops.  When the
USB cable is disconnected, the application would expect for this IO
thread to be completed and exit gracefully, and restarting it on the
next connect.  However, since we are stuck in the read() it can not
proceed further.

I guess in these situations, we should utilize the O_NONBLOCK file
parameter?

Thanks
Wesley Cheng

>>>  	}
>>>  
>>>  	/* Do we halt? */
>>> @@ -3292,6 +3294,7 @@ static int ffs_func_set_alt(struct usb_function *f,
>>>  	if (alt == (unsigned)-1) {
>>>  		ffs->func = NULL;
>>>  		ffs_event_add(ffs, FUNCTIONFS_DISABLE);
>>> +		wake_up_interruptible(&ffs->wait);
>>>  		return 0;
>>>  	}
>>>  

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
