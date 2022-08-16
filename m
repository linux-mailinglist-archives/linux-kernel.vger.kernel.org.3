Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF35957E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiHPKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiHPKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:17:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401151A05A;
        Tue, 16 Aug 2022 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cPJaW2xNn/yDTjrJigRQCIHe05jeFSkKn2MM46dKM5E=; b=rBh97mMKFKdKhEHk1XRKoVzQSl
        VI6XhdyrcrXj8l5sw7dnz71HqVm9wIR9D/pcaacpx0G94JDYlbxXHPJ3sabDcoMAcChgY4VVtjS1J
        0JJB6SscnBDyYaR/NhS1mSATM9tfPgdD8V0a9nm2FdhZ1GEy2IcQzC7MBnXV4Od27kgoRPl4Fu8x2
        Oen1u4lY8W9BnGp0iq2KVW5u1LugL593i5maWV78yYkuOhW4wZW7TZ2q9lrhcXEBCC4rPtoBq22zK
        /H3pnQPRW50TLDBBNodKjNa8M0D8M4fopXRf/XmSdL/UC3CS7wzQ5+6vOO6QRscnc5VONjtV1JS3j
        KKxh7agA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNru9-006iZ7-IE; Tue, 16 Aug 2022 08:26:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC7D0980264; Tue, 16 Aug 2022 10:26:27 +0200 (CEST)
Date:   Tue, 16 Aug 2022 10:26:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH 7/7] perf/x86/intel/P4: Fix smp_num_siblings usage
Message-ID: <YvtUs4o00xYV8BGD@worktop.programming.kicks-ass.net>
References: <20220812164144.30829-1-rui.zhang@intel.com>
 <20220812164144.30829-8-rui.zhang@intel.com>
 <YvoN2DTABnRZiJhf@worktop.programming.kicks-ass.net>
 <66dfcffec12b3558c36007eacec8f91fb91ca04b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66dfcffec12b3558c36007eacec8f91fb91ca04b.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:26:19AM +0800, Zhang Rui wrote:
> On Mon, 2022-08-15 at 11:11 +0200, Peter Zijlstra wrote:
> > On Sat, Aug 13, 2022 at 12:41:44AM +0800, Zhang Rui wrote:
> > > smp_num_siblings can be larger than 2.
> > 
> > Not on a P4 it can't ;-)
> 
> Kernel code doesn't prevent this from happening, so it just depends on
> how SMT ID is encoded in APICID.

No P4 ever encountered had it different and since no P4 will ever be
made again (I sincerely hope) we have a complete case.

> Checking for smp_num_sibling > 1 is the right logic to detect HT
> support, which is followed by all other kernel code except this one. :)

I'm fine with making it consistent, I'm arguing with the subject calling
this a fix, it is not, it's a functional no-op.

