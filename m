Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB21150D6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiDYBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiDYBmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:42:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3E60CB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50BD0B81057
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D9AC385A9;
        Mon, 25 Apr 2022 01:39:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hWmYWoZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650850768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=3PGoms4uKwhDdPL7bDzu5Xb/wx7iM8/XnsILLp5LvEM=;
        b=hWmYWoZzkD9hPFd/y00CDVZxWqVv6Hz4Yrb6K8bGZfazGmgrPtgLKsx9VLNWWmJogPPpDJ
        w55EZeMo9cKJYcm08qxK/K/8uKr3ZG5omixNXcn/YjGclXBLUzrBXsSut1cC1vEYnyIDay
        3mAJAoYBDOm79+zWm593mMztXhiWfcs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 13fee6f6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 01:39:28 +0000 (UTC)
Date:   Mon, 25 Apr 2022 03:39:27 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: odd endianness toolchains for crosstool
Message-ID: <YmX7z+BirkA3VAfW@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd,

I'm again experimenting with switching to your crosstool toolchains for
WireGuard's CI. I've hit a few snags in the process:

- For powerpc, gcc needs to be built with `--enable-secureplt
  --with-long-double-64` in order for musl to run.
- Need powerpc64le compiler (-mabi=elfv2).
- Need mipsel compiler.
- Need aarch64_be compiler.
- Need armeb compiler.
- Need mips64el compiler.

While the existing compilers can all produce code for the wrong endian,
they hit trouble when trying to link against libgcc. So generally a
separate full toolchain is supplied for the less common endians.

I have had success with arm, arm64, mips, x86_64, i386, m68k. If you're
up for adding the above compilers to the collection, I'd be able to
complete the transition, and then look into adding a few more
architectures.

Jason

