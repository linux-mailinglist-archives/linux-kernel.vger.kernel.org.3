Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6791A4AC41A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384487AbiBGPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356862AbiBGPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:39:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEA5C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:39:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79384B815BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF1C340F0;
        Mon,  7 Feb 2022 15:39:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CTXf9czU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644248377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QOL1MCrt4CDbHj9zK2jkE0wQa0KfdFX8W8tTrH61IZo=;
        b=CTXf9czUVWH3PVKCGgU/kChMZTJaqn8KejjtwGfX+X3j3aVn172h/V+a21599HExUausd/
        R0DztLqAO1sET6FLVv3lM/amCtlp/exm1tVE0DW8NldJ/RPx123LcECOwNroALWoGfVjCB
        Tgn2S6vbTcKtHHFGoqKO2FBXiRaINDw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d05209c3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 7 Feb 2022 15:39:37 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 0/2] random: PREEMPT_RT fixes
Date:   Mon,  7 Feb 2022 16:39:12 +0100
Message-Id: <20220207153914.365931-1-Jason@zx2c4.com>
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

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Jason A. Donenfeld (2):
  random: remove batched entropy locking
  random: defer fast pool mixing to worker

 drivers/char/random.c         | 101 +++++++++++++++++++---------------
 include/trace/events/random.h |   6 --
 2 files changed, 56 insertions(+), 51 deletions(-)

-- 
2.35.0

