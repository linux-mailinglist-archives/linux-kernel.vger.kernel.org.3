Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094258BB14
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiHGNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHGNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:46:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313276323
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF6BAB80B35
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22966C433C1;
        Sun,  7 Aug 2022 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659879983;
        bh=5SBeY6UheXkn/55O7f4og0r2Dd8A8ZtEc2SMEyOIu8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsmDxmvm5MTIoJLTAPAYFxYL0BVmVt4l2FOD2LH8fZhBm6cC90wAvWvb4g5ffJEnS
         14oT3KhuWwwuipEcZsqwt95hsHBbZ2SPvw1au37VKyeY+Il3K0jsVVclQZqkXudx/q
         //bbHrl5se3MXhNtCY6u4WK1O4KieAHe+Vmx7jiU=
Date:   Sun, 7 Aug 2022 15:46:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: general protection fault in put_page
Message-ID: <Yu/CLORvJj+2leUQ@kroah.com>
References: <CAO4mrfcuEtSQFj0MEEagWz7bYiYtg9+iCb_j4QstXc9217YZnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrfcuEtSQFj0MEEagWz7bYiYtg9+iCb_j4QstXc9217YZnw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 05:50:56PM +0800, Wei Chen wrote:
> Dear Linux Developer,
> 
> Recently when using our tool to fuzz kernel, the following crash was triggered:
> 
> HEAD commit: 31f4f5b495a6 Linux 5.4-rc7
> git tree: upstream
> compiler: clang 12.0.0
> console output:
> https://drive.google.com/file/d/1rjxlk2_QNsl6CcOwElvUSq5Yhcafb6Il/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1MFN7c56voPBkd7LzgO0mGZ_oOQNHyK-w/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1sFjtE830MyLBJYZzwZ9sJRsKdf5EzUTV/view?usp=sharing
> 
> However, we tried to use syz-prog2c to convert the Syzlang reproducer
> to C format. But the crash wasn't reproduced by the C program. Please
> use syz-execprog to execute the Syzlang reproducer directly on kernel
> to reproduce the bug.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>

As you have a reproducer, please feel free to submit a fix for this,
but:

> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 16421 Comm: syz-executor Not tainted 5.4.0-rc7+ #28

Wow that ia a _VERY_ old and obsolete kernel version.  Please try
something more modern, that is not a valid kernel release to be testing
at all.

How does 5.19.0 work for you?

thanks,

greg k-h
