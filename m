Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550655207CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiEIWgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiEIWgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:36:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035792B94FB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:32:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j14so15181514plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=OGnpUghGinTHrKMvuIufYZhVKzsWXTtBz74k+ehQUmU=;
        b=P4847mqYvFJU1r8pM8dySzlwyIgNtXMJtbDDKvWSq5MGwtlscsCCXVAVp3Een15tLe
         5n1Ydmj9moMd6LKmt4gHIKvaic1BzqcoqL6KWFbWTtasDJ3BWP2ccEtahvna+yVemzis
         iN1RQFTG6BN5PoYdPoJ61hmhf2JFm/LbRNK7uIE236X3HolKFjadTFcKKEk9AsvQjYjP
         pJsGtCW77rc+iguSk+VXaKEz+BzOH2GG5CD1ihjlYTqHbZayoqPzwmAotJfU6v9gDP1k
         Vjt4YeEEM1KNCc4W6h/eu83swnsrnpDl8df6+epZYsqG0Wy5wIR7B4EHFLkXh/EjiI7J
         du5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=OGnpUghGinTHrKMvuIufYZhVKzsWXTtBz74k+ehQUmU=;
        b=O5CmVWnf81t/YlrVENK2LwD7AQV1sX0+neabnIqwxjB1qYk5zMx1EB7pAHnn0MXLY1
         n4YIC1V6OxKz+R/0JNHVdmHYdNZ1WUxi4G+mOe/Ba49ZO31xlvmA0xzBw/J0kg3Uhxrf
         9Bq/cYxK3vPzFd/VSRlkR2sBUmuhndb4qQBPeg3KeBgFbB7JlGR0nl4Qxtq0ghXPX7Ck
         l6PwkVok/F2Xnpj8Nt9uBnstKuW9QFEs+5a2yF8fWIqoEvf5NsrU0XUEryNYBjKOz9WH
         L8TG0gIUDn+3VsBTEJ5CCNS/GUyDFPyh4547LdCqElexI1pMLLpeUsxxw+aKb79gurqs
         StTg==
X-Gm-Message-State: AOAM533mCxYD2FxuJyRGVQeuDAm8ZPnpUBDor+QEll5KjljGzuXbtp6w
        Vg26y5lSYsbr/Rt9ghSeLlsmlyc/yj3DsA==
X-Google-Smtp-Source: ABdhPJwQqh+fMlzdQfbFIVzBAzPAKhyu5i+yFaI9OdV1VeSQSp6KVjEElBPWxJiMze+/T0PiWw2qGQ==
X-Received: by 2002:a17:902:e94d:b0:158:2f50:d04c with SMTP id b13-20020a170902e94d00b001582f50d04cmr17881540pll.11.1652135542508;
        Mon, 09 May 2022 15:32:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v10-20020aa799ca000000b0050dc7628166sm9164094pfi.64.2022.05.09.15.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:22 -0700 (PDT)
Date:   Mon, 09 May 2022 15:32:22 -0700 (PDT)
X-Google-Original-Date: Mon, 09 May 2022 15:29:55 PDT (-0700)
Subject: [GIT PULL] asm-generic: New generic ticket-based spinlock
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-cd395c5c-a0e8-4e49-a61c-56169759df70@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git tags/generic-ticket-spinlocks-v5

for you to fetch changes up to ed9604312e917c3167f156025f45245d4971415d:

  asm-generic: qrwlock: Document the spinlock fairness requirements (2022-05-09 12:42:17 -0700)

----------------------------------------------------------------
asm-generic: New generic ticket-based spinlock

This contains a new ticket-based spinlock that uses only generic
atomics and doesn't require as much from the memory system as qspinlock
does in order to be fair.  It also includes a bit of documentation about
the qspinlock and qrwlock fairness requirements.

This will soon be used by a handful of architectures that don't meet the
qspinlock requirements.

----------------------------------------------------------------
This is aimed towards at least Arnd's tree, assuming it lands I'll deal with
the follow-on bits as per the notes in v5 of the whole patch set.

----------------------------------------------------------------
Palmer Dabbelt (1):
      asm-generic: qrwlock: Document the spinlock fairness requirements

Peter Zijlstra (2):
      asm-generic: ticket-lock: New generic ticket-based spinlock
      asm-generic: qspinlock: Indicate the use of mixed-size atomics

 include/asm-generic/qrwlock.h        |  4 ++
 include/asm-generic/qspinlock.h      | 29 +++++++++++
 include/asm-generic/spinlock.h       | 94 +++++++++++++++++++++++++++++++++---
 include/asm-generic/spinlock_types.h | 17 +++++++
 4 files changed, 137 insertions(+), 7 deletions(-)
 create mode 100644 include/asm-generic/spinlock_types.h
