Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79752ECC5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiETM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiETM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:58:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B4716A26A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D0rE5ocQaNvc6gwUw0uCA5HZ3TY/Uz1wLd+/r/5igCI=; b=T1fD6vnPvo1v8eK3XVf+kwOwIz
        fyqe8th/EBUGWxrvd9S4j2qFFfpJCYQbBs08b4RzbLonNEtXVhGG12SU2wP7mAZ5Gvenp/Clks2dt
        4Uh8/WXm6GcQo2gpWYVnYHwAsTG5RyN7/1w/h4kE8GgsfbMrXois4NAmDFSU0bxnG0hnDHJZw6cBO
        Kru9QFej4iDxqpA5KLaFqfp8qd+SekLezdWIqwX3Vthc2mmbWxgXXTVQvfIymELESJIH2Jmwq5hwD
        eChtTwAPMHpqJovzeVrzmdGvLfZWz8nJS71GT8v34u+FsXP1WU0rvG4YSJz7XdqRmjqPxPi8dPwo9
        JBiUMC0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns2Cz-002Kur-Rn; Fri, 20 May 2022 12:58:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D7E3981243; Fri, 20 May 2022 14:58:19 +0200 (CEST)
Date:   Fri, 20 May 2022 14:58:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220520125819.GS2578@worktop.programming.kicks-ass.net>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
 <20220519220349.GM2578@worktop.programming.kicks-ass.net>
 <20220520022052.mkrc4v4evtp74bxe@black.fi.intel.com>
 <20220520070614.GP2578@worktop.programming.kicks-ass.net>
 <20220520101322.flxf52mg6vkkbc7r@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520101322.flxf52mg6vkkbc7r@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:13:22PM +0300, Kirill A. Shutemov wrote:

> So you want to call call the HLT hypercall with .irq_disabled=false and
> .do_sti=false, but actual RFLAGS.IF in the guest is 0 and avoid CLI on
> wake up expecting it to be cleared already, right?

Yep, just like MWAIT can, avoids pointless IF flipping.

> My reading of the spec is "don't do that". But actual behaviour is up to
> VMM and TDX module implementation. VMM doens't have access to the guest
> register file, so it *may* work, I donno.

Yeah, it totally *can* work, but I've no idea if they done the right
thing.
