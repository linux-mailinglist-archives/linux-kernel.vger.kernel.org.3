Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500CA473141
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbhLMQHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:07:51 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:36386 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbhLMQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:07:49 -0500
Received: from [167.98.27.226] (helo=[10.35.4.115])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1mwnrg-0002E3-2U; Mon, 13 Dec 2021 16:07:48 +0000
Message-ID: <7d39d3af-ced8-13cd-bfd0-3a84d96992fa@codethink.co.uk>
Date:   Mon, 13 Dec 2021 16:07:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] irqdomain: check irq mapping against domain size
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20211105090601.243416-1-ben.dooks@codethink.co.uk>
 <87y262953h.wl-maz@kernel.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <87y262953h.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2021 12:09, Marc Zyngier wrote:
> Hi Ben,
> 
> On Fri, 05 Nov 2021 09:06:01 +0000,
> Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> The irq translate code does not check the irq number against
>> the maximum a domain can handle. This can cause an OOPS if
>> the firmware data has been damaged in any way. Check the intspec
>> or fwdata against the irqdomain and return -EINVAL if over.
>>
>> This is the result of bug somewhere in the boot of a SiFive Unmatched
>> board where the 5th argument of the pcie node is being damaged which
>> causes an OOPS in the startup code.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   kernel/irq/irqdomain.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 6284443b87ec..e61397420723 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -906,6 +906,8 @@ int irq_domain_xlate_onecell(struct irq_domain *d, struct device_node *ctrlr,
>>   {
>>   	if (WARN_ON(intsize < 1))
>>   		return -EINVAL;
>> +	if (WARN_ON(intspec[0] > d->hwirq_max))
>> +		return -EINVAL;
> 
> This doesn't seem right.
> 
> For a start, d->hwirq_max is 0 when the domain is backed by a radix
> tree. Also, nothing says that what you read from the DT is something
> that should be directly meaningful to the irqdomain. A driver could
> well call into this and perform some extra processing on the data
> before it lands into the irqdomain.

Thanks, didn't know that.

would doing:

+	if (WARN_ON(d->hwirq_max && intspec[0] > d->hwirq_max))
+		return -EINVAL;

be acceptable?

> In general, this looks like DT validation code, and I'm not keen on
> that in the core code.

I thought the core was probably the only place to do this, I didn't
think the DT code would know about the hardware capabilities of the
DT controller.

It seems bad that some corrupted data can just crash the kernel in
a non-recoverable and early way that requires some specific debug
features like early-printk enabled. Would anyone else have a way of
fixing this?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
