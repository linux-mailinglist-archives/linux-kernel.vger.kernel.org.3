Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C92590880
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiHKWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiHKWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:04:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243B94EF3;
        Thu, 11 Aug 2022 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wq45TFbP2AKILUBXx++bf06XJdFtfjvXV9u0Ru13Lv4=; b=hZeoY/QMps6s+T3DAxj6Mj86EK
        i74PHci6KNWl9D0ZgPLqENS/3Bp8QnaNbHGtG+Y72pwDAxqxp0rFLe7vgM0pwzngnGlN8vY1Kfew+
        wdIQujnP2TvdMuUaQ8M5RTB8aolPgp5oTcpz9xxql7c5PKcphUTGSimpVhRb7YmIIUhWn4peQu41B
        2ml9drJ+JjfC/q1fTk0DBjtJriR16FK6I3ZxQSgsdCXbdWen5wZW/ZArsHmhTZeLhA3GQnVc5addF
        oAtv+Vha6CcgsEp2dR+/JO1hLde+3rpVJHaOzxjSxZ/hE6LsvObUxGb4QvfvFhPytdvpJuyfUgbbY
        VWmcEzEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oMGHz-003ZFe-0R;
        Thu, 11 Aug 2022 22:04:27 +0000
Date:   Thu, 11 Aug 2022 23:04:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
Message-ID: <YvV86p5DjBLjjXHo@ZenIV>
References: <20220811152446.281723-1-idryomov@gmail.com>
 <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
 <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV>
 <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
 <YvV2zfT0XbgwHGe/@ZenIV>
 <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 02:52:26PM -0700, Linus Torvalds wrote:
> On Thu, Aug 11, 2022 at 2:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Exporting the functionality?  Sure, no problem.  Uninlining that one...
> > I suspect that it's OK, but I'd like to see profiling data; it's not
> > as if it would be hard to return to having it inlined, obviously.
> 
> The only case where I think it might matter is in __d_lookup(), and
> it's probably not measurable.
> 
> Yes, __d_lookup() does matter, but it only matters once you've fallen
> out of RCU mode, and at that point the cost of the function call is
> likely in the noise.
> 
> I don't particularly like how it's inside that dentry hash chain loop,
> but realistically by then we've already done a function call for the
> dentry lock spinlock, so that loop already has to deal with it.

FWIW, I wonder if we should do
	if (READ_ONCE(dentry->d_parent) != parent)
		continue;
before grabbing ->d_lock (and repeat the check after grabbing it,
of course).  It's OK from correctness POV - we are OK with false
negatives from __d_lookup() if concurrent rename happens.  And
it just might be a sufficiently large performance win...
