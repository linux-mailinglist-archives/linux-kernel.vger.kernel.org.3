Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193C54A4E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351011AbiAaS1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350686AbiAaS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:27:39 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F9C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:39 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i16-20020a056830011000b005a3cc8d20fbso7478036otp.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lK9HI/kqkRjUJVN/KDGUc8YUdnUJMrUkHZrERJHnf+g=;
        b=W8FKpKtzRvZH5gMtZhs9iIt59SzSkJsmfP3crTbAutMw5vzj0zU+YZNTG3BU16KdlZ
         G5qVtQKQe48huZBnn4iMLaknUbAIFqysXcnCUBkhjK4BaHMdcT1jFa5QYUcoJzEvCiSV
         TQK8iFA+IPnh2ANJRDiJRWIJ3v7h38htvZLeodwkYCLOzYXMW5ItjESK6DrVadPgEBoL
         +/3hi0AvgPis6EDrjPSRPiqsKjhvtfxDXRBQOVqs2/SqZfmXJOQ3GD5sHFtKX3v2yrlF
         URbp52XXzJe8yOB9KMKlyPpK+HWHepSo1LttT4HARNoxU8MuG8Qr6r3lEBb/7wXFV9cJ
         pGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lK9HI/kqkRjUJVN/KDGUc8YUdnUJMrUkHZrERJHnf+g=;
        b=6UFhlEUlzr2MJIN1Of6oB3uHhWvlfEYAyElt+UCdL5aEsabqrEaSnWh/9Jeot+PhCs
         FB+KVEc0B8W+Slzt7Xl4uijzS/LdcWwsOrK4r+ddaFpjEtqbUovsMhmOXLq8REV6Dt94
         LEqfClYnwOLTgGHNTrt7G6u4u0v2CWBu1qW1khILBWiQiBG+edoJZXK9rWAe+QK3+Nwo
         1ZcYS5Mli6NL37iangqyvpc9QjbCXAqtp8zUYGbS4ln6YpGboXWd6kdxGCIrcHw7Fu9P
         oCWCfJkvebRNbX2KnKaXWM3S6dpJujs2IiEx2QdZj52S/z1O9kZNbEVQLGKLGfia/ft3
         1HcA==
X-Gm-Message-State: AOAM533W8yfFqczZPmEQtgeQhf9net8g0SwNsbC4ayBjnXwsg1RAyYIU
        BdhA0Eherh9TINAkUEAruUNwNWWhA8FXGw==
X-Google-Smtp-Source: ABdhPJyX2cZIYrb8zsfJu0kTdNdvTTTibkTAgJpG/7isbGwNuD8rJ6Iwvngg7+UAdkh3RSQUIKtp0A==
X-Received: by 2002:a9d:12b2:: with SMTP id g47mr12795393otg.19.1643653659130;
        Mon, 31 Jan 2022 10:27:39 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:27:38 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Module relocation fixes and asm/insn.h header
Date:   Mon, 31 Jan 2022 19:27:13 +0100
Message-Id: <20220131182720.236065-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies! I messed up v1. Please consider this patch set only.

The first patch removes a bunch of code from the asm/module.h which is
included in almost all drivers through linux/module.h. Next are two
patches to fix unaligned access when doing module relocations and do
proper range checks for auipc+jalr offsets.

I'm a little less confident about the following patches, so consider
this more of an RFC for those. The idea is to consolidate the RISC-V
instruction generation and manipulation similar to arm64's asm/insn.h
header.

/Emil

Emil Renner Berthing (7):
  riscv: Remove unneeded definitions from asm/module.h
  riscv: Avoid unaligned access when relocating modules
  riscv: Fix auipc+jalr relocation range checks
  riscv: Add asm/insn.h header
  riscv: Use asm/insn.h for module relocations
  riscv: Use asm/insn.h to generate plt entries
  riscv: Use asm/insn.h for jump labels

 arch/riscv/include/asm/insn.h       | 121 ++++++++++++++
 arch/riscv/include/asm/module.h     |  87 ----------
 arch/riscv/kernel/jump_label.c      |  12 +-
 arch/riscv/kernel/module-sections.c |  71 +++++++++
 arch/riscv/kernel/module.c          | 237 +++++++++++++---------------
 5 files changed, 306 insertions(+), 222 deletions(-)
 create mode 100644 arch/riscv/include/asm/insn.h

-- 
2.35.1

