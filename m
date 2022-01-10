Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08831489546
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbiAJJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:35:09 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31082 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbiAJJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:35:06 -0500
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JXT9G5s6Vz1FCWs;
        Mon, 10 Jan 2022 17:31:30 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 17:35:04 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 17:35:03 +0800
Subject: Re: [PATCH v6 05/15] ubifs: Rename whiteout atomically
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        "kirill shutemov" <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
 <20211227032246.2886878-6-chengzhihao1@huawei.com>
 <1985807262.244880.1641762859448.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0477fadd-dfb5-c581-ee6a-ed6df9a966a3@huawei.com>
Date:   Mon, 10 Jan 2022 17:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1985807262.244880.1641762859448.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Richard
> 
> How do you make sure the the whiteout is never written to disk (by writeback) before ubifs_jnl_rename() linked
> it? That's the reason why other filesystems use the tmpfile mechanism for whiteouts too.
> 

The whiteout inode is clean after creation from create_whiteout(), and 
it can't be marked dirty until ubifs_jnl_rename() finished. So, I think 
there is no chance for whiteout being written on disk. Then, 
'ubifs_assert(c, !whiteout_ui->dirty)' never fails in ubifs_jnl_rename() 
during my local stress tests. You may add some delay executions after 
whiteout creation to make sure that whiteout won't be written back 
before ubifs_jnl_rename().

BTW, I considered plan B(Binding whiteout to a negative dentry), but we 
cannot get parent dir's entry in do_rename(), so I abandoned it.
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1334,7 +1335,8 @@ static int do_rename(struct inode *old_dir, struct 
dentry *old_dentry,
                         goto out_release;
                 }

-               err = do_tmpfile(old_dir, old_dentry, S_IFCHR | 
WHITEOUT_MODE, &whiteout);
+               // tmp_dentry = d_alloc(old_dir_dentry, &slash_name); 
// refer to vfs_tmpfile
+               err = do_tmpfile(old_dir, tmp_dentry, S_IFCHR | 
WHITEOUT_MODE, &whiteout);
                 if (err) {
                         kfree(dev);
                         goto out_release;
