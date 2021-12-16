Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29368476E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhLPJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:50:21 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48373 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbhLPJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:50:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V-ntWHj_1639648215;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V-ntWHj_1639648215)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 17:50:16 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] MIPS: Octeon: Fix build errors using clang
Date:   Thu, 16 Dec 2021 17:50:14 +0800
Message-Id: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A large number of the following errors is reported when compiling
with clang:

  cvmx-bootinfo.h:326:3: error: adding 'int' to a string does not append to the string [-Werror,-Wstring-plus-int]
                  ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NULL)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cvmx-bootinfo.h:321:20: note: expanded from macro 'ENUM_BRD_TYPE_CASE'
          case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
                         ~~~^~~~
  cvmx-bootinfo.h:326:3: note: use array indexing to silence this warning
  cvmx-bootinfo.h:321:20: note: expanded from macro 'ENUM_BRD_TYPE_CASE'
          case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
                          ^

Follow the prompts to use the address operator '&' to fix this error.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/mips/include/asm/octeon/cvmx-bootinfo.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 0e6bf220db61..6c61e0a63924 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -318,7 +318,7 @@ enum cvmx_chip_types_enum {
 
 /* Functions to return string based on type */
 #define ENUM_BRD_TYPE_CASE(x) \
-	case x: return(#x + 16);	/* Skip CVMX_BOARD_TYPE_ */
+	case x: return (&#x[16]);	/* Skip CVMX_BOARD_TYPE_ */
 static inline const char *cvmx_board_type_to_string(enum
 						    cvmx_board_types_enum type)
 {
@@ -410,7 +410,7 @@ static inline const char *cvmx_board_type_to_string(enum
 }
 
 #define ENUM_CHIP_TYPE_CASE(x) \
-	case x: return(#x + 15);	/* Skip CVMX_CHIP_TYPE */
+	case x: return (&#x[15]);	/* Skip CVMX_CHIP_TYPE */
 static inline const char *cvmx_chip_type_to_string(enum
 						   cvmx_chip_types_enum type)
 {
-- 
2.32.0

