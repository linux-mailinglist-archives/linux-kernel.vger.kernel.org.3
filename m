Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB359513C16
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiD1TaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiD1TaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:30:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B451594
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:26:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651174016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfSwAQLrJKmPP9oDDd/tVMsIRjX709FvurdZ9DWRoyY=;
        b=Bww6SxbToDwB7bXuj8ePiXTLQlXaWI/ZCOpy0AFAty9VzghL6Qe/zTmiptAyPUEhaRmt0A
        v8KhLTGgOlq/uTo/b7ht4AXlA+UPqMi17fcTxnTgB5cAmUc6l9nfqrFjabv1WPUvkaws21
        riPUfBjEJot46Rcoc0OlCgqO5pwlwv945EYABtOs3Dz3AIaJVG7v9CgrKSW3lsoiemJNQx
        3N3VC9F0kihfKecZXXIGQ5ddNa5JJCqGOCSWSkN18boTGRlKJz3RyuU7XZNedyeZdozDQ2
        0cVsa7nat9FyGySqYlv+LyCC/Ega/5YxC67Hp4DScO5Siu/pq4A++iuGD5xNrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651174016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfSwAQLrJKmPP9oDDd/tVMsIRjX709FvurdZ9DWRoyY=;
        b=dNLCtBuH0dDN/OA2Frm6WTkfshe/9gAZAuVMPBGxqTht57iFqgr+ZIGnusI01XuNL5Mh7B
        KUMgIywRCft10uBg==
To:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, peterz@infradead.org, dave@stgolabs.net,
        manfred@colorfullife.com,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH v2] ipc: Update semtimedop() to use hrtimer
In-Reply-To: <1651158422-28014-1-git-send-email-prakash.sangappa@oracle.com>
References: <1651158422-28014-1-git-send-email-prakash.sangappa@oracle.com>
Date:   Thu, 28 Apr 2022 21:26:55 +0200
Message-ID: <874k2dovpc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash,

On Thu, Apr 28 2022 at 08:07, Prakash Sangappa wrote:
> semtimedop() should be converted to use hrtimer like it has been done
> for most of the system calls with timeouts. This system call already
> takes a struct timespec as an argument and can therefore provide finer
> granularity timed wait.

almost perfect :)

The v1->v2: description wants to be below the '---' separator. It's not
part of the changelog and just helpful for reviewers to assess the
history of the patch(set).

> v1->v2:
>   - Use timespec64_valid() to validate timeout
>      and other changes as suggested by Thomas Gleixner
>
> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
> ---
...
> @@ -2210,7 +2209,7 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>  		/*
>  		 * If an interrupt occurred we have to clean up the queue.
>  		 */
> -		if (timeout && jiffies_left == 0)
> +		if (timed_out)
>  			error = -EAGAIN;
>  	} while (error == -EINTR && !signal_pending(current)); /* spurious */

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
