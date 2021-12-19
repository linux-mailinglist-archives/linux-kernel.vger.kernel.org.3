Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28427479EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 02:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhLSBlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 20:41:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55232 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhLSBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 20:41:50 -0500
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BJ1f62r060317;
        Sun, 19 Dec 2021 10:41:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 19 Dec 2021 10:41:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BJ1f5N7060314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Dec 2021 10:41:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <7c5bbc97-b9dc-96bb-5764-58bebec0178d@i-love.sakura.ne.jp>
Date:   Sun, 19 Dec 2021 10:41:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Julio Faracco <jcfaracco@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, axboe@kernel.dk, tglx@linutronix.de,
        damien.lemoal@wdc.com, dkadashev@gmail.com,
        paul.gortmaker@windriver.com, zhouyanjie@wanyeetech.com,
        niklas.cassel@wdc.com, macro@orcam.me.uk, caihuoqing@baidu.com
References: <20211218042420.28466-1-jcfaracco@gmail.com>
 <Yb4i7LyYIlJi/9fb@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <Yb4i7LyYIlJi/9fb@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/19 3:05, Alan Stern wrote:
>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>> index 2cbf4f85bff3..98cb44414e78 100644
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -64,7 +64,7 @@ qtd_fill(struct ehci_hcd *ehci, struct ehci_qtd *qtd, dma_addr_t buf,
>>  		}
>>  
>>  		/* short packets may only terminate transfers */
>> -		if (count != len)
>> +		if (count != len && maxpacket > 0)
>>  			count -= (count % maxpacket);
> 
> This is different.  But again, I do not think the extra check should be 
> added.  If maxpacket is 0, we _want_ the code to fail in a highly 
> visible manner -- it would mean there is a bug somewhere else in the 
> kernel.

Some of the callers are passing the return value from usb_maxpacket(), and
usb_maxpacket() can return 0. But division by 0 bug here becomes visible
only when len < count in

	count = 0x1000 - (buf & 0x0fff);	/* rest of that page */
	if (likely (len < count))		/* ... iff needed */
		count = len;

is false and count != len in

		if (count != len)
			count -= (count % maxpacket);

is true, which may be quite difficult to trigger.

Maybe we should make sure that maxpacket > 0 on the caller side, for e.g.

	/* qh makes control packets use qtd toggle; maybe switch it */
	if ((maxpacket & (this_qtd_len + (maxpacket - 1))) == 0)
		token ^= QTD_TOGGLE;

and

	if (usb_pipecontrol (urb->pipe)) {
		one_more = 1;
		token ^= 0x0100;	/* "in" <--> "out"  */
		token |= QTD_TOGGLE;	/* force DATA1 */
	} else if (usb_pipeout(urb->pipe)
			&& (urb->transfer_flags & URB_ZERO_PACKET)
			&& !(urb->transfer_buffer_length % maxpacket)) {
		one_more = 1;
	}

are expecting that maxpacket > 0 ?

