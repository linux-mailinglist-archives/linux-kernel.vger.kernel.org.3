Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33205535DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbiE0KEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbiE0KEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:04:42 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4B1078B2;
        Fri, 27 May 2022 03:04:40 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24RA2hPQ029808;
        Fri, 27 May 2022 19:02:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24RA2hPQ029808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653645764;
        bh=61zPFwXwuMzPPnYh5a2KY2eJrg46Tur01X/5UtHyktY=;
        h=From:To:Cc:Subject:Date:From;
        b=2YPSV64Qy3StO2+UBYGQgOhCFR1cwIATKIFqJYTyDsdkMxdosGUD6v4/ed3N9Wbk1
         H1h3RaS9tKQtF6OA0intkN7q+jMauoV0j4XpNnk+qeMaHauQVnjQtPsX46qKIqTlht
         qIcHJse9UrOKt4R3ixLQUU3xdvackns8mxdNPk48DqTn4a4hapvuTTzCTWMgvQSjWb
         kWRmGEDf1557zuUF7bglIVEyA4k9SQ43JXps4nTZV643+td0aA6zHEbs5v9kXYu7I6
         oVCa2dvrMpB++v4qmTDq7rN5UQ+6n7qzYQO0EJuBLUNT7TKQo+5sNP5W2LBXYd4nOu
         1xOiN1zVA94Tg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v7 0/8] kbuild: yet another series of cleanups
Date:   Fri, 27 May 2022 19:01:47 +0900
Message-Id: <20220527100155.1996314-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A couple errors have been reported since I applied v6.

I am sending v7.


Masahiro Yamada (8):
  kbuild: replace $(linked-object) with CONFIG options
  kbuild: do not create *.prelink.o for Clang LTO or IBT
  parisc: fix the exit status of arch/parisc/nm
  kbuild: check static EXPORT_SYMBOL* by script instead of modpost
  kbuild: make built-in.a rule robust against too long argument error
  kbuild: make *.mod rule robust against too long argument error
  kbuild: add cmd_and_savecmd macro
  kbuild: rebuild multi-object modules when objtool is updated

 arch/parisc/Makefile       |  2 +-
 arch/parisc/nm             | 12 +++++-
 scripts/Kbuild.include     | 10 ++++-
 scripts/Makefile.build     | 87 +++++++++++++++++---------------------
 scripts/Makefile.lib       |  7 ---
 scripts/Makefile.modfinal  |  5 +--
 scripts/Makefile.modpost   |  9 +---
 scripts/check-local-export | 65 ++++++++++++++++++++++++++++
 scripts/mod/modpost.c      | 35 +--------------
 9 files changed, 128 insertions(+), 104 deletions(-)
 mode change 100644 => 100755 arch/parisc/nm
 create mode 100755 scripts/check-local-export

-- 
2.32.0

