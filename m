Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758FE527F20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbiEPICp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiEPICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:02:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443202CDCA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=40WKtHNpgYvlQ581J3rT1HA6i63DjPIBf8CHscK5pRw=; b=KA+gQelwKoYZBp/f8IKa+Ifrsi
        eHZp1FcdWAGxgxVHfKWUP1BGicYgkN/pP/mrv8A5FriPPBzkvvO1cTFrFwQfD0rjdGyIB93VB1Qzq
        H/GqQX50A1F2ZK+C+CyHpL5ly1VYCBAHQycEOmZIbnbpWBZAyOY9N8NNyb40c3oVwgm1RKkAjT9bS
        e1sC6r37zLzMvsTkTPH7nc1w66rI4U9TbEBsID+2rBgH2xs0+d2MdVDefBkN2yCXQNUOQfdUp6r6u
        8jTgjF8QoyVzFfjx2AGJ0nMmSb8AndPX9Y2RQYROczLylvxn6QwLaa1X7QvNP6SQRKtmv6qK93V5l
        pFBTouxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqVgP-000u0c-LL; Mon, 16 May 2022 08:02:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FE73300230;
        Mon, 16 May 2022 10:02:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 387E6202674C1; Mon, 16 May 2022 10:02:23 +0200 (CEST)
Date:   Mon, 16 May 2022 10:02:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
Message-ID: <YoIFD0zHTdy/Se2t@hirez.programming.kicks-ass.net>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
 <20220514131448.GL76023@worktop.programming.kicks-ass.net>
 <20220514145551.GC100765@worktop.programming.kicks-ass.net>
 <CAK7LNAR+F5PspM+6CP+H+443nJYy+Rg3jmKp1NyJeepq9sSFQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR+F5PspM+6CP+H+443nJYy+Rg3jmKp1NyJeepq9sSFQA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:26:23AM +0900, Masahiro Yamada wrote:

> BTW, gen-atomics.sh takes more than 1 sec.
> Do you think gen-atomics.sh can be much faster
> if it is rewritten by Python or Perl?
> Then, we can drop 5000 lines from the git repository.

I don't speak either; which would make it unsuitable for purpose.
