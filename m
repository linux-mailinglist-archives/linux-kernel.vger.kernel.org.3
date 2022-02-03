Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981004A8B98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiBCSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353457AbiBCSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:25:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:25:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6928CB8354A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 18:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E67FC340E8;
        Thu,  3 Feb 2022 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643912730;
        bh=mnWvaD2na9yYCHhWNJpo/TRhZYykVHCpFnb0tXlh0Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbKGr0fHiBiW1DJ0/qKVspr4ioCXWAkU0B4zQz0tR1G38oexu0KdkxZVLwYjD2vQX
         eeJbtgCcB97xGjOSKtKlhq8Gyw8n1xs9mLuV3ApiyM504ecM59X1TYSdG9jsT3LG6r
         gX2IwAlGL76H8jUP/fxup+2YHtVxCNQS2ihmRJ7S7rrwIrxSijTH6WQbhIbZUDC4uZ
         +HLZetPgRtXreg3E2IPE2ZK7P9lJzf+kpcWZ5NaKReDehCmfQd3+XEWMUGKew/lp4s
         f4+LSXlbvq8yTmyBWTTbHYPIepH0v06G/4X1gpNTq+bqua2ZJfplBtscrEc9uXlOZ2
         klyWzwNXFb5aw==
Date:   Thu, 3 Feb 2022 19:25:27 +0100
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
Subject: Re: [patch v10 08/10] KVM: x86: process isolation work from VM-entry
 code path
Message-ID: <20220203182527.GB475173@lothringen>
References: <20220127173037.318440631@fedora.localdomain>
 <20220127173206.862057978@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127173206.862057978@fedora.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:30:45PM -0300, Marcelo Tosatti wrote:
> VM-entry code path is an entry point similar to userspace return
> when task isolation is concerned.
> 
> Call isolation_exit_to_user_mode before VM-enter.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  include/linux/entry-kvm.h |    4 +++-
>  kernel/entry/kvm.c        |   18 ++++++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/kernel/entry/kvm.c
> ===================================================================
> --- linux-2.6.orig/kernel/entry/kvm.c
> +++ linux-2.6/kernel/entry/kvm.c
> @@ -2,8 +2,11 @@
>  
>  #include <linux/entry-kvm.h>
>  #include <linux/kvm_host.h>
> +#include <linux/task_isolation.h>
>  
> -static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
> +static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
> +				   unsigned long ti_work,
> +				   unsigned long task_isol_work)
>  {
>  	do {
>  		int ret;
> @@ -25,15 +28,19 @@ static int xfer_to_guest_mode_work(struc
>  		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
>  		if (ret)
>  			return ret;
> +		if (task_isol_work)
> +			task_isol_exit_to_user_mode();
>  
>  		ti_work = read_thread_flags();
> -	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
> +	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched() ||
> +		 task_isol_work);

There too you should join the XFER_TO_GUEST_MODE_WORK mask.

Thanks.
