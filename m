Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2409B495382
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiATRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiATRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:47:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:47:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17632B81E12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F338C340E3;
        Thu, 20 Jan 2022 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642700839;
        bh=52Vom63+2nYZBhxD1RMj3ztHrMkbvCgFFWu3ZvFzGgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=FkJ7nIf5DOqqTeNelTwEkRaGGLLXjfbOQS/f/Q1OHSat8A/e/n96xPb/BWnSQtDaF
         G/fiP/RQwCHusqFYh4/WCm57lJYrxSPM0LwnJGnjjrsbHhhAHzeqSXoBFTAHbtIMJ7
         tyGlbRNgWwsoATDDC1mZq1Vdhr8AgyKWIAEQ1LO8/TKKEe4fiLOO+lml3kj4l3ClHt
         rSmrt477Ehukhy7hTuFcPon73ckAaGrOV6/pgtgN78pmetedDEfOCs2hi0sbHuis3Z
         UMJ3c5s4cLjiVbREa8jaKfxy5rkyHnR+qumHUxGFQFrwCmbz2zIEdhqs73Q44J/Oi5
         YyLndUidiZXVw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] mm/damon/dbgfs: Put "paddr" check into damon_pa_check() func
Date:   Thu, 20 Jan 2022 17:47:16 +0000
Message-Id: <20220120174717.26158-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <44060c744a3760b1ecf6ce52a9b4ec842fa55eef.1642722660.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Fri, 21 Jan 2022 00:04:27 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> The purpose of putting "paddr" check into damon_pa_check() func
> is to better solve "DAMON_DBGFS" dependency on both "DAMON_VADDR"
> and "DAMON_PADDR".

Syntax of "paddr" is dbgfs's own.  I don't think handling it in paddr is a
right thing to do.


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/dbgfs.c      | 2 +-
>  mm/damon/paddr.c      | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 5e1e3a128b77..794b5f453662 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -504,6 +504,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
>  #endif	/* CONFIG_DAMON_VADDR */
> 
>  #ifdef CONFIG_DAMON_PADDR
> +bool damon_pa_check(char *buf, size_t count);
>  bool damon_pa_target_valid(void *t);
>  void damon_pa_set_primitives(struct damon_ctx *ctx);
>  #endif	/* CONFIG_DAMON_PADDR */
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 5b899601e56c..cdb9c1e2ab29 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -374,7 +374,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>  	if (IS_ERR(kbuf))
>  		return PTR_ERR(kbuf);
> 
> -	if (!strncmp(kbuf, "paddr\n", count)) {
> +	if (damon_pa_check(kbuf, count)) {
>  		id_is_pid = false;
>  		/* target id is meaningless here, but we set it just for fun */
>  		scnprintf(kbuf, count, "42    ");
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5e8244f65a1a..14a6bf2a2adb 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -208,6 +208,14 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
>  	return max_nr_accesses;
>  }
> 
> +bool damon_pa_check(char *buf, size_t count)
> +{
> +	if (!strncmp(buf, "paddr\n", count))
> +		return true;
> +
> +	return false;
> +}
> +
>  bool damon_pa_target_valid(void *t)
>  {
>  	return true;
> --
> 2.27.0
> 
> 
