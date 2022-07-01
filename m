Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D61562F61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiGAJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiGAJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:02:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BC193C8;
        Fri,  1 Jul 2022 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0/2zvonDcE3Fklpe/jarNXLTTDqCN2xFbwhTdVMbRho=; b=F6BYYBOSnF6QrD1t3Oziop62MF
        3VjhUBpC4lFaMLIGRMl32DI5uYtwFrEw4YPo0pNH+97ooDPQHISHAb2Ki3OE+1Ogu64u77WvL+z40
        Z0iE2A3Mi5/uRafY2WmLrH2BnqfwK7dlX62jnJ5/p6OienKV6ohiEdHTx5wIDURfJDfPX+pOeuF9W
        TRGCx7RIrvSt2yNnZ2NqghxGdwnsmZRjYeMafZ5vlz5S2yG5aU+b0m9K98+rnyGmkFuxIRHi+ajWT
        E59zMAcJSXcNZsBPDSjjfb8xC2GzFvRiE9qjOEZEYiklU4yDC1TUn8wL4JjWPVzT7GLMAJk8CAdKb
        uQAa7hfA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7CWw-00Fe4k-40; Fri, 01 Jul 2022 09:01:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A278F980017; Fri,  1 Jul 2022 11:01:37 +0200 (CEST)
Date:   Fri, 1 Jul 2022 11:01:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     Ruud van der Pas <ruud.vanderpas@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-toolchains@vger.kernel.org, elena.zannoni@oracle.com
Subject: Re: plumbers session on profiling?
Message-ID: <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rpgpvfj.fsf@gnu.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:08:48PM +0200, Jose E. Marchesi wrote:
> 
> [Added linux-toolchains@vger in CC]
> 
> It would be interesting to have some discussion in the Toolchains track
> on building the kernel with PGO/FDO.  I have seen a raise on interest on
> the topic in several companies, but it would make very little sense if
> no kernel hacker is interested in participating... anybody?

I know there's been a lot of work in this area, but none of it seems to
have trickled down to be easy enough for me to use it.
