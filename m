Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF62E5627D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiGAAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGAAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1D2A255
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BFD660FCE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94383C341C7;
        Fri,  1 Jul 2022 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656636607;
        bh=bxvdgd9kqA3Z8JrdSYeYKq3GX3TDNTe2VkSUMdkkC70=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RNuAM8tJNmv/t1c4/iTjobFlbqr57QjMc+Ywt3fx+l+LKPV+5H35MaW5BqW3OlYbj
         E9K/xMsmWkkhLBHWRtgCPLGzwedzaafmmLJZpWZB2bVOAEO+MJA8c/v23qMKAxJ9zm
         070CH3EKsOZ3zJkbW8IRIJUgyGrbqEQdd8F63FrkpGdNzZaaPPd+6kuPjVuei7XwNo
         DDJX+KHDHKIdkFrUZMXkJkbx2GyApHN6EPM4yfSum6sSwbWz6TFlNLlSLNLTPwMzoQ
         58eGGT+e8eF/1Pcq7obXDzL2B1hXz6aKgbUzHJH7o+Gs7M5FmCYBZNUeVVVbukqnBu
         LoRbHBiFfeD3g==
Message-ID: <a766299e-1a75-5293-dfeb-8f5d6c395644@kernel.org>
Date:   Fri, 1 Jul 2022 08:50:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] f2fs: optimize shrink count
Content-Language: en-US
To:     Guowei Du <duguoweisz@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
References: <20220630112629.6611-1-duguoweisz@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220630112629.6611-1-duguoweisz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/30 19:26, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> Remove the local variable 'run_no', add comments for better
> reading.

Not sure, I guess original implementation considers the race condition for
f2fs_shrink_scan vs f2fs_shrink_scan case? so it uses a local variable to
keep the per-round context info?

Jaegeuk, please help to check that.

Thanks,

> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>   fs/f2fs/shrinker.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index dd3c3c7a90ec..7e439496dfca 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -76,18 +76,18 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
>   	unsigned long nr = sc->nr_to_scan;
>   	struct f2fs_sb_info *sbi;
>   	struct list_head *p;
> -	unsigned int run_no;
>   	unsigned long freed = 0;
>   
>   	spin_lock(&f2fs_list_lock);
> -	do {
> -		run_no = ++shrinker_run_no;
> -	} while (run_no == 0);
> +	shrinker_run_no++;
> +	/* if overflow, next loop needs to skip number 0 */
> +	if (!shrinker_run_no)
> +		shrinker_run_no = 1;
>   	p = f2fs_list.next;
>   	while (p != &f2fs_list) {
>   		sbi = list_entry(p, struct f2fs_sb_info, s_list);
>   
> -		if (sbi->shrinker_run_no == run_no)
> +		if (sbi->shrinker_run_no == shrinker_run_no)
>   			break;
>   
>   		/* stop f2fs_put_super */
> @@ -97,7 +97,7 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
>   		}
>   		spin_unlock(&f2fs_list_lock);
>   
> -		sbi->shrinker_run_no = run_no;
> +		sbi->shrinker_run_no = shrinker_run_no;
>   
>   		/* shrink extent cache entries */
>   		freed += f2fs_shrink_extent_tree(sbi, nr >> 1);
