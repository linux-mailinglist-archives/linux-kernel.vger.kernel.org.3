Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9852EF64
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350947AbiETPjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiETPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:39:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A3A1790AC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A745B82C52
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3399FC34114;
        Fri, 20 May 2022 15:39:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CdDA93IP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653061182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjTQZJZQgulPn2m9ZCd5zit3zBo1nt5rUKPxbyzkWLk=;
        b=CdDA93IPTM0liA99LP3bUYL8IPFJc4pZ6gUPKjzdV4nx/BEvl9EJnGN38VEwwmD6RTWIfT
        pV+nKUCZe0863XlzCIqvhI/H+qa8gAxnC4SpUJdlRykLcPBAoSA2EUxAYJG8a477amhden
        E7A4S+Oxm4haa4x+SR1yqJD/+oTE+7Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd1a99f0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 15:39:42 +0000 (UTC)
Date:   Fri, 20 May 2022 17:39:40 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe2PPA/pzqhf+GZ@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
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

On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
> On 5/20/22 9:25 AM, Jason A. Donenfeld wrote:
> > Hi Jens,
> > 
> > On Fri, May 20, 2022 at 11:44:56AM +0200, Jason A. Donenfeld wrote:
> >> Jens Axboe (3):
> >>   random: convert to using fops->read_iter()
> >>   random: convert to using fops->write_iter()
> >>   random: wire up fops->splice_{read,write}_iter()
> > 
> > FYI, this series makes reads from /dev/urandom slower, from around 616
> > MiB/s to 598 MiB/s on my system. That seems rather unfortunate.
> 
> How reproducible is that? That seems like a huge difference for the
> change. How big are the reads?

Fairly reproducible. Actually, if anything, it reproduces consistently
with worst results; I chose the most favorable ones for the new code.
This isn't any fancy `perf` profiling, but just running:

$ pv /dev/urandom > /dev/null

From looking at strace, the read size appears to be 131072.

Jason
