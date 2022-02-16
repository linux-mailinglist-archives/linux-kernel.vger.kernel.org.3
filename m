Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EF4B8D35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiBPQEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:04:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiBPQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:04:47 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEA2A82EF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:04:35 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 08292784;
        Wed, 16 Feb 2022 16:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 08292784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645027475; bh=/2P6M6HCLMjUw3eGzi89IsGYrZagWScISceMfvEOqv8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kr1szcQ9j4Ir8B6Hl/4MjTPOxdCDNyU4jwwcZ9y9hycAkw/TP2yEpPp5hikXZkdQB
         LnFcwlJnwsgFzoNRr3XGUfu7S1wlQNMmCP4vWrtOrLuXoAKDCQRlhugPQMhSw08s66
         KJvuu7J708CySGoyrRLmCQSjSHarnfWKReGLedMSFiJ4oSQKB1hoTtFi1uHU6xT2/G
         fjdZo0o3F+2g3Gzq/bMwKtsnPfzsmsKySKYK2KExVn2R2MgMbHrVOcCElB2xHqHfdT
         k14YJfALkF7sCe3bLoKRTSpe+lAAEDsNRRn10latA8fS/aFIri/G8gytZGhPykhPvI
         EjSrHsTTrrMkw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] tracing: Fix kernel-doc
In-Reply-To: <20220216075840.63755-1-jiapeng.chong@linux.alibaba.com>
References: <20220216075840.63755-1-jiapeng.chong@linux.alibaba.com>
Date:   Wed, 16 Feb 2022 09:04:34 -0700
Message-ID: <87r1826bn1.fsf@meer.lwn.net>
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

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

> Fix the following W=1 kernel warnings:
>
> kernel/trace/trace.c:1181: warning: expecting prototype for
> tracing_snapshot_cond_data(). Prototype was for
> tracing_cond_snapshot_data() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thank you for working to fix docs warnings.  Unfortunately, this is not
the correct fix.

>  kernel/trace/trace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7c2578efde26..326d96304b84 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1122,7 +1122,7 @@ void tracing_snapshot_instance(struct trace_array *tr)
>  	tracing_snapshot_instance_cond(tr, NULL);
>  }
>  
> -/**
> +/*

Here you are removing kerneldoc markup for comments that are entirely
unrelated to the warning in question.  Why are you doing that?  That
will remove this documentation (for an exported function) from the docs
build. 

>   * tracing_snapshot - take a snapshot of the current buffer.
>   *
>   * This causes a swap between the snapshot buffer and the current live
> @@ -1144,7 +1144,7 @@ void tracing_snapshot(void)
>  }
>  EXPORT_SYMBOL_GPL(tracing_snapshot);
>  
> -/**
> +/*
>   * tracing_snapshot_cond - conditionally take a snapshot of the current buffer.

The same question applies here.

>   * @tr:		The tracing instance to snapshot
>   * @cond_data:	The data to be tested conditionally, and possibly saved
> @@ -1163,8 +1163,8 @@ void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
>  }
>  EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
>  
> -/**
> - * tracing_snapshot_cond_data - get the user data associated with a snapshot
> +/*
> + * tracing_cond_snapshot_data - get the user data associated with a snapshot

Here you got the right fix - getting the name of the function right in
the comment - but you still took out the kerneldoc marker.

These changes have the effect of making the warning go away (and more),
but don't fix the real problem - that tracing_cond_snapshot_data() has
incorrect kerneldoc documentation.  Unless I'm missing something
fundamental (which happens often), the right fix is just the change of
function name in the comment.

Thanks,

jon
