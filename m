Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF955C9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiF0HXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiF0HXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:23:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D47C5FEA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ZCPahz/TSdJ6Ok3pImgDQ4xDIYfyX3LQ2pkho0vEek=; b=h+4Ls9pc4h+2N6iAcVjRTnbTwk
        qQxcTmJEQkKNzlbp+KdLdwsds2e9TfsBkX5SkUJI5A6oQl9mViz3tnFQjosCoiTKvYAoK2b3nI/Im
        XhZofjuL48lJDObSWDw/AXG+L4ITVdegSfFSfRrxeqwNGdw/VWc9T625wAe8RavzYmjTFe76AuU3e
        nlGpzFi3r/VXZJFJXknEVpiDe3hPA6uieV2qDWEpjNzRwUpp9cTGFC2Vl7eQW1iShKoB5qDAJc0Xs
        k9tGFwFQ3LSCgBHf4w/b32UFZPWNCe3mnu5+gAWcY8mtbOiBX9hDzbQCNFJ1+0WUI/GmfekGntq2G
        NYH9xDGg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5j4x-00DNY7-Gf; Mon, 27 Jun 2022 07:22:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B91803001F3;
        Mon, 27 Jun 2022 09:22:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0249201833D4; Mon, 27 Jun 2022 09:22:37 +0200 (CEST)
Date:   Mon, 27 Jun 2022 09:22:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
References: <874k0863x8.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bit off a tangent..

On Mon, Jun 27, 2022 at 05:23:00AM +0900, Tejun Heo wrote:

> This is a bit of bike-shedding but there are inherent downsides to
> callback based interface in terms of write/readability. Now you have
> to move the init code out of line, and if the context that needs to be
> passing doesn't fit in a single pointer, you gotta define a struct to
> carry it adding to the boilerplate.

Yes, I so wish C had reasonable lambda expressions :/ But even if we
could come up with a semi sensible syntax and implementation, it would
still be many *many* years before we could actually use it in-kernel :-(

