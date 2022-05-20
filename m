Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3452EE59
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350420AbiETOjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346535AbiETOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:39:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C7170F1B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B08BB82BF9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B2BC34113;
        Fri, 20 May 2022 14:39:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I9UKjT0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653057583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gS5YO7VFxRJjlPsBk8MahzoIpBYpq3niuVkR6Hn09Fo=;
        b=I9UKjT0faiHaaKDWPT8jzjVx4Ka3INr5VOtMV/x0824/3FCtxnZSNSGqDLhucWd5EwQYR9
        xfremC+tjaN0goFCV6N1OUx3/o5GUKca91ie28kXl9aitwpM856cdDcJUnTYDgNtF+qKjM
        k5vtJ8doxAX2sZ8aRtzYU9Adyegc8dA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7b1fc93 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 14:39:43 +0000 (UTC)
Date:   Fri, 20 May 2022 16:39:41 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 1/3] random: convert to using fops->read_iter()
Message-ID: <YoeoLWTQ29bZCOFI@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <20220520094459.116240-2-Jason@zx2c4.com>
 <YoeZi94CpGW9LE/y@zx2c4.com>
 <35a5ff9f-79d7-feb5-dfa7-a775b9352416@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35a5ff9f-79d7-feb5-dfa7-a775b9352416@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, May 20, 2022 at 08:36:17AM -0600, Jens Axboe wrote:
> On 5/20/22 7:37 AM, Jason A. Donenfeld wrote:
> > On Fri, May 20, 2022 at 11:44:57AM +0200, Jason A. Donenfeld wrote:
> >>  const struct file_operations urandom_fops = {
> >> -	.read = urandom_read,
> >> +	.read_iter = urandom_read_iter,
> > 
> > One thing I noticed is that drivers/char/mem.c has both the .read and
> > the .read_iter functions for /dev/zero and /dev/null and such. I wonder
> > if the .read ones can be removed?
> 
> I'm not sure if we have a clear "always use this if available" set of
> rules for this. Ideally we'd want it to be:
> 
> 1) Use ->read_iter() if available
> 2) If not, use ->read()
> 
> Might require a bit of auditing to ensure that's the case, and if we
> can say that it is, then we could clean that up too.

The only case I found where it wasn't in that order was:
https://lore.kernel.org/lkml/20220520135103.166972-1-Jason@zx2c4.com/

Jason
