Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348935292D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbiEPVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbiEPVZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:25:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887E377E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f5LaeL1FEpXjUMmFs21q4KWaRLycqf1krk+qlaaPSdQ=; b=aB+vbWt2+rcEGXdtnxLTjijd13
        GQgdr20N9wZnKDQQVT7l2yV0G6fVvkYthJeoJSHkcs4WJaXrJMS9sIluMAnEXorHi9WmANOO0m5Oo
        FkJNwrWHykH/NTvz/Xcws39fWF3fQwjf1YPJBM0NcFo4jX+W/4bEMvlQoYsgrN28yRMxy327xoqKY
        KRCXnFyWtm63gUwQ0dOOcsPmQDjrze0wrYBhFxorrHu57O0GMUqXHS5VpV01dkXUf6KNbTpymHvxN
        qtG6IFoVjKkKox9n1DDqrwinTRui9wL3+xEKKucVm/lEE4yUiu4lUB3yw3GXIEhmCHIJ5lHJY7bQc
        ycKabypA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqiDQ-0011sU-8D; Mon, 16 May 2022 21:25:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AA7E980DCC; Mon, 16 May 2022 23:25:17 +0200 (CEST)
Date:   Mon, 16 May 2022 23:25:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix objtool regression on x32 systems
Message-ID: <20220516212517.GP76023@worktop.programming.kicks-ass.net>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
 <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
 <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:56:21AM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 16 May 2022, Peter Zijlstra wrote:
> 
> > On Mon, May 16, 2022 at 11:06:36AM -0400, Mikulas Patocka wrote:
> > > The patch 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols") makes
> > > the kernel unbootable.  The patch c087c6e7b551 ("objtool: Fix type of
> > > reloc::addend") attempts to fix it by replacing 'int' with 'long'.
> > > 
> > > However, we may be running on a system with x32 ABI and 'long' on x32 is
> > > 32-bit, thus the patch c087c6e7b551 doesn't really change anything and we
> > > still end up with miscompiled kernel.  This patch replaces 'long' with
> > > 'long long', so that the 64-bit kernel is correctly compiled on a x32
> > > system.
> > 
> > Hurmph.. you're building a 64bit kernel on a x32 hosted machine? And
> > this is the *only* thing that goes sideways?
> 
> I use the x32 ABI (that is 64-bit mode with addresses truncated to 
> 32-bit). gcc compiled for the x32 ABI is about 5% to 10% faster than gcc 
> compiled for the amd64 ABI. I installed the x32 gcc from Debian Ports.
> 
> > I suspect quite a bit of objtool assumes LP64 and won't quite work right
> > on ILP32 and we've just been lucky so far.
> 
> With this patch, the compiled kernel works. With kernels 5.17 or older, it 
> also works. I bisected it and the breakage is caused by the commit 
> 4abff6d48dbc.

Sure; but it works doesn't mean there aren't more latent issues. ILP32
hosted (cross) builds just aren't a thing I've ever considered. If we
really want to go support that then we should at least audit the whole
thing.

A quick look seems to suggest at least all the 'offset' fields should be
u64 or something. The only reason that works is because -mcmodel=kernel
keeps everything in the 2G range to make s32 immediates work. But it
isn't right.

Additionally, for things like LTO/IBT with vmlinux wide objtool runs,
i've seen objtool use up to ~20G of memory, I'm fairly sure x32 won't
cope with that.
