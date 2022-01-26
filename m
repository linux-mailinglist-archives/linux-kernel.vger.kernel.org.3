Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA849CB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiAZNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiAZNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:49:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61738615BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4426FC340E3;
        Wed, 26 Jan 2022 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643204952;
        bh=cpWJJshLDCMrF55Gm/ZYi8fsRUiUxk7EZ0xMpwks95w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqcoUuwHjTJ9QhGzXvyeJXnf1/xZk8lJAJg809zxorpnTaG3AwG8jkWOp9nUP5JO/
         ghTaEVU7c6SD6vmYLrRR3T8eQCEypne2gaQIFWY4c64LxF//BVG8qoKJkUrGqPmAle
         RbSTXZCfZ4OWmRLqcW6AGOYlib70chbjdCGte10k=
Date:   Wed, 26 Jan 2022 14:49:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     TATSUKAWA =?utf-8?B?S09TVUtFKOeri+W3neOAgOaxn+S7iyk=?= 
        <tatsu-ab1@nec.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] n_tty: wake up poll(POLLRDNORM) on receiving data
Message-ID: <YfFRVkmtSsXPanS5@kroah.com>
References: <TYCPR01MB81902ACABDEC2602282FB81DA55E9@TYCPR01MB8190.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB81902ACABDEC2602282FB81DA55E9@TYCPR01MB8190.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 08:17:22AM +0000, TATSUKAWA KOSUKE(立川 江介) wrote:
> Event POLLRDNORM should be equivalent to POLLIN when used as event in
> poll().

Where is that documented?

> However, in n_tty driver, POLLRDNORM does not return until
> timeout even if there is terminal input, whereas POLLIN returns.
> 
> The following test program works until kernel-3.17, but the test stops
> in poll() after commit 57087d515441 ("tty: Fix spurious poll() wakeups").
> 
> [Steps to run test program]
>   $ cc -o test-pollrdnorm test-pollrdnorm.c
>   $ ./test-pollrdnorm
>   foo          <-- Type in something from the terminal followed by [RET].
>                    The string should be echoed back.
> 
>   ------------------------< test-pollrdnorm.c >------------------------
>   #include <stdio.h>
>   #include <errno.h>
>   #include <poll.h>
>   #include <unistd.h>
> 
>   void main(void)
>   {
> 	int		n;
> 	unsigned char	buf[8];
> 	struct pollfd	fds[1] = {{ 0, POLLRDNORM, 0 }};
> 
> 	n = poll(fds, 1, -1);
> 	if (n < 0)
> 		perror("poll");
> 	n = read(0, buf, 8);
> 	if (n < 0)
> 		perror("read");
> 	if (n > 0)
> 		write(1, buf, n);
>   }
>   ------------------------------------------------------------------------
> 
> The attached patch fixes this problem.
> 
> Signed-off-by: Kosuke Tatsukawa <tatsu-ab1@nec.com>
> Fixes: commit 57087d515441 ("tty: Fix spurious poll() wakeups")

No need for "commit" here, please remove as the documentation asks you
to.

Can you resend this with this fixed up, and a pointer to where the
documentation is for this functionality.

thanks,

greg k-h
