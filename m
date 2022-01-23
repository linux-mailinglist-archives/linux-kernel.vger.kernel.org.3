Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC885496F98
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 03:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiAWCBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 21:01:12 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3013 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiAWCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 21:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1642903272; x=1674439272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RD7Kb5HGRmxu1H1Kfab4Hp6cNBfxp5ZMBIq2r6UZWr8=;
  b=XUqX1tfsxB4p663uSZ0B3Loo8ZRgdE+otapWbyZUSXhudsA9cRPXFqI6
   Hj9KZedZQSboOMtFUJ0TYxkMwmmMX3MOkXMgDoHLXBdKDKByThTIJcd98
   2SUj9V/GxBNFx7iegFNYHJPXFQ8HBpqD96klfNLwINQ60LX2qRiX2yDnF
   Y=;
X-IronPort-AV: E=Sophos;i="5.88,309,1635206400"; 
   d="scan'208";a="189275472"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 23 Jan 2022 02:01:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com (Postfix) with ESMTPS id 196E0419A5;
        Sun, 23 Jan 2022 02:01:11 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 23 Jan 2022 02:01:09 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.114) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 23 Jan 2022 02:01:05 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
CC:     Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <openrisc@lists.librecores.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] openrisc/boot: Remove unnecessary initialisation in memcpy().
Date:   Sun, 23 Jan 2022 11:01:00 +0900
Message-ID: <20220123020100.45201-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.114]
X-ClientProxiedBy: EX13D45UWA004.ant.amazon.com (10.43.160.151) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
initialise them before that.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 arch/openrisc/lib/memcpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
index fe2177628..e2af9b510 100644
--- a/arch/openrisc/lib/memcpy.c
+++ b/arch/openrisc/lib/memcpy.c
@@ -101,7 +101,7 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
  */
 void *memcpy(void *dest, __const void *src, __kernel_size_t n)
 {
-	unsigned char *d = (unsigned char *)dest, *s = (unsigned char *)src;
+	unsigned char *d, *s;
 	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
 
 	/* If both source and dest are word aligned copy words */
-- 
2.30.2

