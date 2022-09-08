Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3845B262B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiIHSuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiIHStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168B30546
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32ED961DCB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12022C433D7;
        Thu,  8 Sep 2022 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662662990;
        bh=9blEcl+kQyexkHeFxKpL4hVCHMxyX6MRyBgDynt2ggA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUYMF6ihxRMbLcvAo6bo2tuSSmkMIp+xGcGekfAMRsJYAgB2hx3pUoob0W9ZShep4
         7xx/DZ/EZc5vgUVSoMNN7y1PT7Tri5U9UjSmREmB261CbfPx108eUd4pihulssseze
         yFRu7JUKS3AxNeF5JUMc+MSIyphZIyLh/kNTS2pWhCOkR6a8vGNrBfCiKR6OmnX27+
         z7UcDie4z0fmoQOy8gw9D8x0XXdgOiCT17IVj3ePqmRnd1VsQ86XVtJFJbsY0nlrk+
         f/8qHDKwjwVyfOW9H/YgqUTq1nffhfYpZeyojGYCB/v/DaIQYFELps/7O9uHmitbdD
         EdkJ9T5DOMQRA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
Date:   Thu,  8 Sep 2022 18:49:47 +0000
Message-Id: <20220908184947.103206-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908081932.77370-1-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Thu, 8 Sep 2022 16:19:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call

checkpatch complains as below:

    WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
    #10:
    These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call

> kstrtoint() to get relative values from sysfs interface, if it return an
> error, there get kobject instance would be meaningless through 'container_of'.

I was thinking the compiler could do that kind of optimization on its own, so I
preferred to make the code shorter.

This change makes the code slightly longer, while the benefit of the change is
unclear.  I'd like to keep it as is unless we get some clear benefit of this?


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/sysfs.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 88f208ff235d..54fdfcdbb3e4 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1031,8 +1031,7 @@ static ssize_t nr_schemes_show(struct kobject *kobj,
>  static ssize_t nr_schemes_store(struct kobject *kobj,
>  		struct kobj_attribute *attr, const char *buf, size_t count)
>  {
> -	struct damon_sysfs_schemes *schemes = container_of(kobj,
> -			struct damon_sysfs_schemes, kobj);
> +	struct damon_sysfs_schemes *schemes;
>  	int nr, err = kstrtoint(buf, 0, &nr);
>  
>  	if (err)
> @@ -1040,6 +1039,8 @@ static ssize_t nr_schemes_store(struct kobject *kobj,
>  	if (nr < 0)
>  		return -EINVAL;
>  
> +	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
> +
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return -EBUSY;
>  	err = damon_sysfs_schemes_add_dirs(schemes, nr);
> @@ -1237,8 +1238,7 @@ static ssize_t nr_regions_show(struct kobject *kobj,
>  static ssize_t nr_regions_store(struct kobject *kobj,
>  		struct kobj_attribute *attr, const char *buf, size_t count)
>  {
> -	struct damon_sysfs_regions *regions = container_of(kobj,
> -			struct damon_sysfs_regions, kobj);
> +	struct damon_sysfs_regions *regions;
>  	int nr, err = kstrtoint(buf, 0, &nr);
>  
>  	if (err)
> @@ -1246,6 +1246,8 @@ static ssize_t nr_regions_store(struct kobject *kobj,
>  	if (nr < 0)
>  		return -EINVAL;
>  
> +	regions = container_of(kobj, struct damon_sysfs_regions, kobj);
> +
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return -EBUSY;
>  	err = damon_sysfs_regions_add_dirs(regions, nr);
> @@ -1440,8 +1442,7 @@ static ssize_t nr_targets_show(struct kobject *kobj,
>  static ssize_t nr_targets_store(struct kobject *kobj,
>  		struct kobj_attribute *attr, const char *buf, size_t count)
>  {
> -	struct damon_sysfs_targets *targets = container_of(kobj,
> -			struct damon_sysfs_targets, kobj);
> +	struct damon_sysfs_targets *targets;
>  	int nr, err = kstrtoint(buf, 0, &nr);
>  
>  	if (err)
> @@ -1449,6 +1450,8 @@ static ssize_t nr_targets_store(struct kobject *kobj,
>  	if (nr < 0)
>  		return -EINVAL;
>  
> +	targets = container_of(kobj, struct damon_sysfs_targets, kobj);
> +
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return -EBUSY;
>  	err = damon_sysfs_targets_add_dirs(targets, nr);
> @@ -1962,8 +1965,7 @@ static ssize_t nr_contexts_show(struct kobject *kobj,
>  static ssize_t nr_contexts_store(struct kobject *kobj,
>  		struct kobj_attribute *attr, const char *buf, size_t count)
>  {
> -	struct damon_sysfs_contexts *contexts = container_of(kobj,
> -			struct damon_sysfs_contexts, kobj);
> +	struct damon_sysfs_contexts *contexts;
>  	int nr, err;
>  
>  	err = kstrtoint(buf, 0, &nr);
> @@ -1973,6 +1975,7 @@ static ssize_t nr_contexts_store(struct kobject *kobj,
>  	if (nr < 0 || 1 < nr)
>  		return -EINVAL;
>  
> +	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return -EBUSY;
>  	err = damon_sysfs_contexts_add_dirs(contexts, nr);
> @@ -2741,8 +2744,7 @@ static ssize_t nr_kdamonds_show(struct kobject *kobj,
>  static ssize_t nr_kdamonds_store(struct kobject *kobj,
>  		struct kobj_attribute *attr, const char *buf, size_t count)
>  {
> -	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
> -			struct damon_sysfs_kdamonds, kobj);
> +	struct damon_sysfs_kdamonds *kdamonds;
>  	int nr, err;
>  
>  	err = kstrtoint(buf, 0, &nr);
> @@ -2751,6 +2753,8 @@ static ssize_t nr_kdamonds_store(struct kobject *kobj,
>  	if (nr < 0)
>  		return -EINVAL;
>  
> +	kdamonds = container_of(kobj, struct damon_sysfs_kdamonds, kobj);
> +
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return -EBUSY;
>  	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
> -- 
> 2.31.0
