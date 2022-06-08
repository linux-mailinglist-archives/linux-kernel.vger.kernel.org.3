Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C5542E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiFHKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiFHKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D4D921C;
        Wed,  8 Jun 2022 03:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1622C60DDF;
        Wed,  8 Jun 2022 10:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD46C34116;
        Wed,  8 Jun 2022 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654685124;
        bh=LYPCoycPntOqqUyvwzMbi2reXIKks5cigZIK3ndZ14w=;
        h=From:To:Cc:Subject:Date:From;
        b=WRB83dfy5epf1QY0IUOGrasmswrkvVv94EvRPlD/obZQHm+iRggmoNolTT1KQqgpu
         ymrnpWcUckIM/yQ8SJLbr8i5dO0tk8zBAWG1lD5slAM1vff6FAmBrEtO6+Wnw+nvVO
         ooUF/dLmDNnuDkDoPw/TcIbgCf0BaM1PifwtSM6kMVhchnjm+3GrrYAQPaghksj6Ar
         puLW2A2xbYvvbiOvVi3nvAJbPGILB87x2gRdHFmn6CrI74n660ywOPnki4Fay+iqOQ
         ZTekVQhM5jkOhVgMthQ1Qg6mwtk6ZZFyFpgHpe87e3+5DSS/mCeewARVDGABe6/8aN
         wooxIxCJM9jQA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/3] jump_label: get rid of NOP patching where possible
Date:   Wed,  8 Jun 2022 12:45:09 +0200
Message-Id: <20220608104512.1176209-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; h=from:subject; bh=LYPCoycPntOqqUyvwzMbi2reXIKks5cigZIK3ndZ14w=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBioH2yp35gwHFD9tVcWbTkYNW5Bl0OgP+AuoaSgKiw PM6tYBaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqB9sgAKCRDDTyI5ktmPJPBhDA CTzcfmFfDApSEEh5wmEbMx0vORABRF2UHR26VW+xnQEuxvv3fdWj4MhkrnbKTdZgg8+ODpY/ZsawYJ cO4u2Dim9utRc7CfedpbcKYOkNDMb+8p/ZwMLLM3dkOdcmbfT7OiL/zboI4wMm423oYhrgw5WV+4I7 16OcblldunBfmU2SI5CgXeHsnVGEuvnePZvjzRJmXE9tD1wxj+zNvYanu80N5hjVWfWiouyWLRjPkn IoVURWaRyizrbmSQOBqqrQDXMF8BuA/C52KdsdtS6nB0RHDjdHnL2FRAJ1GLLCLPnFmNO4/1DHumhC GORpJUs1RRZbvMF5MruEcikCx9ZjVy6qIkq0QjhcJzma6o+v3V/KYsVWCh8Kyoxr1Uyk/YS7SsncJe 5CnPhqGzJLQwUeqeMepDka6Cww3XL4opAW7T1zHtjB92HHtcxDoniAdU2TOYvOMb9Vnqzqhy2jv2YW Vr3lVoqYKw7qGHONu6TPnJwZhPqSUR7HjpEWh2/Gnz2vc=
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

Cc: Peter Zijlstra <peterz@infradead.org>
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
 arch/mips/kernel/jump_label.c         | 17 ++++++++
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
 kernel/jump_label.c                   | 41 ++------------------
 17 files changed, 34 insertions(+), 147 deletions(-)

-- 
2.30.2

