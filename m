Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1082E469B02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbhLFPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbhLFPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:08:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A5C08E883;
        Mon,  6 Dec 2021 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wNn6STBGSbysAtU5JC3MnsHm5l02eeC/MfBuC41IsiY=; b=qoUbaSRA9E2Kh79X/z4KamvMTo
        eEwiCHon5SGJzEYdCA58yv0B6C5DkJPsf+RdLtD4YXZKUnCFnO62LesRMFoFo3Mu1+iP7Fpy2yVgx
        NxSw9Lv+kwNqn0Zfs/BBFpdVkxCJ7+B4h6f80QWUS30oRwQiqFS635rvtJYrcrJuI1YP01BZ63Jwe
        KQqI8+wtoDQdkHRLkzjic8/zLq/9M27xkucTzFJi1WueD4tDda3QlyEsQymgNHWW2Ybux3kJrT763
        j8ymrYGHB3iHHFz0Uo0iOZO31m5v4JujhOw3aaPdTmk7iH79f7P5L7tTaMejoJWf4JNIT1cgJ1ozn
        3CO5Tj/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFWp-004yVc-7h; Mon, 06 Dec 2021 15:03:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97AA9300362;
        Mon,  6 Dec 2021 16:03:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 754CA202420BC; Mon,  6 Dec 2021 16:03:42 +0100 (CET)
Date:   Mon, 6 Dec 2021 16:03:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     rafael@kernel.org, ak@linux.intel.com, bp@alien8.de,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, knsathya@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rjw@rjwysocki.net,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 3/4] ACPI: processor idle: Only flush cache on entering C3
Message-ID: <Ya4mTij+eQPq8dnu@hirez.programming.kicks-ass.net>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
 <20211206122952.74139-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206122952.74139-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:29:51PM +0300, Kirill A. Shutemov wrote:
> According to the ACPI spec v6.4, section 8.2, cache flushing required
> on entering C3 power state.
> 
> Avoid flushing cache on entering other power states.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/acpi/processor_idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 76ef1bcc8848..01495aca850e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -567,7 +567,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  {
>  	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>  
> -	ACPI_FLUSH_CPU_CACHE();
> +	if (cx->type == ACPI_STATE_C3)
> +		ACPI_FLUSH_CPU_CACHE();
>  

acpi_idle_enter() already does this, acpi_idle_enter_s2idle() has it
confused again,

Also, I think acpi_idle_enter() does it too late; consider
acpi_idle_enter_mb(). Either that or the BM crud needs more comments.
