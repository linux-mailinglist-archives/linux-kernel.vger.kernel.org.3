Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B549F08B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbiA1B3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbiA1B3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:29:11 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF055C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:29:10 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id m25so3356729qka.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MuhFyXxprlDzjgBfY4SUp98IZlrtgh5jEf/cbf1kqw=;
        b=SyRFp09HmzHalG1FIA+Fq+Hm+swq2ZzFLKUzeWnAOCLCwcjL9jz5WesrXWl+yQjzC7
         xcFJi4t6RsjuVSnyRAYfIFwyi1RXMTrJ8GCnBoNC4SODOMus7j1CzeMq2HGXZaY73S5b
         Ezhq/ds9Neu8/0yeP5AGbG7Rd8csPnvqxw0csvT4fed2/tJx6zMeJefIcONm3e5gp11q
         l9g7yL0OUgqwPIE0lTJ0qSu3J8rByX9LtADn4dQL/9E+lOoe9gt4l5n/XHa+cLRlneZ2
         cCIyptq51gFTUE4bzhit8hMr1TLWoLRs9Cvd7KXKyQCO3bOqEStZluREe6oBu7A7y2uT
         +TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MuhFyXxprlDzjgBfY4SUp98IZlrtgh5jEf/cbf1kqw=;
        b=QauIi5m0cIjXKSWnaQigHkhkqke9RZF+NkZkWjIVctJobMEKCpwWs5eETpYzfujr3V
         Ky3qewMJJaI2QQb8CiKqNWIRRk7Qdm7BNUaj8SyEPQ9eDq0EVNBCgmc6nkqUSBgjWlJO
         9JhZv/j9APipXMM3cXrGjhXvf9ItOzQY78iR/saovUZefxyhFpkUIS1kuesddHctiHuQ
         n7LRZZyZu4bTcGNg4Ai0sTvzBka5g1yhNA9SNMtRnS8m0jDnR40xyPi3rp7FOFWJ2ElA
         5JSTZo/nURMg3fHrUaSsQ1MSUYj8Gz1VTBio89R3yPs4CNaXZw/yKq++qtNNxtlfw8tU
         FgFA==
X-Gm-Message-State: AOAM5303tPKt0xnhygZTZutYr3S+fF0GzB8bok8IabI3W3YKsNQ9fuQv
        Td3Q/OWfAjzVSzqdwFJc5F4PfM0UbgWDeA==
X-Google-Smtp-Source: ABdhPJyPu3XYPF6AF1OinsqUVUgQwg3b9qlZ1mnjDyW1GpEVQP3XP4y+uJNwGdRbklmNZ5JU8ZKY5A==
X-Received: by 2002:a05:620a:248b:: with SMTP id i11mr4522385qkn.431.1643333350045;
        Thu, 27 Jan 2022 17:29:10 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bm23sm2372608qkb.25.2022.01.27.17.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 17:29:09 -0800 (PST)
Date:   Thu, 27 Jan 2022 20:29:08 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
Message-ID: <YfNG5KAog6fI0kYu@cmpxchg.org>
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
 <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
 <YegK7+oKFG8EPRp9@cmpxchg.org>
 <61ea820f.1c69fb81.e79d5.09c9@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ea820f.1c69fb81.e79d5.09c9@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:51:08AM +0000, CGEL wrote:
>  Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> > On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > > I did a test, when we use zram, it takes longer time for ksm copying than
> > > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > > average takes 55639ns. So I think this patch is reasonable.
> > 
> > Ok, that sounds reasonable to me as well. Please add the
> > PageWorkingset() check and resubmit the patch. Thanks!
> I am a litte confused about adding PageWorkingset(), since I
> think ksm_might_need_to_copy() memstall is like swap_readpage()
> memstall and swap_readpage() doesn't add PageWorkingset().

That's actually a bug! It should do that.

That psi_memstall_enter() in swap_readpage() was added by commit
937790699be9c8100e5358625e7dfa8b32bd33f2. It's for catching the
scenarios that don't go through submit_bio(). When you look at
submit_bio(), it counts stalls only if we have workingset pages:

	/*
	 * If we're reading data that is part of the userspace workingset, count
	 * submission time as memory stall.  When the device is congested, or
	 * the submitting cgroup IO-throttled, submission can be a significant
	 * part of overall IO time.
	 */
	if (unlikely(bio_op(bio) == REQ_OP_READ &&
	    bio_flagged(bio, BIO_WORKINGSET))) {
		unsigned long pflags;

		psi_memstall_enter(&pflags);
		submit_bio_noacct(bio);
		psi_memstall_leave(&pflags);
		return;
	}

I hope that clarifies it. I'll send a patch to fix up swap_readpage().

Thanks
