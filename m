Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0753AC9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353919AbiFASVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347414AbiFASVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:21:32 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B518A33E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:21:30 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 251IJkAT014364;
        Thu, 2 Jun 2022 03:19:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 251IJkAT014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654107590;
        bh=DfGX9X9js5EY/zBCax8VTjZW98hEg7RezVbzqZYSm80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrhCoTXNyAtPJa6Y2ejgBAgPaoUU7j4Z5bIlZUgcrwGbF7sziHBowTEPAW0FSU/8B
         jlK60LFQOvNd01klVlgxiRlTHim6jeyWqWarpqj4R75RoH1FAZu0ml7sXHv3bJ/V1K
         QRcm16WRYwCivH2VtJfXJ6ICEbrSzotkkAcFrqpAouiFa77VqQ0oVObzvheDql1XUS
         pJDGvMo90/aeJozhby91dsaznEnp0Smq5NjtMfJyR9BJFyNssCNbDzfEjf9oVNsn26
         ymlSjknZNbJWPOytAtzl3N8eigmyNp5XB0bKapapxwpgmHz5Jmsc66AKtyqrmEPer9
         FO/tD4mccBNnw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Christopher Ferris <cferris@google.com>,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 3/3] sparc: fix mis-use of __kernel_{uid,gid}_t in uapi/asm/stat.h
Date:   Thu,  2 Jun 2022 03:19:41 +0900
Message-Id: <20220601181941.3706832-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220601181941.3706832-1-masahiroy@kernel.org>
References: <20220601181941.3706832-1-masahiroy@kernel.org>
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

Commit 31a088b664d6 ("sparc: add asm/stat.h to UAPI compile-test
coverage") converted as follows:

  uid_t  -->  __kernel_uid_t
  gid_t  -->  __kernel_gid_t

It changed the field widths of struct stat because Sparc uses 16-bits for
___kernel_{uid,gid}_t as in arch/sparc/include/uapi/asm/posix_types.h.

The safe replacements across all architectures are:

  uid_t  -->  __kernel_uid32_t
  gid_t  -->  __kernel_gid32_t

as defined in include/linux/types.h.

A similar issue was reported for the android binder. [1]

[1]: https://lore.kernel.org/all/20220601010017.2639048-1-cmllamas@google.com/

Fixes: 31a088b664d6 ("sparc: add asm/stat.h to UAPI compile-test coverage")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/include/uapi/asm/stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/stat.h b/arch/sparc/include/uapi/asm/stat.h
index e03d6f8ec301..47f54133a141 100644
--- a/arch/sparc/include/uapi/asm/stat.h
+++ b/arch/sparc/include/uapi/asm/stat.h
@@ -11,8 +11,8 @@ struct stat {
 	__kernel_ino_t st_ino;
 	__kernel_mode_t st_mode;
 	short   st_nlink;
-	__kernel_uid_t st_uid;
-	__kernel_gid_t st_gid;
+	__kernel_uid32_t st_uid;
+	__kernel_gid32_t st_gid;
 	unsigned int st_rdev;
 	long    st_size;
 	long    st_atime;
-- 
2.32.0

