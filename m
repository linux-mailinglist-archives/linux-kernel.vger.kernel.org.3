Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873C8525908
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359758AbiEMAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiEMAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA57606CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07EAB6205A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DE7C385B8;
        Fri, 13 May 2022 00:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652402568;
        bh=n+YkgIXMbs5r/IrOg8NDKPb5pr+3M20tWFLhucxHzTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z9kjB3CuAN5ZwzDK7nRXCRFIMR2e3iFFqvaypZxsQnn2tBmW32umPWUIIWJIu7Ekt
         CzfUdZ0WXvcuwPdWqFBWhpVpY+gWfwUQe33y2QAZ9ifDzMDi/lKXfVIWoyq/vMIQEY
         6v0CLYJ10ftLPxn14WLZs2y6JwdM0aY3rGgbSnp8=
Date:   Thu, 12 May 2022 17:42:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?ISO-8859-1?Q?NAOYA?= (=?UTF-8?Q?=E5=A0=80=E5=8F=A3_?=
        =?UTF-8?Q?=E7=9B=B4=E4=B9=9F?=) <naoya.horiguchi@nec.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if
 swap read fails
Message-Id: <20220512174247.c4e178334879fb6b10134c2c@linux-foundation.org>
In-Reply-To: <2a95aebe-3a00-4699-12d4-fc5d934dde2c@huawei.com>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
        <20220424091105.48374-2-linmiaohe@huawei.com>
        <20220510061712.GA162496@hori.linux.bs1.fc.nec.co.jp>
        <2a95aebe-3a00-4699-12d4-fc5d934dde2c@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 14:58:05 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> > 
> > When I reproduced the issue (generated read error with dm-dust), I saw
> > infinite loop in the while loop in shmem_unuse_inode() (and this happens
> > even with this patch). I confirmed that shmem_swapin_page() returns -EIO,
> > but shmem_unuse_swap_entries() does not return the error to the callers,
> > so the while loop in shmem_unuse_inode() seems not break.
> > 
> 
> Many thanks for your report! I didn't test the shmem case because I saw -EIO
> is returned. So I just focus on the normal page case. Sorry about it. :(
> 
> > So maybe you need more code around shmem_unuse_inode() to handle the error?
> 
> I will try to reproduce it and come up a fixup patch asap! And if you like, you
> can kindly solve this issue too. ;)

Seems that this patch didn't cause the infinite loop, so as far as I
can tell it is good to be merged up.  But the problem it solves isn't
urgent and fixing that infinite loop might impact this change so I
think I'll drop this version.
