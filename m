Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FBD4D6CFE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 07:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiCLGQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 01:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:15:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C3210D4A;
        Fri, 11 Mar 2022 22:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HDJyrHj1AaE/N2JHmkP+7shkgaIsuKnGFuwt2ikYqoc=; b=rcCJmxebZY7F1zWhrKcA2l/9zq
        YOW95V2m+5mPIeyd0BlIix+khkiPYPhmZ1gVmI1Ats+crYhwqtW/pHbG9KtXpmC2ONSYTbDgf6lCC
        AWRXb+hwWnA0sWotoGYZZOdl1Cp8AVUd2uHks91SoZFpEyQFZaFpg+VsWrUI3j3AhnuddeUNICAXO
        VZGtqGOPj02cDtefX+XBKYZ3cKEILDGsr95tYq8Cg/uq33L1wFTEGAiOGhfxkgQaPNqYf+cyVWS7l
        5nOxrHoSt6uNY1DTXuaoqzNdoh9SH1oV3W/i6dildc7mKgF2AQeoCwDKYMh8NboWWoQ37bHnvseGp
        qyEbh9kQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSv1f-000pK4-Ez; Sat, 12 Mar 2022 06:14:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH] sh: nmi_debug: fix return value of __setup handler
Date:   Fri, 11 Mar 2022 22:14:50 -0800
Message-Id: <20220312061450.24876-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) argument or environment
strings. Also, error return codes don't mean anything to
obsolete_checksetup() -- only non-zero (usually 1) or zero.
So return 1 from nmi_debug_setup().

Fixes: 1e1030dccb10 ("sh: nmi_debug support.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/nmi_debug.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220310.orig/arch/sh/kernel/nmi_debug.c
+++ linux-next-20220310/arch/sh/kernel/nmi_debug.c
@@ -49,7 +49,7 @@ static int __init nmi_debug_setup(char *
 	register_die_notifier(&nmi_debug_nb);
 
 	if (*str != '=')
-		return 0;
+		return 1;
 
 	for (p = str + 1; *p; p = sep + 1) {
 		sep = strchr(p, ',');
@@ -70,6 +70,6 @@ static int __init nmi_debug_setup(char *
 			break;
 	}
 
-	return 0;
+	return 1;
 }
 __setup("nmi_debug", nmi_debug_setup);
