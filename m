Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC914CC947
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiCCWma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiCCWm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:42:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539751662FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=52IPoiZlULRFsRfp7a+MOcHPPK5OVaKArRJeKTkzhvo=; b=KRjqs5qByXCCtDLJuVi6CXCPEi
        Lpe0SgN11Y9rnKZhPft2uhbuREDPHnG+3PYR9R9faV5PJG2TCg9lOpWNOZHWAzJaT1lfLmOojK3xL
        1P00Mu4GJnFpxvLRLiGHRJg1rmHpX3zEgakW1IWBZbdAnXP77Kp6GEI0XJGNfYbprut/I6tYMccVY
        R7AiMS81A4YWCTxb2MK1mCg6sLoiWcWzmYpvJiv+sagrOqn0TYMAIW8dpAC7qCWSThbsurU/ahF3P
        nSvw2sANT59tduACOlNAgWIVloDzRiiJPl2oDSOmqF6/3QLpFKZY5Epf3+UtBH2DVIFL2M4/PhNyt
        gHkqkyrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPu8g-00C3LQ-Kt; Thu, 03 Mar 2022 22:41:38 +0000
Date:   Thu, 3 Mar 2022 22:41:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: delete __ClearPageWaiters()
Message-ID: <YiFEIslJ9m57G6wM@casper.infradead.org>
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
 <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com>
 <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:28:46PM -0800, Hugh Dickins wrote:
> On Thu, 3 Mar 2022, David Hildenbrand wrote:
> > On 03.03.22 02:56, Hugh Dickins wrote:
> > > The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
> > > vmscan.c's free_unref_page_list() callers rely on that not to generate
> > > bad_page() alerts.  So __page_cache_release() and release_pages() (and
> > > the presumably copy-and-pasted put_zone_device_private_or_public_page())
> 
> Hah, I'm showing my age there, or the patch's age: it's been rebranded
> frequently since then, with linux-next calling it free_zone_device_page(),
> as you kindly point out.  How long before it's free_zone_device_folio()?

Probably not a serious question, but within the next year, I expect.
I have a prototype patch to do the entire page freeing path, but it
wasn't a priority for this merge window.
