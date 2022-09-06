Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC565AF679
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIFVAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFVAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:00:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F854A801
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VfkRYEMWj3FD8tJg6/WhebmsvjXoNQjBzn0bpZ2iFog=; b=FXBP2PcZI1p1iGJHVq+rmXJUFc
        hNewwmCKp0B8i+343tpoaqxtI6fszAT5bPagQgkp9nKY1u+n4cewpMO9nVjl7fH9m+RI+JgBV7rUs
        FxKTvczPiWvV6fTDfLjIqwk3wHJx6ZjVpIKBXGgvQdkqpy/89H7IWkUn9NZYrWUwHVGyKHRnLSD5b
        WvylxT4BYnnGIzSXW6VO7tOW6nPe3yNrXV9AtYapKXmR0O5rPLj5XgPGze+c0Wk8nZIjygTLD0gUy
        HXuXEF2rU6OF3D+qunS7GYG7saqc21+Ky1XkdtljtuDRsGB0GBPbFWbj3WD2/prcnhnMz4p/zDl0B
        9tUJOq2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVfgU-00AlK0-Ry; Tue, 06 Sep 2022 21:00:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDDB7300244;
        Tue,  6 Sep 2022 23:00:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC1CA2B977EDE; Tue,  6 Sep 2022 23:00:36 +0200 (CEST)
Date:   Tue, 6 Sep 2022 23:00:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Message-ID: <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
 <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:56:47PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/6/22 22:43, Peter Zijlstra wrote:
> > On Tue, Sep 06, 2022 at 10:17:43PM +0200, Hans de Goede wrote:
> >> On an Intel Atom N2600 (and presumable other Cedar Trail models)
> >> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
> >> by msr_build_context().
> >>
> >> This causes restore_processor_state() to try and restore it, but writing
> >> this MSR is not allowed on the Intel Atom N2600 leading to:
> > 
> > FWIW, virt tends to do this same thing a lot. They'll allow reading
> > random MSRs and only fail on write.
> 
> Right. So I guess I should send a v2 with an updated commit
> message mentioning this ?

Nah, just saying this is a somewhat common pattern with MSRs.

The best ones are the one where writing the value read is invalid :/ or
those who also silently eat a 0 write just for giggles. Luckily that
doesn't happen often.
