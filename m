Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1F467A07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381683AbhLCPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381687AbhLCPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:11:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F3C061354
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:08:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F7462BC0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66710C53FCD;
        Fri,  3 Dec 2021 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638544085;
        bh=MmeocnAtZRTxSrKg2v6lxKM91AhmG97cllsCqczeYC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1JmrUjoJwsqKFSYV8e9ThGQ0UHNAWpSsGb370UGRHwHeR/7mCv7WQn1NfsAaZ/v5k
         tn5GgaOVHiMqNX+/+wJGLDT4TnUB8qeoIO4Tjkm40KBrAs8vM++Y8LVBj+Ic16py1M
         mUxny41NJsev80rk3BCS9jcel5ed8pysRQEG9awo=
Date:   Fri, 3 Dec 2021 16:08:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 1/2] kobject: don't delay to cleanup module kobject
Message-ID: <Yaoy0suaOekUH9Mp@kroah.com>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129034509.2646872-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:45:08AM +0800, Ming Lei wrote:
> CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release and
> cleanup issue. The module kobject is released after module_exit() returns.
> If this kobject is delayed too much, and may cause other kobjects cleaned
> up a bit earlier before freeing module, then real issue is hidden.
> 
> So don't delay module kobject's cleanup, meantime module kobject is
> always cleaned up synchronously, and CONFIG_DEBUG_KOBJECT_RELEASE is
> actually needless for module kobject.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/kobject.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 4a56f519139d..b81319b0bd5a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -16,6 +16,7 @@
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  #include <linux/random.h>
> +#include <linux/module.h>
>  
>  /**
>   * kobject_namespace() - Return @kobj's namespace tag.
> @@ -727,6 +728,19 @@ static void kobject_release(struct kref *kref)
>  	struct kobject *kobj = container_of(kref, struct kobject, kref);
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
>  	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
> +
> +	/*
> +	 * Don't delay to release module kobject so that we can detect late
> +	 * kobject release more effectively because module unloading waits
> +	 * for completion of module kobject release, see mod_kobject_put.
> +	 *
> +	 * Meantime mod_kobject_put() always waits for completion of module
> +	 * kobject's release, CONFIG_DEBUG_KOBJECT_RELEASE is basically
> +	 * useless for debugging module kobject's release.
> +	 */
> +	if (kobj->ktype == &module_ktype)
> +		delay = 0;

again, no, module kobjects are not more special than anything else.

greg k-h
