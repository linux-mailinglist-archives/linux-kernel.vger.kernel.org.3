Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A15549D16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348228AbiFMTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351938AbiFMTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:26 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165655044D;
        Mon, 13 Jun 2022 10:09:39 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 25DH9AWg022790;
        Tue, 14 Jun 2022 02:09:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 25DH9AWg022790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655140151;
        bh=9Q9bxsPVmhKwllUyQfLhby20MugRprrtgLBKGwhNpWw=;
        h=From:To:Cc:Subject:Date:From;
        b=DSyTHOZfbTmmeaf0xcRHSWqL20l8v7gw/xJof5PN0P2NEWvfjDZbIH8hrOWnHxFwz
         9o84Exx/1/8hjLJmO3n2ADPktDPQKMd/tS9OPXJW7ycZBanwz5RhZeiN8pedfx0/Kg
         5LZQeQA9wXWKSfggX73/S/dRAd54bW0SaXK/WGDrOCYri0AOxF2HKJNHJHJD8CU+VY
         B2MONiSIYxs+S7kLNskxlcuYGJLjfdgchAipDvGN3fRdUvFZHTmFdqVwKH6sWyQtMI
         3yBHIakI3PGCH4HWyTJRqFznstgR0zo2kd1IYbCp0F7cmm92tsE6IL8CkuA6Bpe6Cw
         pc4QGfcATOqfA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] s390: remove unneeded 'select BUILD_BIN2C'
Date:   Tue, 14 Jun 2022 02:09:00 +0900
Message-Id: <20220613170902.1775211-1-masahiroy@kernel.org>
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

Since commit 4c0f032d4963 ("s390/purgatory: Omit use of bin2c"),
s390 builds the purgatory without using bin2c.

Remove 'select BUILD_BIN2C' to avoid the unneeded build of bin2c.

Fixes: 4c0f032d4963 ("s390/purgatory: Omit use of bin2c")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 91c0b80a8bf0..8cd9e56c629b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -484,7 +484,6 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
-	select BUILD_BIN2C
 	depends on CRYPTO
 	depends on CRYPTO_SHA256
 	depends on CRYPTO_SHA256_S390
-- 
2.32.0

