Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68695480F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhL2DwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:52:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39342 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhL2DwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEE9CB81806
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C96CC36AE7;
        Wed, 29 Dec 2021 03:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640749931;
        bh=vjtsNUUMkIinnGK3dCSQAtvu19a85YrXX81k+IY0q6k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hZcEcJqjLlhwLmNayO5bcQjvrgLtTskoMhpGJutOl/GwV9LgEvCfp6KHr743OVkiO
         65DcXcge3D9CjxCP9NkRqGQBODuyBmKSD0U2GXqXXWQwb03kkI3bmp/2ONzz3Ovxe4
         QuDz34ouIi0hqCQ4OOFicrbiW0vqistbZpo7W4+W0sguPwNXnUQ03jc+ewgbOjm6Ia
         DO83X6M1csF4vlkJiS29r36DmCBfo3vl+HWCKXVXm98fAYgLN5oLKSARqpcDo2bN2Z
         0Mn1ffVeXALCK7WZiE3I+m5WxoKW9kH1TIe8YTClRaQ/4JiwgF5ROc0i/j8IuqJ9Io
         xa13DFU5UecvQ==
Subject: Re: [PATCH] ARC: dw2 unwind: use swap() to make code cleaner
To:     cgel.zte@gmail.com, vgupta@kernel.org
Cc:     ye.guojin@zte.com.cn, yangdianqing@yulong.com, wjc@cdjrlc.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20211110055602.136926-1-ye.guojin@zte.com.cn>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <b49ad227-f849-bea9-5f8d-fc76d130f7fd@kernel.org>
Date:   Tue, 28 Dec 2021 19:52:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211110055602.136926-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 9:56 PM, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> This was found by coccicheck:
> ./arch/arc/kernel/unwind.c, 251, 22-23, WARNING opportunity for swap()
> ./arch/arc/kernel/unwind.c, 254, 18-19, WARNING opportunity for swap()
> 
> Addtionally, adjust the sequence of header files to be arranged in
> alphabetical order.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>   arch/arc/kernel/unwind.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 9e28058cdba8..ea795304982a 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -10,17 +10,18 @@
>    * is not much point in implementing the full Dwarf2 unwind API.
>    */
>   
> -#include <linux/sched.h>
> -#include <linux/module.h>
> +#include <asm/sections.h>
> +#include <asm/unaligned.h>
> +#include <asm/unwind.h>

No this is not correct. We always include linux/* first followed by any 
specific arch asm/* includes.

>   #include <linux/memblock.h>
> -#include <linux/sort.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/ptrace.h>
> +#include <linux/sched.h>
>   #include <linux/slab.h>
> +#include <linux/sort.h>
>   #include <linux/stop_machine.h>
>   #include <linux/uaccess.h>
> -#include <linux/ptrace.h>
> -#include <asm/sections.h>
> -#include <asm/unaligned.h>
> -#include <asm/unwind.h>
