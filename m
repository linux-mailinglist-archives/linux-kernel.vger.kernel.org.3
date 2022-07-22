Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2257D8B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiGVCnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiGVCnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C289A7D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8C66201F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20340C3411E;
        Fri, 22 Jul 2022 02:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658457799;
        bh=/nLfBny++QJC2G15ji7Jr16oDuC0KkPWGQcXsMuiKi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLNsAbWq+O8lSxcCO5rRft70tFlZn2LKl/xrgVQtb6AH1C7Gogcg2orjH8O3xm6YF
         NRrv/lLVzrGQAMRDB0PppYtvxh6T/FPn0QydS6eh8pKkZZTwRYHtnGi79dHYQspO/I
         8zuyHIX/kYldyeUQPno2/XaEPHyjQCUCBYV5jP7QMzn7LfhiRA4iSoE3YAJYSGWYfm
         dBrBlno1TOhL32WFykL8e5RhK/dkX1j8V8wgjBzWh71ZZwSDmh4nYl9AVryWti3Qrb
         aIl/fwB1xtJCHHaeDj3Jy/lS+s7XSh6xYfpQam63QQJ50uIfEz5DFCv19SWdZaCwLf
         eD/3UGJ6W2zMw==
Date:   Thu, 21 Jul 2022 19:43:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Guowei Du <duguoweisz@gmail.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH] f2fs: modify task name prefix
Message-ID: <YtoOxTyWPFUpw/Y0@google.com>
References: <20220718081038.2279-1-duguoweisz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718081038.2279-1-duguoweisz@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> If there are more than one f2fs sbi, there will be more
> discard threads. But the comm is too long to show dev
> minor. So, change the default prefix of thread from
> "f2fs_discard" to "f2fs_dcd".

That looks quite unreadable. What about unmap?

> 
> Before:
> $ ps -e | grep f2fs
> 1628 ?        00:00:00 f2fs_ckpt-7:10
> 1629 ?        00:00:00 f2fs_flush-7:10
> 1630 ?        00:00:00 f2fs_discard-7:
> 1631 ?        00:00:00 f2fs_gc-7:10
> 2030 ?        00:00:00 f2fs_ckpt-7:27
> 2031 ?        00:00:00 f2fs_flush-7:27
> 2032 ?        00:00:00 f2fs_discard-7:
> 2033 ?        00:00:00 f2fs_gc-7:27
> 
> After:
> $ ps -e | grep f2fs
> 1628 ?        00:00:00 f2fs_ckpt-7:10
> 1629 ?        00:00:00 f2fs_flush-7:10
> 1630 ?        00:00:00 f2fs_dcd-7:10
> 1631 ?        00:00:00 f2fs_gc-7:10
> 2030 ?        00:00:00 f2fs_ckpt-7:27
> 2031 ?        00:00:00 f2fs_flush-7:27
> 2032 ?        00:00:00 f2fs_dcd-7:27
> 2033 ?        00:00:00 f2fs_gc-7:27
> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 874c1b9c41a2..2eeefcbe62db 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2018,7 +2018,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
>  		return 0;
>  
>  	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> -				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> +				"f2fs_dcd-%u:%u", MAJOR(dev), MINOR(dev));
>  	if (IS_ERR(dcc->f2fs_issue_discard))
>  		err = PTR_ERR(dcc->f2fs_issue_discard);
>  
> -- 
> 2.36.1
