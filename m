Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9E14AE5FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiBIAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiBIAYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:24:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58BC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57E5161000
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B968C004E1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:24:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="m/eb1fhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644366291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbdXfuTD6th2pc/toA16UIqb14BCKQ7LeKx2MOXtTO8=;
        b=m/eb1fhvqhNudzfwbgUCDUnZpjS4ct8kdVi+7unkxZrAH8+zBsNwuwoSpbasLzfl/e5jYJ
        TiYeKnbS8IUWZx57QE5c3w5a/sAGfvci9ZcMM3xeopnB/SN0lsLPICBEX01SEYuWYj8yIN
        2Nt/YQnP7PEGJeBjQbYkRMo+5aHsDdU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43071cde (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 9 Feb 2022 00:24:51 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id y203so1300596yby.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 16:24:50 -0800 (PST)
X-Gm-Message-State: AOAM533NaA9Mr6lS6221stMA6KrLJ9u1yx/ACDDq7peQdX/W6QEi5yfS
        8qHCz2TtCo1eskk6v64g7KBjpYTS6u+pCqfa9vc=
X-Google-Smtp-Source: ABdhPJztKBVrGAs92FK1hBdfSh/4jl9WF47QNzLwCZ1kttHmXcDA+ORuw38OvgnhOi7hGm+5oLrbt7bEVx0YfJsO8tc=
X-Received: by 2002:a25:42:: with SMTP id 63mr5601999yba.245.1644366290160;
 Tue, 08 Feb 2022 16:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20220207153914.365931-1-Jason@zx2c4.com> <20220207153914.365931-2-Jason@zx2c4.com>
 <YgMAV2Ps/k80w48M@sol.localdomain>
In-Reply-To: <YgMAV2Ps/k80w48M@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 01:24:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9qajS8RVEa6NCYQZtfoFDCV9jXDPG1JTMxy_cOQJ3f34Q@mail.gmail.com>
Message-ID: <CAHmME9qajS8RVEa6NCYQZtfoFDCV9jXDPG1JTMxy_cOQJ3f34Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] random: remove batched entropy locking
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
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

On Wed, Feb 9, 2022 at 12:44 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Looks good.  The comment above invalidate_batched_entropy() needs to be updated,
> though.

Fixed, thanks.
