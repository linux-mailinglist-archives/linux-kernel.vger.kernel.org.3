Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38557574F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiGNNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiGNNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:39:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757060510;
        Thu, 14 Jul 2022 06:39:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3DAE92DC;
        Thu, 14 Jul 2022 13:39:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3DAE92DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657805987; bh=6nEqc/8db9cnSBDSgS+CSBHWXQlL3UmK0hfgzuNWVgI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mSlq5oswWR02kCA7qjoLfvi5QhFce7TkiQZrNRaXKqoxtxPzCa9UHBBSPUEI+CPK4
         BhpnLayiPVb3bpxFQdLwohdDzwoPABmO/mtlZiLt4Jxy2CeMqJT4k3mcRCQfi20zey
         NMj+sIh20fb4bzPApaSE/hfEPlpiFUMnvGTKNQXEIYNfyFJjKmeHGwKO89WH/tDRRo
         u3RrEU5FqG8x4HT9LuAdWZiW36nMl1yL7G66EbU/224SWffUVrDnIiOyEsu+DIkKCF
         xs1i0ErZKraw2HUMkMh/IHqL5pfZbYtW/Uu8Di7Aj4VWTPJyvtGpXnXINHSRT0eD7r
         3bDG1nJsojDGg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/lzo/lzo1x_compress.c: replace ternary operator with
 min() and min_t()
In-Reply-To: <20220714015441.1313036-1-13667453960@163.com>
References: <20220714015441.1313036-1-13667453960@163.com>
Date:   Thu, 14 Jul 2022 07:39:46 -0600
Message-ID: <87bktr24pp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiangshan Yi <13667453960@163.com> writes:

> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>
> Fix the following coccicheck warning:
>
> lib/lzo/lzo1x_compress.c:54: WARNING opportunity for min().
> lib/lzo/lzo1x_compress.c:329: WARNING opportunity for min().
>
> min() and min_t() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  lib/lzo/lzo1x_compress.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> index 76758e9296ba..9d31e7126606 100644
> --- a/lib/lzo/lzo1x_compress.c
> +++ b/lib/lzo/lzo1x_compress.c
> @@ -50,9 +50,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  
>  		if (dv == 0 && bitstream_version) {
>  			const unsigned char *ir = ip + 4;
> -			const unsigned char *limit = ip_end
> -				< (ip + MAX_ZERO_RUN_LENGTH + 1)
> -				? ip_end : ip + MAX_ZERO_RUN_LENGTH + 1;
> +			const unsigned char *limit = min(ip_end, ip + MAX_ZERO_RUN_LENGTH + 1);
>  #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
>  	defined(LZO_FAST_64BIT_MEMORY_ACCESS)
>  			u64 dv64;
> @@ -326,7 +324,7 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
>  	data_start = op;
>  
>  	while (l > 20) {
> -		size_t ll = l <= (m4_max_offset + 1) ? l : (m4_max_offset + 1);
> +		size_t ll = min_t(size_t, l, m4_max_offset + 1);
>  		uintptr_t ll_end = (uintptr_t) ip + ll;
>  		if ((ll_end + ((t + ll) >> 5)) <= ll_end)
>  			break;

So these look like good changes to me, but I am not the maintainer of
this code.  Maybe Andrew (copied) would have a spot for this patch?

Thanks,

jon
