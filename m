Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC72525700
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358657AbiELVYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiELVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:24:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB1C270CAC
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:24:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652390667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0oZd+Y8woJ6fFGZxNFZTKswF93ZoW1CaLUWFySAj0A=;
        b=nAdjWvTjYBrTDrCyGJfRXhhyjrSHLW4CZ3GF6Yf71+/cg6pHseaIqb2GEGB3ZTITjBCV3u
        u+nwms1rNvpSQF7UZibEepc2avbvdv7x4sOPQiFC90ll+IiVTbkjr5oIZ6fd+YcyKpJloq
        aq2qtwU+mWMU8dxGt3OBGwzQrR50UoV8DmBKcTRbu6jwXRwrfdsAD9dJGnqlEimpTaK4vS
        Z9fNxHovZSvpr7qUs4/KZFSsGdavGsKTd21O54MLx9/0MrdSVqQB5sTxiL1lirVtW/U/ae
        OtFuPPBdRI/JJAfFoi6Umj7JSK2wiKLktQJpLw0ir8nsNZbCBiuQhzOi9V8hvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652390667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0oZd+Y8woJ6fFGZxNFZTKswF93ZoW1CaLUWFySAj0A=;
        b=mc+PbD5GUeDJd5gRo1q9/E9BiRbr+vlIeXqnLZGcFbpz8umfAIgSRpndoFcOjBunDCmkPE
        PBx7GjFwxgTG2OAg==
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
In-Reply-To: <875ymav8ul.ffs@tglx>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
Date:   Thu, 12 May 2022 23:24:27 +0200
Message-ID: <87zgjmtpf8.ffs@tglx>
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

On Thu, May 12 2022 at 21:39, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 10:22, Dave Hansen wrote:
>> One of the stated reasons for adding LAM hardware is that folks want to
>> use sanitizers outside of debugging environments.  To me, that means
>> that LAM is something that the same binary might run with or without.
>
> On/off yes, but is there an actual use case where such a mechanism would
> at start time dynamically chose the number of bits?

This would need cooperation from the application because it has to tell
the magic facility whether it intends to utilize the large VA space on a
5-level paging system or not.

I have no idea how that is supposed to work, but what do I know about
magic.

>> It's totally fine with me if the kernel only initially supports LAM_U57.
>>  But, I'd ideally like to make sure that the ABI can support LAM_U57,
>> LAM_U48, AMD's UAI (in whatever form it settles), or other masks.
>
> Sure. No argument here.

Assumed that the acronym of the day, which uses this, has a real benefit
from the larger number of bits, we can support it.

But we are not going to make this a per thread selectable thing.

It's a process wide decision at startup simply because it does no buy
thread A anything to select U57 if thread B selects U48 before thread A
was able to map something into the U48 covered address space. Same issue
the other way round as then B has to fallback to U57 or NONE. That does
not make any sense at all.

I'm all for flexible, but not just because we can. It has to make sense.

Making it process wide and once on startup puts the 'complexity' into
the prctl(), but keeps the runtime overhead as small as it gets:

  - CR3 switching needs just the | mm->lam_cr3_mask

  - untagging one of the uglies Peter and I came up with

Making U48/U57 hardcoded would not buy much.

Thanks,

        tglx



