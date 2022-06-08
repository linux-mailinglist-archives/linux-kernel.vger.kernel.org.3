Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4BD542A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiFHI6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiFHI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93113F25
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5861A61629
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B2DC34116
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:18:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TlIuLfn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654676303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alAdv7j7f5ECVgJ2anP3RiBDf+KhFA1OGU7bKYuO3yo=;
        b=TlIuLfn7xALwjUJAK2fvjuioP4zrwY1GKS1bGejMtXWgMIBX4SVxdszrnHvmGaue6mBtdH
        8XrZT/yB3vQYCe22W8pxHYw/tyyZS/UVFchOS/rAO101CH5lEQeII7xL0h0J7N20Cxgids
        dZgnmSvK/xr1QLu5kabM2ZsgF7LPvOA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 090b0093 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 8 Jun 2022 08:18:23 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id w2so35237040ybi.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:18:22 -0700 (PDT)
X-Gm-Message-State: AOAM532CNHRKYzBezVva2cqTlpw/If43o1SpHr/rFvQVyyXMQAQHmsVR
        jhCQygkQq8k+HxRp9x3+yuvtUxRCrajgYwMAgSM=
X-Google-Smtp-Source: ABdhPJyCnqazeF70H7gjiA8eJBbCW0sMG3RUv+Th4Afn7+awOBkDw7LsCtRq9do9DHNuSus+KtdPQ2mZ09Qqq4yjEt0=
X-Received: by 2002:a25:83c2:0:b0:65c:bc75:800b with SMTP id
 v2-20020a2583c2000000b0065cbc75800bmr33835531ybm.373.1654676301725; Wed, 08
 Jun 2022 01:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yp9yUqHNNaAxZ/5y@zx2c4.com> <20220607193044.1063287-1-Jason@zx2c4.com>
In-Reply-To: <20220607193044.1063287-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 8 Jun 2022 10:18:10 +0200
X-Gmail-Original-Message-ID: <CAHmME9orsVXb3cgOhRoKYo69qcrYovW9sJaNW8e-szuLRR3jCQ@mail.gmail.com>
Message-ID: <CAHmME9orsVXb3cgOhRoKYo69qcrYovW9sJaNW8e-szuLRR3jCQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: initialize jump labels before setup_machine_fdt()
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russel King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
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

This patch isn't needed in the end. An equivalent patch is needed on
xtensa, powerpc, arc, mips, arm32, arm64, riscv. That's a bit much and
points to a larger issue. So I'll fix this the ugly way in the
random.c code :(.

Jason
