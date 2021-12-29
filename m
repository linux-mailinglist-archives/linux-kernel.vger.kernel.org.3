Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051C480EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhL2Brh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 20:47:37 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57213 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232932AbhL2Brf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:47:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V0B6Ze5_1640742452;
Received: from 30.225.24.43(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V0B6Ze5_1640742452)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Dec 2021 09:47:33 +0800
Message-ID: <c91e5edb-9d27-f05d-6151-8aaf030583a7@linux.alibaba.com>
Date:   Wed, 29 Dec 2021 09:47:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] ocfs2: use default_groups in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm <akpm@linux-foundation.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com
References: <20211228144517.391660-1-gregkh@linuxfoundation.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20211228144517.391660-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

On 12/28/21 10:45 PM, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the ocfs2 code to use default_groups field which has been
> the preferred way since aa30f47cf666 ("kobject: Add support for default
> attribute groups to kobj_type") so that we can soon get rid of the
> obsolete default_attrs field.
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@oss.oracle.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/ocfs2/filecheck.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
> index de56e6231af8..1ad7106741f8 100644
> --- a/fs/ocfs2/filecheck.c
> +++ b/fs/ocfs2/filecheck.c
> @@ -94,6 +94,7 @@ static struct attribute *ocfs2_filecheck_attrs[] = {
>  	&ocfs2_filecheck_attr_set.attr,
>  	NULL
>  };
> +ATTRIBUTE_GROUPS(ocfs2_filecheck);
>  
>  static void ocfs2_filecheck_release(struct kobject *kobj)
>  {
> @@ -138,7 +139,7 @@ static const struct sysfs_ops ocfs2_filecheck_ops = {
>  };
>  
>  static struct kobj_type ocfs2_ktype_filecheck = {
> -	.default_attrs = ocfs2_filecheck_attrs,
> +	.default_groups = ocfs2_filecheck_groups,
>  	.sysfs_ops = &ocfs2_filecheck_ops,
>  	.release = ocfs2_filecheck_release,
>  };
