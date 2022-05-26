Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CB534D42
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbiEZKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiEZKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:23:25 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E8C5DAF
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:23:23 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8B90E217A;
        Thu, 26 May 2022 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653560574;
        bh=W0DpAQyoq876DrlqhAskeolqdKC31dHHiEqyp43/xeA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nVKc598zYVkv4trcv6ycpLzm2MBB7bkuHWBKSVJ48+E/dr80+9RoTkfwTODOmZtK2
         HwcMM/G8xbobEczyaUoIDErAZso5CRSRXydi2RKvyx7TroYYiH4ZhoobB4p5g8JRsO
         lZVB6lSGUDhHkNY+5vv3KitKM+580cIO1AyD0tao=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 26 May 2022 13:23:21 +0300
Message-ID: <14b2ae23-2f7b-401a-dcee-cc6114849022@paragon-software.com>
Date:   Thu, 26 May 2022 13:22:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] fs/ntfs3: fix null pointer dereference in
 d_flags_for_inode
Content-Language: en-US
To:     Liangbin Lian <jjm2473@gmail.com>, <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>
References: <20220506034656.50038-1-jjm2473@gmail.com>
From:   Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220506034656.50038-1-jjm2473@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Thank you for reporting this bug.
The bug happens because we don't initialize i_op for records in $Extend.
We tested patch on our side, let me know if patch helps you too.

     fs/ntfs3: Fix missing i_op in ntfs_read_mft
     
     There is null pointer dereference because i_op == NULL.
     The bug happens because we don't initialize i_op for records in $Extend.
     Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
     
     Reported-by: Liangbin Lian <jjm2473@gmail.com>
     Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 879952254071..b2cc1191be69 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -430,6 +430,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
         } else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
                    fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
                 /* Records in $Extend are not a files or general directories. */
+               inode->i_op = &ntfs_file_inode_operations;
         } else {
                 err = -EINVAL;
                 goto out;


On 5/6/22 06:46, Liangbin Lian wrote:
> ntfs_read_mft may return inode with null i_op, cause null pointer dereference in d_flags_for_inode (inode->i_op->get_link).
> Reproduce:
>   - sudo mount -t ntfs3 -o loop ntfs.img ntfs
>   - ls ntfs/'$Extend/$Quota'
> 
> The call trace is shown below (striped):
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   CPU: 0 PID: 577 Comm: ls Tainted: G           OE     5.16.0-0.bpo.4-amd64 #1  Debian 5.16.12-1~bpo11+1
>   RIP: 0010:d_flags_for_inode+0x65/0x90
>   Call Trace:
>   ntfs_lookup
>   +--- dir_search_u
>   |    +--- ntfs_iget5
>   |         +--- ntfs_read_mft
>   +--- d_splice_alias
>        +--- __d_add
>             +--- d_flags_for_inode
> 
> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> ---
>   fs/ntfs3/inode.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 9eab11e3b..b68d26fa8 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -45,7 +45,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>   	struct MFT_REC *rec;
>   	struct runs_tree *run;
>   
> -	inode->i_op = NULL;
>   	/* Setup 'uid' and 'gid' */
>   	inode->i_uid = sbi->options->fs_uid;
>   	inode->i_gid = sbi->options->fs_gid;
