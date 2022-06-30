Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A635614D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiF3IWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiF3IVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:21:48 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD80BC9E;
        Thu, 30 Jun 2022 01:20:13 -0700 (PDT)
Received: from grover.sesame ([133.106.249.59]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 25U8IuIs002167;
        Thu, 30 Jun 2022 17:18:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 25U8IuIs002167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656577138;
        bh=oCy0zw+wURoxfZMcYbF4qQYsFUfZjWgGoas52B3YrXM=;
        h=From:To:Cc:Subject:Date:From;
        b=n4iDwOvEiKupwRDEy4cVT3Xg19j1QMhKBNRL8DfdeLoy/wAK2xQrQQVPdMwsz5X0V
         ETp/isNQ7ab/MYlW9z+27Suk731LdviMqNCC5778bipy5353y9Yw8tsSk0g+tpzQ25
         AwkukdQN1SJyMtojDOl7ujnyBuKA103WGowDrb8klMPtz2P3NMESD9ghgsiv4szKRS
         9yNj8n/80xA2HbJ3yxhzq8C+NKTK8Sk+j6TmREPaxKCyjxA4/xyvH/esr5itmrXSF/
         WhuQDZ1BG214kznXCVul6UTGviTTTXBWVL0Srh0V3gbdYt/upAxFaRLzRcv8ln92Tw
         qoB0H9fuvx88A==
X-Nifty-SrcIP: [133.106.249.59]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "scripts/mod/modpost.c: permit '.cranges' secton for sh64 architecture."
Date:   Thu, 30 Jun 2022 17:18:46 +0900
Message-Id: <20220630081846.317517-1-masahiroy@kernel.org>
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

This reverts commit 4d10c223baab8be8f717df3625cfece5be26dead.

Commit 37744feebc08 ("sh: remove sh5 support") removed the sh64 support
entirely.

If ".cranges" section is used for other architectures, it is easy to
get it back.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 620dc8c4c814..e15227ee58fc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -742,7 +742,6 @@ static const char *const section_white_list[] =
 {
 	".comment*",
 	".debug*",
-	".cranges",		/* sh64 */
 	".zdebug*",		/* Compressed debug sections. */
 	".GCC.command.line",	/* record-gcc-switches */
 	".mdebug*",        /* alpha, score, mips etc. */
-- 
2.32.0

