Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2254222F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391042AbiFHBwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449341AbiFGXJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:09:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7E1F5741
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417A7B823F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895F4C385A5;
        Tue,  7 Jun 2022 20:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654634769;
        bh=ZjlX7o9AK/ffVeqZzZ5K4UUhk6vQnABK67ThoO275YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOIxLu13wVKoV2xBLBasWEyRxoaHDvHdOdJkJ3hcGSMnqiY7pZ4OSwzWbJ4QOwRMj
         Hi5qA8rcylqPocnEC2UA+ePhLKsFECsJfu0uDLYTXVOD9nawHFmQtBRv/orfaezf9y
         dOjC33JC63ObFelRd3cDa23fqrWjVO29LsIMMuP13ZdwKZdkAsgx4a/YPa4Vdw8k01
         FGal4+vdAgC4KVrzoS/ozUBpCm7/qkc6DN6fJ1oGyWAm/v1ypiQge3sOdcqrW6NcsQ
         UbshIOcb64NI1PfCCUsqvKGYb/03v/H+BCTVI//5bjlqXhMiP5XdFzuPH9PSOAV6gg
         71qGlJdGCU8rw==
Date:   Tue, 7 Jun 2022 13:46:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Justin Stitt <jstitt007@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: conntrack: fix this -Wformat clang warning:
Message-ID: <Yp+5DqDrVJAS5T8I@dev-arch.thelio-3990X>
References: <20220606212819.9548-1-jstitt007@gmail.com>
 <Yp9uRz40J24vWLSb@dev-arch.thelio-3990X>
 <CAKwvOdmFCge4cpcyqL1gtqg2xdAgmeuaJZaSMvW=m+cTr8XaaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmFCge4cpcyqL1gtqg2xdAgmeuaJZaSMvW=m+cTr8XaaQ@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:29:30PM -0700, Nick Desaulniers wrote:
> On Tue, Jun 7, 2022 at 8:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Justin,
> >
> > The subject might be a little more descriptive if if were something
> > like:
> >
> > netfilter: conntrack: Fix clang -Wformat in print_tuple()
> >
> > rather than saying "this warning", as subjects should be standalone from
> > the rest of the message. Minor nit but some maintainers have high
> > standards for commit messages.
> >
> > On Mon, Jun 06, 2022 at 02:28:19PM -0700, Justin Stitt wrote:
> >
> > It would be helpful to note here that this warning appears when building
> > arm64 with clang using -Wformat; the architecture is critical for
> > reproducing this warning.
> >
> > >  | net/netfilter/nf_conntrack_standalone.c:63:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->src.u.tcp.port),
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:64:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->dst.u.tcp.port));
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:69:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->src.u.udp.port),
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:70:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->dst.u.udp.port));
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:75:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->src.u.dccp.port),
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:76:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->dst.u.dccp.port));
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:80:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->src.u.sctp.port),
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  | net/netfilter/nf_conntrack_standalone.c:81:7: warning: format specifies type
> > >  | 'unsigned short' but the argument has type 'int' [-Wformat]
> > >  |                            ntohs(tuple->dst.u.sctp.port));
> > >  |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Variadic functions (printf-like) undergo default argument promotion.
> > > Documentation/core-api/printk-formats.rst specifically recommends
> > > using the promoted-to-type's format flag.
> > >
> > > Also, as per C11 6.3.1.1:
> > > (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf)
> > > `If an int can represent all values of the original type ..., the
> > > value is converted to an int; otherwise, it is converted to an
> > > unsigned int. These are called the integer promotions.`
> >
> > I think that it is probably worth noting that ntohs() has type 'int' in
> > this case because arm64 does not define CONFIG_ARCH_USE_BUILTIN_BSWAP to
> > use the version of __swab16() with a cast to __u16; rather, it uses the
> > one with the conditional operator, which per 6.5.15.5 means the type of
> > the result of the conditional operator is determined through these
> > promotion rules as well.
> >
> > I suspect that the conditional versions of __swab{16,32,64}() in
> > include/uapi/linux/swab.h want a cast on the outside of the conditional
> > operator with the specified type but I am not sure what other
> > repurcussions that might have so it is probably safer to just fix these
> > warnings up one by one.
> 
> Yes, there's a subtly where for ternary's the resulting type is the
> largest of all operands. When the LHS of the ? is larger than either
> results, the result is STILL the larger type.
> https://godbolt.org/z/EGjW8sqzf

Ha, I used the same test locally to make sure I was understanding things
correctly :)

> That said, regardless of that change, unnamed parameters of variadic
> functions will still undergo default argument promotion, so the __u16
> would still be promoted to int.  So we still want this patch, too.

Ah right, I forgot about the default argument promotion rules. While the
result of ntohs() would still be promoted to int (and we should use the
wider specifier for that reason as you said), we wouldn't see a warning
in the first place because the type of ntohs() would match the specifier
in all cases, rather than !CONFIG_ARCH_USE_BUILTIN_BSWAP, which is the
only reason I made that comment. I suspect adding that cast will clear
up more warnings than just this one, depending on how many there are
from ntohs() (and __swab16()).

> Justin, can you send a separate patch adding the explicit cast to to
> __u16 for the ternary expression in __swab16 when
> __HAVE_BUILTIN_BSWAP16__ is not defined?
> include/uapi/linux/swab.h
> Please include Nathan's suggested by tag; cc me and I'll provide review.
> 
> >
> > > Thus it makes sense to change %hu (as well as %u) to %d.
> >
> > Regardless of that, changing from '%hu' to '%d' is recommended so that
> > part of the change is fine. I am not sure that changing '%u' to '%d'
> > does anything other than add to the diff, as there was no warnings from
> > those, but consistency is key.
> 
> These types in the case of icmp are uint8_t; they also are
> default-argument-promoted to int. All possible values of uint8_t are
> representable by int, and so %d and %u will make no difference. It is
> "no functional change" and simply being consistent, as you say.

Right, I should have made that more clear by adding ", so that part is
fine as well", thanks for spelling it out!

Cheers,
Nathan
