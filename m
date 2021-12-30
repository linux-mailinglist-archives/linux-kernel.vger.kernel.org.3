Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F848193F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhL3EOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:14:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33029 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235835AbhL3EOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:14:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V0IJ-js_1640837668;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0IJ-js_1640837668)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 12:14:30 +0800
Date:   Thu, 30 Dec 2021 12:14:28 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] erofs: use meta buffers for xattr operations
Message-ID: <Yc0yJMgPGqUJ5Ju+@B-P7TQMD6M-0146.local>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
 <20211229041405.45921-5-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211229041405.45921-5-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 12:14:04PM +0800, Gao Xiang wrote:

...

>  
> @@ -659,6 +608,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	if (ret)
>  		return ret;
>  
> +	it.it.buf = __EROFS_BUF_INITIALIZER;
>  	it.dentry = dentry;
>  	it.buffer = buffer;
>  	it.buffer_size = buffer_size;
> @@ -669,6 +619,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	ret = inline_listxattr(&it);
>  	if (ret < 0 && ret != -ENOATTR)
>  		return ret;
> +	erofs_put_metabuf(&it.it.buf);
>  	return shared_listxattr(&it);

There is a bug here, I will fix it in the next version.

Thanks,
Gao Xiang

>  }
>  
> -- 
> 2.24.4
