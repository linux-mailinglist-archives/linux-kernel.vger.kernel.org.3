Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460914CE852
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 03:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiCFCrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 21:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiCFCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 21:47:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2685A168;
        Sat,  5 Mar 2022 18:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=u/33azRL5XameLxIEXRB7SnNNWFdwGDEuCezQAz1NOk=; b=LVYda2IyoTiJ39UfbnVKOeY6S+
        7EKIU71T3ZBamFhT3Oh+wSeBO7XBgEwyMBmX41oQamqPUBhKc+HHKByuDMrdt9FFzb+V7xUmPljgs
        t+WAKn02tlhlUx9K6QZniv9JLJHjsPQTIM120xEQqfppiXMk9HII3vQyrq/H4t5gXqjPq8tHgSlAV
        2utO4D2DEdr/F+Ei5TX+NB8QaKfo4ShUumavFJspn/1z7k7btrnlU2Vkl737Kq9UFSKORyX8PL1Se
        A51TdF0on/UzIPZehc51N0sDEfJghqehzMFmv5CZYARdhMf8qCfbtXYljeL/zkNc1PhTu+zCT2sb5
        JZCfh2mQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQguc-00E4e7-TT; Sun, 06 Mar 2022 02:46:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Huang Ying <ying.huang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ACPI: APEI: fix return value of __setup handlers
Date:   Sat,  5 Mar 2022 18:46:20 -0800
Message-Id: <20220306024620.5847-1-rdunlap@infradead.org>
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

__setup() handlers should return 1 to indicate that the boot option
has been handled. Returning 0 causes a boot option to be listed in
the Unknown kernel command line parameters and also added to init's
arg list (if no '=' sign) or environment list (if of the form 'a=b').

Unknown kernel command line parameters "erst_disable
  bert_disable hest_disable BOOT_IMAGE=/boot/bzImage-517rc6", will be
  passed to user space.

 Run /sbin/init as init process
   with arguments:
     /sbin/init
     erst_disable
     bert_disable
     hest_disable
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc6

Fixes: a3e2acc5e37b ("ACPI / APEI: Add Boot Error Record Table (BERT) support")
Fixes: a08f82d08053 ("ACPI, APEI, Error Record Serialization Table (ERST) support")
Fixes: 9dc966641677 ("ACPI, APEI, HEST table parsing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: James Morse <james.morse@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/acpi/apei/bert.c |    2 +-
 drivers/acpi/apei/erst.c |    2 +-
 drivers/acpi/apei/hest.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- lnx-517-rc6.orig/drivers/acpi/apei/bert.c
+++ lnx-517-rc6/drivers/acpi/apei/bert.c
@@ -77,7 +77,7 @@ static int __init setup_bert_disable(cha
 {
 	bert_disable = 1;
 
-	return 0;
+	return 1;
 }
 __setup("bert_disable", setup_bert_disable);
 
--- lnx-517-rc6.orig/drivers/acpi/apei/erst.c
+++ lnx-517-rc6/drivers/acpi/apei/erst.c
@@ -891,7 +891,7 @@ EXPORT_SYMBOL_GPL(erst_clear);
 static int __init setup_erst_disable(char *str)
 {
 	erst_disable = 1;
-	return 0;
+	return 1;
 }
 
 __setup("erst_disable", setup_erst_disable);
--- lnx-517-rc6.orig/drivers/acpi/apei/hest.c
+++ lnx-517-rc6/drivers/acpi/apei/hest.c
@@ -224,7 +224,7 @@ err:
 static int __init setup_hest_disable(char *str)
 {
 	hest_disable = HEST_DISABLED;
-	return 0;
+	return 1;
 }
 
 __setup("hest_disable", setup_hest_disable);
