Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3835247699E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhLPFZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhLPFZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:25:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FBC061574;
        Wed, 15 Dec 2021 21:25:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D283FB82232;
        Thu, 16 Dec 2021 05:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D90C36AE2;
        Thu, 16 Dec 2021 05:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639632353;
        bh=+eJtz//5cGB7b9ENlk4d9Q+wDotc77DfxSWMK6U3Dwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfj9zuny/Ijd19+ICpHntStcMtSC1zYpyPwnNCUjXs9/rNvV90gurIYOItvqYiaCr
         mCQO9rrijE9HGEmDdnBfcApYhR9CnryQL12Ml8jPY4Oi9OecwDN+mRl9iD6U+NcvkO
         4HODK/ElklFB2tgVGmQECPbNkDtx8bLZR3brfzcUNqmHe7J5aN0Y3KdGLGB+Tj9NDl
         XTFwpzx12t3eAjqBvCewf4lqa7qLFLCHWy4iqNlrre8fgx1yR2obB6y5R0VBljsWjJ
         V2pvp1YGo4akwGVM1/N4vHyvp7NmGNMoG3BGcDXH0ycq8IV6zwzs/DCTBcbTP2idbX
         cQXo+8YxTsZkQ==
Date:   Thu, 16 Dec 2021 10:55:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <quic_bbhatt@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        Carl Huang <cjhuang@codeaurora.org>,
        Carl Yin <carl.yin@quectel.com>, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: core: Use correctly sized arguments for bit
 field
Message-ID: <20211216052545.GA42608@thinkpad>
References: <20211215232446.2069794-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215232446.2069794-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:24:46PM -0800, Kees Cook wrote:
> The find.h APIs are designed to be used only on unsigned long arguments.
> This can technically result in a over-read, but it is harmless in this
> case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> which we'd like to enable globally:
> 
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:22,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:55,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from ./include/linux/debugfs.h:15,
>                  from drivers/bus/mhi/core/init.c:7:
> drivers/bus/mhi/core/init.c: In function 'to_mhi_pm_state_str':
> ./include/linux/find.h:187:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'enum mhi_pm_state[1]' [-Warray-bounds]
>   187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                                     ^~~~~
> drivers/bus/mhi/core/init.c:80:51: note: while referencing 'state'
>    80 | const char *to_mhi_pm_state_str(enum mhi_pm_state state)
>       |                                 ~~~~~~~~~~~~~~~~~~^~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

A small nit pick below but I'll fix it up while applying.

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index f1ec34417592..b91f75fff962 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -79,7 +79,8 @@ static const char * const mhi_pm_state_str[] = {
>  
>  const char *to_mhi_pm_state_str(enum mhi_pm_state state)
>  {
> -	int index = find_last_bit((unsigned long *)&state, 32);
> +	unsigned long bits = state;

Variable "bits" could be changed to "pm_state".

> +	int index = find_last_bit(&bits, 32);
>  
>  	if (index >= ARRAY_SIZE(mhi_pm_state_str))
>  		return "Invalid State";
> -- 
> 2.30.2
> 
