Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034B52ED42
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349862AbiETNhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345592AbiETNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:37:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BBABF69
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9966CB82B05
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9543EC385A9;
        Fri, 20 May 2022 13:37:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TWLjNSQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653053837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Ssgv9imXNbu6BbEi8XDoZyaLG/tsht/Ay9PbMzrlyo=;
        b=TWLjNSQQhNiLeb03cZpOku8Fj9Hf1lDyPh4PmP29XsLyXT23g5wdxYt9CoeOh/qTYRuIrx
        nwrM5AqMNXV9CAPLJHlk6RzQaPKQ5fdpCiuf6KvMB5AorTUOvUhvu3em2/L+LMeqj4bQQH
        Hy1WClUG6bo7XzwAYbdysjZhLRsl9NQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 26eb1d9c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 13:37:16 +0000 (UTC)
Date:   Fri, 20 May 2022 15:37:15 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 1/3] random: convert to using fops->read_iter()
Message-ID: <YoeZi94CpGW9LE/y@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <20220520094459.116240-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520094459.116240-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:44:57AM +0200, Jason A. Donenfeld wrote:
>  const struct file_operations urandom_fops = {
> -	.read = urandom_read,
> +	.read_iter = urandom_read_iter,

One thing I noticed is that drivers/char/mem.c has both the .read and
the .read_iter functions for /dev/zero and /dev/null and such. I wonder
if the .read ones can be removed?

Jason
