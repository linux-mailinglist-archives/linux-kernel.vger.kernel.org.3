Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4326749F0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiA1Cbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiA1Cbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:31:47 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09436C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:31:47 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b22so4372658qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=5u2jhzSbci02DpL8YYcbGQRLZiKg87QxYq8u7qHJ9q4=;
        b=k+CMzbUW2NpYbVjuhjmSVirvpjKYpwBBGYvOOD7fqs6OwOWdT3uEVzuqRIJDTfW9EU
         BZh4Yy8lVJvdwaI0v7Xwjc9U7TC0NP/48na4FHtTWVK2jKRlpWMvY3IvXKZqeKAql4A0
         6S0XrtmGnRSSap25iyVYj8JdhQxE162urXriyAINPudsfO7Xa7eY/7vuvXLeQNlPR1ru
         WpOi1gAwKCdFf4gN0i2tHLMyJH6+Hd9r16yB6W6L31wjxQEaZ+RKs3PWr75c2XqtUNmQ
         ffq4DOhK0XFGWRCEQwe4QmhR1UaHVW3yIJW89At/1M0kAEmT5Uc6Jcmbe43Ljn0suf6d
         eGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=5u2jhzSbci02DpL8YYcbGQRLZiKg87QxYq8u7qHJ9q4=;
        b=K8O2hm+/N2zUGud8qo0qapzn1HM20A/oXEGVCgFXSwRV0pU5b7FqXmJxEMPbia4w60
         wrW0QB5WuD4i0PJy9NeknhqWxVOrFpGh827d3nZRZByZiFVLHLIPQWZUl3ZVT95ZElzt
         9nGYf/3wa3hF9pBapqf5yOe1z3vVjcAitQRl60O/rip8L36Sxen3Q2bdUbChgpCkotfx
         AFMl8Y7W0WTm9dPB5sPIb4eSTDkn4D4QLjj7+qrZBrxP7ZklSgCPqA4gE0eG+tqMFKfa
         Rx3RQ5q+RU/TB777StYjM27EBndYX8bPFH++p3AvTeZgfKePgtAIGUGsEpdKL+hI22zv
         Z9xQ==
X-Gm-Message-State: AOAM533BlcA1dr3t2bG5F24lqgzSr8+fQ8Bvqr8t1Xrfh1RjsMvzGe/d
        L3Q7alqXzu7OjC2MfNoRLic=
X-Google-Smtp-Source: ABdhPJyO95xPseqHxFw59OvWUfHS8aZwDZkQFNWL5W7osk2CvOn1CX1Y/27eooB14xz418xa9vcZzg==
X-Received: by 2002:a37:660a:: with SMTP id a10mr4664131qkc.506.1643337106234;
        Thu, 27 Jan 2022 18:31:46 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i4sm641272qkn.13.2022.01.27.18.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:31:45 -0800 (PST)
Message-ID: <61f35591.1c69fb81.48dad.3244@mx.google.com>
X-Google-Original-Message-ID: <20220128023142.GA1205335@cgel.zte@gmail.com>
Date:   Fri, 28 Jan 2022 02:31:42 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
 <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
 <YegK7+oKFG8EPRp9@cmpxchg.org>
 <61ea820f.1c69fb81.e79d5.09c9@mx.google.com>
 <YfNG5KAog6fI0kYu@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfNG5KAog6fI0kYu@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:29:08PM -0500, Johannes Weiner wrote:
> On Fri, Jan 21, 2022 at 09:51:08AM +0000, CGEL wrote:
> >  Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> > > On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > > > I did a test, when we use zram, it takes longer time for ksm copying than
> > > > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > > > average takes 55639ns. So I think this patch is reasonable.
> > > 
> > > Ok, that sounds reasonable to me as well. Please add the
> > > PageWorkingset() check and resubmit the patch. Thanks!
> > I am a litte confused about adding PageWorkingset(), since I
> > think ksm_might_need_to_copy() memstall is like swap_readpage()
> > memstall and swap_readpage() doesn't add PageWorkingset().
> 
> That's actually a bug! It should do that.
I recently found that too. Please CC to me your new patch, thanks!
And I will send V2 of this patch "psi: Treat ksm swapping in copy
as memstall" with PageWorkingset().

> That psi_memstall_enter() in swap_readpage() was added by commit
> 937790699be9c8100e5358625e7dfa8b32bd33f2. It's for catching the
> scenarios that don't go through submit_bio(). When you look at
> submit_bio(), it counts stalls only if we have workingset pages:
> 
> 	/*
> 	 * If we're reading data that is part of the userspace workingset, count
> 	 * submission time as memory stall.  When the device is congested, or
> 	 * the submitting cgroup IO-throttled, submission can be a significant
> 	 * part of overall IO time.
> 	 */
> 	if (unlikely(bio_op(bio) == REQ_OP_READ &&
> 	    bio_flagged(bio, BIO_WORKINGSET))) {
> 		unsigned long pflags;
> 
> 		psi_memstall_enter(&pflags);
> 		submit_bio_noacct(bio);
> 		psi_memstall_leave(&pflags);
> 		return;
> 	}
> 
> I hope that clarifies it. I'll send a patch to fix up swap_readpage().
> 
> Thanks
