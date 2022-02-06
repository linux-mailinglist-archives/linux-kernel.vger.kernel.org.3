Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38D4AB270
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiBFVih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiBFVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:38:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1CDC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r+t4PcKV535fJ1zMDpcnTHvBXuLCN0XAAbrQTepxxJA=; b=O7eitr/kLhNRexf+ZI8jsPr6fE
        b+IwTBtBbyAEjIPgju/5PwN3cYXYLvYW/oDI5EUOdS3+xqvzTjHLjzjeqiOr2p0NJLF1L6/Xqq7Zf
        kWFmeFmeGqpRo8V+TC9WTZ2413MjgGBnbXstSxrks7ITn+/Gz8v8+9De//LscdL4wy2LeORS/EFus
        BcwHxB3UOti4taQCDsvWFj1UKTH6yEWKc8uzuTxrR60KKqLqJ6KreFeyNFCVSBYFWRnAHEjCVzwzI
        ohQKOmHYcidAFEUakVClWDl7ZATfynfqPnnaRdiHawzE9Qc1FKYHG7L+XntIkyd89heVBWRpNjAVL
        R7KS8KLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGpEn-00Fi0E-O4; Sun, 06 Feb 2022 21:38:25 +0000
Date:   Sun, 6 Feb 2022 21:38:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/13] mm/munlock: rework of mlock+munlock page handling
Message-ID: <YgA/0TfVOpQkMuQT@casper.infradead.org>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 01:27:41PM -0800, Hugh Dickins wrote:
> Here it is based on 5.17-rc2, applies also to -rc3, almost cleanly to
> mmotm 2022-02-03-21-58 (needs two easy fixups in mm/huge_memory.c); but
> likely to conflict (I hope not fundamentally) with several concurrent
> large patchsets.

Most of this patchset hasn't arrived here yet, but I would be
_delighted_ to rebase the folio conversion on top of this.  What
convoluted code it is!  I am so glad you've cleaned this up; I was
dreading doing the rest of the mlock file.
