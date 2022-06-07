Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C228B53FEAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiFGMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbiFGMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF26EB2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD9661777
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4A1C385A5;
        Tue,  7 Jun 2022 12:23:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lEPN28Et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654604637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uu649PYiv1GRF9nmsyHrE3npqNZsP0f4UsF1f3YXORc=;
        b=lEPN28Etn8Gb65vtd0R2/4QaZuo1x8vX3ax7kdN+Kbq2cxjGxjh+p4M2XSU851NVsUyJxU
        VrCm+6aeqvgNjP+pcJaSkqXWJGP1d4V65y0EHIKHzV4yL/OdX8dJETjlXcwnjEvex4QBVW
        6IjBn2oLfpOWDRR+wPot2TCZDYfmq9M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d61e4268 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 12:23:57 +0000 (UTC)
Date:   Tue, 7 Jun 2022 14:23:53 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] random: defer crediting bootloader randomness to
 random_init()
Message-ID: <Yp9DWT3RttJGZhvu@zx2c4.com>
References: <CAHmME9pspbPpLnfjypneOCPuVFLd5U29D92kyuqiCaH7fHZ8zQ@mail.gmail.com>
 <20220607113238.769088-1-Jason@zx2c4.com>
 <a09c83a2-f3a3-6ae8-ca96-3560bd6b9f91@raspberrypi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a09c83a2-f3a3-6ae8-ca96-3560bd6b9f91@raspberrypi.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Tue, Jun 07, 2022 at 01:19:41PM +0100, Phil Elwell wrote:
> After a trivial merge conflict (into 5.15) was resolved, this patch allows the 
> downstream kernel with CONFIG_RANDOM_TRUST_BOOTLOADER=y to boot cleanly. 
> However, it does delay the initialisation of crng significantly compared to my
> hack.
> 
> With v2:
> [    1.981493] bcm2835-rng 3f104000.rng: hwrng registered
> [   12.549190] random: crng init done

Thanks. It's because the patch is buggy :)

v3 coming right up.

Jason
