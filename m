Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12707507BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357984AbiDSVZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiDSVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:25:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230641FA6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:22:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650403370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eocecnDpptAC/EGkvzqxs0DwJFFc0p4YBknIOB3vi64=;
        b=I1NjPxxkkP36M3WKMWrL/IbeVkJTu6D1maHJ+VKQvBTxrbPzy3klZIdP3E6SNDKak+lLE/
        /YF5q4ELDCfdx1u1FGoZC5JaxF44/GvTqluec9GOh7z8zeA5pvRQMvx3S3nj5foHBMEclq
        oFNC7WmRtSl95sSQ2UVTUUkJrSv43+NJ/zQPoHp2OpE4cHu+8GHPQEhwhBiwAMEib1cW/M
        ZLgcZzbP2/825WaKXrs205LcNwmG/zkaIFmgpSzYdilJBb6WkmbEzMTyYXSamFDMxDTn2l
        FX/8fKepuaCnrxLyydnZBDDihcfGZj781XOAxFBHpOCcw200+YZKqiwA2T+7eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650403370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eocecnDpptAC/EGkvzqxs0DwJFFc0p4YBknIOB3vi64=;
        b=XjOXQo2w9NEOuqXXM80zQ2FdrnvXkCiAksTBHT634qb7gURY89A5+7Ywb6UMdbme33hUbz
        StsVoOh99VkZ8iCw==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is
 supported
In-Reply-To: <87ee1t9oka.ffs@tglx>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.713066297@linutronix.de>
 <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com> <87ee1t9oka.ffs@tglx>
Date:   Tue, 19 Apr 2022 23:22:49 +0200
Message-ID: <878rs0vkd2.ffs@tglx>
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

On Tue, Apr 19 2022 at 15:43, Thomas Gleixner wrote:
> On Thu, Apr 14 2022 at 10:24, Dave Hansen wrote:
>> On 4/4/22 05:11, Thomas Gleixner wrote:
>>> which is suboptimal. Prefetch works better when the access is linear. But
>>> what's worse is that PKRU can be located in a different page which
>>> obviously affects dTLB.
>>
>> The numbers don't lie, but I'm still surprised by this.  Was this in a
>> VM that isn't backed with large pages?  task_struct.thread.fpu is
>> kmem_cache_alloc()'d and is in the direct map, which should be 2M/1G
>> pages almost all the time.
>
> Hmm. Indeed, that's weird.
>
> That was bare metal and I just checked that this was a production config
> and not some weird debug muck which breaks large pages. I'll look deeper
> into that.

I can't find any reasonable explanation. The pages are definitely large
pages, so yes the dTLB miss count does not make sense, but it's
consistently faster and it's always the dTLB miss count which makes the
big difference according to perf.

For enhanced fun, I ran the lot on a AMD Zen3 machine and with the same
test case (hackbench -l 10000) repeated 10 times by perf stat this is
consistently slower than the non optimized variant. There is at least an
explanation for that. A tight loop of 1 Mio xgetbv(1) invocations takes
9 Mio cycles on a SKL-X and 50 Mio cycles on a AMD Zen3.

XSAVE is wonderful, isn't it?

Thanks,

        tglx
