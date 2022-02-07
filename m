Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14D4ACBD4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiBGWIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbiBGWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:07:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00127C061355;
        Mon,  7 Feb 2022 14:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l7wWM/7p7XzTmhY8BZsL4D072e/QasMVDV2u2jXUfrY=; b=hn6BCjAp2gxmRN151mnG+VR8rY
        2AQdbOiW4Dxq7NDDRQhXscADWWw6TWPIS8+14A52A77U01tZodRLuUR1WqAyGcWWqffMfgpUA9vWN
        L+UBSFtcaCX694winIwieaxvtmo1m8fkMdtx3zUM/o4G+b3IyIC9tUMTdhlE0YImYuaWCeFsHHbcO
        MpeL+ggqrIX4ZbWDXzPB2nOyE9rDftNebyf3WG2eNktx8k5kqWORUaEatODoS6JeMCvMjaXicq439
        hieni0DwFYZK+Tg+osFFK/eU22RhT6mtms15rmUJvbTjKNi/ythbSG6okbmEeBKwWMJfDpsuo4jOx
        Hkkdaspw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHCAh-00Bq5q-S6; Mon, 07 Feb 2022 22:07:43 +0000
Date:   Mon, 7 Feb 2022 14:07:43 -0800
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
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>
Subject: Re: [PATCH v5] modules: add heuristic when stripping unneeded symbols
Message-ID: <YgGYL1MKEX9t/ciO@bombadil.infradead.org>
References: <20220203060641.119522-1-vimal.agrawal@sophos.com>
 <20220204083933.136096-1-vimal.agrawal@sophos.com>
 <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
 <CALkUMdRv0tMuLpi3Syw7MndBTa9b0xRLGdb6QvM8Q69zXnmUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdRv0tMuLpi3Syw7MndBTa9b0xRLGdb6QvM8Q69zXnmUkw@mail.gmail.com>
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

On Mon, Feb 07, 2022 at 06:51:50PM +0530, Vimal Agrawal wrote:
> >
> > You did not explain why you change your code to not use the below
> > (!best) branch. I'd much prefer it there as that is when we know
> > for sure we have no real symbol defined.
> >
> >   Luis
> 
> Actually I had it  under (!best) in my first patch. I had to change it
> because it was resolving the address to symbols like __this_module for
> init address at times which is not correct for text address.

Can you say that again?

> It was
> not entering inside if (!best) as it found some match but the match
> was not correct.

Is this a summary of what you said above and I could not understand?

OK so you're saying sometimes "best" is not true when we use
INSTALL_MOD_STRIP="--strip-unneeded"? This is news.

> It could be fine for some non text addresses but not
> for text addresses.

In particulr you seem to be suggesting that if --strip-unneeded was
used "best" could be incorrect for !is_module_text_address().

In any case, you completely changed things in your patch and did not
mention *any* of this in your follow up patch, leaving me to question
the validity of all this work.

> So I had to move this check out of (!best) and put a check explicitly
> for text address to avoid any impact on non text addresses by
> following:
> 
> +       if ((is_module_text_address(addr) &&
> +               (bestval < baseval || bestval > nextval))) {
> +               /*
> +                * return MODULE base and offset if we could not find
> +                * any best match for text address
> +                */
> 
> I tested it on next-20220116-1-gff24014a52c0 today and I am able to
> repro at least for init address easily with test_module.ko.

I tried to reproduce and couldn't and sent you a configuration to test.

> I can update the patch explaining this in comments in between the code.

The above is not clear and you need to make things crystal clear. If the
existing heuristic for best is not valid all the times it needs to be
made clear using a comment, sure.

If your heuristic is *better* than the existing heuristic *today*, that
needs to *also* be clearly spelled out. Your patch does none of this and
the commit log clearly does not reflect it.

  Luis
