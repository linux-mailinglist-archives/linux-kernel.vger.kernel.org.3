Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC90A54CD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiFOPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFOPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:41:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7542E69F;
        Wed, 15 Jun 2022 08:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF88EB81FCD;
        Wed, 15 Jun 2022 15:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F57C34115;
        Wed, 15 Jun 2022 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655307709;
        bh=4W3jsjWJz1C/Sx04Tfe1wqMqpWb2MMMxBdXzowiBwj0=;
        h=From:To:Cc:Subject:Date:From;
        b=POC0aKJeGNB7XE6Kdew/cLf56vQ1GVOjdO2F91ip1Tbtr9z2Ae4tUdwjMmo3EWpAY
         LJMzPuTClEcbqsqdfRbERawI42b1v3fkXtT026TJc0AbrZhr1LtoZq+55rtXVHtY5s
         IH1sr0Wu+YGsD8goyoE753TVy9dfDgOTSz66NVIvFHsm9WUQkLRLak7ccL5yWRK+CJ
         /gK77t18jAy4rC7itoUN2Gyhr7KblsZ4NAxn89whuf4nLqIZCdvU8/w0rXzeIK+X9o
         lvLxXGlFTrMG1VZ0jo5QFSfHhG37plALl2uCPzQr4joSUFdHzg7sIApHTNozoDsi0o
         nyxLT0jA8WTUg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/3] jump_label: get rid of NOP patching where possible
Date:   Wed, 15 Jun 2022 17:41:39 +0200
Message-Id: <20220615154142.1574619-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; h=from:subject; bh=4W3jsjWJz1C/Sx04Tfe1wqMqpWb2MMMxBdXzowiBwj0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiqf2wp3rY7kfOcb3a6vq+iySWA8sjXdE7fisy+IP4 5V4b7LOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqn9sAAKCRDDTyI5ktmPJBy1C/ 9CfZWST0pKJSzgtTRNYSOV/OB4KGvjvqU/RIT7j6gJrPJnBRnp0rAEyyHP70OXshALiz9UAWy4F/V3 MSOJScr97M4oIHuL12lFzUtO6gAvL4Jgo3+vpILcGidFqTs+kCbASCHsXHsXsrAxrJ+4RJDtGMadnS s2SviCOCJROLUM6j685o4HmrCG5ij50txvEDRWzjj7Zcfgl78JiBbTSYNScs8bH0kH0RxgvyNgcsQV NHWtFttrJhoTzfWa0F6gHLsBaOk2VErNYpx2JB3W6jpZPIO+4OpxG0cfxE4nl6LAFRcsAikVZ2j0bL Q4Prm1CBBp7bl3uELp/+cucFU1zIApBMLDra25RE+jQaWyu+GgVIdLGwUTHPEuUPLNk5oSp7AmQUL+ NKBiuUvAbfBuM5ts9BtZ29WbkXMM17mmoN/BoGBuzqn1S7c0QHnWfXLDIWGvar5tB6k+5Gc2HLMb5X E0mD09H9pc3jlLmvrMB0jEufoHOaw5K275xaPMz/sMB7Y=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only architecture that actually needs to convert compiler generated
jump label NOP encodings into something else at runtime is MIPS, because
the assembler cannot be trusted to emit a sequence that can be safely
patched into a branch instruction.

All other architectures either do nothing with jump label NOPs at load
time, or patch a perfectly good NOP into a different one, or into the same
one - none of this seems very useful, so let's get rid of it where we
can.

Changes since v1:
- use a default implementation of arch_jump_label_transform_static()
  instead of an empty macro in patch #3
- fix MIPS with CONFIG_MODULES=n
- add acks from Mark and Peter to patch #3

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-s390@vger.kernel.org

Ard Biesheuvel (3):
  jump_label: s390: avoid pointless initial NOP patching
  jump_label: mips: move module NOP patching into arch code
  jump_label: make initial NOP patching the special case

 Documentation/staging/static-keys.rst |  3 --
 arch/arc/kernel/jump_label.c          | 13 -------
 arch/arm/kernel/jump_label.c          |  6 ---
 arch/arm64/kernel/jump_label.c        | 11 ------
 arch/mips/include/asm/jump_label.h    |  2 +
 arch/mips/kernel/jump_label.c         | 19 +++++++++
 arch/mips/kernel/module.c             |  5 ++-
 arch/parisc/kernel/jump_label.c       | 11 ------
 arch/riscv/kernel/jump_label.c        | 12 ------
 arch/s390/include/asm/jump_label.h    |  5 +--
 arch/s390/kernel/jump_label.c         | 28 +++----------
 arch/s390/kernel/module.c             |  1 -
 arch/sparc/kernel/module.c            |  3 --
 arch/x86/kernel/jump_label.c          | 13 -------
 arch/x86/kernel/module.c              |  3 --
 include/linux/jump_label.h            |  7 +---
 kernel/jump_label.c                   | 41 +++-----------------
 17 files changed, 38 insertions(+), 145 deletions(-)

-- 
2.35.1

