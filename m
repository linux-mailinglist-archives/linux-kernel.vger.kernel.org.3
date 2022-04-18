Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF15505E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347629AbiDRTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbiDRTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C07A64C4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB46160C91
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEACC385A1;
        Mon, 18 Apr 2022 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309595;
        bh=fMRmxDGA7HvyX1AhV9WMrS3yAztOUhwSHU/GlvALZsI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FB6VgUXfEJKQe7iHhx49f3TuSShudqNowUV6WJ+2P+1xyUROYQoGoUBoRfD44DDs8
         Yu+nuLEjO+Qw6VH4heC2C3rllQJm2wx1Pk9LlXrnI5Sv6b0Y+BIlwMwZPoSGArqR+Z
         KtysTSebtNy9cSNPImqFkdVbZcV3nchLTEImB3n5xPjcDcrq5YGZjCVLcSO7bUuSmb
         MhuxyA3xcJi59x79i2NwYeKUI29JrTTToYT8tvHkqzev9fcSSm7ARQu6OnB3jhm4N/
         1Iw1tku/0LkVDOxLSZX1rI+G2swdahnyToN8xgSjgQBP6p2KV9JV5sLbW4SPZQEyJH
         MDp43MM1pKA/Q==
Message-ID: <e86916c4-1a5c-f89d-bcec-c4ed275aa4be@kernel.org>
Date:   Mon, 18 Apr 2022 12:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARC: remove redundant READ_ONCE() in cmpxchg loop
Content-Language: en-US
To:     Bang Li <libang.linuxer@gmail.com>, vgupta@kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, valentin.schneider@arm.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220319020316.142479-1-libang.linuxer@gmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220319020316.142479-1-libang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/22 19:03, Bang Li wrote:
> This patch reverts commit 7082a29c22ac ("ARC: use ACCESS_ONCE in cmpxchg
> loop").
>
> It is not necessary to use READ_ONCE() because cmpxchg contains barrier. We
> can get it from commit d57f727264f1 ("ARC: add compiler barrier to LLSC
> based cmpxchg").
>
> Signed-off-by: Bang Li <libang.linuxer@gmail.com>

Indeed this is not needed. However have you checked the code with and/wo 
this change to see if it builds the same.

-Vineet

> ---
>   arch/arc/kernel/smp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
> index 78e6d069b1c1..56c23f3e1309 100644
> --- a/arch/arc/kernel/smp.c
> +++ b/arch/arc/kernel/smp.c
> @@ -274,7 +274,7 @@ static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
>   	 * and read back old value
>   	 */
>   	do {
> -		new = old = READ_ONCE(*ipi_data_ptr);
> +		new = old = *ipi_data_ptr;
>   		new |= 1U << msg;
>   	} while (cmpxchg(ipi_data_ptr, old, new) != old);
>   

