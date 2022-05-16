Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5503527F13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiEPH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbiEPH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:59:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F02AE33
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DMPIEYqudJnc78X1YnfA4VhQpF5cbJj7pr8jc+iy0Ug=; b=PloENFhj2BfH5h+b065sfgHG+G
        jozeFl0MzH+AmDk8tbBw8t7SfF8n0zQjLoEYzQIW2MhXqE2WK6vCyWOR7M8s1qZmWxeVo+tvbRAyh
        x2Rhoalc8Qzs+OkFIYOldt88iQ95V4lMWJUDDy9rK5vqIHJAn3UrU70fbT+n7GhOt6qe6EJ3GVhQq
        0fyL13iTdIa4WNHIBD10TyR8cdwS2+cwymKsU4xVPXT1gjI5UDeA1+Y4boLyOj3yjQiFxGCb8JGJ1
        ePtlhLpYiRYpKxPiMRsR6qmFJx+mhq7OaA9SlnWtAK3r2D+qup7lzODopxrnhFRhzTZDJK7/IxcNX
        uHEeBx9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqVdW-009gC4-Hz; Mon, 16 May 2022 07:59:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E64EA30018E;
        Mon, 16 May 2022 09:59:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABA2B202674C1; Mon, 16 May 2022 09:59:23 +0200 (CEST)
Date:   Mon, 16 May 2022 09:59:23 +0200
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
Message-ID: <YoIEW/CCs6uyGJix@hirez.programming.kicks-ass.net>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
 <20220514131448.GL76023@worktop.programming.kicks-ass.net>
 <CAK7LNATUMfyqiWeZeZJCVO74XtQ1Bw-MN7bcaTZ1pgQy8H2Ehg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATUMfyqiWeZeZJCVO74XtQ1Bw-MN7bcaTZ1pgQy8H2Ehg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:07:27AM +0900, Masahiro Yamada wrote:
> On Sat, May 14, 2022 at 10:15 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > NAK
> 
> I consider NAK as "I do not like it".

Well, I *am* the maintainer of that stuff, you can consider all you
like, but I *will* revert anything I don't like.
