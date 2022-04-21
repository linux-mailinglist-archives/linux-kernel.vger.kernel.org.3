Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57862509D31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388145AbiDUKOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388143AbiDUKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CFD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so4572688pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJvg5qdwZy92dqfWpy9TlwqA6E9AtPhwiY+V07K0U7s=;
        b=kSpAaU5M4rU+n8fx4RyNiZ0RYZu2ip2Fiasl/se3avD8VUijKLCLOFHXS7f7c9a3uR
         vNDGjAbp+1+WN3TYZjX3t+MqnVJuTgSw24mWnxWaBAv20WhywpxTE//onnZAXTCNFwhD
         leCp2ixUdAivBX+IQaVHNI9R/L8HwJgnb8Xtmwk07DSWBf0xqvwLuJx1rPYtZKtQjjSZ
         JdZAuzrwvmH+oxBnWuI8EToFFCY7TsvrJQhK8PQpseCF3IHFx+XCNIeJA22pdaq90q5i
         Kteh+j2LLjE8ImF2TkRSqMz8kXuVVMyQ/RzHjcZA6Prm6UhcQyeHjlcUZ/gquN8qcOAN
         dx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJvg5qdwZy92dqfWpy9TlwqA6E9AtPhwiY+V07K0U7s=;
        b=nIG2XwZtKnhEjxHNZPh1u4JrQEI7wwZUSNtym5A63tm6YoloqgeG1a25sZG1BjRyLk
         /CJua7Jc6wdh8bDX7kE9KrDUanJNH3zuhYwYxGR4u/sxqYwQkp+X4Bfrob1k63yImStc
         20eSJwM/6CyNcZU0g2iEBJrrSwFSjjBkduWlr0UxLSS/buBdLxOp/SNqzE1stQgGZo4c
         dhJsgL7I0N7C4EEYrvueGYtBtNppkdZtkhD/dFYa8zMBBjp6TTqwBq6nIug6y4PCiZoS
         l6GePumDxxuk/MOrmxfBA1ln6Dlyy5SOD1FTDXH9rZHaisz8gpKleVYG6pJbjxs1sjoS
         JEHQ==
X-Gm-Message-State: AOAM530I6UViRBzMhuy5Qblq06m+Q3K7rKHVJR16//kw2RYyFHi/VMSc
        Bn7GjGf62oxh/V+PSOkWS+unJ8Ihk8b3jDAS
X-Google-Smtp-Source: ABdhPJwe179+lHI6oHzPdAOdgkuDSdG81OsnWCMYiyKhwX28MH5t+5t3amVPv9NW4CPmGlu9eDj37A==
X-Received: by 2002:a05:6a00:2391:b0:50a:3ea9:e84d with SMTP id f17-20020a056a00239100b0050a3ea9e84dmr28323398pfc.21.1650535854186;
        Thu, 21 Apr 2022 03:10:54 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:10:53 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 00/10] xtensa: support coprocessors on SMP
Date:   Thu, 21 Apr 2022 03:10:23 -0700
Message-Id: <20220421101033.216394-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series does a bunch of small cleanups around exception and
coprocessor handling code and adds coprocessors support in SMP
configurations.

Changes v1->v2:

- clean up exception handler prototypes
- merge SAVE_CP_REGS_TAB and LOAD_CP_REGS_TAB
- get rid of stack frame in coprocessor_flush
- document rules for coprocessor context management
- clean up context management from the LKMM point of view, introduce
  and document barriers
- support CPU hotplug

Max Filippov (10):
  xtensa: clean up function declarations in traps.c
  xtensa: clean up exception handler prototypes
  xtensa: clean up declarations in coprocessor.h
  xtensa: clean up excsave1 initialization
  xtensa: use callx0 opcode in fast_coprocessor
  xtensa: handle coprocessor exceptions in kernel mode
  xtensa: add xtensa_xsr macro
  xtensa: merge SAVE_CP_REGS_TAB and LOAD_CP_REGS_TAB
  xtensa: get rid of stack frame in coprocessor_flush
  xtensa: support coprocessors on SMP

 arch/xtensa/include/asm/coprocessor.h |  11 +-
 arch/xtensa/include/asm/processor.h   |   7 +
 arch/xtensa/include/asm/thread_info.h |   7 +-
 arch/xtensa/include/asm/traps.h       |  40 +++--
 arch/xtensa/kernel/asm-offsets.c      |   8 +-
 arch/xtensa/kernel/coprocessor.S      | 230 +++++++++++++++-----------
 arch/xtensa/kernel/entry.S            |  12 +-
 arch/xtensa/kernel/process.c          | 112 ++++++++++---
 arch/xtensa/kernel/ptrace.c           |   3 +-
 arch/xtensa/kernel/s32c1i_selftest.c  |   7 +-
 arch/xtensa/kernel/signal.c           |   3 +-
 arch/xtensa/kernel/smp.c              |   7 +
 arch/xtensa/kernel/traps.c            |  69 ++++----
 13 files changed, 334 insertions(+), 182 deletions(-)

-- 
2.30.2

