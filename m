Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573855B40D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiFZUjO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jun 2022 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiFZUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:39:12 -0400
Received: from relay4.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A0DD8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:39:11 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 0A933120DAD;
        Sun, 26 Jun 2022 20:39:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 77FB020025;
        Sun, 26 Jun 2022 20:39:02 +0000 (UTC)
Message-ID: <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
Subject: Re: [RFC[ Alloc in vsprintf
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Date:   Sun, 26 Jun 2022 13:39:01 -0700
In-Reply-To: <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
         <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
         <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
         <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
         <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
         <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
         <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 77FB020025
X-Stat-Signature: k6zu5exz6pfmapas8yidcramkpopggc3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/JLXlIzYuF27J9e1KXiNp5QhT/nSZMl8E=
X-HE-Tag: 1656275942-506383
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-26 at 13:19 -0700, Linus Torvalds wrote:
> On Sun, Jun 26, 2022 at 12:53 PM Joe Perches <joe@perches.com> wrote:
> > 
> > In a reply to the printbufs thread, I wrote a proposal to use an
> > alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.
> > 
> > No one has replied to this but I think it's somewhat sensible.
> 
> I think that's a bad idea.

Somewhat sensible not sensible...

> Those things are *literally* called from panic situations, which may
> be while holding core memory allocation locks, or similar.

True, and special_hex_number was used on alloc failure.

> Now, you are correct that the stack buffer is annoying. But I think
> the proper way to fix that is to say "we already *have* the target
> buffer, let's use it".

OK, and that's true for all the temp stack buffers in every %p<foo>.

> That does require teaching the sprint_symbol() functions that they
> need to take a "length of buffer" and return how much they used, but
> that would seem to be a sensible thing anyway, and what the code
> should always have done?

Unnecessary stack and/or unnecessary buffers for printbufs are
just unnecessary. 

> It's bad policy to just pass in a buffer without length, and I think
> it was always broken. Nasty. That KSYM_SYMBOL_LEN is magically taking
> care of it all, but it's ugly as heck, wouldn't you say?

Yup.

