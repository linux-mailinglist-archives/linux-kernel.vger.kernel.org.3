Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149D449DE93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiA0J4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiA0J4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:56:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B0C061714;
        Thu, 27 Jan 2022 01:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vXgIaQHv1WwPHTBX3+DS0LsBoq4oci9EBPzt7CvHDrk=; b=Q7RpGLD+CLAuxSeoUa+m+yscqR
        PXROARvnTVuQl4eCsx0sm104eBUw6cjrSWVM/mgh8V7zPnn3r4FR2lNnAWkGx1bcFywjSxidg3eAC
        6qsf/72PQtVQzaABPK1fNhwzaDC3lcn1QmZ1TzCkL/jAtzFtTyL97n7BmyoFY6e66V6nqMwmHrjPm
        m4nYp5H+4JHa9otDcQCKogSoIGhK9jP1vUor2qsbcVDmMsDqNWXaltH7rBy0yn0gJWfGUTH79tlSK
        5LIr5SsbqOnzLsCQOm/sCLTmS53vjQJg6yrjYx0QVXj2Xi/Zu/P1VVKlHGp8HJjFjpGZ/e0e+vGc2
        Dbvixmrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1Ve-00483l-9t; Thu, 27 Jan 2022 09:56:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E901300268;
        Thu, 27 Jan 2022 10:56:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 114542B383F52; Thu, 27 Jan 2022 10:56:05 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:56:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 4/5] x86/uaccess: Implement
 unsafe_try_cmpxchg_user()
Message-ID: <YfJsNcYNH8JTHrM/@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.852009966@infradead.org>
 <YfIAsHQv5Q84fOqO@google.com>
 <YfI9Y5l0fQAKuJav@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfI9Y5l0fQAKuJav@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 06:36:19AM +0000, Sean Christopherson wrote:
> On Thu, Jan 27, 2022, Sean Christopherson wrote:
> > Doh, I should have specified that KVM needs 8-byte CMPXCHG on 32-bit kernels due
> > to using it to atomically update guest PAE PTEs and LTR descriptors (yay).
> > 
> > Also, KVM's use case isn't a tight loop, how gross would it be to add a slightly
> > less unsafe version that does __uaccess_begin_nospec()?  KVM pre-checks the address
> > way ahead of time, so the access_ok() check can be omitted.  Alternatively, KVM
> > could add its own macro, but that seems a little silly.  E.g. somethign like this,
> > though I don't think this is correct
> 
> *sigh*
> 
> Finally realized I forgot to add back the page offset after converting from guest
> page frame to host virtual address.  Anyways, this is what I ended up with, will
> test more tomorrow.

Looks about right :-) (famous last words etc..)
