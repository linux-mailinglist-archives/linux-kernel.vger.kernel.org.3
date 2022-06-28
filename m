Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9855DEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbiF1MCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbiF1MCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:02:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646432E9F2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jL1gJrWX37x+h1++tMH8uyXq3CpESXwb4NN7kK1bpMQ=; b=FkBGuceDB+930n1nflLN+Xh7/b
        nGOeTfqCSPCtLyf4mzzQIKy1oRKK0pbxBc2aAU5HoIJoX+1Hd7sohK11AKhh1wXaYizF/gmftDlTe
        4DjuWlbuten+rP1bxn1aouP1Fa8TpmLs3IV/Xn2MCEqeltERbKnN6wNen4Mza3d1JOPfidENXdwGy
        Cx3tNocWai9krfdudDHuTpyG3VU6ywmzBcP9FOjUlU4FegJaM+/mieI30TdGVtztIuAJ4s2CUg7gS
        r7eFp4ySh5fImKKdPOdPj0cUVUpLTLT1moRiaO/ZTs6mdGM5i+GuS8LcqFdr0ijoPcwUV6dblbRmO
        m1D2ZQ5Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o69uP-00E5X7-Ce; Tue, 28 Jun 2022 12:01:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FBD330017D;
        Tue, 28 Jun 2022 14:01:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AC342020A5A1; Tue, 28 Jun 2022 14:01:31 +0200 (CEST)
Date:   Tue, 28 Jun 2022 14:01:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, mmarek@suse.cz,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to
 IS_ENABLED() and co
Message-ID: <Yrrtm0rRzLMCzKiM@hirez.programming.kicks-ass.net>
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
 <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:19:17PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 28, 2022 at 11:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Since IS_ENABLED() (and friends) are clearly meant to be used on
> > CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
> > tautology, allow the more compact usage of: IS_ENABLED(foo).
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I'd prefer to keep the more verbose usage, mainly because it makes it easier
> to grep for a symbol. If today you do 'git grep CONFIG_PM_SLEEP', you find
> all instances in Makefile, in #ifdef and in IS_ENABLED(), though not the
> references in Kconfig language, which leave out the prefix.

Which is why I never grep for the CONFIG_ thing to begin with, it misses
the Kconfig site.

> If we remove the prefix for IS_ENABLED(), the same grep fails to get
> all the results, while searching for the substring without the CONFIG_
> prefix can end up finding false-positives by finding longer strings (e.g.
> CONFIG_DEBUG_STACKOVERFLOW vs
> CONFIG_HAVE_DEBUG_STACKOVERFLOW).

Me being used to that doesn't consider that a real issue :-) I'd much
rather have the somewhat shorter IS_ENABLED() things.
