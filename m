Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBA4F16FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbiDDObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377366AbiDDObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:31:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D22222AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XpS5aZQkcSL10p2MN2J1N7nVQsjQzVnvWn1ELX+BXSY=; b=bvAU1XgLDOVwe2ywssCcBJ6i7y
        girD+4D7WObAaZhLv/bNsnHQ96firOrDf3CVewm3tb5IbUSQTQaMxbBlHEwZVI19MYh5jsEZPqilU
        Q1i/bqz4cnyuQYuJ1Zh/wHNzVPqofZhj6dW5kUtLIFB7v1ICO9qBmGcR0dzzhGXeREm0oOa133xbe
        ZmXPv0sc1pB/cFhAim5noIwDvvfv6Fr3Gc/Ds6diOFYU/qoMDBPdor5PMTHPhZf/LPukm+Q5wRJeW
        J+Eqx9cF9+WHHGale+r+CJTrNzqRtUS2+bY3xla17aQiNptNaFiF2Mv/Uh49Mh6RXP7zzE1Bhp/VE
        rNuCDg1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbNhh-005ng0-Os; Mon, 04 Apr 2022 14:29:13 +0000
Date:   Mon, 4 Apr 2022 15:29:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers
 VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Message-ID: <YksAub9UccPZa9DI@casper.infradead.org>
References: <20220404132908.GA785673@u2004>
 <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 10:05:00AM -0400, Zi Yan wrote:
> On 4 Apr 2022, at 9:29, Naoya Horiguchi wrote:
> > I found that the below VM_BUG_ON_FOLIO is triggered on v5.18-rc1
> > (and also reproducible with mmotm on 3/31).
> > I have no idea about the bug's mechanism, but it seems not to be
> > shared in LKML yet, so let me just share. config.gz is attached.
> >
> > [   48.206424] page:0000000021452e3a refcount:6 mapcount:0 mapping:000000003aaf5253 index:0x0 pfn:0x14e600
> > [   48.213316] head:0000000021452e3a order:9 compound_mapcount:0 compound_pincount:0
> > [   48.218830] aops:xfs_address_space_operations [xfs] ino:dee dentry name:"libc.so.6"
> > [   48.225098] flags: 0x57ffffc0012027(locked|referenced|uptodate|active|private|head|node=1|zone=2|lastcpupid=0x1fffff)
> > [   48.232792] raw: 0057ffffc0012027 0000000000000000 dead000000000122 ffff8a0dc9a376b8
> > [   48.238464] raw: 0000000000000000 ffff8a0dc6b23d20 00000006ffffffff 0000000000000000
> > [   48.244109] page dumped because: VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
> > [   48.249196] ------------[ cut here ]------------
> > [   48.251240] kernel BUG at mm/memcontrol.c:6857!
> > [   48.260535] RIP: 0010:mem_cgroup_migrate+0x217/0x320
> > [   48.286942] Call Trace:
> > [   48.287665]  <TASK>
> > [   48.288255]  iomap_migrate_page+0x64/0x190
> > [   48.289366]  move_to_new_page+0xa3/0x470
> 
> Is it because migration code assumes all THPs have order=HPAGE_PMD_ORDER?
> Would the patch below fix the issue?

This looks entirely plausible to me!  I do have changes in this area,
but clearly I should have submitted them earlier.  Let's get these fixes
in as they are.

Is there a test suite that tests page migration?  I usually use xfstests
and it does no page migration at all (at least 'git grep migrate'
finds nothing useful).

