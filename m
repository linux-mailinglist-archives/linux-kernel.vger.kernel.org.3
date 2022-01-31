Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED9A4A4DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiAaSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbiAaSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:22:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEEC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:14 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so13788225otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfu91ED7nMYsdGJsGmRKK0mjbCW2X1OHhuirg8wEvSo=;
        b=pjRAWmYLG0dJkTiGdZm4iCOSEVzXjZRzPTkHcUf7n2L9hbs6S3Bqa3hrfRqFDVjTXP
         hm8qpwRgjGKK+Bq+BRfmqXoO94K9Bfm5Gs+ULcAhD08S+Uxxm3OGuGpRhpFkyvEd6SAW
         qfV209FbF3cjuW8j/Y8n8RxP0tZqxhLeDP7evBy70vY/ztM9Kd4uAZq2yx1/mCIR8OCO
         lCilLiig0dYg4X2JVCBFZAPjPcCes4NRm1o26lPNwRfNYT1p+cWmAw23oJJNJ07NxF4h
         Mcu8BnjFGP/jyyp1MBdGR6VrgzHBfg0cAQu7Zi1zU4lUgFgkZ87sV7f4NBG5A9KpgBZw
         PnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cfu91ED7nMYsdGJsGmRKK0mjbCW2X1OHhuirg8wEvSo=;
        b=rwYWblC0kh0mc5FQXGr5Yc/cbyccez5uON0f0mVNE9c+QRaTRn1v+EKwlUpKIKAqS3
         WtOVH9v5ap9HmH3iFfTaddry7wTT/m52SIIaC7XJsWSJMbIYjQwflbEjelLYrspiBGrG
         3HQVTSB9rqCG5IEOSPynLB2c3w5+CEudc+uE/GcObrvdSATPKczW14UxvGwVGW7sFL7O
         kCDPgdwAw1hI79vYpWGbMnb0thnPYtzBx8WJObqwrZkk8m5FX/sEOZArLtOdXDDJB6th
         Ow+7pAw+MNkkVWd8rMtKINK9WUqFab9X4bKuuwErcwCog1+ZgMk5Jc4yYZC7aUthBKgY
         0ryg==
X-Gm-Message-State: AOAM533uDisTvaqR1FD+xKGDzkQgXZ4g8H/uzFvawKOc7HZov4Oy4IVb
        n5ZilGi41rMNMKyx9KhZ7injEZbU8mc=
X-Google-Smtp-Source: ABdhPJzQdE+2cpMUX04bRQ9sdblJf+SpfAeCDWlFvQWJArEom0X2jACKe+FwqljHc8vqN+RnXMy1xA==
X-Received: by 2002:a05:6830:40ab:: with SMTP id x43mr12207931ott.132.1643653334335;
        Mon, 31 Jan 2022 10:22:14 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t4sm12986340oie.14.2022.01.31.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:22:13 -0800 (PST)
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
Subject: [PATCH v1 0/7] Module relocation fixes and asm/insn.h header
Date:   Mon, 31 Jan 2022 19:21:38 +0100
Message-Id: <20220131182145.236005-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  riscv: Avoid unaligned access when relocating modules
  riscv: Fix auipc+jalr relocation range checks
  riscv: Add asm/insn.h header
  riscv: Use asm/insn.h for module relocations
  riscv: Use asm/insn.h to generate plt entries
  riscv: Use asm/insn.h for jump labels
  riscv: kernel/modules.c simplification

 arch/riscv/include/asm/insn.h       | 121 +++++++++++
 arch/riscv/kernel/jump_label.c      |  12 +-
 arch/riscv/kernel/module-sections.c |  27 +--
 arch/riscv/kernel/module.c          | 326 +++++++++++++---------------
 4 files changed, 276 insertions(+), 210 deletions(-)
 create mode 100644 arch/riscv/include/asm/insn.h

-- 
2.35.1

