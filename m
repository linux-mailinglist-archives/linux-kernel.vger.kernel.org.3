Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1634B5AEF23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiIFPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbiIFPis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:38:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2EC740B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:48:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g21so8301131qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/LvRxaQfk8WhkD1Tk1fIdqDGzkA2WRBWTAlHD7HDHQQ=;
        b=SJIv2HY+5v4upEotC2/9z8ktmtKx1D1KSGbinSicnG7zDPc8eZMk7nXMqm55PooO4k
         avCg2X+opKNuYvhUMPk8S9LCxUVG+s+RY3YFJ/ve6Ngp6yH9zEX29eYzgkZmljlQJawX
         qTZWBeaeoBy/6tD+MIsWwxajKyeWMqqhK45ZWiSKkPUdjPAjh/Gody1Y7FHjXm+Dluig
         n+VZ9KAtUby8tin11rCfiKZxTWfefSwkfHRF/8TLZuu0OxD6s7cwltAWfyGx1XP+Vwsq
         KEpk2/DX7Uis4TG8QQINCFZOwPxksnnRHmuICgVk9mfOT75GWWxFByQ13d5C5pKO/0XV
         z3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/LvRxaQfk8WhkD1Tk1fIdqDGzkA2WRBWTAlHD7HDHQQ=;
        b=zSaKjOrIxfciSyLNnwX34ylrGBkbwJN9lT2EAntQJ0kLxHKBG9poIPqdk06qEtVqU2
         JW+57bwCDSjjWQ0OuPaZLm+BgOAirCZjVP5YCx7FGO0csapYbQgyyp8FONb/shKCxC8o
         wg2dT4snOZ2RRny8dUBAQvtsChBbpKO6HVaXZnA09c8AGRdidwnoui5AUvIi/M6VHntR
         bYba9zzz+3oJVyCGNdQHKUCu9qq6VfwbWO+pPs/+l5h/XlptSMUhzcE9DwPGosOVa9ac
         tFxqnTdrjGub5s8l1RWKziPs3WV1SnHr7tvSfMM4HvguTNvk47utM3elWF8IC408Lz0r
         GwCA==
X-Gm-Message-State: ACgBeo0paE6iMZpNmLu89nSNEwA9Hruh8ka4ckh/tzcd2Ff+Il13l1pI
        W6pq+EyQg7y/iIzt9F6CUmY=
X-Google-Smtp-Source: AA6agR5DcEIRwpNCJ/ysm7YDNgIKJV1r0qj37EwhyrIOewBXN19KJAF9t3qSJpJXPmjYvUSak6eMXQ==
X-Received: by 2002:a05:620a:288b:b0:6b6:4f9b:85c6 with SMTP id j11-20020a05620a288b00b006b64f9b85c6mr35926458qkp.614.1662475711226;
        Tue, 06 Sep 2022 07:48:31 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:20bc:1817:1631:6d06])
        by smtp.gmail.com with ESMTPSA id q28-20020a37f71c000000b006bac157ec19sm10789923qkj.123.2022.09.06.07.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:48:30 -0700 (PDT)
Date:   Tue, 6 Sep 2022 07:48:30 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits
 mess
Message-ID: <Yxddvvx4DgOpWaAe@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
 <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 01:06:47PM +0100, Valentin Schneider wrote:
> On 06/09/22 10:55, Peter Zijlstra wrote:
> > On Mon, Sep 05, 2022 at 04:08:15PM -0700, Yury Norov wrote:
> >> cpumask subsystem uses nr_cpu_ids and nr_cpumask_bits interchangeably
> >> despite that the variables have different meaning and purpose. It makes
> >> some cpumask functions broken.
> >>
> >> This series cleans that mess and adds new config FORCE_NR_CPUS that
> >> allows to optimize cpumask subsystem if the number of CPUs is known
> >> at compile-time.
> >
> > Who will use this? Distro's can't, which means 99% of people will not
> > use this ever. Is it worth it?
> 
> I'd tend to agree here.
> 
> One extra thing worth noting is CONFIG_CPUMASK_OFFSTACK=n cpumask_size()
> still uses NR_CPUS under the hood, despite being (mostly) used to
> dynamically allocate cpumasks. So having an unconditionnal
> 
>   #define nr_cpumask_bits nr_cpu_ids
> 
> would save up some memory for those allocations.

Thanks, I didn't mention this. This is exactly what I meant by
'cleaning the mess'.
 
> A quick compile test on x86 defconfig (OFFSTACK=n) gives me:
> 
>   Total: Before=18711411, After=18705653, chg -0.03%
 
All cpumask_size() allocations are runtime, right?

> If it's in the range of barely-half-a-page on other archs, could we just
> do that then?

How many is that in terms of I-cache lines?
