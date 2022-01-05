Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F3484C8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiAECbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiAECbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:31:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A77C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EsCFlp1h6di6DkZFmQeLKYecbBslAXJD/VJOnuuazog=; b=HCxqpniCNws8BJJRQ8zCslauYc
        bqJ/HXgOfDVYnihn/y9nDAjs8QZClu0E9JGcSqJnfED/D5JJLHz4PoW/WRGmS8wEkqgekKVVuhjzT
        1ZPALcke1uPq0bP2qejPlfVbRuewR5Tcnz+BlhGq0bJt2cu11NDw/wg11qLk4DOl6DqQF/Y6HHgmG
        3+4sDY/kBdMrJmwGDYn05k+zxFzUqhtDAGKuTmjNHiySTn3rnvw2Wcd0ErlU1DvX4Fwlj8I/rRZkk
        O0q53Cz/joA2qm/5s5+S4GCcnZtBT37N22STMbMrv/djaCw76ib5WerbcrPnvex99u1Fe6Ejym5QC
        Y956l/HQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4w4e-00EBlj-FP; Wed, 05 Jan 2022 02:30:48 +0000
Message-ID: <94566879-d558-909c-7ba7-fbf944a7427b@infradead.org>
Date:   Tue, 4 Jan 2022 18:30:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next] notifier: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, bigeasy@linutronix.de
Cc:     rafael.j.wysocki@intel.com, stern@rowland.harvard.edu,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220105010948.49695-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220105010948.49695-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/22 17:09, Yang Li wrote:
> Remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> kernel/notifier.c:68: warning: Excess function parameter 'returns'
> description in 'notifier_call_chain'
> kernel/notifier.c:116: warning: Function parameter or member 'v' not
> described in 'notifier_call_chain_robust'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/notifier.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index ba005ebf4730..52b417951c0a 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -59,8 +59,6 @@ static int notifier_chain_unregister(struct notifier_block **nl,
>   *			value of this parameter is -1.
>   *	@nr_calls:	Records the number of notifications sent. Don't care
>   *			value of this field is NULL.

For this one, preferably use:

 * Return: the value returned by the last notifier function called.

> - *	@returns:	notifier_call_chain returns the value returned by the
> - *			last notifier function called.
>   */
>  static int notifier_call_chain(struct notifier_block **nl,
>  			       unsigned long val, void *v,
> @@ -102,7 +100,7 @@ NOKPROBE_SYMBOL(notifier_call_chain);
>   * @val_up:	Value passed unmodified to the notifier function
>   * @val_down:	Value passed unmodified to the notifier function when recovering
>   *              from an error on @val_up
> - * @v		Pointer passed unmodified to the notifier function
> + * @v:		Pointer passed unmodified to the notifier function
>   *
>   * NOTE:	It is important the @nl chain doesn't change between the two
>   *		invocations of notifier_call_chain() such that we visit the

thanks for the patch.

-- 
~Randy
