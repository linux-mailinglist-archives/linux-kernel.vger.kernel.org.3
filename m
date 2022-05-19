Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6D52E080
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbiESXZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiESXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F964DA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12A06190C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC20CC385AA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:25:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O8BJSFLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653002747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2GhPQtANSAtmVp6qBsOBDeAp5KRP+LjdJj1alVgOro=;
        b=O8BJSFLWVUBV73yEmoGXlAHjyt3qKztag6NyGb4p58RU+k94+zqZpWovOQ9/7VH0izoZtV
        7O0refOJk1y/fXvPNheozqTmzM3f841AnnO1lZojTRSAdgMHyXfHufjqjCDiv1OFLftVjr
        P+Gd04MMyxxrgqeB4FYG7kl4GEgQHIU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 00addbc5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 May 2022 23:25:47 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2fee010f509so71505287b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:25:46 -0700 (PDT)
X-Gm-Message-State: AOAM531sfTLA/YzAqkQ6f4Cd9vbgIgtoOJD1pc7IYCT6msZlBMGkEOFw
        Yxb06qZTrYWF7cZGnA5mxP9HplwxCcwWR/weJO8=
X-Google-Smtp-Source: ABdhPJzV3iNR1WgMmIW40IarEp7QUDogIEZ3MqzCY1qvLHUzCKoCH4FV17g/c4lvEKmhHEUpQgHtyoxjTmAqSSc2qX4=
X-Received: by 2002:a0d:ef03:0:b0:2fa:245:adf3 with SMTP id
 y3-20020a0def03000000b002fa0245adf3mr7572937ywe.100.1653002745991; Thu, 19
 May 2022 16:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220519193133.194138-1-axboe@kernel.dk> <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk> <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk>
 <YobPfgkzGrNPDDFI@zx2c4.com> <60b82026-9c46-16ea-d9fa-05eb96ae2218@kernel.dk>
In-Reply-To: <60b82026-9c46-16ea-d9fa-05eb96ae2218@kernel.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 May 2022 01:25:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9rdJ=Pa=KOY6voryiHffWSkRKxC75+Wz-xoQOpowObwWw@mail.gmail.com>
Message-ID: <CAHmME9rdJ=Pa=KOY6voryiHffWSkRKxC75+Wz-xoQOpowObwWw@mail.gmail.com>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, May 20, 2022 at 1:22 AM Jens Axboe <axboe@kernel.dk> wrote:
> I can certainly do the write side too. To fix this regression, I just
> valued doing read_iter first and I'd hate to hold that up to do the
> write side too. I'll do the write side later today, but let's keep them
> separate.

Excellent, thanks. I plan to queue these up all in a row.

Jason
