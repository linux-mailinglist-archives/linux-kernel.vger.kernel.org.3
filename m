Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DF596B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiHQIUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiHQIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:20:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0F5A3E3;
        Wed, 17 Aug 2022 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FbA2D5Ytl8+XtaWqyY9MA5kUljBxAI9NwrGzxlRhdQk=; b=EFCB5EU9sU/o+jU27fJtSjV5w0
        X+PBVw0yoVvPMJDNmJHygP8pfcG9OE0UGoD69l1lZAB7HdW5Pm1kQIJNQz1xzV5CVTtlnyV7RqLph
        tvISqn1NRSaAGr/hkVcVNkIlK+Gv9tHxd66mSyZPpPQe124aCKJfFWQyH5fXGM9Emid7ULWv7ev4K
        G9IheupG/D6E8JOMPsoX6O6Jb4uorIHT5DoUD5Zi6u9cCNO7PsAX3KObZnWUuXeoi4Z/YxLxwWOZv
        nr9IJ69C6Jpnk4X2Wo0Ifq8MI4+0zxXN4HbGve5aqeeF7XNGafNee9zUPrt4+wnb38Lw1k07iCNyb
        yOjNQzfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOEHc-003DEo-GU; Wed, 17 Aug 2022 08:20:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 806FB98007A; Wed, 17 Aug 2022 10:20:10 +0200 (CEST)
Date:   Wed, 17 Aug 2022 10:20:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <YvykurTz/O93AEIa@worktop.programming.kicks-ass.net>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com>
 <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com>
 <87bkt2sqq4.ffs@tglx>
 <YuktqQS7Rb0IbJNh@zx2c4.com>
 <878ro6smmm.ffs@tglx>
 <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
 <87zggmqo0w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zggmqo0w.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:27:43AM +0200, Thomas Gleixner wrote:
> Assumed that there is a sensible usecase, there is a way out and that's
> exactly the library part. You can make that VDSO interface versioned and
> provide a library in tools/random/ which goes in lockstep with the VDSO
> changes.

Well.... there is still the old idea of making a genuine libkernel.so
which is part of the kernel and provided as a virtual file (say in
/sys/lib/).

Since that's perfectly in lock-step with the kerne image, it can be
used to avoid the vdso data layout compat issues. Only the actual
symbols provided by the library are ABI constrained, not their
implementation.
