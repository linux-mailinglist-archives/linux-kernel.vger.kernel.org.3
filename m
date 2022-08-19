Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD25995B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbiHSG6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbiHSG6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:58:32 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08322662;
        Thu, 18 Aug 2022 23:58:26 -0700 (PDT)
Received: from grover.sesame ([133.106.49.178]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 27J6uUCM012757;
        Fri, 19 Aug 2022 15:56:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 27J6uUCM012757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660892191;
        bh=kLteZgzDyCsUaZbAhJIThD6Chhgc+3Ar23SEEf1zkz8=;
        h=From:To:Cc:Subject:Date:From;
        b=wwV9lkhrn16+U7gm+YFpddQAOvKBNo21MwndzEd1hbUr5kQl01tjwsDdVc1rl+xuX
         ZTamMEMDp2YkQHqXjbVIAqB7aPluHPQOqjmsMPsCLtDFxOrPSOWIj2MkPDORKwYw4E
         ayzZXLlBofkKBB48QKEQQ/GsniPrWVxmR2OBdaq3cfz9TdCNCPQvL5atvzrEa5JyAQ
         HoPAo5IX3mX75x86HjMUnU8L87RTl8xY2FD23/iQGxhKKfwEPRzbV8FHP80hpdEdph
         DmX0c7fME6ugquFwnRmAl2PLIf+HRQ22WC/FEdF7zHSVgRoz8YRlPi2UEpdqBevZL9
         8SrWSPzrXPZoQ==
X-Nifty-SrcIP: [133.106.49.178]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] kbuild: change the default shell to bash
Date:   Fri, 19 Aug 2022 15:56:00 +0900
Message-Id: <20220819065604.295572-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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


This is related to the discussion about the portability [1].

I wrote this code some time ago for some reason. My motivation at that
time was trap handling.

We use the EXIT trap in several places. The POSIX [2] mentions the 'EXIT'
as the trap condition, but nothing about the actual conditions that trigger
the EXIT trap. Bash invokes the EXIT trap when it exits after receiving
an unhandled signal, while dash does not.

I did not submit the patches because I lost the use-case of the EXIT trap
except cleaning temporary files. It is harmless to have temp files left over.

Recently, I saw a bug report regarding the portability of 'echo'
('echo' is a shell's built-in command. The behavior is different between
bash and dash).

I am sharing this patch set as RFC in case somebody might have interest or comment.
I am still wondering if this might be a big hammer, though.

[1]: https://lore.kernel.org/all/e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org/
[2]: https://pubs.opengroup.org/onlinepubs/009604599/utilities/trap.html



Masahiro Yamada (3):
  kconfig: move declarations for prepossessing to internal.h
  kconfig: allow to choose the shell for $(shell ) functions
  kbuild: use bash as the default shell for Make and Kconfig

 .../kbuild/kconfig-macro-language.rst         |  4 ++
 Makefile                                      |  7 ++
 scripts/Kconfig.include                       |  3 +
 scripts/kconfig/confdata.c                    |  1 +
 scripts/kconfig/internal.h                    | 18 +++++
 scripts/kconfig/lexer.l                       |  1 +
 scripts/kconfig/lkc_proto.h                   | 13 ----
 scripts/kconfig/parser.y                      |  1 +
 scripts/kconfig/preprocess.c                  | 66 +++++++++++++++----
 9 files changed, 87 insertions(+), 27 deletions(-)

-- 
2.34.1

