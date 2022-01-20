Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63D0494FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbiATOHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbiATOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:07:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C9C061574;
        Thu, 20 Jan 2022 06:07:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o12so21970020lfu.12;
        Thu, 20 Jan 2022 06:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=khQglnbXo1F6ghNCeJbEOjQxnRPP7WedSM2hEo1x1cg=;
        b=VQDTlTdn9a0nWrjEasDAQTrYLleF53p9YhUEw8B2T97sSUp+ixfG+inujDyMEADSnS
         QBAB49YGKsDyaAFS8TZ/FRdn1F3yBm9X9AteH3nKtr3DPB4d8PNHTYKscD14mG3009pQ
         LrLC87NnuDzUp6ieKWkWd7XjPXn/cG+tsBeWNCTloPeAcRVO66ZWaN1ZWdAM8d6zt9qy
         FvCOA2Kcxtq0opx8MAdh7PXVc5OUUn6AaizkD1Qwoc1nmsm85ApoHcdh2J6lHJLP2zIJ
         Z8Zt9njEsekwcrST3HWCIywDdOe9d6IU3KMDwF+SAF99OolUBuT1Ehd25W0mFXqAMZ3a
         wwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=khQglnbXo1F6ghNCeJbEOjQxnRPP7WedSM2hEo1x1cg=;
        b=XRzS3aT6nXG7WxzK61WL3VjmDUo7lLXfIqNp6nP7wK3XYf7cCH+71hSkW8UtbBQnM0
         oj2Gw7NUogD8LK8JUWrk7BbNifAZ1xGXxh3MkChsUs1AsFxfO6EDpBMQ0UEher4PeZlA
         +lUlNG/pLE1PI3QBFtOIB+a+fHtwPg2viF0O5sFJAc0yveXLqIbDmuTfP0/oydXu1Xzd
         ftMjyGyGhxYEIf/EHuVAf+d60ug7J+WzzTvQuNjYEGlJqFHKtZ6fvqGgGOOqO5pjQbjT
         2DVfSmw2Hx7H62wr+kCzmmLtp2cLWch8yDTP1iAYs2iJ9uZKYHDaIpWQW8RiCGwTCain
         HCAA==
X-Gm-Message-State: AOAM533WturD3dEoa6yZvchZNdJJKLbaiS5Wqs39DQ+iDAKfjpjF0X3C
        up3pJ5tD7qo+o9ecfgZzyq1IkrxxDLI8HQ==
X-Google-Smtp-Source: ABdhPJyYgy5IKkBVsVhnJIRa1iJhOKJFNE4g/PcTziDUYG491KJSxfnmv2Sq838gAN51s05Ue9jgjA==
X-Received: by 2002:a2e:958d:: with SMTP id w13mr28310203ljh.507.1642687657377;
        Thu, 20 Jan 2022 06:07:37 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id q5sm135798lfe.279.2022.01.20.06.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:07:37 -0800 (PST)
Message-ID: <0bc923d8-6565-69a3-c234-3789707efeb9@gmail.com>
Date:   Thu, 20 Jan 2022 17:07:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fs: nilfs2: fix memory leak in
 nilfs_sysfs_create_device_group
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220120134415.57147-1-dzm91@hust.edu.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220120134415.57147-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On 1/20/22 16:44, Dongliang Mu wrote:
> The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> nilfs_sysfs_delete_device_group") only handles the memory leak in the
> nilfs_sysfs_delete_device_group. However, the similar memory leak still
> occurs in the nilfs_sysfs_create_device_group.
> 
> Fix it by adding kobject_del when
> kobject_init_and_add succeeds, but one of the following calls fails.
> 
> Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_device_group")

Why Fixes tag points to my commit? This issue was introduced before my patch

> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>   fs/nilfs2/sysfs.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index 379d22e28ed6..0b2db2b499d5 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -995,7 +995,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
>   
>   	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
>   	if (err)
> -		goto cleanup_dev_kobject;
> +		goto delete_dev_kobject;
>   
>   	err = nilfs_sysfs_create_checkpoints_group(nilfs);
>   	if (err)
> @@ -1027,6 +1027,9 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
>   delete_mounted_snapshots_group:
>   	nilfs_sysfs_delete_mounted_snapshots_group(nilfs);
>   
> +delete_dev_kobject:
> +	kobject_del(&nilfs->ns_dev_kobj);
> +
>   cleanup_dev_kobject:
>   	kobject_put(&nilfs->ns_dev_kobj);
>   	kfree(nilfs->ns_dev_subgroups);
With regards,
Pavel Skripkin
