Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E8656FFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiGKLPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiGKLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:15:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE21301;
        Mon, 11 Jul 2022 03:33:33 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff601329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f601:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 317821EC0567;
        Mon, 11 Jul 2022 12:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657535606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mtjDsDO71nPhY5TZ9r2wPpSA0kUObkSTB+i8h+NQfsw=;
        b=M+c3B7xVKSjX18CkA4XSZarUwA9h9PAxou8AWmpppYs69p36vamcy9Gj467He+fOihRu+n
        mDIGn/qZQZ5HIj3wI4ly3WwM17zZIk/Lz8K51d0lEjqHmtgwL6cLfbyQ+/R7odH5VQvrO+
        7Zn8arslSwSwEqL0cbIpNTaPSAhJRaA=
Date:   Mon, 11 Jul 2022 12:33:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        patrice.chotard@foss.st.com, Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Hugh Dickins <hughd@google.com>, patches@lists.linux.dev,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH -final] x86/clear_user: Make it faster
Message-ID: <Ysv8cAa7wcDmQlpm@zn.tnic>
References: <YnqqhmYv75p+xl73@zn.tnic>
 <Ynq1nVpu1xCpjnXm@zn.tnic>
 <YozQZMyQ0NDdD8cH@zn.tnic>
 <YrMlVBoDxB21l/kD@zn.tnic>
 <CAHk-=wgmOfipHDvshwooTV81hMh6FHieSvhgGVWZMX8w+E-2DQ@mail.gmail.com>
 <YrN4DdR9HN0srNWe@zn.tnic>
 <CAHk-=wj_MeMUnKyRDuQTiU1OmQ=gfZVZhcD=G7Uma=1gkKkzxg@mail.gmail.com>
 <YrQ1PPB77PBWyaHs@zn.tnic>
 <YsRuUl24zkhpE3s/@zn.tnic>
 <YsVUvK/zQaIW749P@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsVUvK/zQaIW749P@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:24:12PM +0300, Alexey Dobriyan wrote:
> On Tue, Jul 05, 2022 at 07:01:06PM +0200, Borislav Petkov wrote:
> 
> > +	asm volatile(
> > +		"1:\n\t"
> > +		ALTERNATIVE_3("rep stosb",
> > +			      "call clear_user_erms",	  ALT_NOT(X86_FEATURE_FSRM),
> > +			      "call clear_user_rep_good", ALT_NOT(X86_FEATURE_ERMS),
> > +			      "call clear_user_original", ALT_NOT(X86_FEATURE_REP_GOOD))
> > +		"2:\n"
> > +	       _ASM_EXTABLE_UA(1b, 2b)
> > +	       : "+&c" (size), "+&D" (addr), ASM_CALL_CONSTRAINT
> > +	       : "a" (0)
> > +		/* rep_good clobbers %rdx */
> > +	       : "rdx");
> 
> "+c" and "+D" should be enough for 1 instruction assembly?

I'm looking at

  e0a96129db57 ("x86: use early clobbers in usercopy*.c")

which introduced the early clobbers and I'm thinking we want them
because "this operand is an earlyclobber operand, which is written
before the instruction is finished using the input operands" and we have
exception handling.

But maybe you need to be more verbose as to what you mean exactly...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
