Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFD597424
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbiHQQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbiHQQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D88A0307
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:27:37 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S8cEo5yPBDZFmWTJAlnsL4er4PqEcEC7xdye2QerCLU=;
        b=3js9FtXGjkkmS+K2vMEGOgdv3cpnzc/4umeFsH3GkjNYIdWWDNgjOcCpuEE4kWvBeQ3TRK
        rmZAJVStU3/QBr1QTecYO/N5oeD1B+htaHrFxAR0fhRamOvuilBWeRIKGwyY4XNCHuk/7B
        UM15AK8SIAMgrWoafqCpu1CQWiZr54OzCCiy+GVXyMqaAKEFqv+0zXGr1gc1ZyJ1/TeP0S
        VU7MfmBFWJtXNi9ctfiDGYxF3jlMWuAGOkRGp4jr/S/XYVfsEyermHxg9isEDUf2qT7UiO
        3UKeyZoWzBWj0h36vhn2KT2sC4BiNVPZFM0+TAMzyu5YMTRS/qEx2+/nLPKyaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S8cEo5yPBDZFmWTJAlnsL4er4PqEcEC7xdye2QerCLU=;
        b=Axjanp5bui//gxUBL/iLZ7uqhIpL30WyfWSYVuoYz2jNCYxK9bz9UBulZxAbAr+/Myn1Ip
        D+0suN2mlDBLbjCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/9] Replace PREEMPT_RT ifdefs with preempt_[dis|en]able_nested().
Date:   Wed, 17 Aug 2022 18:26:54 +0200
Message-Id: <20220817162703.728679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
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


