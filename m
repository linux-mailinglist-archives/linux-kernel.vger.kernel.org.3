Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315C1489615
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiAJKOW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 05:14:22 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:54490 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbiAJKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:14:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A59D9614E2C4;
        Mon, 10 Jan 2022 11:14:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WaqFIDSVFe8L; Mon, 10 Jan 2022 11:14:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0F0F3614E2CB;
        Mon, 10 Jan 2022 11:14:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ow2vDdpUq3-d; Mon, 10 Jan 2022 11:14:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D1EFD614E2C4;
        Mon, 10 Jan 2022 11:14:03 +0100 (CET)
Date:   Mon, 10 Jan 2022 11:14:03 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1422943582.246718.1641809643674.JavaMail.zimbra@nod.at>
In-Reply-To: <0477fadd-dfb5-c581-ee6a-ed6df9a966a3@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <20211227032246.2886878-6-chengzhihao1@huawei.com> <1985807262.244880.1641762859448.JavaMail.zimbra@nod.at> <0477fadd-dfb5-c581-ee6a-ed6df9a966a3@huawei.com>
Subject: Re: [PATCH v6 05/15] ubifs: Rename whiteout atomically
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Rename whiteout atomically
Thread-Index: Of79WMESjxJ46JfpBVi92+tw9bYfxg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "mcoquelin stm32"
> <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 10. Januar 2022 10:35:02
> Betreff: Re: [PATCH v6 05/15] ubifs: Rename whiteout atomically

> Hi, Richard
>> 
>> How do you make sure the the whiteout is never written to disk (by writeback)
>> before ubifs_jnl_rename() linked
>> it? That's the reason why other filesystems use the tmpfile mechanism for
>> whiteouts too.
>> 
> 
> The whiteout inode is clean after creation from create_whiteout(), and
> it can't be marked dirty until ubifs_jnl_rename() finished. So, I think
> there is no chance for whiteout being written on disk. Then,
> 'ubifs_assert(c, !whiteout_ui->dirty)' never fails in ubifs_jnl_rename()
> during my local stress tests. You may add some delay executions after
> whiteout creation to make sure that whiteout won't be written back
> before ubifs_jnl_rename().

From UBIFS point of view I fully agree with you. I'm just a little puzzled why
other filesystems use the tmpfile approach. My fear is that VFS can do things
to the inode we don't have in mind right now.

Thanks,
//richard
