Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE358850C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiHCAMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHCAMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:12:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AFF1D0E0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFFDDB8215D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC31C433D6;
        Wed,  3 Aug 2022 00:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659485536;
        bh=j5DiZB7awx92wK0xf/+EzvYAorL6T6kj0ZX0XBRlF8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EGn4PBf25k/O0WyCujaARDLi3ImjZPQnLCb8RLVnya4HGjSIYl57o9MM9zpftWr+v
         0l8NttqRxekOg3CoUc6kLUguHLUw7XY+e+K4iqpBl5AojVbku9iBhId9pDYI5JVCay
         1XX2dgTNnbCPgTzYdtuxcHbFMHNUDYmX9jPWDqtI=
Date:   Tue, 2 Aug 2022 17:12:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, jgg@nvidia.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com, david@redhat.com
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Message-Id: <20220802171215.3c909e1984ec345ff94af155@linux-foundation.org>
In-Reply-To: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Aug 2022 10:30:12 +1000 Alistair Popple <apopple@nvidia.com> wrote:

> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. This is indicated by returning zero. When all pages
> are in the correct zone the number of pinned pages is returned.
> 
> However migration can also fail, in which case pages are unpinned and
> -ENOMEM is returned. However if the failure was due to not being unable
> to isolate a page zero is returned. This leads to indefinite looping in
> __gup_longterm_locked().
> 
> Fix this by simplifying the return codes such that zero indicates all
> pages were successfully pinned in the correct zone while errors indicate
> either pages were migrated and pinning should be retried or that
> migration has failed and therefore the pinning operation should fail.
> 
> This fixes the indefinite looping on page isolation failure by failing
> the pin operation instead of retrying indefinitely.
> 

Are we able to identify a Fixes: for this?  Presumably something in the
series "Add MEMORY_DEVICE_COHERENT for coherent device memory mapping"?
