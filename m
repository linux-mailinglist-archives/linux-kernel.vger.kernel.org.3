Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8E508A01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379174AbiDTOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiDTOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157E3E0DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i63so1697071pge.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lawfx27xta4vfR+4MosfdO7oG8Hnj+YwEmI/W9otsus=;
        b=GxVa8lq0hY3BT7fav05p0SMUyezgEY1uIy+ZgBDa4XsugOwBffXhDQFr0P/vMBVjD7
         QVnDqaz9KiXDgjfFaldOiKsWg05ZvCb7dHm+GjZZfcYEjDaXhMnKtxVLVfeAR/2yb3h2
         uFruHDNkNflM9LEwUzwISQmnjWoaPfodfDT2x738I2zQyHkQUCcdqBYZXzLHDFoPLOjs
         uW8IB98LbxCnWy/h3CutN2oTgYFFtZvgHFDVHj7Vb8Fg+9HvRuMtNjqqz5zWgoFb1dqn
         3fgQjJ8ounYpaudnkKyqjbSsvSW1MCupJGYrHQURJ+CMZeeqzptZdiEhv8x/WjvmOTyU
         0JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lawfx27xta4vfR+4MosfdO7oG8Hnj+YwEmI/W9otsus=;
        b=B/7Zne24nf6pYZ5TUm6T91bySemmlfU9dKLf2lBtvupcjKoVRx6BymoyjaRB+nmZ/m
         z9Dbgto4geviVtMhtB8vhSHQSQfo2wi2Yfly0ZcRC6iUn2P6PoEnEIy82T04vTkrV2gd
         PcZFl099YlKVOVSZp+OquLFZnKUYJAK7b0+QnqTcc6yl8Jy6EFhKajm2NsfpiftGsZkF
         Py4T+zjlsBsrWotrlL7/n2TS2ihlwtk233KK+L0bhN6RlVydMLytnB5+KvEbyj3MYdds
         qFhyn/n8n4PHalSfR4S8UbpMpAvwjZrnkEKj4oIEbrJjh69DOpshob7eiU1ZsvuS6vqn
         Os3A==
X-Gm-Message-State: AOAM5305/DVFWG0BUqNjhn58ulWCbLg5aakCTxhobSBVzoC/HVOKYhsj
        UDtJ9yBUIlEgtIyXGZyRIOM8A1csIQ==
X-Google-Smtp-Source: ABdhPJyqV6J9YtrSx9zs543pGsBRCkaga0d8/OJxaVvsfbUHMaMpwB8ODXnAm19kyamE/o8+sBlktQ==
X-Received: by 2002:a63:482:0:b0:3aa:5637:e33a with SMTP id 124-20020a630482000000b003aa5637e33amr4832486pge.536.1650463540097;
        Wed, 20 Apr 2022 07:05:40 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:05:39 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Baokun Li <libaokun1@huawei.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 0/9] trival fix or improvement about irq_desc access
Date:   Wed, 20 Apr 2022 22:05:12 +0800
Message-Id: <20220420140521.45361-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I went through the access of irq_to_desc(), I found the following
trival issue or improvement can be done.
[1-4/9]: clean up or small improvement
[5-6/9]: bugfix for access to irq_desc under releasable context
[7/9]: clean up
[8-9/9]: bugfix for irq debugfs


Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Rix <trix@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc: YueHaibing <yuehaibing@huawei.com>
To: linux-kernel@vger.kernel.org


Pingfan Liu (9):
  irq/irqdesc: put the lock at the exact place in irq_sysfs_init()
  irq/irqdesc: change the name of delete_irq_desc() to irq_delete_desc()
  irq/manage: remove some unreferenced code
  s390/irq: utilize RCU instead of irq_lock_sparse() in
    show_msi_interrupt()
  x86/irq: place for_each_active_irq() in rcu read section
  pm/irq: make for_each_irq_desc() safe of irq_desc release
  irq: remove needless lock in takedown_cpu()
  irq: make irq_lock_sparse() independent of CONFIG_SPARSE_IRQ
  irq/irqdesc: rename sparse_irq_lock to bitmap_lock

 .clang-format                  |  1 -
 arch/s390/kernel/irq.c         | 11 ++++----
 arch/x86/kernel/apic/io_apic.c |  3 +++
 include/linux/irq.h            |  1 -
 include/linux/irqdesc.h        | 10 +++-----
 include/linux/irqnr.h          |  3 ---
 kernel/cpu.c                   | 15 ++++-------
 kernel/irq/cpuhotplug.c        |  4 +--
 kernel/irq/debugfs.c           |  4 +--
 kernel/irq/irqdesc.c           | 47 +++++++++++++++++-----------------
 kernel/irq/manage.c            | 15 -----------
 kernel/irq/pm.c                |  3 +++
 12 files changed, 47 insertions(+), 70 deletions(-)

-- 
2.31.1

