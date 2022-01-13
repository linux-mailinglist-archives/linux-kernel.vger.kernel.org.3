Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21C48DF90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiAMV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiAMV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:27:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F8EC061574;
        Thu, 13 Jan 2022 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ayS3prurjAu/ZPuhb/qI34CN7+Mgs9bDXWUscUrqSMk=; b=ZJ7Hm/hT9j+Jgq31XRQ8PdnWLQ
        zlxQMkNuR1Yap1HH9DQx0bri7HCa/TsoTd6cu02X5haj7+F2a8Qa64M5CfJByBeEib0E0IMqkhKkh
        ZA6EnQAuIGSjDim9BgQoBeLQ8B8DPHdXxQ/VSD9ZHOjvU5ctmy6cl/cC+LJPW4iOXTn8zpeFdpCoC
        uwOM83bQNnyW58yosvLtJMCQ+DLHwqxWaY4LSsXvCAo0Nedssw7tmsl9EvFQFsLCyU3piMNauliTF
        k3/3oLN/RtVEQGC1PT4d58GR6Peh60T/uznSKPHSXDPYTmvV+yM1j1Hl4l0WWRpcJsXeVzlpRrSI5
        sW5Jrziw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n87cT-0011Xg-JH; Thu, 13 Jan 2022 21:26:53 +0000
Message-ID: <24d83e9c-a4d5-176b-1ff3-909d0ad56302@infradead.org>
Date:   Thu, 13 Jan 2022 13:26:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: Tree for Jan 13 (UBSAN: invalid-load in
 ../mm/swap.c:996:11)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220113152247.3f7c6c49@canb.auug.org.au>
 <56c04e36-ff53-10c7-34dd-1c1385639de6@infradead.org>
 <YeCP8Kh+4y7NR1K+@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YeCP8Kh+4y7NR1K+@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/22 12:47, Matthew Wilcox wrote:
> On Thu, Jan 13, 2022 at 12:12:52PM -0800, Randy Dunlap wrote:
>> [    1.561983] UBSAN: invalid-load in ../mm/swap.c:996:11
>> [    1.561986] load of value 221 is not a valid value for type '_Bool'
> 
> Ooh.  This one's mine.  Randy, does it repeat easily?  This should
> fix it:

Yes, 100% of the time (for N = 3).

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Fixed 100% of the time (for N = 3).

Thanks.

> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index dda8d5868c81..67b1246f136b 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -111,6 +111,7 @@ static_assert(offsetof(struct pagevec, pages) ==
>  static inline void folio_batch_init(struct folio_batch *fbatch)
>  {
>  	fbatch->nr = 0;
> +	fbatch->percpu_pvec_drained = false;
>  }
>  
>  static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
> 


-- 
~Randy
