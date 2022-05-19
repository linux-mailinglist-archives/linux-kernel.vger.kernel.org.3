Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1680552DEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiESVLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiESVLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:11:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8B5D659;
        Thu, 19 May 2022 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RsD1R0hAhzMWzL8Ms/92Dme20g8ukj3CJvKnbXnQYw=; b=F53cZcgsujm2ilSXrIKDzWiIVw
        okrqaZwCNeOPvpsX6NoAjjBM0jdT0kLNzPdVSPA2Z0/Uz8WG1kcTXjrNwrraeVw0XN/+VbxL/DhRa
        X3XrKUp5cnE9h9pBYAS4djbtf74Gwg4k1rjue2BR1iVyu1aoSCNd2gzII9zcnw1JYg8Uxs73MtaYV
        pGlQ/TrSUvob3SJxDBpwmD+hClWyIauWIyJuCE6Mb1RzTSdBAT+eLNgY0VYU+oMWt57dX4TJcKxKU
        8RsfMyttxssYEt9XoGuz6sqPc6KKGD9BFws8P9kSatLU6oocdeDAg/b9KN/r3WgMvO0vYeQxpb2bf
        DRtINZcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnQq-00D6QD-IL; Thu, 19 May 2022 21:11:40 +0000
Date:   Thu, 19 May 2022 22:11:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <YoayjKMjhRVCiKKl@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
 <Yoam1bW/vni3srLc@smile.fi.intel.com>
 <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:26:26PM -0400, Kent Overstreet wrote:
> On Thu, May 19, 2022 at 11:21:41PM +0300, Andy Shevchenko wrote:
> > On Thu, May 19, 2022 at 01:24:00PM -0400, Kent Overstreet wrote:
> > > +void pr_human_readable_s64(struct printbuf *buf, s64 v)
> > > +{
> > > +	if (v < 0)
> > > +		pr_char(buf, '-');
> > > +	pr_human_readable_u64(buf, abs(v));
> > 
> > Wouldn't -v work?
> 
> This is a bit terser

How about:

	if (v < 0) {
		pr_char(buf, '-');
		v = -v;
	}
	pr_human_readable_u64(buf, v);

(some pedantic compilers might warn about the behaviour of S64_MIN, but
I think we're OK)

> > > + * pr_human_readable_u64 - Print out a u64 according to printbuf unit options
> > 
> > Have you ever compile this? We have kernel doc validator running when compiling
> > the code...
> 
> Yes I have, but I've never seen the kernel doc validator - can you point me to
> something so I can get that working?

You have to run 'make W=1' to get it, so Andy is being a bit overly
harsh here.  Most people use neither W=1, nor C=1.

