Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7B52DE10
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbiESUGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiESUGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683464BFD
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 021FF61C33
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE78C385AA;
        Thu, 19 May 2022 20:06:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UyXaa50y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652990788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hmADdHULjYqs4wkpWmCIgpha8mSnfTgSG1iLN/3rKFQ=;
        b=UyXaa50y21jgqcK7zgu6xHZsaJ646nk3IdZMvdNxslgWRs6WiulpdjTMp+4rsk/vDCqBx2
        hwEirvT/5rfpNseXzX1bv4cvLO3PAbIUHYGyccFmyIrZQfsB66F0+7BEfyXLHdlSnzuoqp
        CgLHWbjYAI8osAx7NR09b09lakbik+Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf4f919a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 19 May 2022 20:06:27 +0000 (UTC)
Date:   Thu, 19 May 2022 22:05:29 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YoajCafKmgUbbaY0@zx2c4.com>
References: <20220519193133.194138-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519193133.194138-1-axboe@kernel.dk>
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

On Thu, May 19, 2022 at 01:31:31PM -0600, Jens Axboe wrote:
> Hi,
> 
> We recently had a failure on a kernel upgrade because splice no longer
> works on random/urandom. This is due to:
> 
> 6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

Thanks for this. I'd noticed this a few months ago and assumed it has
just always been that way, and hadn't gotten to looking at what was up.

I'll take a look at these patches in detail when I'm home in a few
hours, but one thing maybe you can answer more easily than my digging
is:

There's a lot of attention in random.c devoted to not leaving any output
around on the stack or in stray buffers. The explicit use of
copy_to_user() makes it clear that the output isn't being copied
anywhere other than what's the user's responsibility to cleanup. I'm
wondering if the switch to copy_to_iter() introduces any buffering or
gotchas that you might be aware of.

Also you may need to rebase this on the random.git tree at
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git

Regards,
Jason
