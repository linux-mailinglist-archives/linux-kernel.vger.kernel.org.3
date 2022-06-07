Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11B53FD98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiFGLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiFGLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313DC2E09B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0444616C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B376C385A5;
        Tue,  7 Jun 2022 11:35:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J+iGEOkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654601721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHuOos5FYGJzaRithMcXZPaMqy5pqEvF3gQXE6l18Ts=;
        b=J+iGEOkguDHkFjkoFiE1G5uQtPmrAc4ExyGFY0En5bmKMrfU0dI9N/80sJmtRo+ORWDDTg
        iph7m1Ooo2gKNZUNdEAT7kMH9lTBq1aZ772o8UGlkH+c8hLwbtvdmm6EgBZGh2tNNHxs3N
        A8IJvM8TLDQICBdL++HX32swl5lNjMA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4ac0d11f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 11:35:20 +0000 (UTC)
Date:   Tue, 7 Jun 2022 13:35:16 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: do not use jump labels before they are
 initialized
Message-ID: <Yp839NjwW3scZEqi@zx2c4.com>
References: <20220607100210.683136-1-Jason@zx2c4.com>
 <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com>
 <Yp8rcFrqK/IkzKXj@zx2c4.com>
 <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
 <Yp8wz2Ey4J4u+ZlK@zx2c4.com>
 <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 07, 2022 at 01:10:52PM +0200, Ard Biesheuvel wrote:
> Fair enough. What I would like is to remove the need to play around
> with the placement of jump_label_init() across architectures. Jump
> labels are fundamentally a performance optimization, so unless you can
> explain how setting it as early as possible makes a material
> difference, performance or otherwise, I really think we should pursue
> a solution that does the static key manipulation at some later time.

Alright. It sounds like Catalin also prefers the same. This seems simple
enough with minimal downsides: https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/

So maybe we should just go that route.

Jason
