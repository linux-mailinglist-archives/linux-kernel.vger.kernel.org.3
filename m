Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F34D9349
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbiCOEWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiCOEWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:22:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAED12A9A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C510EB80D20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DFCC340E8;
        Tue, 15 Mar 2022 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647318088;
        bh=92N7wiO5DH6MIG7OI/keYmonozvVE63Ota9hoIR7/bo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a3nmDbj9hIT5BHXOrUkOgHJYejfbiyt36AMauCj+660L/ij+0r8qn3+t7ZeUru05p
         WmdLq6/EgFi+wTmQStXFtofJdKqaaEwD4lQAg9BIftk1nxnhH5IwKLeX47t6SzeBmJ
         moVvwt94fdpD5H2p6mEK36/n8WHJ+mkJBLKt07w8=
Date:   Mon, 14 Mar 2022 21:21:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Marc Zyngier <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: Re: [PATCH] mm/migrate: fix race between lock page and clear
 PG_Isolated
Message-Id: <20220314212127.a2797926ee0ef8a7ad05dcaa@linux-foundation.org>
In-Reply-To: <20220315030515.20263-1-andrew.yang@mediatek.com>
References: <20220315030515.20263-1-andrew.yang@mediatek.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 11:05:15 +0800 Andrew Yang <andrew.yang@mediatek.com> wrote:

> When memory is tight, system may start to compact memory for large
> continuous memory demands. If one process tries to lock a memory page
> that is being locked and isolated for compaction, it may wait a long time
> or even forever. This is because compaction will perform non-atomic
> PG_Isolated clear while holding page lock, this may overwrite PG_waiters
> set by the process that can't obtain the page lock and add itself to the
> waiting queue to wait for the lock to be unlocked.
> 
> CPU1                            CPU2
> lock_page(page); (successful)
>                                 lock_page(); (failed)
> __ClearPageIsolated(page);      SetPageWaiters(page) (may be overwritten)
> unlock_page(page);
> 
> The solution is to not perform non-atomic operation on page flags while
> holding page lock.

Sure, the non-atomic bitop optimization is really risky and I suspect
we reach for it too often.  Or at least without really clearly
demonstrating that it is safe, and documenting our assumptions.

I'm thinking this one should be backported, so I'll queue it for
5.18-rc1, with a cc:stable so it gets trickled back.
