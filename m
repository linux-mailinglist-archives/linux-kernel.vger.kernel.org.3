Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063CC562FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGAJRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGAJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:16:58 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B5F427FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1656667015;
  x=1688203015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yLWxJPfnToMyz/XrFhdVClGvwJBpxKEAR/Sl0m5JrbU=;
  b=f+Pw36Tt61W/hRhmiMxWWrXDxF1INAlc3B+jcKxfplH3VlPloxNdnZ7K
   7AkPZ5MTHZ8RILRwuAYV1GhqxSG59pG75uB+Fp0CTDUJCNuCOeLPvjRHs
   EOr6CU8Evj0z5CkBu96GqKm9mqG55Gs2lTsYZ8EXYnEI8oMZQfWfuAGTD
   VihCrEE9IHmes6wX9VCHPdr0GoZiiXAObi/pIGabjlve6Y7ZzHAgiwNg5
   fQ7C8qs63DfKazaaYVGGPOxb9NcFGaVf8KZmd9RC1mvXkRh5T6bKhTnvP
   +Wpj++D09wLlTGVouOJTsEy8tLddPjJVvnlDZ7h7wP23pjv9a5f/SonSx
   Q==;
Date:   Fri, 1 Jul 2022 11:16:53 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     David Gow <davidgow@google.com>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
Message-ID: <20220701091653.GA7009@axis.com>
References: <20220630080834.2742777-1-davidgow@google.com>
 <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
 <20220630125434.GA20153@axis.com>
 <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
 <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:08:27AM +0200, David Gow wrote:
> On Thu, Jun 30, 2022 at 9:29 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > Stack trace collection code might trigger KASAN splats when walking
> > stack frames, but this can be resolved by using unchecked accesses.
> > The main reason to disable instrumentation here is for performance
> > reasons, see the upcoming patch for arm64 [1] for some details.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11
> 
> Ah -- that does it! Using READ_ONCE_NOCHECK() in dump_trace() gets rid
> of the nasty recursive KASAN failures we were getting in the tests.
> 
> I'll send out v5 with those files instrumented again.

Hmm, do we really want that?  In the patch Andrey linked to above he
removed the READ_ONCE_NOCHECK() and added the KASAN_SANITIZE on the
corresponding files for arm64, just like it's already the case in this
patch for UML.
