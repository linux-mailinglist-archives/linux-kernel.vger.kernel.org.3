Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4625630F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiGAKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiGAKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:04:49 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F0574DD6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1656669884;
  x=1688205884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9yKLAcuZ5hnkYBCpoRQx1zMhVYu01vnHM+Lplb5HMc=;
  b=BxifDh2c1kPEu3rm1uWBi2bGi5bTCS9kg/uE4xzOjT92oHFOlMDR1D/Z
   IWBmJCDtu6BncqQHiRcTH+F8ziELcFgldto5cd8o6IQye5mVHg4fA91e5
   spohbFvaQ+RfKqnXuN7+uc9/59MhEJVPfIj1eNlPNLPGN1+9k9ewdiOdV
   rcaSrJlkY/rZhNA6l6Jb3XHDJ5dP9pghrwdEqrmJxo73+C5+qJYUNw94Z
   RxHjBc+PdtgbzVUxV49SU/jLqd5BYmz5VFh5EjN783/Rx8xkOsXt5mOj8
   WfR106TfTFYzuLfgpAhNzVk8+UpaQ9NaMANVPUBoWHZ701FR4igDc+DeN
   Q==;
Date:   Fri, 1 Jul 2022 12:04:41 +0200
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
Message-ID: <20220701100441.GA8082@axis.com>
References: <20220630080834.2742777-1-davidgow@google.com>
 <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
 <20220630125434.GA20153@axis.com>
 <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
 <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
 <20220701091653.GA7009@axis.com>
 <CABVgOSnEEWEe16O4YsyuiWttffdAAbkpuXehefGEEeYvjPqVkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABVgOSnEEWEe16O4YsyuiWttffdAAbkpuXehefGEEeYvjPqVkA@mail.gmail.com>
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

On Fri, Jul 01, 2022 at 05:43:26PM +0800, David Gow wrote:
> On Fri, Jul 1, 2022 at 5:16 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > On Fri, Jul 01, 2022 at 11:08:27AM +0200, David Gow wrote:
> > > On Thu, Jun 30, 2022 at 9:29 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > > > Stack trace collection code might trigger KASAN splats when walking
> > > > stack frames, but this can be resolved by using unchecked accesses.
> > > > The main reason to disable instrumentation here is for performance
> > > > reasons, see the upcoming patch for arm64 [1] for some details.
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11
> > >
> > > Ah -- that does it! Using READ_ONCE_NOCHECK() in dump_trace() gets rid
> > > of the nasty recursive KASAN failures we were getting in the tests.
> > >
> > > I'll send out v5 with those files instrumented again.
> >
> > Hmm, do we really want that?  In the patch Andrey linked to above he
> > removed the READ_ONCE_NOCHECK() and added the KASAN_SANITIZE on the
> > corresponding files for arm64, just like it's already the case in this
> > patch for UML.
> 
> Personally, I'm okay with the performance overhead so far: in my tests
> with a collection of ~350 KUnit tests, the total difference in runtime
> was about ~.2 seconds, and was within the margin of error caused by
> fluctuations in the compilation time.
> 
> As an example, without the stacktrace code instrumented:
> [17:36:50] Testing complete. Passed: 364, Failed: 0, Crashed: 0,
> Skipped: 47, Errors: 0
> [17:36:50] Elapsed time: 15.114s total, 0.003s configuring, 8.518s
> building, 6.433s running
> 
> versus with it instrumented:
> [17:35:40] Testing complete. Passed: 364, Failed: 0, Crashed: 0,
> Skipped: 47, Errors: 0
> [17:35:40] Elapsed time: 15.497s total, 0.003s configuring, 8.691s
> building, 6.640s running

OK, good to know.

> That being said, I'm okay with disabling it again and adding a comment
> if it's slow enough in some other usecase to cause problems (or even
> just be annoying). That could either be done in a v6 of this patchset,
> or a follow-up patch, depending on what people would prefer. But I'd
> not have a problem with leaving it instrumented for now.

I don't have any strong opinion either way either, so you don't have to
change it back on my account.  Thanks.
