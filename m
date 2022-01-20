Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C649537A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiATRnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:43:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37234 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiATRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:43:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C925B81D84
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E171C340E0;
        Thu, 20 Jan 2022 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642700585;
        bh=mhP/PzXnEIshsVfkUkWrpdeuD4+coem5ElvjqkGG6Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UArT7mtGUSmO4tDlvt+C3aeIRpTk+3JF//Kk8s0PGhkRjbdiTsv7ZNSChETsHDQNl
         b7Jgri552jePYEA7ELCdlRlG61woAs3hjRBPNnsS8ZXmxZzvxpBVda+4jow7kv4BxR
         /FouekDtIPjTWj7pTJ4WP8Xi9Ls+ZlVh1/LLfJDqsygo6Y0Xfy2MPtSw9aIxhl/d9R
         K4LluCu0bfbhtJTDgRY+jt0phJmHTRXldRkQbDX2A8JCMiPgANMd4AIwynaMMOrxYQ
         j4eQtjdkpxoeo2RpABLYhch8Uwz3ZvZtTzRAfobMc3H1CiOIiHHuQxtzGum/2BbwLQ
         HqtZ5y26OtbBQ==
Date:   Thu, 20 Jan 2022 18:43:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 01/10] add basic task isolation prctl interface
Message-ID: <20220120174301.GA213170@lothringen>
References: <20211208161000.654492429@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208161000.654492429@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 01:09:07PM -0300, Marcelo Tosatti wrote:
> +int __copy_task_isolation(struct task_struct *tsk)
> +{
> +	struct isol_info *info, *new_info;
> +
> +	info = current->isol_info;
> +	if (!(info->inherit_mask & (ISOL_INHERIT_CONF|ISOL_INHERIT_ACTIVE)))
> +		return 0;
> +
> +	new_info = tsk_isol_alloc_context();
> +	if (IS_ERR(new_info))
> +		return PTR_ERR(new_info);
> +
> +	new_info->inherit_mask = info->inherit_mask;

Ok then it might be worth mentioning in the docs that the inheritance
propagates to all the descendants and not just the immediate children,
unless the inheritance is explicitly reconfigured by some children of course.

> +
> +	if (info->inherit_mask & ISOL_INHERIT_CONF) {
> +		new_info->quiesce_mask = info->quiesce_mask;

Looks like if the parent has oneshot quiesce features configured, those
will be inherited as non-oneshot.

> +		new_info->conf_mask = info->conf_mask;
> +	}
> +
> +	if (info->inherit_mask & ISOL_INHERIT_ACTIVE)
> +		new_info->active_mask = info->active_mask;
> +
> +	tsk->isol_info = new_info;
> +
> +	return 0;
> +}

Other than that:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
