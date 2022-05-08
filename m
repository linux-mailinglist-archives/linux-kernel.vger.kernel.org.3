Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C162351EAEC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383783AbiEHCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381840AbiEHCfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:35:47 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78C310FED;
        Sat,  7 May 2022 19:31:54 -0700 (PDT)
X-QQ-mid: bizesmtp71t1651977109tdkre7k6
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:31:48 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: F3yR32iATbhVoP/UdK+aSM1hXbaRJ4vnXPb7LPBb9R2nuCQZ7cjs9VD0o0UU2
        0rkzMPStiEeeebPnFUFRUAMDPRH5GAfySTSubZC0jPGeK65XqV4xpHBcqE5UkWrJhpn+vCB
        uOWQX6STRxLVfNoaXtZPuKJmO3TS3oLlz6Hju0FF89Q9jWRy8fU8U3Qtio62iyiff7Uh789
        6vyukJIJBKHvhUl4ps9E9449wS4U4/JNk+tCU5G3iHtNzIbcSj8EyUJ9A3zdkq/DAhYzLVf
        I+dQi96E3sgAinOdZARb8qEZ6+9DmjpT5hsyyh7EvglrS0pOuRS8IVw+UDgCKsUYleABAD8
        r/uqhtdwLOcprhn2VltsKLQgKoxDw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     wangborong@cdjrlc.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: tools: no need to initialise statics to 0
Date:   Sun,  8 May 2022 10:31:46 +0800
Message-Id: <20220508023146.100385-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/boot/tools/relocs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/tools/relocs.c b/arch/mips/boot/tools/relocs.c
index 1bf53f3524b3..02fc85f3e8ff 100644
--- a/arch/mips/boot/tools/relocs.c
+++ b/arch/mips/boot/tools/relocs.c
@@ -351,7 +351,7 @@ static void read_symtabs(FILE *fp)
 
 static void read_relocs(FILE *fp)
 {
-	static unsigned long base = 0;
+	static unsigned long base;
 	int i, j;
 
 	if (!base) {
-- 
2.35.1

