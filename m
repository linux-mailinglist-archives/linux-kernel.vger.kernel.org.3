Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127D851DCBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443314AbiEFQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392246AbiEFQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:05:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104CD2F005;
        Fri,  6 May 2022 09:01:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651852889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJBPtOUuNGrHC5/SIZntmXtYnpjE0lXfTrqYkqCo5pQ=;
        b=CBRYzpdKZZWT8ytV6rdLyCTJAwiIN2rDkMGzmpPv6H/tLdWpFMd0OVu51xFn2g+pD0JXff
        nn9WCQx/GgXK4oaq3X7ULoHpGW0qtqJS/meB2ZCxtbkYbiXeru1XCrcqzJXOMTiaLtx78I
        DhLroSR+vkZsqD7zlSvvm2j236SioBZu+QS0eeJB5nfPZ6BiGkjxvNdXGMBO/RanCr7iKa
        35Tx4Eig/PIVdZ4o1vXWx0YQhY1usKFh4bOyQXHJn5tnTiq3JNNTNnlMUIWkIcJdJ+qAAn
        cyFSF54QcGwIuSHnDq7xRaCTkb6ysRFJ/SWrCNOmYirRbgWiqF6PCJHBFUEsGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651852889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJBPtOUuNGrHC5/SIZntmXtYnpjE0lXfTrqYkqCo5pQ=;
        b=AXBihZhZn5hV8VcQ9uLilDw48pxRojGFGEGM7trGpG072E3p97DGWqIo6FNwOcqlKrzLrW
        ZOOhrNn/8XuZybCQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-crypto@vger.kernel.org, nathan@kernel.org
Subject: Re: [timekeeping]  3aeaac747d: PANIC:early_exception
In-Reply-To: <YnT0dDFtq7HnRC7n@zx2c4.com>
References: <20220506032023.GA23061@xsang-OptiPlex-9020>
 <8735hnhz1q.ffs@tglx> <YnT0dDFtq7HnRC7n@zx2c4.com>
Date:   Fri, 06 May 2022 18:01:29 +0200
Message-ID: <87o80ahcpy.ffs@tglx>
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

On Fri, May 06 2022 at 12:12, Jason A. Donenfeld wrote:
> On Fri, May 06, 2022 at 09:59:13AM +0200, Thomas Gleixner wrote:
>> +/**
>> + * random_get_entropy_fallback - Returns the raw clock source value,
>> + * used by random.c for platforms with no valid random_get_entropy().
>> + */
>> +unsigned long random_get_entropy_fallback(void)
>> +{
>> +	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
>> +	struct clocksource *clock = READ_ONCE(tkr->clock);
>> +
>> +	if (!timekeeping_suspended && clock)
>> +		return clock->read(clock);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
>
> I tried to address this already in
> <https://lore.kernel.org/lkml/20220505002910.IAcnpEOE2zR2ibERl4Lh3Y_PMmtb0Rf43lVevgztJiM@z/>,
> though yours looks better with the READ_ONCE() around clock, and I'll
> send a v8 doing it that way. I didn't realize that clock could become
> NULL again after becoming non-NULL.

This happens at early boot where clock is NULL.

> I'm not quite sure I understand the purpose of !timekeeping_suspended
> there, though. I'm not seeing the path where reading with it suspended
> negatively affects things. I'll take your word for it though.

Some clocks are not accessible during suspend.

Thanks,

        tglx
