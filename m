Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2AE4BE69D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378171AbiBUOnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:43:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbiBUOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:43:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE113E06;
        Mon, 21 Feb 2022 06:42:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E105261052;
        Mon, 21 Feb 2022 14:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0676EC340E9;
        Mon, 21 Feb 2022 14:42:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QnJLh0k9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645454567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+WQhj2bKXmrHAlboGodRiAor51NQtRBFZD94x6/+vb4=;
        b=QnJLh0k9n13zUM7Ht6ApQC16QTwAEj6ueaTWi4ayNv0y3JFTnhaW78p3HIWpQXmooYRYTv
        HYGlNjzdv2l4Snh0O1cIPWq0PQ2IztNHs/Pn6u+iYvvjkNNxej+3TNPu42h2lMnYCJWDi9
        L7DZepzuYtvyBsyZW32EfKEH3vIr1SQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e046bba (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 14:42:47 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id p19so34795873ybc.6;
        Mon, 21 Feb 2022 06:42:46 -0800 (PST)
X-Gm-Message-State: AOAM5327W52pTSTHApq/cO/AjI52DFAu3mIYwhUEd6Oda7wJGc+pszg8
        Ig0/LwzwpDfWEO1Gvubs1aRgEZFxZ5rla+ebN+4=
X-Google-Smtp-Source: ABdhPJwkU2f1EUQ8qcxRDppbN7rT/bIQ0Pert0HuvvnxBX0Zhhd7mmYS3O4mQe2fKjogzQCWvxx+Hbjsu+dUF8HlbjQ=
X-Received: by 2002:a25:238d:0:b0:619:3e19:b06b with SMTP id
 j135-20020a25238d000000b006193e19b06bmr18492362ybj.382.1645454565770; Mon, 21
 Feb 2022 06:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20220214184627.3048-1-Jason@zx2c4.com> <20220216232142.193220-1-Jason@zx2c4.com>
 <YhMJAsiHsjCJU1A4@sol.localdomain>
In-Reply-To: <YhMJAsiHsjCJU1A4@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 15:42:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9qptoGM=Xc+qJKN87OC6-RdnbJNSx3GCfLUz4p7qQwzuw@mail.gmail.com>
Message-ID: <CAHmME9qptoGM=Xc+qJKN87OC6-RdnbJNSx3GCfLUz4p7qQwzuw@mail.gmail.com>
Subject: Re: [PATCH v4] random: use simpler fast key erasure flow on per-cpu keys
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jann Horn <jannh@google.com>
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

On Mon, Feb 21, 2022 at 4:37 AM Eric Biggers <ebiggers@kernel.org> wrote:
> The only oddity I noticed is that some new comments use the net coding style for
> multi-line comments, and get reformatted to the standard style later in a later
> patch.  It would be preferable to use the standard style from the beginning.

You can tell where I've been spending my time... :)

I'll fix this up.

Thanks a lot for your review on this patch and the couple dozen of others too.

Jason
