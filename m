Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE848ED4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbiANPnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:43:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57268 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbiANPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:42:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2124461F38;
        Fri, 14 Jan 2022 15:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B9FC36AEA;
        Fri, 14 Jan 2022 15:42:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J50NzVoQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642174976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jHAjYaJLduk1oUVrq3t+bswqqI+Vo9Ud2UlUUNOhc3w=;
        b=J50NzVoQ/cbnu7PvlAljPB2adxPxtTbcpV518xAwKtnnFVteirroyQHFH+QvrwXAmjdH6r
        kcSh/aS4PEL2p/SQzdlILejpqte0HhIlABh9U3fcFBdV8kzZkpfMAXZ3rlH8MFDFUzuA1j
        2qkerbMEh9m/2OaeYQxR6pbZBHXKuFM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 92ac44a4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 14 Jan 2022 15:42:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, herbert@gondor.apana.org.au
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH crypto v3 0/2] reduce code size from blake2s on m68k and other small platforms
Date:   Fri, 14 Jan 2022 16:42:45 +0100
Message-Id: <20220114154247.99773-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending this v3, because the previous one was so deeply nested
  inside other patchset threads that b4 was unable to extract it without
  getting terribly confused. And if b4 was confused, probably human
  readers were too. This new cover letter is a new root thread. ]

Hi,

Geert emailed me this afternoon concerned about blake2s codesize on m68k
and other small systems. We identified two effective ways of chopping
down the size. One of them moves some wireguard-specific things into
wireguard proper. The other one adds a slower codepath for small
machines to blake2s. This worked, and was v1 of this patchset, but I
wasn't so much of a fan. Then someone pointed out that the generic C
SHA-1 implementation is still unrolled, which is a *lot* of extra code.
Simply rerolling that saves about as much as v1 did. So, we instead do
that in this patchset. SHA-1 is being phased out, and soon it won't
be included at all (hopefully). And nothing performance-oriented has
anything to do with it anyway.

The result of these two patches mitigates Geert's feared code size
increase for 5.17.

v3 improves on v2 by making the re-rolling of SHA-1 much simpler,
resulting in even larger code size reduction and much better
performance. The reason I'm sending yet a third version in such a short
amount of time is because the trick here feels obvious and substantial
enough that I'd hate for Geert to waste time measuring the impact of the
previous commit.

Thanks,
Jason

Jason A. Donenfeld (2):
  lib/crypto: blake2s: move hmac construction into wireguard
  lib/crypto: sha1: re-roll loops to reduce code size

 drivers/net/wireguard/noise.c | 45 ++++++++++++++---
 include/crypto/blake2s.h      |  3 --
 lib/crypto/blake2s-selftest.c | 31 ------------
 lib/crypto/blake2s.c          | 37 --------------
 lib/sha1.c                    | 95 ++++++-----------------------------
 5 files changed, 53 insertions(+), 158 deletions(-)

-- 
2.34.1

