Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD5566F61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiGENhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiGENgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:36:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E014011;
        Tue,  5 Jul 2022 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zG2nGXxaq7Y3XFLnvZZ3I2cqkxTm504h+OJqSyMVwqo=; b=orBkxc/e9M1r2QILIiagrpcgNg
        qRNs4ogyMMveieLvAY87iZ7sRl7ggZNP/H+F5AAGUi5uT1cpGIAW8K16q2I6e7Z8GCwtpE1Mwzps+
        wHFTxPJ6994ioagBLZ9hUP6eEPEry/EOBhsSGldpJtzkFfevtwo1H/PodHvRTMQmbYTEw57xLYaQ9
        gb0ciA5kG3jgsusSy0xalyZoG5cHCHrUCM1lRFz6Z+v03sv+rsaqbLu//qe87TFpPHBrS/W8aFJwS
        zv6B6qwHTdFXFnfd54NxR2M6NZ9yskIXxoqrbQbZ/Q9rnnusaJ0GSNo9j1miykdzbG5E0wfShYRTl
        6ToE0tbQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8i7q-000aZI-8f; Tue, 05 Jul 2022 12:57:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35308980060; Tue,  5 Jul 2022 14:57:56 +0200 (CEST)
Date:   Tue, 5 Jul 2022 14:57:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bill Wendling <morbo@google.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        Ruud van der Pas <ruud.vanderpas@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        elena.zannoni@oracle.com
Subject: Re: plumbers session on profiling?
Message-ID: <YsQ1VKODuKztM0ad@worktop.programming.kicks-ass.net>
References: <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
 <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
 <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
 <YsLyq5FUZj9NLy3V@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLyq5FUZj9NLy3V@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 04:01:15PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 01, 2022 at 11:57:25AM -0700, Bill Wendling wrote:

> > As for LBR, that will work with Intel/AMD, but I thought that LBR
> > doesn't exist for Arm processors (my knowledge could be out of date on
> > this).
> 
> Not totally up to date on the ARM thing either; but I believe you're
> right in that they don't yet have such a feature.

Just found this in my inbox; I should've seen it before, but it must've
slipped my mind:

  https://lkml.kernel.org/r/20220613100119.684673-1-anshuman.khandual@arm.com

And of course, PowerPC also supports this.
