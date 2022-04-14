Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67150180E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349648AbiDNQAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359472AbiDNPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:45:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF223F3A5B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yidt7R5bheIfbYpn867nE8JQLZqnVpDSVLNv8ery+dk=; b=FAnI244LULICsDqLqtDUx9+abr
        dmQY4PY/y5ohjZDKBQQ/9ng7A+uDXKdNQYVYgNfSWPNBOefKpMm4rOLkDAtQjRCszNW8ErMWtMKBP
        Z+Q6cAmqL4GvFjSMUKt5RYbo7B2xwEFHZ6rFDHQ511QF6XVddbJb0lXitM9zDWGHSHDrjeJroHeFk
        SuIXr9JnXZkRorlXP7z/RLhOtqsputjnaXSsTKFhVUfvAvSHkKtp0i0Wh6K3Tn3PhOvuFW/4GK82s
        aQnNfJkoMGepsrQ6mDNtqo8PfAfVuI4tNkE+QvHY3nPdSAARUnvYk0mu/wpl9jKDJtd/O4dgGG7LC
        uERcRV6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf1Ru-00536U-Am; Thu, 14 Apr 2022 15:31:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D54D73002DE;
        Thu, 14 Apr 2022 17:31:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5DD62041A9A0; Thu, 14 Apr 2022 17:31:57 +0200 (CEST)
Date:   Thu, 14 Apr 2022 17:31:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <Ylg+bewBpaqqYgeB@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
 <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
 <20220414152148.cwdefx744kymqcut@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414152148.cwdefx744kymqcut@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:21:48AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 14, 2022 at 09:05:47AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 13, 2022 at 04:19:37PM -0700, Josh Poimboeuf wrote:
> > 
> > > @@ -34,8 +37,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
> > >  
> > >  	str = malloc(strlen(name) + 20);
> > >  
> > > -	if (func)
> > > -		sprintf(str, "%s()+0x%lx", name, name_off);
> > > +	if (sym)
> > > +		sprintf(str, "%s%s+0x%lx", name, is_text ? "()" : "", name_off);
> > >  	else
> > >  		sprintf(str, "%s+0x%lx", name, name_off);
> > 
> > So I like the patch, except that "()" thing is something where we differ
> > from the kernel's %ps format and I've cursed it a number of times
> > because I then have to manually edit (iow remove) things when pasting it
> > in various scripts etc..
> 
> Oh, hm, that's true.  I can remove them if you prefer.

Yeah, I think taking it out is best, easier if we're consistent with %ps
for everybody.

> > That said, it totally makes sense to differentiate between a text and
> > data symbol this way :/
> 
> Yes, but if we're keeping the "Add sec+offset to warnings" patch then
> that distinction is already (kind of) being made by showing the data
> section name.  And the data symbol warnings should be rare.

Yes, I'd not seen that yet, what's that for? The Changelog alludes to
something, but I don't think it actually does get used later.
