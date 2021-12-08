Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C646CAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhLHCF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:05:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50936 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHCF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:05:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5506EB81E56
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 02:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805F7C341C8;
        Wed,  8 Dec 2021 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638928943;
        bh=TJShJeJra4JM6lK+S2xnRB0dnR+l73/WBrpKq55FgUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBk8I8kDnBTczD+FSxOu9Z6r+SSkJls4SdJKsn6KcKVjE+RBbRWX5YsldLg0Sp4et
         A5JGKLF4b0NKNaHfoyqSxy6qd8++wcITgyDNpdsVphLQbDz6/eMoz/GTmYX8KP8mzV
         Hmka5bQSORrR2Pimq2TsLXMoP5BVqMRXhRberUwnCX9zoaE+vBTihnpWwQFj/AFjHk
         J3tL5KFqdWpUBDEWr+ZHdkmHW94Nv5znzJWc9afVS4TOWPMRQ/YOPggZDfA6O8vB7A
         bls5UgXnHIt4fFOfSy+IjP6bCr+ziLs4LlUbZv5WDWb8C9/W8G+ZnV3VfunHv4jxjL
         z37RppbAvgYFw==
Date:   Wed, 8 Dec 2021 10:02:05 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Huang Jianan <jnhuang95@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-kernel@vger.kernel.org, guoweichao@oppo.com,
        guanyuwei@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v7 2/3] erofs: add sysfs interface
Message-ID: <20211208020204.GA13528@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <jnhuang95@gmail.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-kernel@vger.kernel.org, guoweichao@oppo.com,
        guanyuwei@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        Huang Jianan <huangjianan@oppo.com>
References: <CAJfKizqxkt4BYa26cmOgCD9OFOck_J0NZ8hxCQbVoyv0j4SMJg@mail.gmail.com>
 <20211201145436.4357-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201145436.4357-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Wed, Dec 01, 2021 at 10:54:36PM +0800, Huang Jianan wrote:
> Add sysfs interface to configure erofs related parameters later.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Reviewed-by: Chao Yu <chao@kernel.org>

...

> +static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
> +						const char *buf, size_t len)
> +{
> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
> +						s_kobj);
> +	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
> +	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
> +	unsigned long t;
> +	int ret;
> +
> +	switch (a->attr_id) {
> +	case attr_pointer_ui:
> +		if (!ptr)
> +			return 0;
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if (t > UINT_MAX)
> +			return -EINVAL;

Intel 0day CI report a warning.
https://lore.kernel.org/r/61aede22.lQ5T3RqGz2H%2Fg4aR%25lkp@intel.com

I fix this like below:

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 41a7de772412..33e15fa63c82 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -128,8 +128,8 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
                ret = kstrtoul(skip_spaces(buf), 0, &t);
                if (ret)
                        return ret;
-               if (t > UINT_MAX)
-                       return -EINVAL;
+               if (t != (unsigned int)t)
+                       return -ERANGE;
                *(unsigned int *)ptr = t;
                return len;
        case attr_pointer_bool:

Thanks,
Gao Xiang

