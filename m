Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFD5430C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiFHMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbiFHMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC203C4AE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D8E619C0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B1C34116;
        Wed,  8 Jun 2022 12:49:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YW4cLIZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654692553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hySWdXi2kL6m9EGUGgZIsII1nwfn9UHerii4bIuCYus=;
        b=YW4cLIZby+GCYoNqZX29VlKmj5DMZvNlecSHVgOSVP3SYmPUHiZBmZvrbKgrCJOEpXLPme
        79qrLJXdx+dTiW3zozVZsUGUqL9z/NEv86+jwSFzXTR+xbsadl+92UEyoZ+l0cNeK1VTq3
        Os9Bg7fA14bHO9kaZdaa5sw05c2oHpE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d1293f51 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 8 Jun 2022 12:49:12 +0000 (UTC)
Date:   Wed, 8 Jun 2022 14:49:07 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] splice: allow direct splicing with chardevs
Message-ID: <YqCaw3zychulNAp1@zx2c4.com>
References: <20220520095747.123748-1-Jason@zx2c4.com>
 <938111ca-d3c7-9888-24f8-0017a989002b@kernel.dk>
 <CAHmME9pSZYZSz3YLRK7onO0E6zq9_B1GNwoTOkEQy_kws200Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pSZYZSz3YLRK7onO0E6zq9_B1GNwoTOkEQy_kws200Fw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Thu, May 26, 2022 at 11:19:46PM +0200, Jason A. Donenfeld wrote:
> Hey Al,
> 
> On 5/20/22, Jens Axboe <axboe@kernel.dk> wrote:
> > On 5/20/22 3:57 AM, Jason A. Donenfeld wrote:
> >> The original direct splicing mechanism from Jens required the input to
> >> be a regular file because it was avoiding the special socket case. It
> >> also recognized blkdevs as being close enough to a regular file. But it
> >> forgot about chardevs, which behave the same way and work fine here.
> >>
> >> This commit adds the missing S_ISCHR condition so that chardevs such as
> >> /dev/urandom can be directly spliced without strangely returning
> >> -EINVAL.
> >
> > Should be fine to turn this on for char devices:
> >
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> >
> 
> Was wondering if this would make 5.19. That'd be nice, as it's the
> release in which we switch to read_iter().

Just thought I should ping once more on this. Should probably be queued
up somewhat soon for 5.19 if it's to make 5.19, which I would really
appreciate.

Jason
