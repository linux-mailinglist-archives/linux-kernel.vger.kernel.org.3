Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8502525109
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355825AbiELPQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355867AbiELPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:16:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9C20F58
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:16:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652368572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grsC0w+E9Jfgx2nf3sde57yzh3ij8Mi1ObW9I0pQcXg=;
        b=QP9d2vJHTocBeVJGSXckP+GiDE7SnKW6S8OcPZe9+uq845NpdBDnLqssIS2OsTgDSmHBxu
        AM9gkU2DIL5w5tw42R/cVp6oWGGpHN7Y3//rkCDvlhoII9OBk25WB2mjb6hgVJhKFEavMv
        estScOX8SotUNTYuZs2TsWMf6TMSblYYqjWkLQhxN0Wk2FL1qsrqNp8xz3bFrS/WjlwMc0
        USLLNJTNsNGxf9qcoD930NiRt/dohlPDR462wfK+abm/5ZLP6Ft/dLWIbRG3TS0fgGCtJc
        OYFtUFXKa+AOGS/3I7sLz8OjK2M4wb8iYnGqMT5nIo+8JiMOk+aI0riolxJyHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652368572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grsC0w+E9Jfgx2nf3sde57yzh3ij8Mi1ObW9I0pQcXg=;
        b=iuRZSkwtyMK+lJI9aS6Ba4q73+eZ+FZGunSKYXQB3nHdm4GEmHTNOE/mVJ/PcUpfsVKJac
        V4fUVoxCgKjP7GAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
In-Reply-To: <Yn0YdPNG/Q3lf+4G@hirez.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
 <87a6bmx5lt.ffs@tglx> <Yn0YdPNG/Q3lf+4G@hirez.programming.kicks-ass.net>
Date:   Thu, 12 May 2022 17:16:11 +0200
Message-ID: <87sfpevl1g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12 2022 at 16:23, Peter Zijlstra wrote:
> On Thu, May 12, 2022 at 03:06:38PM +0200, Thomas Gleixner wrote:
>
>> #define untagged_addr(addr)	({			\
>> 	u64 __addr = (__force u64)(addr);		\
>> 							\
>> 	__addr &= current->thread.lam_untag_mask;	\
>> 	(__force __typeof__(addr))__addr;		\
>> })
>> 
>> No conditionals, fast _and_ correct. Setting this untag mask up once
>> when LAM is enabled is not rocket science.
>
> But that goes wrong if someone ever wants to untag a kernel address and
> not use the result for access_ok().
>
> I'd feel better about something like:
>
> 	s64 __addr = (addr);
> 	s64 __sign = __addr;
>
> 	__sign >>= 63;
> 	__sign &= lam_untag_mask;

that needs to be

 	__sign &= ~lam_untag_mask;

> 	__addr &= lam_untag_mask;
> 	__addr |= __sign;
>
> 	__addr;
>
> Which simply extends bit 63 downwards -- although possibly there's an
> easier way to do that, this is pretty gross.

For the price of a conditional:

    __addr &= lam_untag_mask;
    if (__addr & BIT(63))
        __addr |= ~lam_untag_mask;

Now you have the choice between gross and ugly.

Thanks,

        tglx
