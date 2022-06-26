Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FCF55B41D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiFZVCl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jun 2022 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiFZVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:02:40 -0400
Received: from relay4.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FEC388D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:02:38 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 1C5C76077D;
        Sun, 26 Jun 2022 21:02:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id A762F8000D;
        Sun, 26 Jun 2022 21:02:32 +0000 (UTC)
Message-ID: <20e7ca5f3b7b5b473afe891e8b28c83de62bc6d6.camel@perches.com>
Subject: Re: [RFC[ Alloc in vsprintf
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Date:   Sun, 26 Jun 2022 14:02:31 -0700
In-Reply-To: <20220626205158.bqeyetui3cromscp@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
         <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
         <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
         <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
         <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
         <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
         <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
         <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
         <20220626205158.bqeyetui3cromscp@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: utcy8ffawdp8eazsjjuun81kku5n1chr
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A762F8000D
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19dTAM/tGp+XPWuoAl7IzFSwvdBH7J6rlo=
X-HE-Tag: 1656277352-34782
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-26 at 16:51 -0400, Kent Overstreet wrote:
> On Sun, Jun 26, 2022 at 01:39:01PM -0700, Joe Perches wrote:
> > On Sun, 2022-06-26 at 13:19 -0700, Linus Torvalds wrote:
> > > On Sun, Jun 26, 2022 at 12:53 PM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > In a reply to the printbufs thread, I wrote a proposal to use an
> > > > alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.
> > > > 
> > > > No one has replied to this but I think it's somewhat sensible.
> > > 
> > > I think that's a bad idea.
> > 
> > Somewhat sensible not sensible...
> > 
> > > Those things are *literally* called from panic situations, which may
> > > be while holding core memory allocation locks, or similar.
> > 
> > True, and special_hex_number was used on alloc failure.
> > 
> > > Now, you are correct that the stack buffer is annoying. But I think
> > > the proper way to fix that is to say "we already *have* the target
> > > buffer, let's use it".
> > 
> > OK, and that's true for all the temp stack buffers in every %p<foo>.
> 
> Serious question: why are you trying to half-ass just _one_ of these functions
> when I've been working on solving stack allocations in all of them?

Because the stack use in _this_ function is quite large.
Backporting to stable would be trivial.
No so with printbufs.

> if you want to help out instead of just slag what I'm
> doing... well, it'd be nice...

Also nice to _be_ nice.
Honestly Kent, I haven't seen much of that from you.

