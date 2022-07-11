Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFA570C29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiGKUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:47:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5641D24
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XrLdqfPwURSj69Ep14KJAkiXrmXt6ijJ4MRJWNKc45s=; b=RENKm906mJC1CPNUrTj//EtxjB
        ODJ6LCUxuYKVl3TZ799Tz5Jj20/2u8K8Sj+/cnsHAxXdcJYmJVS+V7Kfkjb+GTKjjfd4eRKlMcNf0
        SLg8VrC+8dRAGJDQxEAxLC6uXf7hJz1CEikVye87ngGiFcj5eimww85g9AWMnBdrKCw6lfVPocxGH
        PNs2LLlsdcSymV1WCIPkysS2Kr0EYVLU5Zo6+PUbOlY4rVPBtVmKw3oB+/WUN7c9VnmI6rhrzm5YI
        QHJzl57I/7LHvlwscmfzzS3QzuZf+jRgDpoWNl3C0B+LJH+0KXdrKzKnGqM9MgzX1tWfty144NTLC
        hGe3djOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB0J1-006HJO-F9; Mon, 11 Jul 2022 20:46:59 +0000
Date:   Mon, 11 Jul 2022 21:46:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Zach O'Keefe <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] memory leak in xas_create
Message-ID: <YsyMQ2jzOICVbCda@casper.infradead.org>
References: <000000000000eb2d6c05e35a0d73@google.com>
 <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 01:38:08PM -0700, Andrew Morton wrote:
> On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> > 
> > 2022/07/05 05:22:17 executed programs: 828
> > 2022/07/05 05:22:23 executed programs: 846
> > 2022/07/05 05:22:30 executed programs: 866
> > 2022/07/05 05:22:37 executed programs: 875
> > BUG: memory leak
> 
> Thanks.  Presumably due to khugepaged changes.

Huh, I was expecting it to be something I'd messed up.  I've been
looking at it today, but no luck figuring it out so far.

> Can we expect a bisection search?

We only have a syz reproducer so far, and if I understand correctly,
it's probably because this is a flaky test (because it's trying to
find something that's a race condition).

I expect a bisection search to go badly wrong if this is true.
