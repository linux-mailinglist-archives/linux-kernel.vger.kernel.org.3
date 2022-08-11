Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63325908C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiHKWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHKWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:44:13 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9069C8F8;
        Thu, 11 Aug 2022 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=41VaQhN6jBu2TRCoY2HPGKTvHCVOHtR6Uu0laLQNqvY=; b=s1WMml9knuBcXv2L4QTpJfeMZm
        Q2fGkpv5fvDNKiuf7f+xhuB9isZYfr3rvm8eStkpQ52kASGe5XCJygLUImwE0sSVw2wSLSp3IV0PX
        B3u4DUtIKE8lbEYFo4HCvUOg2MANjWkwq5aqoBlf1UChWMSEKgVkWmwEGXM6qfv6n5FWeSh/UNP9R
        8evvo4f9WmsBaH2NiXUwTkzLUTJteKgbr9Jz/zh7Y20aqZkrn4y8Drg5PKIyvI7QEVHnxUFwJPkkV
        PgwgGxe/330DJbSBD0qzo6He2OUcLN6QkefaIhlZ7/sQvgd8bj/S12UnQq3MqpgaDwKwhsRe59Yok
        10gwlvVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oMGuO-003Zay-7O;
        Thu, 11 Aug 2022 22:44:08 +0000
Date:   Thu, 11 Aug 2022 23:44:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
Message-ID: <YvWGOKqmuaGm8yCd@ZenIV>
References: <20220811152446.281723-1-idryomov@gmail.com>
 <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
 <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV>
 <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
 <YvV2zfT0XbgwHGe/@ZenIV>
 <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
 <YvV86p5DjBLjjXHo@ZenIV>
 <CAHk-=wjCa=Xf=pA2Z844WnwEeYgy9OPoB2kWphvg7PVn3ohScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCa=Xf=pA2Z844WnwEeYgy9OPoB2kWphvg7PVn3ohScw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:22:38PM -0700, Linus Torvalds wrote:
> On Thu, Aug 11, 2022 at 3:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > FWIW, I wonder if we should do
> >         if (READ_ONCE(dentry->d_parent) != parent)
> >                 continue;
> > before grabbing ->d_lock (and repeat the check after grabbing it,
> 
> It kind of makes sense. We already do that d_name.hash check outside
> of the lock, so we already have that "we might race with a rename"
> situation.
> 
> That said, I do think __d_lookup_rcu() is the more important of the two.
> 
> Here's a recreation of that patch I mentioned where the OP_COMPARE is
> moved out of the loop. Just for fun, look at how much better the code
> generation is for the common case when you don't have the call messing
> up the clobbered registers etc.
> 
> Entirely untested, and I might have messed something up, but I suspect
> this is a much bigger deal than whether d_same_name() is inlined or
> not in the non-RCU path.

Looks sane at the first pass, but right now I'm really half-asleep - 5 hours
of sleep tonight, and about the same yesterday ;-/

I'll try to grab at least an hour or two and reread it once I'm more or less
awake...
