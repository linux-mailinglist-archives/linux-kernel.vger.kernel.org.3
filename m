Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2493447FBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbhL0KNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Dec 2021 05:13:11 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34408 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhL0KNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:13:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 87DDE614E2CD;
        Mon, 27 Dec 2021 11:13:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ysNS8lgvNeiu; Mon, 27 Dec 2021 11:13:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B5DDC614E2D5;
        Mon, 27 Dec 2021 11:13:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Re93ILpuHEY9; Mon, 27 Dec 2021 11:13:07 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8FFB3614E2CD;
        Mon, 27 Dec 2021 11:13:07 +0100 (CET)
Date:   Mon, 27 Dec 2021 11:13:07 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1020444725.206730.1640599987424.JavaMail.zimbra@nod.at>
In-Reply-To: <20211227032246.2886878-1-chengzhihao1@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
Subject: Re: [PATCH v6 00/15] Some bugfixs for ubi/ubifs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: Some bugfixs for ubi/ubifs
Thread-Index: AQ1RdLNSe9iocMwMdcHAv1rGWr/ndw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "mcoquelin stm32" <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 27. Dezember 2021 04:22:31
> Betreff: [PATCH v6 00/15] Some bugfixs for ubi/ubifs

> v1->v2:
>  1. Add new fix for ubifs, "ubifs: Fix to add refcount once page is set
>  private"
>  2. Update "ubifs: Rename whiteout atomically":
>     1) Move inode mode in create_whiteout()
>     2) Don't check O_SYNC for whiteout, because it inherits from the old_dir
>     3) Remove useless 'synced_i_size ' assignment for whiteout, because
>	it's always be zero.
>     4) Remove unused variable 'ui' in create_whiteout()
>  3. Update "ubifs: setflags: Make dirtied_ino_d 8 bytes aligned":
>     1) Align dirtied_ino_d with 8 bytes.
> 
> v2->v3:
>  1. Update "ubifs: Rename whiteout atomically":
>     1) Fix misspelling 'have already check the old dir inode' ->
>        'have already checked the old dir inode'
>     2) Fix misspelling "Whiteout don't have non-zero size" ->
>        "Whiteout  have non-zero size"
>  2. Update "ubifs: Fix to add refcount once page is set private"
>     1) Fix commit message to explain the root cause.
>  3. Update "ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when
>     fm->used_blocks>=2"
>     1) Add fastmap used pebs into 'ai' in for-loop, rather than in
>        two-steps(Add pebs [pnum<UBI_FM_MAX_START] then add pebs
>	[pnum>=UBI_FM_MAX_START] into 'ai').
> 
> v3->v4:
>  1. Update "ubifs: Add missing iput if do_tmpfile() failed in rename whiteout":
>     1) Move whiteout cleanup into do_tmpfile() according to Sascha's advice
>  2. Add new fix for ubifs, "ubifs: ubifs_writepage: Mark page dirty after
>     writing inode failed"
> 
> v4->v5:
>  1. Add new fix for ubifs, "ubifs: ubifs_releasepage: Remove ubifs_assert(0)
>     to valid this process"
> 
> v5->v6:
>  1. Add new fix for ubi: "ubi: fastmap: Fix high cpu usage of ubi_bgt by
>     making sure wl_pool not empty"
> 
> Zhihao Cheng (15):
>  ubifs: rename_whiteout: Fix double free for whiteout_ui->data
>  ubifs: Fix deadlock in concurrent rename whiteout and inode writeback
>  ubifs: Fix wrong number of inodes locked by ui_mutex in ubifs_inode
>    comment
>  ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
>  ubifs: Rename whiteout atomically
>  ubifs: Fix 'ui->dirty' race between do_tmpfile() and writeback work
>  ubifs: Rectify space amount budget for mkdir/tmpfile operations
>  ubifs: setflags: Make dirtied_ino_d 8 bytes aligned
>  ubifs: Fix read out-of-bounds in ubifs_wbuf_write_nolock()
>  ubifs: Fix to add refcount once page is set private
>  ubi: fastmap: Return error code if memory allocation fails in
>    add_aeb()
>  ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when
>    fm->used_blocks>=2
>  ubifs: ubifs_writepage: Mark page dirty after writing inode failed
>  ubifs: ubifs_releasepage: Remove ubifs_assert(0) to valid this process
>  ubi: fastmap: Fix high cpu usage of ubi_bgt by making sure wl_pool not
>    empty

Thanks a lot for all this fixes! I will start reviewing/picking them an
as soon the series is stable.
So please don't resend everything if you only add a new patch.

Thanks,
//richard
