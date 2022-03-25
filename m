Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA44E7BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiCYTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiCYTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:48:46 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F0C2B2050;
        Fri, 25 Mar 2022 12:32:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 158632C3;
        Fri, 25 Mar 2022 19:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 158632C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648236733; bh=49jpW2WxwfDWgFFg2FEAQXR26EWHs8pIegLvOIkxseo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bAxEoivqRB+DOXFovPcLu/16Ktwh00jBNgPNhyGIbRappbFfTiVDnz18bGe2pbbvG
         QDQ4bYVfnLlfSXAqzTtAEKlqSgabmb/JMxNHKmANeQ7DrtV+6UHg0UkTgMUsFCuT4v
         zz2ydPArc9/TpTtrYbukEKfnVBzbbCYR2T09PNzn0RVS9RGs82kwVkNbuvLUES7Hq1
         tpSKN8+FVzL9c24J8rNQ/Kqitxc7OncOrI+cS/Q4RrQE3ZnoHQLCHg4YPtXh2LUqhs
         aRX0doy8aB0ckQk86IecEt/zAX6lzpy23lNkcMV2ZEr29OlEGskrq4sLEM3oVgw0U2
         lSgxTC7Y6+E4w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gpiccoli@igalia.com,
        kernel@gpiccoli.net, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Documentation: Fix duplicate statement about
 raw_spinlock_t type
In-Reply-To: <20220321144133.49804-1-gpiccoli@igalia.com>
References: <20220321144133.49804-1-gpiccoli@igalia.com>
Date:   Fri, 25 Mar 2022 13:32:12 -0600
Message-ID: <87r16peslf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> Unless it was duplicate on purpose, to emphasize that a raw_spinlock_t
> is always a spinning lock regardless of PREEMPT_RT or kernel config,
> it's a bit odd that this text is duplicate. So, this patch just clean
> it up, keeping the consistency with the other sections of the text.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 919e9e6395cf ("Documentation: Add lock ordering and nesting documentation")
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Documentation/locking/locktypes.rst | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index bfa75ea1b66a..9933faad4771 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -211,9 +211,6 @@ raw_spinlock_t and spinlock_t
>  raw_spinlock_t
>  --------------
>  
> -raw_spinlock_t is a strict spinning lock implementation regardless of the
> -kernel configuration including PREEMPT_RT enabled kernels.
> -
>  raw_spinlock_t is a strict spinning lock implementation in all kernels,
>  including PREEMPT_RT kernels.  Use raw_spinlock_t only in real critical
>  core code, low-level interrupt handling and places where disabling

I don't think that was intentional.  Applied, thanks.

For future reference, a far better changelog would have been something
like:

	Remove the duplicated sentence from locktypes.rst

Thanks,

jon
