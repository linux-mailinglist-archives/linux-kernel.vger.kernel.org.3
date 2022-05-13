Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F5525DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378178AbiEMI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbiEMI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:28:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662C65F27F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:28:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652430512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7avP9kQVE0MWtOQvN65Uv2IDjaisxjzLPFA4LnZXoE=;
        b=cdUDCSQRLQffppm8ZF6ZF1WA7yW+Swl/SYpZ9kiy/4AhT8lN5StoZZa/EoaE62Mhzhajjo
        HUsq0BiYFpWvr6kJV488ml8O35G7Woweu/2RBaEx8IE/fY1zaB4PwIcF2d/Kvbi1AeJDTu
        +fxktLsUvuk2ITMbcWp0RQOioO4q7qipwiyR3NGcGwQ68g3XRxPHUxs4aC2bSJSnFpZMHR
        /ukfHmvwhS9DM8PGXGlh2yXzo7uzFFsUaIGqwVLTLASsZElLwgo3IXet63LK5iZsfVP6+Q
        zlDEWU3MbLGBwytDaNcjg3TVmmKm8jD9r9kcLY/FY/meD6qAcLukJ8riStELkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652430512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7avP9kQVE0MWtOQvN65Uv2IDjaisxjzLPFA4LnZXoE=;
        b=hWvzcLujdLspE9h0n+Lla1LSNSBaq0PRD+NI1vhmkbZrGHZcq/aa1QvGgiAQWJOjXJMzPm
        Sh51ecK3LMC/WzBQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <ee786113-2173-b78b-774d-9d61d08b069b@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
 <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com> <878rr6te6b.ffs@tglx>
 <ee786113-2173-b78b-774d-9d61d08b069b@intel.com>
Date:   Fri, 13 May 2022 10:28:31 +0200
Message-ID: <875ym9u98w.ffs@tglx>
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

On Thu, May 12 2022 at 20:05, Dave Hansen wrote:

> On 5/12/22 18:27, Thomas Gleixner wrote:
>> On Thu, May 12 2022 at 17:46, Dave Hansen wrote:
>>> On 5/12/22 17:08, H.J. Lu wrote:
>>> If I had to take a shot at this today, I think I'd opt for:
>>>
>>> 	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);
>>>
>>> although I'm not super confident about the "fuzzy" flag.  I also don't
>>> think I'd totally hate the "blind" interface where the kernel just gets
>>> to pick unilaterally and takes zero input from userspace.
>> That's the only sane choice and you can make it simple for userspace:
>> 
>>        ret = prctl(GET_XXX_MASK, &mask);
>> 
>> and then let it decide based on @ret and @mask whether to use it or not.
>> 
>> But of course nobody thought about this as a generic feature and so we
>> have the ARM64 TBI muck as a precedence.
>
> Well, not quite *nobody*:
>
>  https://lore.kernel.org/linux-arm-kernel/7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com/

Sigh....
