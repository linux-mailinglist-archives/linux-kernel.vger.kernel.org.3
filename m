Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0B565836
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiGDODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiGDODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:03:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2077BE39;
        Mon,  4 Jul 2022 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1T6SVyyOJpN9/GWpMLEq69oLc1h5UxF4v7bv25UoGhs=; b=uppmf7BIrnYV3iMe75idjW/LOU
        I3VPn7L/oZPOqnGb/94W4U/NMq3zD/SH7ecWMnFZbuvF9xjt/X1xja4Cw8V0AxDYN4qaB/Nd07KT6
        ZdkeIMyyMZU/8jd5ZVHsxvlIAKoGWhMP9knmHSSyZv5zYdpDyRG7nrsBuQHP9rAE0NB8UbxRiwV8y
        LjPtthp8jZIJH4dcnsCHWZnMevofqlomb3dfy9GRzKmrGfB6fG0GttcX4LoNRg9fvgl6v80pv5qYO
        kQyXWnuLtpz8Xc/tdtCEzhA75gB18DxLcB7zIBzdzGCpMo8stq28TxwbbJuNUR/y8lC7ZdArMfrxe
        xXo1Bggg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8MfD-00HLfn-VJ; Mon, 04 Jul 2022 14:03:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AC20980057; Mon,  4 Jul 2022 16:03:00 +0200 (CEST)
Date:   Mon, 4 Jul 2022 16:03:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
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
Message-ID: <YsLzFAoWz1mykLmy@worktop.programming.kicks-ass.net>
References: <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
 <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
 <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
 <20220701193409.p4ejod7olx7ngl5m@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701193409.p4ejod7olx7ngl5m@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:34:09PM -0700, Fangrui Song wrote:

> Instrumentation based PGO has the nice property that it works with all
> architectures (the compiler supports) and does not rely on hardware
> support. In addition, it collects indirect call targets and string
> operation sizes which are very difficult/impossible for sample based
> PGO.

LBR samples should provide the indirect call targets just fine.
