Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10262542452
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386291AbiFHCF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841804AbiFHAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:08:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A319F052
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bjf+JB+wVxqKYyInjDis734wWz+kHKNkj5PzDHZNhCY=; b=mxldPOzI0bYYj/2pAoTFTm9amq
        sn5MLz64QAnytFq6wXehCPig00lmm86lbLq+wxD8+iRl8Xq6DI/aN52oBO7oDoy1Gy7jj6IFJcskF
        obq2f1BRzfcfZIAazBNrZh7R5OlSxjxWOIdVe8Vns47JRQNHhBfdBXn4NKZdRsfpdXsbLAHrenByn
        BXfbzDuc2dQ+f8KuS5svQEd3NDDj82SRB2nf0r8C/Hh8bMPAxWOsjh8OBrIV7dEVL9UIF1ZOujXX0
        RQzOR3h8aOXwQdQTpCDn2Z20Nl81+LMX6nlKqiYxOtuLOPYeG+4OUug9vNzxvWNF9hB6ntpwwJ5os
        SWj9xVkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyerO-00Buo2-WF; Tue, 07 Jun 2022 19:27:27 +0000
Date:   Tue, 7 Jun 2022 20:27:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Write in
 check_move_unevictable_pages
Message-ID: <Yp+mnq9x4/tIG+Sz@casper.infradead.org>
References: <0000000000003fc46005e0db5390@google.com>
 <00000000000063ade705e0de053e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000063ade705e0de053e@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:24:21AM -0700, syzbot wrote:
> BUG: KASAN: vmalloc-out-of-bounds in folio_batch_add include/linux/pagevec.h:130 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in check_move_unevictable_pages+0x3f6/0x440 mm/vmscan.c:4857

Oh, I forgot to call folio_batch_init(), so ->nr contains some stack
garbage and we index into hyperspace.  I'll fix it up, thanks.
