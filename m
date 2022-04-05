Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9C4F527F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850553AbiDFCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836748AbiDFAja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9191AECA5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3792661989
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACC3C385A0;
        Tue,  5 Apr 2022 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649198953;
        bh=awHlS99jHdeeMvW5vMaa8y/eOaLgtQdto8jxDdWuvoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yW8xzL99stdIIsz1Uwj8ViHVbX6o3MGkdk44C90KDUPId1u1fTiKrM/mhj+w9my6a
         NKkuPzZ8tep66QFQCMXVXJvbzDykqLe9xpPaHvZNa9ngt2PRiTliYYyLF+A/hMVXPj
         95uIs5AyCqnV6GBbZyjMH3A/pUDCQIgmIOEYVc2E=
Date:   Tue, 5 Apr 2022 15:49:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-Id: <20220405154912.4cda03c2cc5d801d25d5c2dd@linux-foundation.org>
In-Reply-To: <YkzF4/e86qwcuXiA@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
        <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
        <YkzF4/e86qwcuXiA@xz-m1.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 18:42:43 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Tue, Apr 05, 2022 at 03:16:16PM -0700, Andrew Morton wrote:
> > On Mon,  4 Apr 2022 21:46:23 -0400 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
> > > write protection. 
> > 
> > Various compilation catastrophes with x86_64 allnoconfig.  I poked at
> > the include ordering for a while but other things quickly became more
> > attractive ;)
> 
> Sorry about that.  I still don't know what's the problem, but I'll give it
> a shot soon.
> 
> I think I only tried out with the new configs but not all the rest configs.
> I thought there're some bot looking after that one, from which I used to
> receive build reports. And IIRC I fixed some build issues in early versions
> from those reports.  Maybe I was wrong..
> 
> Any more hints on the latter?

`make allnoconfig'?
