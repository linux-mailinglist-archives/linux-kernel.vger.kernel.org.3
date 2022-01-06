Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA54863C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiAFL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:29:28 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50698 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238533AbiAFL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:29:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V15g75R_1641468564;
Received: from 30.225.24.46(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V15g75R_1641468564)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 19:29:25 +0800
Message-ID: <0dd319cf-8e2e-e378-368f-e419d5f9b6a6@linux.alibaba.com>
Date:   Thu, 6 Jan 2022 19:29:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] ocfs2: cluster: use default_groups in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ocfs2-devel@oss.oracle.com
References: <20220106102028.3345634-1-gregkh@linuxfoundation.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220106102028.3345634-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-and-Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

On 1/6/22 6:20 PM, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the ocfs2 cluster sysfs code to use default_groups field
> which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: ocfs2-devel@oss.oracle.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/ocfs2/cluster/masklog.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
> index 810d32815593..563881ddbf00 100644
> --- a/fs/ocfs2/cluster/masklog.c
> +++ b/fs/ocfs2/cluster/masklog.c
> @@ -120,7 +120,8 @@ static struct mlog_attribute mlog_attrs[MLOG_MAX_BITS] = {
>  	define_mask(KTHREAD),
>  };
>  
> -static struct attribute *mlog_attr_ptrs[MLOG_MAX_BITS] = {NULL, };
> +static struct attribute *mlog_default_attrs[MLOG_MAX_BITS] = {NULL, };
> +ATTRIBUTE_GROUPS(mlog_default);
>  
>  static ssize_t mlog_show(struct kobject *obj, struct attribute *attr,
>  			 char *buf)
> @@ -144,8 +145,8 @@ static const struct sysfs_ops mlog_attr_ops = {
>  };
>  
>  static struct kobj_type mlog_ktype = {
> -	.default_attrs = mlog_attr_ptrs,
> -	.sysfs_ops     = &mlog_attr_ops,
> +	.default_groups = mlog_default_groups,
> +	.sysfs_ops      = &mlog_attr_ops,
>  };
>  
>  static struct kset mlog_kset = {
> @@ -157,10 +158,10 @@ int mlog_sys_init(struct kset *o2cb_kset)
>  	int i = 0;
>  
>  	while (mlog_attrs[i].attr.mode) {
> -		mlog_attr_ptrs[i] = &mlog_attrs[i].attr;
> +		mlog_default_attrs[i] = &mlog_attrs[i].attr;
>  		i++;
>  	}
> -	mlog_attr_ptrs[i] = NULL;
> +	mlog_default_attrs[i] = NULL;
>  
>  	kobject_set_name(&mlog_kset.kobj, "logmask");
>  	mlog_kset.kobj.kset = o2cb_kset;
