Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1418548DB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiAMPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:54:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40706 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234645AbiAMPx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:53:58 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1A741EC05B0;
        Thu, 13 Jan 2022 16:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642089237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=U3BQvwcl4RMD5luy2fWSwHs4CpYGNadDZY+h/rqGUrE=;
        b=PTxo9xZ4LmrdYZ5U/zEbtxcsJXt3ryoqECJzqB6bTyEI2o/FOpFDT2kLq5RalFAdADLm7R
        l5VXFSRPbpNNYHaf4qPqrvOamWM4RFwXyntJP5YdTRKQj3rRHeQ8rdr8K/hcy5MWTzxPbf
        Tl1s8l8rgMPsk+j0OieJPCBnEDY4B7Y=
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] generic/bitops: Always inline some more generic helpers
Date:   Thu, 13 Jan 2022 16:53:55 +0100
Message-Id: <20220113155357.4706-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

a build report by the 0day robot:

  https://lore.kernel.org/r/Yc7t934f%2Bf/mO8lj@zn.tnic

made me look at asm and how gcc, at least, generates funky calls to the
*_bit() bit manipulation functions on x86 instead of inlining them into
the call sites as on x86 that's a single insn, in most of the cases.

So PeterZ says the way to go is to always inline them. So here they are.
The fun thing is that on x86 there is even a size decrease of more than
a Kilobyte for a defconfig, which is nice, see patch 1.

As always, comments and suggestions are welcome.

Thx.

Borislav Petkov (2):
  asm-generic/bitops: Always inline all bit manipulation helpers
  cpumask: Always inline helpers which use bit manipulation functions

 include/asm-generic/bitops/instrumented-atomic.h | 12 ++++++------
 .../asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
 include/linux/cpumask.h                          | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.29.2

