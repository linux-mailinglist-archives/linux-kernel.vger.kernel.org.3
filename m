Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57BE54738C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiFKKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFKKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF61162
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36996B83610
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 10:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AABFC34116;
        Sat, 11 Jun 2022 10:05:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c5ArRhjg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654941903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K8Fih1pMzbVI+b3h1u5AjgJXQiwLKTClqbDyl1iljVs=;
        b=c5ArRhjg4H54HtkZZoMU9fiXH+0tj5yv7Mf/BNtUopdXPcjeHx+AYoga5qFuwfYji9J5iI
        jFwKQfMTJJSh38GgD7nJPj8lRKEdb4rGFu1+NrhZsBzg1Raj4iRkNkHYZRrl1yxseL0Bj3
        p949vJSpPkmQjvjlp3APGXpYbhTZCFI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 62c13b0c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 11 Jun 2022 10:05:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 0/3] powerpc: wire up rng during setup_arch
Date:   Sat, 11 Jun 2022 12:04:44 +0200
Message-Id: <20220611100447.5066-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform's RNG must be available before random_init() in order to be
useful for initial seeding, which in turn means that it needs to be
called from setup_arch(), rather than from an init call. This series
wires that up properly on the three platforms that currently initialize
the RNG from the wrong place.

Jason A. Donenfeld (3):
  powerpc/microwatt: wire up rng during setup_arch
  powerpc/powernv: wire up rng during setup_arch
  powerpc/pseries: wire up rng during setup_arch

 arch/powerpc/platforms/microwatt/rng.c   |  9 ++-------
 arch/powerpc/platforms/microwatt/setup.c |  8 ++++++++
 arch/powerpc/platforms/powernv/rng.c     | 17 ++++-------------
 arch/powerpc/platforms/powernv/setup.c   |  4 ++++
 arch/powerpc/platforms/pseries/rng.c     | 11 ++---------
 arch/powerpc/platforms/pseries/setup.c   |  3 +++
 6 files changed, 23 insertions(+), 29 deletions(-)

-- 
2.35.1

