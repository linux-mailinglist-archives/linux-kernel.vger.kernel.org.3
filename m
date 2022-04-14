Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D6500B39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiDNKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiDNKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:37:18 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB1E49925
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649932495;
  x=1681468495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JB1JYKc2t7KYR3hxZpxMRwToN5ZsCx2BtRr9rtxcR4s=;
  b=k0gsXxemTvYCzUW65GW6incsDpOzywJhHtBBDV3Ii+LS+6s5izQHIUC6
   Tpz1GkfCbWVnsfWU8CCCOfBr/7CMTB65RtdLCuFsybd65aBhGWmfzwWMJ
   yeMVF6fyGIoxKajk3UyZzGORIp3+lCsBcvIZpyuMtAO3vLo9ghAd2hhZf
   4ucu6XrIne+S1TjvdUkQj4MDlXppOHp9wxVJFgN7Q2Ayrd2oakePpUFUo
   9TKRsr/n1kuqNAmskkUt9QIzCMZndbXusnkY0rZhzjPSi1F1Xn0H1fOwQ
   J4uttvmrcyGsI5aZP8LyAL5TfdXGCaSqq1ClSAD22JKkQtj8G1J6lZ/ir
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: enable ARCH_HAS_GCOV_PROFILE_ALL
Date:   Thu, 14 Apr 2022 12:34:51 +0200
Message-ID: <20220414103451.1662906-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARCH_HAS_GCOV_PROFILE_ALL so that CONFIG_GCOV_PROFILE_ALL can be
selected on UML.  I didn't need to explicitly disable GCOV on anything
to get this to work on the configs I tested.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4d398b80aea8..8062a0c08952 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_EPHEMERAL_INODES
+	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-- 
2.34.1

