Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC24ADFFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384522AbiBHRzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384471AbiBHRzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:55:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F2C061578;
        Tue,  8 Feb 2022 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ztOs9rdQFcLSesu9yn9FzljZLdIAbRP2bvIGIa+5XDE=; b=y7RsM5q/MionYV9yNSbokVw3Ms
        ZCSQEuC1mHxLIgf1BdIDSMfT9mUN13eCx8/7PdaSsrjzKp49TQ6GrAaWBcg/0VX1np+OQ4emzhUBr
        WA4jyZBEJeSoIAW5RbQ9MogoX4LlyUmLiVbhhkvea4HvcA5mKjy3mRUxfO5YsuILrtnQV6/BlHgvi
        +BuNSc7r6ZIibuEenR//5rmcy+Yg27k1z8XzBYl9sn/06g4BxcV3sXgmMXfTw+YqD5Hln6xu+c16G
        woSFyjYnWcDc8aZGryVR5Siz7GSAqz/9PnTzwyVaalG2Dbry3Vfw1Mp+lZDr3uFgR7iD4J6KveHGP
        LxKLdaYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHUhs-00FAzD-De; Tue, 08 Feb 2022 17:55:12 +0000
Date:   Tue, 8 Feb 2022 09:55:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        nishit.shah@sophos.com, Vimal Agrawal <vimal.agrawal@sophos.com>,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v5] modules: add heuristic when stripping unneeded symbols
Message-ID: <YgKugFcF1kkWPsNa@bombadil.infradead.org>
References: <20220203060641.119522-1-vimal.agrawal@sophos.com>
 <20220204083933.136096-1-vimal.agrawal@sophos.com>
 <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
 <CALkUMdRv0tMuLpi3Syw7MndBTa9b0xRLGdb6QvM8Q69zXnmUkw@mail.gmail.com>
 <YgGYL1MKEX9t/ciO@bombadil.infradead.org>
 <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:22:06AM +0530, Vimal Agrawal wrote:
> > > Actually I had it  under (!best) in my first patch. I had to change it
> > > because it was resolving the address to symbols like __this_module for
> > > init address at times which is not correct for text address.
> >
> > Can you say that again?
> 
> I hit this a few times later after the first patch. Basically there
> are all symbols in symbol table and best could be none zero ( means it
> matched some symbol) but it may not be match to .text symbol for text
> address ( esp. when --strip-unneeded is used as there are very few
> symbols left after stripping)

You are saying that sometimes having "best" evaluated to non zero
yields incorrect results, where the symbol found is actualy not a .text
symbol for a text address? If so, is this really true for cases where
no stripping is used? If so this is bigger news and I'd like to address
this separately in another commit but we need proof, not just
speculation.

And you seem to be suggesting that this seems to hold more true when
"--strip-unneeded" is used given there are fewer symbols left after
striping?

Did I comprehend what you are trying to say correctly?

> > OK so you're saying sometimes "best" is not true when we use
> > INSTALL_MOD_STRIP="--strip-unneeded"? This is news.
> >
> yes, best can be non zero and may not resolve to .text address when
> --strip-unneeded is used. 

OK.

> without stripping, it will definitely
> resolve to some .text address closely matching in case of no stripping

OK so there is no issue when stripping is used.

> but it can go wrong with stripping. I have seen it a few times post
> the first patch during testing.

OK then we need to take care your added heuristics do not affect
non-stripping.

> > In particulr you seem to be suggesting that if --strip-unneeded was
> > used "best" could be incorrect for !is_module_text_address().
> >
> best could be incorrect even for text address when --strip-unneeded is used.
> e.g. in my case, it is resolving .init.text address to __this_module

You should be explicit about this in your commit log.

> > In any case, you completely changed things in your patch and did not
> > mention *any* of this in your follow up patch, leaving me to question
> > the validity of all this work.
> >
> The Only change I did from the first patch was to move this hunk out of (!best).
> Yes, I missed commenting it in the code.

When you submit a v2 patch and you change something like that you must
clarify changes which are not clear either in the commit log or below
the --- lines after the diffstat and before the actual patch. Each new
patch iteration should have a set of bullets with all the changes you
have made so that the maintainer can track what you have done
differently on each iteration.

Right now you are not making any of this easy on me so I ask that you
stop submitting new patches willy nilly until we have actualy discussed
each item, and we decide what to do. I also ask that you keep track of
each change you are making on each new patch iteration on the patch
after the --- lines and before the patch, so I can easily tell all the
changes you have made on each new iteration.

  Luis
