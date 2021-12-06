Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C4C469193
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhLFIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhLFIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:38:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEDC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 00:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnJTiqc7wfLC3AN3GXkcSjJJh4LRELQ9dTaxe/sfKJ4=; b=mAq4cm13U8EMh7r1EXO/UeQZ7o
        Y/6AA14SWrjIS6Gc+AW/ODVIcglSSv//jHXLO05ZaPaiEPigP2YgOoner63OWGN7F5SnGaSldScVt
        x1LEheXkz0kZoe+TnkmAiqET8fb34Ay3Vzc3uH+CpGSU0WWMKrgXD5moYIgTwLC2EKnxLchEs4u5u
        6ROcuyHQFHICLoI37RWcnTQdq0vryWKWRtxRNMZQ9G+13kJaMruNxSgzRCIAsElfEhSanEv5sv07w
        AHlNEB0Rc3UYbi4j9rQpV0YTDCDbvSAJtR/2U6KzuZmXcJB3qGTN3jpSc8Ntz2wUEl96Z2faeV1Gj
        Waq9JxIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu9SA-002WIc-5d; Mon, 06 Dec 2021 08:34:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DFA43000E6;
        Mon,  6 Dec 2021 09:34:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A8682B32066F; Mon,  6 Dec 2021 09:34:29 +0100 (CET)
Date:   Mon, 6 Dec 2021 09:34:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] completion: introduce complete_put() helper function
Message-ID: <Ya3LFV2W05TZzMnC@hirez.programming.kicks-ass.net>
References: <20211206040319.7063-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206040319.7063-1-yajun.deng@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:03:19PM +0800, Yajun Deng wrote:
> There are many cases where it is necessary to decrease refcount and test,
> then called complete(). So introduce complete_put() helper function.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  kernel/sched/completion.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index a778554f9dad..dcb737f1edc2 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -38,6 +38,13 @@ void complete(struct completion *x)
>  }
>  EXPORT_SYMBOL(complete);
>  
> +void complete_put(refcount_t *r, struct completion *x)
> +{
> +	if (refcount_dec_and_test(r))
> +		complete(x);
> +}
> +EXPORT_SYMBOL(complete_put);

Please submit such things as part of the series that makes use of them.
