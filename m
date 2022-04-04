Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9D4F1820
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378490AbiDDPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiDDPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:20:06 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342528E34
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:18:10 -0700 (PDT)
Date:   Tue, 5 Apr 2022 00:18:05 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649085488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZ2miKBTVPr3F+L5ojFoVTTDrRk5AYtrEEP/TQPrTdw=;
        b=iaj9dlWqaS7vybtNKFDB++49DZVieYTAJhxXSpIM6itTj+7vhMoGhgS47O1lXtt1WUFHvx
        OvjqHtyuLtXvPlGbr04YmWmDG31ijAiXNElchjylQ86whJp5pD/k1Riw9Nzpr3iz7OE3m0
        L1nuSJjpjQ+uk7brFUkI/iuXgWggRm8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers
 VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Message-ID: <20220404151805.GA800317@u2004>
References: <20220404132908.GA785673@u2004>
 <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
 <YksAub9UccPZa9DI@casper.infradead.org>
 <C4792D17-A7F6-4803-B8FC-B8682F50E044@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C4792D17-A7F6-4803-B8FC-B8682F50E044@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 10:47:20AM -0400, Zi Yan wrote:
> On 4 Apr 2022, at 10:29, Matthew Wilcox wrote:
> 
> > On Mon, Apr 04, 2022 at 10:05:00AM -0400, Zi Yan wrote:
> >> On 4 Apr 2022, at 9:29, Naoya Horiguchi wrote:
> >>> I found that the below VM_BUG_ON_FOLIO is triggered on v5.18-rc1
> >>> (and also reproducible with mmotm on 3/31).
> >>> I have no idea about the bug's mechanism, but it seems not to be
> >>> shared in LKML yet, so let me just share. config.gz is attached.
> >>>
> >>> [   48.206424] page:0000000021452e3a refcount:6 mapcount:0 mapping:000000003aaf5253 index:0x0 pfn:0x14e600
> >>> [   48.213316] head:0000000021452e3a order:9 compound_mapcount:0 compound_pincount:0
> >>> [   48.218830] aops:xfs_address_space_operations [xfs] ino:dee dentry name:"libc.so.6"
> >>> [   48.225098] flags: 0x57ffffc0012027(locked|referenced|uptodate|active|private|head|node=1|zone=2|lastcpupid=0x1fffff)
> >>> [   48.232792] raw: 0057ffffc0012027 0000000000000000 dead000000000122 ffff8a0dc9a376b8
> >>> [   48.238464] raw: 0000000000000000 ffff8a0dc6b23d20 00000006ffffffff 0000000000000000
> >>> [   48.244109] page dumped because: VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
> >>> [   48.249196] ------------[ cut here ]------------
> >>> [   48.251240] kernel BUG at mm/memcontrol.c:6857!
> >>> [   48.260535] RIP: 0010:mem_cgroup_migrate+0x217/0x320
> >>> [   48.286942] Call Trace:
> >>> [   48.287665]  <TASK>
> >>> [   48.288255]  iomap_migrate_page+0x64/0x190
> >>> [   48.289366]  move_to_new_page+0xa3/0x470
> >>
> >> Is it because migration code assumes all THPs have order=HPAGE_PMD_ORDER?
> >> Would the patch below fix the issue?

I briefly confirmed that this bug didn't reproduce with your change,
thank you very much!

- Naoya Horiguchi

> >
> > This looks entirely plausible to me!  I do have changes in this area,
> > but clearly I should have submitted them earlier.  Let's get these fixes
> > in as they are.
> >
> > Is there a test suite that tests page migration?  I usually use xfstests
> > and it does no page migration at all (at least 'git grep migrate'
> > finds nothing useful).
> 
> https://github.com/linux-test-project/ltp has some migrate_pages and move_pages
> tests. You can run them after install ltp:
> sudo ./runltp -f syscalls -s migrate_pages and
> sudo ./runltp -f sys calls -s move_pages

