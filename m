Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5990457AAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiGTAF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiGTAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:05:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662D7D136
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 85098CE1B63
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B9CC341C6;
        Wed, 20 Jul 2022 00:05:08 +0000 (UTC)
Date:   Tue, 19 Jul 2022 20:05:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220719200507.361b06ee@rorschach.local.home>
In-Reply-To: <7462e934-f746-eef7-ff92-0eeb8cc08b82@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
        <20220719191522.4002a5fb@gandalf.local.home>
        <7462e934-f746-eef7-ff92-0eeb8cc08b82@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 19:43:46 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> On 7/19/22 19:15, Steven Rostedt wrote:
> > On Sun, 19 Jun 2022 20:41:59 -0400
> > Kent Overstreet <kent.overstreet@gmail.com> wrote:
> >   
> >> Core idea: Wouldn't it be nice if we had a common data structure and calling
> >> convention for outputting strings?  
> > 
> > Because seq_buf gives us this already, the cover letter really just needs
> > to state exactly what the benefit is to replace seq_buf with printbuf (and
> > why seq_buf can not be simply extended to do some extra features).  
> 
>   - seq_buf has the wrong semantics on overflow for what vsnprintf needs.

More specific please.

>   - seq_buf is somewhat unnecessarily coupled to tracing needs - the 
> readpos member has nothing to do with outputting formatting strings, and 
> some of the pretty-printers are tracing specific and don't really belong 
> in a generic pretty-printing library.

That's not really a benefit between the two.

> 
> And, when I tried to talk to you about changing seq_buf to be more 
> suitable you didn't respond - you just dropped off the IRC discussion we 
> were having.

I told you I've been swamped and this wasn't the best time for me. I
can't drop everything for you.

> 
> > 
> > I just applied your series and ran the tracing selftests and several of
> > them failed.
> > 
> >   # cd tools/testing/selftests/ftrace/
> >   # ./ftracetest  
> 
> Thank you for telling me where to find the tests. It would've saved us 
> some back and forth (and I could've gotten on this sooner) if you'd 
> responded when I asked before.

It's in kernel selftests, they are not hard to find.

> 
> It may seem like the perfectly natural place to look to you - who works 
> on the code - but to someone who works on a variety of subsystems, each 
> of which puts their test code (if they have any!) in a different place, 
> it wasn't.

All the subsystems tests should be in tools/testing/selftests this
isn't just where tracing goes. It's the standard place.

> 
> However, when I enabled all the tracing kernel config options, your 
> tests are now failing to run at all with:
> 
> db_root: cannot open: /etc/target
> 
> So now I've got to debug your tests, too. Gah.

WTF?

-- Steve
