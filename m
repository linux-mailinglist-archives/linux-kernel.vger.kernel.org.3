Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91FF49537E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiATRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiATRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:46:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D556EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:46:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F58661702
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B02C340E5;
        Thu, 20 Jan 2022 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642700796;
        bh=e1uJFssQC8Z3OMC0Nax/ctnBNnBtNUwX7kg1Woy/Mbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=usAJvR482cG12Ju4uqKtyIznP78ktbsUZERqoqBRo6AD0oC8T7yeIE/DtUR6df8pR
         PNZttifl7CcF0TRRPYLfwv3V61ODyExKVea1c7Kr4uwqOQ7VF6C4bfHE/mzbzjoYUK
         IsJfSEq2LJ3sNZVS+ftoNIrbk4Vrq2dyhQOcOES+95o2j4PnLxPHT7hlCquMHHElIa
         m0Ir1o35zIOZAIQfKbaMlUsJVaQBNH5UA/odJinrAebjc2WLWtXSsLc7acfRKvJ5t0
         safwquk4N0ZJMUTCUI/Ah/8Jb09+3hlrOWwWvRc9jcif+okPCQuEJ60D/NYYCS0GFC
         EXJkPv1CEnapg==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Thu, 20 Jan 2022 17:46:30 +0000
Message-Id: <20220120174630.26102-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <00a90e13bba20c252a0ea1c0fb3e1c07b0fbb3b0.1642722660.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,


I guess this should be at least v3, as you posted v1[1] and v2[2] before.
Could you please also summarize what changes are made from v2?

On Fri, 21 Jan 2022 00:04:28 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> If you want to support "DAMON_DBGFS" in config file, it only depends on
> any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
> use damon virtual address function, but it is unreasonable to include
> "DAMON_PADDR" in config file which cause the damon/paddr.c be compiled.

My comment[3] to the v2 was,

    So, unless you make me believe the benefit is big enough and all possible
    corner cases are well handled and sufficiently tested, I'm sorry but I would
    not be convinced with this change.

I don't find answers to the requests here.  Could you please add those if you
have?

[1] https://lore.kernel.org/linux-mm/fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@lin
ux.alibaba.com/
[2] https://lore.kernel.org/linux-mm/b6bd0063-efb2-62ce-53ee-0193f63262d8@linux.alibaba.com/
[3] https://lore.kernel.org/linux-mm/20211123103855.12592-1-sj@kernel.org/


Thanks,
SJ

> 
> So there just do little change to fix it.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 16 ++++++++++++++++
>  mm/damon/Kconfig      |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 794b5f453662..c83e4588aa45 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -501,12 +501,28 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>  #ifdef CONFIG_DAMON_VADDR
>  bool damon_va_target_valid(void *t);
>  void damon_va_set_primitives(struct damon_ctx *ctx);
> +#else
> +static inline void damon_va_set_primitives(struct damon_ctx *ctx) { }
> +static inline bool damon_va_target_valid(void *t)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_DAMON_VADDR */
> 
>  #ifdef CONFIG_DAMON_PADDR
>  bool damon_pa_check(char *buf, size_t count);
>  bool damon_pa_target_valid(void *t);
>  void damon_pa_set_primitives(struct damon_ctx *ctx);
> +#else
> +static inline bool damon_pa_check(char *buf, size_t count)
> +{
> +	return false;
> +}
> +static inline void damon_pa_set_primitives(struct damon_ctx *ctx) { }
> +static inline bool damon_pa_target_valid(void *t)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_DAMON_PADDR */
> 
>  #endif	/* _DAMON_H */
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 5bcf05851ad0..a8952af3c8bf 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
> 
>  config DAMON_DBGFS
>  	bool "DAMON debugfs interface"
> -	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
> +	depends on (DAMON_VADDR || DAMON_PADDR) && DEBUG_FS
>  	help
>  	  This builds the debugfs interface for DAMON.  The user space admins
>  	  can use the interface for arbitrary data access monitoring.
> --
> 2.27.0
> 
