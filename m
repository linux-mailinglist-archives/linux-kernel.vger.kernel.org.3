Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6048CAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356109AbiALSKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356091AbiALSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:09:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87779C029821
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:08:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 537E6B82019
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD856C36AE5;
        Wed, 12 Jan 2022 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010925;
        bh=VlrEvxHO8qId8hO2mJ1A4YNsrSfUlCpbrxYUtTbPUss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=casDJNYZ+EmimQPGtXoxCj/EyHIV8HglReYvVT8MqQIdFnYyLCrGYJ7GWHem4U+sA
         fZFZcuRtdzxMRaQYly9tb+JynVW40KfDDz4ixyu2zM3Ei9h5vc3BhLk6CxVAsEKlxh
         NR4slFd69YHy6QGxoEstrwriSo7MlZHQVB3j69tKR2CtRChi2kswo1hg4n7qPTu809
         9DGHryht8+WRJcQ46stSyNDp6p1Lk8HEy6lx89aR1NlMxLv++9ssX0ZPwrX3bZpqXI
         sNK0xc4XWU08VDdXKwjG+UiLoqq9ywleO6/Ruy2W05pJpLYfn+QvMYdQzoDydb0HLY
         bcxJj0yIFDT3g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n7i39-00073g-JF; Wed, 12 Jan 2022 18:08:43 +0000
MIME-Version: 1.0
Date:   Wed, 12 Jan 2022 18:08:43 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
In-Reply-To: <9c3f9a6e-89b6-b73b-032f-e4b4ee6f72ac@omp.ru>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <87pmp7volh.wl-maz@kernel.org> <9c3f9a6e-89b6-b73b-032f-e4b4ee6f72ac@omp.ru>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <58caf8b54828bcc25cfc65220d29b68f@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: s.shtylyov@omp.ru, gregkh@linuxfoundation.org, rafael@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, geert@linux-m68k.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-12 17:53, Sergey Shtylyov wrote:
> On 1/4/22 12:26 PM, Marc Zyngier wrote:
> 
>> [Adding Geert]
>> 
>> On Sat, 06 Nov 2021 20:26:47 +0000,
>> Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>>> 
>>> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 
>>> is
>>> invalid") only calls WARN() when IRQ0 is about to be returned, 
>>> however
>>> using IRQ0 is considered invalid (according to Linus) outside the 
>>> arch/
>>> code where it's used by the i8253 drivers. Many driver subsystems 
>>> treat
>>> 0 specially (e.g. as an indication of the polling mode by libata), so
>>> the users of platform_get_irq[_byname]() in them would have to filter
>>> out IRQ0 explicitly and this (quite obviously) doesn't scale...
>>> Let's finally get this straight and return -EINVAL instead of IRQ0!
>>> 
>>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is 
>>> invalid")
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> 
>>> ---
>>> The patch is against the 'driver-core-linus' branch of Greg 
>>> Kroah-Hartman's
>>> 'driver-core.git' repo.
>>> 
>>>  drivers/base/platform.c |    6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>> 
>>> Index: driver-core/drivers/base/platform.c
>>> ===================================================================
>>> --- driver-core.orig/drivers/base/platform.c
>>> +++ driver-core/drivers/base/platform.c
>>> @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
>>>  out_not_found:
>>>  	ret = -ENXIO;
>>>  out:
>>> -	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>> +	if (WARN(!ret, "0 is an invalid IRQ number\n"))
>>> +		return -EINVAL;
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
>>> @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
>>> 
>>>  	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
>>>  	if (r) {
>>> -		WARN(r->start == 0, "0 is an invalid IRQ number\n");
>>> +		if (WARN(!r->start, "0 is an invalid IRQ number\n"))
>>> +			return -EINVAL;
>>>  		return r->start;
>>>  	}
>> 
>> Geert recently mentioned that a few architectures (such as sh?) still
>> use IRQ0 as something valid in limited cases.
>> 
>> From my PoV, this patch is fine, but please be prepared to fix things
>> in a couple of years when someone decides to boot a recent kernel on
>> their pet dinosaur. With that in mind:
>> 
>> Acked-by: Marc Zyngier <maz@kernel.org>
> 
>    Greg, so would that ACK be enough? Is there a chance this patch
> gets finally included
> into 5.17-rc1? Or should I look into fixing the recently found
> arch/sh/ issue 1st (as you
> can see, just WARN()'ing about IRQ0 wasn't enough to get this fixed)?

Fixing SH would be a good thing.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
