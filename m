Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF552ECD6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349686AbiETNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiETNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:04:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDCF59972
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D07A9B82A78
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE0CC385A9;
        Fri, 20 May 2022 13:04:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oYbD0jQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653051862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GIxYVqfvvrLOFh88kelq3vqnshFAmdZSykwrnhgR3L4=;
        b=oYbD0jQoUwyLrEfJpzvNQyF+mIVRRQtqCRrt2VNmuk/ZVcqb2qFzVxi7Er01wTwqBh+pht
        /1nS11gLznyKC9u/dDqGmY9e1KGMomRba4WY0iCo6GMXLsZnbJglZl9zwwIRSi4APs/Mta
        qITlg1dF5ug1wqy8ShbUwE9A3llpNag=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9fffb8bb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 13:04:22 +0000 (UTC)
Date:   Fri, 20 May 2022 15:04:20 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YoeR1JeXxzPoKylm@zx2c4.com>
References: <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk>
 <YobldmDn6pU9mr4f@zx2c4.com>
 <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk>
 <YoboEokc00YACuha@zx2c4.com>
 <435cc499-7564-13e2-c4ef-a71119379cf0@kernel.dk>
 <YoeM6hP0JVqL9edj@zx2c4.com>
 <110504dc-4720-1430-2e18-a7b6e3a12015@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <110504dc-4720-1430-2e18-a7b6e3a12015@kernel.dk>
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

On Fri, May 20, 2022 at 06:49:45AM -0600, Jens Axboe wrote:
> > I posted
> > https://lore.kernel.org/lkml/20220520095747.123748-1-Jason@zx2c4.com/ to
> > fix it if you'd like to review.
> 
> Not in my inbox, but you also used an email that hasn't been valid in 16
> years :-)
> 
> But looks fine to me, we can open this up to character devices, don't
> see an issue with that.

Whoops! I'll bounce it to you so you can provide a Reviewed-by for Al
over there.

Jason
