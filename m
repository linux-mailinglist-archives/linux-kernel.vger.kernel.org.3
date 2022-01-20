Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34133494751
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbiATGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358734AbiATGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:31:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 22:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B82BB81A74
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55985C340E0;
        Thu, 20 Jan 2022 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642660271;
        bh=Irfj9p2ilfq4lKdinTmm7EYh2n65nyXEfW/EZ4F6L88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxwCDDIoxdIbMOX1Z3bDU4RzztcfdvnPW58QvPUat301IajS76TSK3/rK8qCQR2Zj
         fe55Pnd7ZkwIlNuXr6GnwRqh7sDposyKCL0WvpbzNDuCFVDUIr354K+tHqL5V7dqOv
         ctOW3Xtm0WTGIyAf4MRrTrN2beEGs+5UzbCXfzeU=
Date:   Thu, 20 Jan 2022 07:31:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     keescook@chromium.org, dan.carpenter@oracle.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lkdtm/bugs: Check for the NULL pointer after calling
 kmalloc
Message-ID: <YekBrYDA+/Vxxwwr@kroah.com>
References: <20220120012552.1851621-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120012552.1851621-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:25:51AM +0800, Jiasheng Jiang wrote:
> As the possible failure of the kmalloc(), the not_checked and checked
> could be NULL pointer.
> Therefore, it should be better to check it in order to avoid the
> dereference of the NULL pointer.
> Also, we need to explicitly yell about the memory failure and then
> kfree the 'not_checked' and 'checked' to avoid the memory leak if fails.
> And since it is just a test, it may directly return without error
> number.
> 
> Fixes: ae2e1aad3e48 ("drivers/misc/lkdtm/bugs.c: add arithmetic overflow and array bounds checks")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v1 -> v2
> 
> * Change 1. Add the kfree if fails.
> 
> v2 -> v3
> 
> * Change 1. Add pr_err if fails.
> ---
>  drivers/misc/lkdtm/bugs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index f4cb94a9aa9c..c64ab6f387eb 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -325,6 +325,12 @@ void lkdtm_ARRAY_BOUNDS(void)
>  
>  	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
>  	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
> +	if (!not_checked || !checked) {
> +		pr_err("FAIL: could not allocate required buffers!\n");

As was pointed out, this is now a checkpatch failure :(

