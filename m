Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB14D6B31
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiCKXhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCKXhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:37:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD740A2F;
        Fri, 11 Mar 2022 15:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ADB661021;
        Fri, 11 Mar 2022 23:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAD9C340E9;
        Fri, 11 Mar 2022 23:36:08 +0000 (UTC)
Date:   Fri, 11 Mar 2022 18:36:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [next] arm64: allmodconfig: kernel BUG at
 include/linux/page-flags.h:509
Message-ID: <20220311183607.291dc950@gandalf.local.home>
In-Reply-To: <20220311232809.GA2044@kbox>
References: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
        <20220311112426.7e3cf434@gandalf.local.home>
        <20220311171123.GA1675@kbox>
        <20220311130453.54a4e0b2@gandalf.local.home>
        <20220311181328.GA1904@kbox>
        <20220311181500.0be31225@gandalf.local.home>
        <20220311232809.GA2044@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 15:28:09 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> OK, you know more than I, so hopefully we can land on if we really need
> it or not. For now I've left it in.
> 
> > > 
> > > The other thing is that this patch applied to 5.10.X on ARM64 does not
> > > appear to hit this. Is it some weird interaction with something else or
> > > was 5.10.X just getting lucky?  
> > 
> > Perhaps it's because you allocated the page with kzalloc and not just
> > getting a page directly?

I sent a version that removes it, but I think we can add it back.

> >   
> 
> Yeah, I think so too. I was able to repro locally and validate that using
> alloc_pages directly fixes this by setting DEBUG_VM_PGFLAGS=y.
> 
> I've posted a patch for this:
> https://lore.kernel.org/linux-trace-devel/20220311223028.1865-1-beaub@linux.microsoft.com/

Just saw it (I screwed up my procmail settings getting rid of some more
spam, and ended up sending all my email to a ":" folder :-p)

If you want, I can send another version of my patch that doesn't remove the
reserve. But I like my patch as it sets the MAX_EVENTS based on a order and
not the other way around.

-- Steve
