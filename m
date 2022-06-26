Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFC55B3FF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiFZUNa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jun 2022 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFZUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:13:29 -0400
Received: from relay4.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E51D6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:13:28 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id D012C1201EE;
        Sun, 26 Jun 2022 20:13:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 642306000B;
        Sun, 26 Jun 2022 20:13:19 +0000 (UTC)
Message-ID: <48797a0c929e87a72fccc48ce5cb95263da23e22.camel@perches.com>
Subject: Re: [RFC[ Alloc in vsprintf
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Date:   Sun, 26 Jun 2022 13:13:18 -0700
In-Reply-To: <20220626200618.jhxu5lg4w7o2irhr@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
         <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
         <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
         <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
         <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
         <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
         <20220626200618.jhxu5lg4w7o2irhr@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 8o99j5gabfgg5nj5pz8mqjhwiu7bprsq
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 642306000B
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+tTOT7eiYgj584PVuGjuFgfb+g9zXp/lI=
X-HE-Tag: 1656274399-556557
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-26 at 16:06 -0400, Kent Overstreet wrote:
> On Sun, Jun 26, 2022 at 12:53:26PM -0700, Joe Perches wrote:
> > In a reply to the printbufs thread, I wrote a proposal to use an
> > alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.
> > 
> > No one has replied to this but I think it's somewhat sensible.
> > 
> > Thoughts?
> 
> As functions get converted to printbufs the separate stack allocated buffers
> become unnecessary, because printbufs have helpers that do bounds checking and
> make outputting to the vsprintf buffer painless. So it's not necessary - I
> haven't fully converted symbol_string() yet but I'll do so by the time I mail
> out the next round of patches.

_If_ the printfbufs patch series gets applied.
I think that series is not great yet.

Even if applied via something like the printbufs series, the
stack use of this function needs/could use attending.

~700 bytes of stack use here isn't great.

