Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4532E4690BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhLFHW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:22:59 -0500
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:47970 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238367AbhLFHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:22:58 -0500
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3AD031812E207;
        Mon,  6 Dec 2021 07:19:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 14FC136;
        Mon,  6 Dec 2021 07:18:27 +0000 (UTC)
Message-ID: <c9e11594e7edbbf8ee0a01a5009457a2c4a79ffc.camel@perches.com>
Subject: Re: [PATCH v2] uacce: use sysfs_emit instead of sprintf
From:   Joe Perches <joe@perches.com>
To:     Kai Ye <yekai13@huawei.com>, gregkh@linuxfoundation.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Date:   Sun, 05 Dec 2021 23:18:27 -0800
In-Reply-To: <20211206070943.45971-1-yekai13@huawei.com>
References: <20211206070943.45971-1-yekai13@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.51
X-Stat-Signature: 6jgz9zig8ybgcwhjzm93p4hihmuq9spj
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 14FC136
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX185Y5inXYrUxkzkZxWYJPHp1Xne4MA8TpY=
X-HE-Tag: 1638775107-18119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 15:09 +0800, Kai Ye wrote:
> Use the sysfs_emit to replace sprintf. sprintf may cause
> output defect in sysfs content, it is better to use new
> added sysfs_emit function which knows the size of the
> temporary buffer.
[]
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
[]
> @@ -309,7 +309,7 @@ static ssize_t available_instances_show(struct device *dev,
>  	if (!uacce->ops->get_available_instances)
>  		return -ENODEV;
>  
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		       uacce->ops->get_available_instances(uacce));

It's generally good form to rewrap the multiple line statements
to the open parenthesis so the below would be better:

	return sysfs_emit(buf, "%d\n",
			  uacce->ops->get_available_instances(uacce));

> @@ -326,7 +326,7 @@ static ssize_t region_mmio_size_show(struct device *dev,
>  {
>  	struct uacce_device *uacce = to_uacce_device(dev);
>  
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       uacce->qf_pg_num[UACCE_QFRT_MMIO] << PAGE_SHIFT);

etc...


