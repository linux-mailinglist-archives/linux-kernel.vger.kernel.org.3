Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125494E2F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349114AbiCURfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1A936660A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXMMQ007569;
        Mon, 21 Mar 2022 18:33:22 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 0/8] nolibc: small updates required for the self-tests
Date:   Mon, 21 Mar 2022 18:33:06 +0100
Message-Id: <20220321173314.7519-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

while developing the nolibc self-tests, I naturally faced a few
limitations ranging from missing POLL* flags to missing strcmp() or
getenv(), as well as the ability for printf() to print "(null)" on
"%s" instead of crashing.

This series adds a makefile and a headers installation target that
creates a sysroot made of kernel headers and nolibc headers, which
significantly ease building programs.

I already have some test code with roughly 75 tests, but I find it
misplaced in the nolibc dir, I need to move it to testing/selftests/
before sending it to you.

This series is intended to be an add-on to what you already have in your
dev branch. I don't intend to send you much more stuff on top of this,
but I expect to see an update from Ammar's patch set (CCed). With all
this I think we'll have a good basis to easily add new tests.

Thanks!
Willy

---
Willy Tarreau (8):
  tools/nolibc/stdio: make printf(%s) accept NULL
  tools/nolibc/stdlib: add a simple getenv() implementation
  tools/nolibc/stdio: add support for '%p' to vfprintf()
  tools/nolibc/string: add strcmp() and strncmp()
  tools/nolibc/sys: add syscall definition for getppid()
  tools/nolibc/types: add poll() and waitpid() flag definitions
  tools/nolibc: add a makefile to install headers
  tools/nolibc: add the nolibc subdir to the common Makefile

 tools/Makefile                |  4 ++++
 tools/include/nolibc/Makefile | 43 +++++++++++++++++++++++++++++++++++
 tools/include/nolibc/stdio.h  | 32 +++++++++++++++++---------
 tools/include/nolibc/stdlib.h | 23 +++++++++++++++++++
 tools/include/nolibc/string.h | 23 +++++++++++++++++++
 tools/include/nolibc/sys.h    | 17 ++++++++++++++
 tools/include/nolibc/types.h  | 10 ++++++++
 7 files changed, 141 insertions(+), 11 deletions(-)
 create mode 100644 tools/include/nolibc/Makefile

-- 
2.35.1

