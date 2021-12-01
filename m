Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C254644DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbhLAC2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:28:48 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54218 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241292AbhLAC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:28:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UywMFvQ_1638325498;
Received: from 30.225.24.35(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UywMFvQ_1638325498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Dec 2021 10:24:59 +0800
Message-ID: <92d4d393-9734-9f7e-4440-20429bdac14f@linux.alibaba.com>
Date:   Wed, 1 Dec 2021 10:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] ocfs2: fix uninitialized variable in
 ocfs2_dio_wr_get_block()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>, ryan.ding@oracle.com,
        Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Sunil Mushran <sunil.mushran@oracle.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Mark Fasheh <mark@fasheh.com>
References: <20211130104043.GB5827@kili>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20211130104043.GB5827@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/21 6:40 PM, Dan Carpenter wrote:
> The callers assume that "*fsdata" is set on the success path, but
> that's not necessarily true on this path.
> 

In ocfs2_page_mkwrite(), since in this case no target page locked, it
will finally return VM_FAULT_NOPAGE (better VM_FAULT_RETRY?) and throw 
to handle_mm_fault(). So no problem as comments described.

But things seems changed since append direct io path started to use
write_[begin/end]. In this path, the target page is expected as NULL.
This needs more discussion.

Thanks,
Joseph

> Fixes: 5cffff9e2986 ("ocfs2: Fix ocfs2_page_mkwrite()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Please review this one EXTRA CAREFULLY.  It's from static analysis and
> the truth is I'm not 100% sure it's correct.  I'm also not sure that
> it's a complete fix.
> 
> Especially, please review how this is called from ocfs2_write_begin()
> to make sure that this doesn't break anything.
> 
> 
>  fs/ocfs2/aops.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 68d11c295dd3..a74a370f16f0 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -1813,6 +1813,7 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
>  	if (ret == -EAGAIN) {
>  		BUG_ON(wc->w_target_page);
>  		ret = 0;
> +		*fsdata = wc;
>  		goto out_quota;
>  	}
>  
> 
