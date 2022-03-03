Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69754CB96D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiCCIn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:43:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5321E17
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26177B82423
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237BC004E1;
        Thu,  3 Mar 2022 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646296957;
        bh=wxx3qu0sZ0wQv3hV3t/+/URflGLqV8/abpb8AHjS6C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ffszb4I60l5M5WMVrHLPIVQQ2S1VhGgAcyC4rX5vqFN+04Frzv1IHDLCuqPu81n0L
         WDsu8UNbVQJNZDiaXpkAsdujuKhx6Ju9iIlV5PWMnfxDK1CUEyBbfMdRtSnjfqrWyS
         afyvS2wVV42YoL/87PfsJb4Me6pjRiTK89fmodWi6iu8SYkzUsm7p0nT4ZgxrcfXBl
         AeZ8q2NyPwxwzvs/49E+0/LXm3dplkhTn7giMvVGzYuQoKHVKrwijfz0gLS/4mn/3Z
         7jp41i6tzs3SMSymTS9qlxXUYHQH3wW/qLuFplILfq5CyGD5HRFEiu8IlAKHNgNaAW
         dOBUatl8q/ukw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: remove repeat container_of() in damon_sysfs_kdamond_release()
Date:   Thu,  3 Mar 2022 08:42:35 +0000
Message-Id: <20220303084235.356-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220303075314.22502-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,


On Thu, 3 Mar 2022 15:53:14 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_kdamond_release(), we have use container_of() to get
> "kdamond" pointer, so there no need to get it once again.

Good catch!  Thank you always :)

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index a4ad6b473b0a..687e7c7e8dea 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2432,7 +2432,7 @@ static void damon_sysfs_kdamond_release(struct kobject *kobj)
>  
>  	if (kdamond->damon_ctx)
>  		damon_destroy_ctx(kdamond->damon_ctx);
> -	kfree(container_of(kobj, struct damon_sysfs_kdamond, kobj));
> +	kfree(kdamond);
>  }
>  
>  static struct kobj_attribute damon_sysfs_kdamond_state_attr =
> -- 
> 2.27.0
