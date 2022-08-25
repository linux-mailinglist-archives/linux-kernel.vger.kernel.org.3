Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80545A16E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiHYQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbiHYQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:42:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915EBB00D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:41:53 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HJQHOzzBWBUsO7fsEyeJUHcnp7PL1dORslWKtuk1duQ=;
        b=m3tJ12dYitPLEwvZ203te40Y9+B0R0Brc22MwSS5vH0UX7etVfsiDP8SJ+x4MMfvhxg5u9
        ZiCpD4BZ6n0Ln3snBalMINEFP7IevnPYoOf6LICgFtcEQTo1yh8Qt8nJkBthbKDPEBZqdr
        EbuQZ9etY/QGjHeHuDjFvLb1R3aOPRECmTpDYmjI5UwuVF8VneXkpjWMUnONRmvfT+L8Ym
        GalylK6hO9CAC55fcC9FBbcZMnupTLxlMf6wUrDG5qdJxQMvbDwaXP2qR9Nh6zQqJWKJ25
        +FymDSCeuiAiAGl2y3aAz5U/yx7M1ZMgZ/FMWO8aAwvqVfM93L2cPTE4OKWmxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HJQHOzzBWBUsO7fsEyeJUHcnp7PL1dORslWKtuk1duQ=;
        b=vx73HV7gWTsNp5eADDUQWdnG8Lqc6AqNFjBG2jV1onK+mUFI31tG06UNzyuDRapQvF1fRb
        IkkFHme7hfdRxdDw==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/8] Replace PREEMPT_RT ifdefs with preempt_[dis|en]able_nested().
Date:   Thu, 25 Aug 2022 18:41:23 +0200
Message-Id: <20220825164131.402717-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

this is v2 of "Replace PREEMPT_RT ifdefs with preempt_[dis|en]able_nested()=
."
The v1 is at
   https://lore.kernel.org/all/20220817162703.728679-1-bigeasy@linutronix.d=
e/

v1=E2=80=A6v2:
   - The SLUB patch got s/use_lockless_fast_path/USE_LOCKLESS_FAST_PATH/ as
     Linus asked for and was handed over to Vlastimil and is sitting in his
     slab tree:
        https://git.kernel.org/vbabka/slab/c/591570a7

   - The compaction patch got an "depends on COMPACTION" so it is not listed
     .config if compaction is disabled (Rasmus Villemoes).

   - The removal of u64_stats_fetch_begin_irq() has been excluded from the
     series and staged for later. Jakub asked for this, so that it can be
     included in later merge window.

   - A patch for flex_proportions has been added which also needs a
     preempt_disable_nested() since the merge window.

Original cover letter:

this is the follow up to the "vfs.git pile 3 - dcache" pull request [0].
It was concluded that the introduction of
	preempt_disable_nested()

in general makes sense and should be used in places where preemption on
!RT is disabled by other means and PREEMPT_RT need to explicitly disable
it.

This series introduces the macro and converts already existing users to
that macro. The u64_stat interface was simplified to make the change
simpler and code easier to follow.

[0] https://lore.kernel.org/all/YurA3aSb4GRr4wlW@ZenIV/

Sebastian


