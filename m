Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E146485A92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiAEVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:23:46 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:52580 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbiAEVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:23:41 -0500
Received: from [192.168.1.18] ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5Dkonz8rwBazo5Dkon0Nlo; Wed, 05 Jan 2022 22:23:40 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 05 Jan 2022 22:23:40 +0100
X-ME-IP: 90.11.185.88
Message-ID: <bc95636a-8b67-b0cd-dc18-b21ac4b83962@wanadoo.fr>
Date:   Wed, 5 Jan 2022 22:23:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] alpha: Remove usage of the deprecated "pci-dma-compat.h"
 API
Content-Language: en-GB
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        martin.oliveira@eideticom.com, alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <0b8bacb36e111d2621c2c0459b20b1da9f4375c0.1641137463.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a2XwFveAd8nSCexZG3_UZga2PQ+EXHxQLGaWkLjCwrBxQ@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAK8P3a2XwFveAd8nSCexZG3_UZga2PQ+EXHxQLGaWkLjCwrBxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/01/2022 à 02:51, Arnd Bergmann a écrit :
> On Sun, Jan 2, 2022 at 10:32 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> In [1], Christoph Hellwig has proposed to remove the wrappers in
>> include/linux/pci-dma-compat.h.
>>
>> Some reasons why this API should be removed have been given by Julia
>> Lawall in [2].
>>
>> A coccinelle script has been used to perform the needed transformation.
>> Only relevant parts are given below.
>>
>>
>> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
>> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> It looks like the number of remaining files that use the old
> interfaces has gone down
> a lot more since you last sent these patches. I would suggest you send them as a
> series that includes the patch to remove the header as the last change, and
> ask Andrew to pick up the ones that remain after this resend into the -mm tree,
> possibly after the next -rc1. How many patches do you have left?
> 
>           Arnd
> 

Hi,

This would be ~ 10 patches.
I sent recently some missing ones because I was not aware of 
--include-headers. So .h files were missing in my previous patches.


The main remaining issue is linked to files in message/fusion.
The patches are big.
They have to be looked at carefully because it touches some GFP flags 
when s/pci_alloc_consistent/dma_alloc_coherent/.

My last try did not get any attention.
Even [1] which is purely mechanical

I'll try another approach without trying to turn some (hidden) 
GFP_ATOMIC into GFP_KERNEL.
1st patch: only mechanical changes done with coccinelle, leaving GFP_ATOMIC
2nd patch: add some FIXME comments explaining why some could be turned 
into GFP_KERNEL
3rd patch: remove the comments and update the GFP flags accordingly.

So, a maintainer could either apply 1 (no risk at all, should even 
generate the same .o file), or 1+2 (only FIXME comments for future 
analysis) or 1+2+3 for full clean-up (if he trusts me and/or has time to 
check my explanations).

This way, I hope that some could at least apply the first one.


Being able to axe this deprecated API and .h file would be my 
contribution to Ingo Molnar's "Fast Kernel Headers" tree :)

CJ

[1]: 
https://lore.kernel.org/kernel-janitors/db5aa78d7d44b809ab83ba6fb4880d698517bfec.1623580326.git.christophe.jaillet@wanadoo.fr/
