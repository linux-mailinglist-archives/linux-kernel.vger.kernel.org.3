Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D615255E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358138AbiELTjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358142AbiELTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:39:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABB27A8B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:39:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652384371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUz/BjKKRmAHMrmDYPctuxo3Uvh/hIwMWxZ45+KcIM8=;
        b=DLIGD7nk/KRxYOD4MQIE9L5MM3/IryL1Q1VlmffS9cBtZXDvty2I6GR64wKr4JdtdrQ7Em
        V1zsOLF9FphUbcPjweUlBWgwVtGjbvYk3Ohh28gtBgWoJaWFLYw5e4NMclzaG7fnmDkpQ2
        8KGPWhZ600aRFrKf1ElqqXmRStvAOXm8B0/I64cm88tocAPzPBUUEhtg1sdOjAkA+L+BT+
        JoVR8gbChuUtLNuHPP5xJxa4ScXbQSR6vRgGSpvGyUp+LQ9Qjps/zPVNxTbt1h3SXCvaY6
        pKfZ4uEuoiWAIbsmGuJ9xz7jd2Z1f83z5tP9/lmds1b6lAX2EAK/w6YyasGzFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652384371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUz/BjKKRmAHMrmDYPctuxo3Uvh/hIwMWxZ45+KcIM8=;
        b=F2+NdbtVyvY2xUHVu+eCjUsArIm5thXcsqqKvl0/k2KMT9Fl7EaeoXFThWoUXmB0A3pYPY
        xju0rp8Vh2RSElCw==
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
Date:   Thu, 12 May 2022 21:39:30 +0200
Message-ID: <875ymav8ul.ffs@tglx>
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

On Thu, May 12 2022 at 10:22, Dave Hansen wrote:

> On 5/10/22 23:49, Peter Zijlstra wrote:
>>> The feature competes for bits with 5-level paging: LAM_U48 makes it
>>> impossible to map anything about 47-bits. The patchset made these
>>> capability mutually exclusive: whatever used first wins. LAM_U57 can be
>>> combined with mappings above 47-bits.
>> So aren't we creating a problem with LAM_U48 where programs relying on
>> it are of limited sustainability?
>
> I think allowing apps to say, "It's LAM_U48 or bust!" is a mistake.

That'd be outright stupid.

> It's OK for a debugging build that runs on one kind of hardware.  But,
> if we want LAM-using binaries to be portable, we have to do something
> different.
>
> One of the stated reasons for adding LAM hardware is that folks want to
> use sanitizers outside of debugging environments.  To me, that means
> that LAM is something that the same binary might run with or without.

On/off yes, but is there an actual use case where such a mechanism would
at start time dynamically chose the number of bits?

> It's totally fine with me if the kernel only initially supports LAM_U57.
>  But, I'd ideally like to make sure that the ABI can support LAM_U57,
> LAM_U48, AMD's UAI (in whatever form it settles), or other masks.

Sure. No argument here.

Thanks,

        tglx
