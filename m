Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B72564B44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGDBnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiGDBnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540864E5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E79A66134B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FC9C341C6;
        Mon,  4 Jul 2022 01:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656898980;
        bh=/LMQ8BboRFFus9I/l+fXn306egan/qVJVZnhwpwGzBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QYjD4qaV1QJKWOycKvk8iwmzRD8fmoKoPmYJtUEuuPU6jL+YskiZxAQepyT47cyZt
         XGe+2xlP/tORKOZPfqfARmSU0oI923n/NM1ZghDyo1yDT3x/bfP7UnJFJPg/iG0YcS
         Adm05c6sOnFb+/uRhYOJ4aLgv+8NgxsnCqMVzBCE=
Date:   Sun, 3 Jul 2022 18:42:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable PATCH v4 2/9] mm/hugetlb: separate path for
 hwpoison entry in copy_hugetlb_page_range()
Message-Id: <20220703184259.99a37313037000bd2e9ace9a@linux-foundation.org>
In-Reply-To: <20220704013312.2415700-3-naoya.horiguchi@linux.dev>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
        <20220704013312.2415700-3-naoya.horiguchi@linux.dev>
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

On Mon,  4 Jul 2022 10:33:05 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:

> Originally copy_hugetlb_page_range() handles migration entries and hwpoisoned
> entries in similar manner.  But recently the related code path has more code
> for migration entries, and when is_writable_migration_entry() was converted
> to !is_readable_migration_entry(), hwpoison entries on source processes got
> to be unexpectedly updated (which is legitimate for migration entries, but
> not for hwpoison entries).  This results in unexpected serious issues like
> kernel panic when forking processes with hwpoison entries in pmd.
> 
> Separate the if branch into one for hwpoison entries and one for migration
> entries.
> 
> ...
>
> Cc: <stable@vger.kernel.org> # 5.18

It's unusual to have a cc:stable patch in the middle of a series like
this.  One would expect the fix to be a standalone thing against
current -linus.

As presented, this patch won't get into mainline until after 5.20-rc1. 
If that's OK then OK.  Otherwise I can shuffle things around and stage
this patch in mm-hotfixes?

