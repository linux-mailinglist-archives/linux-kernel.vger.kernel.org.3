Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334D4D9C57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348749AbiCONgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCONgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:36:03 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A476443
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:34:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7HuS4f_1647351284;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7HuS4f_1647351284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 21:34:46 +0800
Date:   Tue, 15 Mar 2022 21:34:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: erofs: add sanity check for kobject in
 erofs_unregister_sysfs
Message-ID: <YjCV9PEK6nE7ufjd@B-P7TQMD6M-0146.local>
References: <20220315132814.12332-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315132814.12332-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:28:14PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> is triggered by injecting fault in kobject_init_and_add of
> erofs_unregister_sysfs.
> 
> Fix this by adding sanity check for kobject in erofs_unregister_sysfs
> 
> Note that I've tested the patch and the crash does not occur any more.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/sysfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index dac252bc9228..f3babf1e6608 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -221,9 +221,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> -	wait_for_completion(&sbi->s_kobj_unregister);
> +	if (sbi->s_kobj.state_in_sysfs) {
> +		kobject_del(&sbi->s_kobj);
> +		kobject_put(&sbi->s_kobj);
> +		wait_for_completion(&sbi->s_kobj_unregister);
> +	}
>  }
>  
>  int __init erofs_init_sysfs(void)
> -- 
> 2.25.1
