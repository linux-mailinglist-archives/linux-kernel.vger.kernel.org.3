Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFF52700E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiENIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiENIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 04:37:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B121AD
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 01:37:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652517475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6e1jTkAbidYEYkvtAlwySzul8HD/CSNOuCA4PYjeMA=;
        b=GqntqGTEYbeXboqHBKQtbKbNZor6WVvmvezaJ9tHWBUr5KzMyrNdMMDfnYFs7ydZeqfBqF
        uz5jOfOiRiRTXQu6xWsgm9xqxxsDFJLPfJD4Bsd5fX4jhAWXpZvHLelYrQ56Q9oL5NA4j2
        4mR+2vREQALY3cLjbEjXWFX8XMmDyP1xcaIGPqgtXn+wIPa12xFxccGe/JNaXtsD+IX2zI
        UoahGfHQFN1A9YgqYQw56u4/Z+1KBRdVax0hRuwfXzKaXm+rt1AzJMBVui+P3gDsW9DqnW
        49JEkXxKPdQmoER1Tif0JRzez4tefe16yvFnjttzRw3bZrRDoe5agsIVraEzzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652517475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6e1jTkAbidYEYkvtAlwySzul8HD/CSNOuCA4PYjeMA=;
        b=7S01T5JIx2GvRHvdFB0JVC0zNy9JSJDffIBBolmfNTszaX9PlAuHsIiStajOqQTkImV4VY
        Mj/sry6jcYL77ZAw==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 08/10] x86/mm: Make LAM_U48 and mappings above 47-bits
 mutually exclusive
In-Reply-To: <20220513232242.7ac7herw7iyfkd2h@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
 <875ymax480.ffs@tglx> <20220513232242.7ac7herw7iyfkd2h@black.fi.intel.com>
Date:   Sat, 14 May 2022 10:37:55 +0200
Message-ID: <87h75sse58.ffs@tglx>
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

On Sat, May 14 2022 at 02:22, Kirill A. Shutemov wrote:

> On Thu, May 12, 2022 at 03:36:31PM +0200, Thomas Gleixner wrote:
>> On Wed, May 11 2022 at 05:27, Kirill A. Shutemov wrote:
>> > LAM_U48 steals bits above 47-bit for tags and makes it impossible for
>> > userspace to use full address space on 5-level paging machine.
>> 
>> > Make these features mutually exclusive: whichever gets enabled first
>> > blocks the othe one.
>> 
>> So this patch prevents a mapping above 47bit when LAM48 is enabled, but
>> I fail to spot how an already existing mapping above 47bit would prevent
>> LAM48 from being enabled.
>> 
>> Maybe I'm missing something which makes this magically mutually
>> exclusive.
>
> It is in 09/10. See lam_u48_allowed()

Sure, but that makes this changelog not any more correct.
