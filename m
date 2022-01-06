Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6B486B98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiAFVFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:05:42 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:50348 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiAFVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RjinO8IcnDpJH9TEhia5kvOwgPh5fe8QqWyiQwb8cvs=; b=sBFtvIF22PUjiVd/XPbex2QJQ5
        MRs0oYEzTOjyNJQZCln6UYBHHYd9T0RsH4LLYSf9T09nKu8sYU/by3yzsKjsrpJ/1RwCuK+vddmR0
        IS9CMOrz3qWAIGsbG+b6Xb9i6w/dA1VgVoJWD0JXYi2n23dWR6VHMRdQY2HGnl/32cIAUesVVq9KM
        XNgK53P9NaMD2a0xL2tB4dYO7T5YWgE0LSmnZ7p7+xTyF5mj4QjWOHIuPxItYyicCyCSsptaY9753
        8aYDdL5XEH+VYDxUmR9i4zARuz7Dsc4InRLBYaDi2kZszBQ14SVwFmu5Y2dEmcN5zDCY1v6wFU1ON
        s+yaYRkg==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n5Zws-000BUL-D4; Thu, 06 Jan 2022 22:05:26 +0100
Subject: Re: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
References: <20220106200007.112357-1-gpiccoli@igalia.com>
 <YddQOFye7Rhr9NDl@rowland.harvard.edu>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <4e416d20-13f2-25ea-6ff7-b8c0c1818eac@igalia.com>
Date:   Thu, 6 Jan 2022 18:05:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YddQOFye7Rhr9NDl@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 17:25, Alan Stern wrote:
> [...]
>> +	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
>> +		if (!is_panic_notifier_filtered(n))
>> +			goto panic_filtered_out;
> 
> Forget the unlikely(); this is not a hot path.
> 

Thanks for the review Alan! Sure, I can remove that in the V3 - good point.


>> +
>>  	ret = notifier_chain_register(&nh->head, n);
>> +
>> +panic_filtered_out:
>>  	spin_unlock_irqrestore(&nh->lock, flags);
>>  	return ret;
>>  }
> 
> It would be simpler to do:
> 
> 	if (!(nh == &panic_notifier_list && panic_nf_count > 0 &&
> 			is_panic_notifier_filtered(n)))
> 		ret = notifier_chain_register(&nh->head, n);
> 
> If there were special-purpose functions just for registering and 
> unregistering callbacks on the panic_notifier_list, the design would be 
> cleaner (no need to modify core notifier code).  But making that change 
> would mean altering a lot of call sites.  :-(
> 

Good suggestion, I'll change the code with your suggestion in the V3.

And I agree, I considered something like that when writing this "hijack"
into core code just for the sake of panic notifier filtering...
I'm not sure though it worth the effort and code addition, to change all
the call sites and add a special register mechanism to the panic
notifier only. Let's see what the others think...

Cheers,


Guilherme


>> @@ -162,10 +194,16 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
>>  		struct notifier_block *n)
>>  {
>>  	unsigned long flags;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	spin_lock_irqsave(&nh->lock, flags);
>> +	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
>> +		if (!is_panic_notifier_filtered(n))
>> +			goto panic_filtered_out;
>> +
>>  	ret = notifier_chain_unregister(&nh->head, n);
>> +
>> +panic_filtered_out:
> 
> Same idea here.
> 
> Alan Stern
> 
