Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84421537335
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiE3BHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiE3BHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:07:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B95EDC1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IPFTQZuRqUZGPpMs2Tbq5NA/YUi9v0QLAMJuBZ/M428=; b=bCTTDUuItadsxAakExgMdByKiI
        P8OT/Hh49mubuXG/9Fl84MxUsZqsv6au9iISF8jC9+7lfbVBHUagq+8vZPOXAofrb3EB71oEeItNd
        zOBog4I7dvZ9adR8yZ1GuoAvKa6VE65cZIyqcCLeCzKKdUzKN+fhdhu3TDdutHqIZmwjqYWc7nsYG
        k17WZ1v2MBbLuuz7ijAaPRM/8rmnGaV7YdVjQnTR/dSHm7zogL/oEDaiLg4p1VPrZxbMsLz6Q81w5
        DO5pcQhhy7RY+JffO51i7Diz2HfEkNdNndkGPJq82YwKugEr4w8esMehC50dZ77mpwPLdwwuIS/9G
        vchE/xnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvTse-0043JI-Ad; Mon, 30 May 2022 01:07:36 +0000
Date:   Mon, 30 May 2022 02:07:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in xas_nomem
Message-ID: <YpQY2HMaXEaTMNZe@casper.infradead.org>
References: <00000000000036af2005e009e7e6@google.com>
 <20220529163935.5118b4f91e2c5c3378ab326f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529163935.5118b4f91e2c5c3378ab326f@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 04:39:35PM -0700, Andrew Morton wrote:
> On Fri, 27 May 2022 20:20:21 -0700 syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    1e57930e9f40 Merge tag 'rcu.2022.05.19a' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17afc423f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5757003cb23a31a7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9e27a75a8c24f3fe75c1
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc056ef00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b7d9df00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com
> > 
> > BUG: memory leak
> 
> (hopefully cc's willy)

Thanks; I saw it, I've just been busy this weekend.
https://www.sportstats.ca/display-results.xhtml?raceid=114439&status=results&bib=3970
