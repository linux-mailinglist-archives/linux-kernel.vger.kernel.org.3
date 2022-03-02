Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876D4CA396
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiCBL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiCBL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:27:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECBC606E0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF0C61804
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF105C004E1;
        Wed,  2 Mar 2022 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646220388;
        bh=6W7SfMZEcKBurppT4JmTriEQYTHDDhDDMD4bmaPdRXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=O06KienHdNP5Xzvk47c9xmfX43LzwPGlQvZ8akIT/CrIDqq3tNwDG+kmhBfu20MFE
         uBYbaRInWh4e8h+HU97a27Xz4F1ha3v13aE982AeNHcxRHD4iNsBZLK1/de+CVPby8
         JD+R3mvxh6e1CQs7muMNzo9Pp5ceM9yKomo2EsawBc3cmolWj9JagufFykzktHl878
         qXBohdjUgDY/huPfaWb7VXIctUQu/mDdJyLxIFz2Zw8lS47v67rvHRIkQ1dF6+wPlK
         jWk3DnD6Fd4XXa8MuMsUN2kB1XPzOk7SP6DczoKcs3uhqATUPAAMS7/qc9toQg0qtJ
         zAPcHSW1YhciA==
From:   SeongJae Park <sj@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm/damon/sysfs: Fix missing error code in damon_sysfs_attrs_add_dirs()
Date:   Wed,  2 Mar 2022 11:26:25 +0000
Message-Id: <20220302112625.7345-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302111120.24984-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 19:11:20 +0800 Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> The error code is missing in this code scenario, add the error code
> '-ENOMEM' to the return value 'err'.
> 
> Eliminate the follow smatch warning:
> 
> mm/damon/sysfs.c:1647 damon_sysfs_attrs_add_dirs() warn: missing error
> code 'err'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Good eye, thank you!

Reviewed-by: SeongJae Park <sj@kernel.org>

Andrew, please fold this patch into
mm-damon-implement-a-minimal-stub-for-sysfs-based-damon-interface.patch[1].

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-damon-implement-a-minimal-stub-for-sysfs-based-damon-interface.patch


Thanks,
SJ

> ---
>  mm/damon/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 32a9d21c0db5..0eca71163924 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1643,8 +1643,10 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
>  	attrs->intervals = intervals;
>  
>  	nr_regions_range = damon_sysfs_ul_range_alloc(10, 1000);
> -	if (!nr_regions_range)
> +	if (!nr_regions_range) {
> +		err = -ENOMEM;
>  		goto put_intervals_out;
> +	}
>  
>  	err = kobject_init_and_add(&nr_regions_range->kobj,
>  			&damon_sysfs_ul_range_ktype, &attrs->kobj,
> -- 
> 2.20.1.7.g153144c
