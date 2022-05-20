Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3B52EFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351129AbiETPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbiETPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:55:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E815EA41
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E3ABFCE2991
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34E9C34100;
        Fri, 20 May 2022 15:55:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NbhhjPbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653062107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUosTam6sJ3QFBqPm2/0VkGE5we6zMbpQ9U8h/KBbBA=;
        b=NbhhjPbeQRm3SkmaBPqs4icVbL8d/4Oyn/EYFkDr+nDFbkxeKrWegBzml8pOpvVHS/w7fv
        ip8Qfd8P0OJ7NKq7jU2m8F1gnbQauwluw41MpowDGCyrsG9L2GaJvPoOVNJLkj1SZXndDZ
        vOVECAGJr22wyFyOYmNqPl3h97nGSqI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 47eeb361 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 15:55:06 +0000 (UTC)
Date:   Fri, 20 May 2022 17:55:05 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe52RaMayvgodVW@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe2PPA/pzqhf+GZ@zx2c4.com>
 <0a6ed6b9-0917-0d83-5c45-70ff58fad429@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a6ed6b9-0917-0d83-5c45-70ff58fad429@kernel.dk>
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

On Fri, May 20, 2022 at 09:44:25AM -0600, Jens Axboe wrote:
> Ran 32, 1k, 4k here and it does seem to be down aboout 3%. Which is
> definitely bigger than I expected, particularly for larger reads. If
> anything, the 32b read seems comparably better than eg 1k or 4k, which
> is also unexpected. Let me do a bit of profiling to see what is up.

Something to keep in mind wrt 32b is that for complicated crypto
reasons, the function has this logic:

- If len <= 32, generate one 64 byte block and give <= 32 bytes of it to
  the caller.

- If len > 32, generate one 64 byte block, but give 0 of it to the
  caller. Then generate ⌈len/64⌉ blocks for the caller.

Put together, this means:

- 1..32, 1 block
- 33..64, 2 blocks
- 65..128, 3 blocks
- 129..196, 4 blocks

So you get this sort of shelf where the amortization benefits don't
really kick in until after 3 blocks.

> If you're worried about it, I'd just keep the read/write and add the
> iter variants on the side.
 
Not a chance of that. These functions are already finicky as-is; I would
really hate to have to duplicate all of these paths.

Jason
