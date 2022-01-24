Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0890497BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiAXJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAXJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:20:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0CC061401;
        Mon, 24 Jan 2022 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yAu3ycJAkCMvCvv05qqdk9uFzATo1prXz0NvLjvbSbg=; b=S3zEXfuPEWPt0oS/zAr8ORkJ3y
        QY/LAKamm8bSqsvuvcpzlTiNTQWSdZgR4945ZcWL8FbT8BSQ4GoZOMDYsBNXVyImYURFgzSYp5wmA
        yVc3Y63q2krFPqG3t3QqO6NLWPu0X31PEs0bQYumxGSqtVKN5PCw1iQ4i7ORby3GVqMiZ1VHtklwY
        G03SDo8po0t0CqvAy3ZAwEyHm17XZuEMKQVouYWHaxFnBs8rZyk3+xkMy/QVIFWXCnovUW/YQTbMZ
        XFnBPjyUy3lgY8/6/nKO5dx5Sy2Xe6oltK8SfV8N3xOeM8Za9wVOPyMS6/W9acavxhu7BihZDL9SY
        4qZ2ymgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvWB-002lld-6l; Mon, 24 Jan 2022 09:20:07 +0000
Date:   Mon, 24 Jan 2022 01:20:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -next] exit: export make_task_dead()
Message-ID: <Ye5vR609miJCKdYa@infradead.org>
References: <20220122174834.6493-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122174834.6493-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 09:48:34AM -0800, Randy Dunlap wrote:
> In a config file from "kernel test robot <lkp@intel.com>" for a
> different problem, this linker error was exposed when
> CONFIG_IA64_MCA_RECOVERY=m.
> 
> We could either export make_task_dead() or restrict IA64_MCA_RECOVERY
> to a bool Kconfig symbol instead of a tristate symbol, so go with the
> EXPORT_SYMBOL() path.
> 
> Fixes this build error:
> 
> ERROR: modpost: "make_task_dead" [arch/ia64/kernel/mca_recovery.ko] undefined!
> 
> Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: kernel test robot <lkp@intel.com>
> ---
>  kernel/exit.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20220121.orig/kernel/exit.c
> +++ linux-next-20220121/kernel/exit.c
> @@ -896,6 +896,7 @@ void __noreturn make_task_dead(int signr
>  
>  	do_exit(signr);
>  }
> +EXPORT_SYMBOL(make_task_dead);

EXPORT_SYMBOL_GPL and restricted, please.

Or even better: force the mca recovery code to be built in.
