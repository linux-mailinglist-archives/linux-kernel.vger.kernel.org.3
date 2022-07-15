Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45185575A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGOEKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiGOEKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:10:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB978204;
        Thu, 14 Jul 2022 21:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FP50lK3xBTOjUUYYSIIFEqkI1PWnVPpuFJpL7i8sB7o=; b=qs+DNpZUXt9BxlyoZA7Ych79ee
        vuQoJvRtmATeiPIQH6uTZmJloklIblBL6q/t8gYc2MoXZRM1lbRlGzgPlvhg63l99XFPx7aQV6M9w
        9lmK7V/ZLOfVIFg6DUQw4SGK3YnZe/vK8n8Ok/DArSW5V4AsO5Li039nAYq1dhWeod5HlMzX3ZVvj
        p7462low2+6S6ciSxaBvDrAR295YIEuUCdael1ia3VYm9X33NxK0vlmVZy/Jnzd1gypnaa+W3/7iA
        tY0mJDwV2o0HRDHxNECfISt+qvfQMcsXeOY84+bBB5Jzc9tYJQDGAAReAbLShhzS6/noUTty7E+Kr
        rfCnLLBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oCCeh-00CAeg-0X;
        Fri, 15 Jul 2022 04:10:19 +0000
Date:   Fri, 15 Jul 2022 05:10:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <YtDoqhuAt6Sv6qgV@ZenIV>
References: <20220715140259.205ef267@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715140259.205ef267@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 02:02:59PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/block/ublk_drv.c:951:19: error: 'no_llseek' undeclared here (not in a function); did you mean 'noop_llseek'?
>   951 |         .llseek = no_llseek,
>       |                   ^~~~~~~~~
>       |                   noop_llseek
> 
> Caused by commit
> 
>   71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> 
> interacting with commit
> 
>   8804bffa93a1 ("fs: remove no_llseek")
> 
> from the vfs tree.

I suspect that it would be a good idea to slap
#define no_llseek NULL
into include/linux/fs.h for the merge window, then remove it (and all
stray no_llseek initializers) at -rc1.  Linus, would you be OK with
that approach?
