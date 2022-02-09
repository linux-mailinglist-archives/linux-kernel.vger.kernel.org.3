Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA74AF230
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiBIM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBIM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:57:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A98C0613CA;
        Wed,  9 Feb 2022 04:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65592B820C9;
        Wed,  9 Feb 2022 12:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62781C340EB;
        Wed,  9 Feb 2022 12:57:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WiLYt5BM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644411421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TzHGC6wsLVu0PsKqyS6HzONuY4q5KF/exMn4jqmC1oQ=;
        b=WiLYt5BMmAAa9p+aVYtVwyeijjHBt4ma+Hzz7gcijJbehzg8368FCv5LdKft6GbfE7TGMx
        XoZDq1oXv8SIvfV10Vpa7gXPGnlxo7UgpAApGF9ViGgWfKL0W/bqKZ6DKPinw9oA5hRQ8h
        Rm6KYTDepv50QJ7SEIH4edJiD6S58/4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e7d50b0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 12:57:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 0/2] random: PREEMPT_RT fixes
Date:   Wed,  9 Feb 2022 13:56:42 +0100
Message-Id: <20220209125644.533876-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Here are the two patches we've been looking at thus far in separate
threads, now brought together as one patchset. This doesn't fix _all_ of
the PREEMPT_RT issues, but it does very much move in the right direction
of having less locking in places where that matters.

v4 improves on v3 by fixing documentation comments and copying the fast
pool to the stack before mixing.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: Eric Biggers <ebiggers@kernel.org>

Jason A. Donenfeld (2):
  random: remove batched entropy locking
  random: defer fast pool mixing to worker

 drivers/char/random.c         | 109 +++++++++++++++++++---------------
 include/trace/events/random.h |   6 --
 2 files changed, 62 insertions(+), 53 deletions(-)

-- 
2.35.0

