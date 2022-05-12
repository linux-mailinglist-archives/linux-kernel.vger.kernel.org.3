Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685025255BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358046AbiELTba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358038AbiELTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:31:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCB3BBC8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:31:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652383882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGtrQksjQfamBywCmnK7pPuFj4WwCjQmxlrTTj3S/6I=;
        b=1T8MYAwPo2BEm/6WmMHLKCbQY3p/N6rOZLdz3iI4vaCMn8SA7CLKFECG9eIE+7gOpqhtq/
        CaILNXJySrPfWNjAViBxh5vkMssMmhwsFL3Kp9fXPhwG3f/KBLUHBL2Empa6yJ5AwS5PUf
        Wz1wU8NADjeRlzrsLDpjAM7ZQGYwBdj8knj/SZmnjtdZb+JhTtKpKLKxENV1tTySs0iQAC
        uyCBRZg1Jkga0NA5a7AnSlYbAYyuaELHKoFFKKgNFk94XvqlhJKPSEvD8ck/qS9kcxdwE1
        ADCkse3eItboihLHZwQjgBx2NnbvSkomFr7RB54CQCX8Q2X6hzNwnuC6FHJjEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652383882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGtrQksjQfamBywCmnK7pPuFj4WwCjQmxlrTTj3S/6I=;
        b=ZBiQRbX7ElsW/WoC766JtZsjlIY4BrgDJBq/ChyizEXD64Qh1JWjnOli+d7aHN2ZxjqRYq
        FfbBeDw3SZHDZ0Aw==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <20220512165612.gizedzgtpzbi7jbl@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <87pmkivjst.ffs@tglx> <20220512165612.gizedzgtpzbi7jbl@black.fi.intel.com>
Date:   Thu, 12 May 2022 21:31:22 +0200
Message-ID: <878rr6v985.ffs@tglx>
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

On Thu, May 12 2022 at 19:56, Kirill A. Shutemov wrote:
> On Thu, May 12, 2022 at 05:42:58PM +0200, Thomas Gleixner wrote:
>> On Wed, May 11 2022 at 08:49, Peter Zijlstra wrote:
>> > On Wed, May 11, 2022 at 05:27:40AM +0300, Kirill A. Shutemov wrote:
>> > So aren't we creating a problem with LAM_U48 where programs relying on
>> > it are of limited sustainability?
>> >
>> > Any such program simply *cannot* run on 5 level pagetables. Why do we
>> > want to do this?
>> 
>> More bits are better :)
>> 
>> Seriously, I agree that restricting it to LAM57, which gives us 6 bits,
>> makes a lot of sense _and_ makes the whole thing way simpler.
>> 
>> So supporting both needs a truly good justification and a real world use
>> case.
>
> I asked the question before[1]. Basically, more bits more better:
>
> 	For HWASAN #bits == detection probability.
> 	For MarkUS #bits == exponential cost reduction

What is MarkUS? It's not really helpful to provide acronyms which are
not decodable.

> I would really like to have only LAM_U57, but IIUC 6 bits is not always
> enough.
>
> Dmitry, could you elaborate?
>
> [1] https://mobile.twitter.com/dvyukov/status/1342019823400837120

I don't know whether he reacts on posting a link to his twitter
account. I've CC'ed him now. Maybe that works better.

Thanks,

        tglx
