Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A67488C7D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiAIVOX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jan 2022 16:14:23 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44904 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiAIVOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:14:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9F91E62DA608;
        Sun,  9 Jan 2022 22:14:20 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bSx-a38A2nzo; Sun,  9 Jan 2022 22:14:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A532F60A3582;
        Sun,  9 Jan 2022 22:14:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SFKkIQnS078n; Sun,  9 Jan 2022 22:14:19 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7997462DA608;
        Sun,  9 Jan 2022 22:14:19 +0100 (CET)
Date:   Sun, 9 Jan 2022 22:14:19 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1985807262.244880.1641762859448.JavaMail.zimbra@nod.at>
In-Reply-To: <20211227032246.2886878-6-chengzhihao1@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <20211227032246.2886878-6-chengzhihao1@huawei.com>
Subject: Re: [PATCH v6 05/15] ubifs: Rename whiteout atomically
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Rename whiteout atomically
Thread-Index: znpCv2h6Hs/0pJ+9Ww4OAQ97kBgRdg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "mcoquelin stm32" <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 27. Dezember 2021 04:22:36
> Betreff: [PATCH v6 05/15] ubifs: Rename whiteout atomically

> Currently, rename whiteout has 3 steps:
>  1. create tmpfile(which associates old dentry to tmpfile inode) for
>     whiteout, and store tmpfile to disk
>  2. link whiteout, associate whiteout inode to old dentry agagin and
>     store old dentry, old inode, new dentry on disk
>  3. writeback dirty whiteout inode to disk
> 
> Suddenly power-cut or error occurring(eg. ENOSPC returned by budget,
> memory allocation failure) during above steps may cause kinds of problems:
>  Problem 1: ENOSPC returned by whiteout space budget (before step 2),
>	     old dentry will disappear after rename syscall, whiteout file
>	     cannot be found either.
> 
>	     ls dir  // we get file, whiteout
>	     rename(dir/file, dir/whiteout, REANME_WHITEOUT)
>	     ENOSPC = ubifs_budget_space(&wht_req) // return
>	     ls dir  // empty (no file, no whiteout)
>  Problem 2: Power-cut happens before step 3, whiteout inode with 'nlink=1'
>	     is not stored on disk, whiteout dentry(old dentry) is written
>	     on disk, whiteout file is lost on next mount (We get "dead
>	     directory entry" after executing 'ls -l' on whiteout file).
> 
> Now, we use following 3 steps to finish rename whiteout:
>  1. create an in-mem inode with 'nlink = 1' as whiteout
>  2. ubifs_jnl_rename (Write on disk to finish associating old dentry to
>     whiteout inode, associating new dentry with old inode)
>  3. iput(whiteout)
> 
> Rely writing in-mem inode on disk by ubifs_jnl_rename() to finish rename
> whiteout, which avoids middle disk state caused by suddenly power-cut
> and error occurring.

How do you make sure the the whiteout is never written to disk (by writeback) before ubifs_jnl_rename() linked
it? That's the reason why other filesystems use the tmpfile mechanism for whiteouts too.

Thanks,
//richard
