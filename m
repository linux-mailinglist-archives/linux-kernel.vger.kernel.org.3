Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C052E066
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbiESXNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiESXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:13:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5810654B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F4C6187A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1F3C385AA;
        Thu, 19 May 2022 23:13:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oL5ntF+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653001993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vg8EgL5l07IptbmY+1AkGLthZNVnNbClGhjWdqOGk8Q=;
        b=oL5ntF+Efrsww7IVuS+h8SINkOnKYtJ2/IUciuolk53yFFiEp1vs3RMzfODL4RQGRjS4RU
        4FDBdmNuEYHcldwadDvpO75rotxUS9S7fFjf2JRHA6wElcf6tCAEuwpdzahvGnAndKlspV
        9Gs5IxLJxt9TWYMdv8njFkWHpv34I6k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6184367 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 19 May 2022 23:13:13 +0000 (UTC)
Date:   Fri, 20 May 2022 01:13:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YobPB27Ozl7uqUEu@zx2c4.com>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
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

On Thu, May 19, 2022 at 02:49:13PM -0600, Jens Axboe wrote:
> > There's a lot of attention in random.c devoted to not leaving any output
> > around on the stack or in stray buffers. The explicit use of
> > copy_to_user() makes it clear that the output isn't being copied
> > anywhere other than what's the user's responsibility to cleanup. I'm
> > wondering if the switch to copy_to_iter() introduces any buffering or
> > gotchas that you might be aware of.
> 
> No, it's just a wrapper around copying to the user memory pointed to by
> the iov_iter. No extra buffering or anything like that. So I think it
> should be fine in that respect, and it actually cleans up the code a bit
> imho since the copy_to_iter() since the return value of "bytes copied"
> is easier to work with than the "bytes not copied".

Alright, that's good to hear. So even for kernel->kernel writes, the
argument is that what ever buffers are used in the process are the same
ones that the user would be hitting anyway by calling write() on the
destination if this roundtripped through userspace, so nothing changes?

Jason
