Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED052ECDD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349695AbiETNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiETNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:08:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431FE1632AB;
        Fri, 20 May 2022 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qv6/4a2wBNDQJF5/SQ2zXLlQvCZJuVj2i9jXmuvnhLU=; b=KzG64xjTtnNSbLjJuGhHGl3g4A
        uKgbJ0C+5ZSKJOvca7A6k86RS2rBJczwtflJl/bRyzdUK+fKkV0ofm5i0LI5n3Mn8KF/XoMLPlhko
        +FYCr6j7m1HaihC34LFeXpmS139LrVSYz96NFzvdem8t11bDiLbPvvi2bKNloB/EgNv7GNejTpyFA
        2LSZKz7tbXbOPNSef40HBrtH4yGfDm2LFhpaiFxb1eBlrkd6zgJv62daeuSs6LgHY0BSEvWfPxs0m
        iBrG6sMPTZoYTcQZPqizC3A2HVncUfzaQPx/nOv/pw6y4FJykA3TA8t4gKdaxRL4zbuyOnxJ6BLFV
        L6vPZ+Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns2N4-00Dl90-0x; Fri, 20 May 2022 13:08:46 +0000
Date:   Fri, 20 May 2022 14:08:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Kent Overstreet' <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <YoeS3R4HE1fRkonT@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
 <Yoazbys+LiG0Uqcc@casper.infradead.org>
 <786516a0b71a4c6689592b89b146edec@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786516a0b71a4c6689592b89b146edec@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:03:29AM +0000, David Laight wrote:
> From: Matthew Wilcox
> > Sent: 19 May 2022 22:15
> > 
> > On Thu, May 19, 2022 at 09:06:24PM +0000, David Laight wrote:
> > > I suspect this a very good way to blow the kernel stack.
> > > The highest stack use is already very likely to be inside
> > > the printf code in an error path somewhere.
> > 
> > ...
> > 
> > > Double copying using a temporary buffer isn't the end of the world.
> > 
> > How can you hold both of these positions simultaneously?
> 
> Mostly you only need a short(ish) buffer to format a single item.
> But even a full line buffer is probably less stack than a
> nested printf call.
> It certainly makes it possible for static analysis to determine
> maximum stack depth.

There are a lot of words in this response.  Numbers, please.

> That made me realise that one of the problems doing static
> analysis of stack depth is indirect calls.
> The hashes that (IIRC) fine-ibt add to indirect calls
> and functions make it possible to tie these together.
> So you can determine the worst one of the called functions
> and use it for the stack depth at the call sites.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
