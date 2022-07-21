Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E557CEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGUPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGUPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:10:45 -0400
X-Greylist: delayed 1120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 08:10:43 PDT
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3922068DE6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:10:43 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEXp3-001VUo-10;
        Thu, 21 Jul 2022 16:10:41 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] kallsyms: make arch_get_kallsym() static
Date:   Thu, 21 Jul 2022 16:10:40 +0100
Message-Id: <20220721151040.359389-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_get_kallsym() function is not used anywhere in the kernel
now, so it should at-least be static or just be removed as there
are no users. Making it static fixes the following sparse warning:

kernel/kallsyms.c:590:12: warning: symbol 'arch_get_kallsym' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3279ac..14922fb21f7b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -587,7 +587,7 @@ struct kallsym_iter {
 	int show_value;
 };
 
-int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+static int arch_get_kallsym(unsigned int symnum, unsigned long *value,
 			    char *type, char *name)
 {
 	return -EINVAL;
-- 
2.35.1

