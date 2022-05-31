Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094AA539131
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbiEaM7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245085AbiEaM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:59:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4969165A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BUGBteA8JfJc0y+36tB67b05qFOjdvVc5xttIZ7wN/s=; b=pgO9wo+FHXzCz6tvx585lEwztt
        X6GBD59PGZXI0hlG4z61Q+5Ogny9aGHZsbtPHm9jSzubwFESORwhFP4Ydh+LWGt17e5jCCP1BR5t/
        FW477VYiIpBYv3Xh3cHlbagKul15CCZpzjjNPVlkPhIUwvMUOPyuehCLfaqWeL3Qpo3PoOrWHivrP
        XL32olI79zvFkNvcD/e1dsrQoYzIonKuI/Lta3uTgOuM85YxMcDm7A6p3bpJifQBbh45y+Edec+gw
        /hDZRkiEfjBeOvxbQ6g+qDg/6RgpjghKLJ6QDyXVmzfu/4xhjJT+bVfj5JP/QT/7Cji2flZeZ6DuP
        5l97hFfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw1SC-005O1Z-0G; Tue, 31 May 2022 12:58:32 +0000
Date:   Tue, 31 May 2022 13:58:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        peterx@redhat.com, apopple@nvidia.com, ying.huang@intel.com,
        osalvador@suse.de, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
Message-ID: <YpYQ937N8Daad6u/@casper.infradead.org>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530113016.16663-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 07:30:13PM +0800, Miaohe Lin wrote:
> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
> extends the period of the rcu_read_lock until after the permissions checks
> are done to prevent the task pointed to from changing from under us. But
> the task_struct refcount is also taken at that time, the reference to task
> is guaranteed to be stable. So it's unnecessary to extend the period of
> the rcu_read_lock. Release the rcu lock after task refcount is successfully
> grabbed to reduce the rcu holding time.

But why bother?  You know the RCU read lock isn't a "real" lock, right?
