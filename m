Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07D4954DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiATTXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:23:33 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:24700 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbiATTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:23:31 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 20KJMCMN001376;
        Fri, 21 Jan 2022 04:22:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 20KJMCMN001376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642706532;
        bh=gPoSejFv1rZps1hQ66wlGv5FGinyPUP1BTtRi8b169c=;
        h=From:To:Cc:Subject:Date:From;
        b=IDKXs+gIUr7RFnQw7j+xeXOXvn3Y8X0iyTPdjYQFqbMQS0oh6KcK9TMkX4XecLvGs
         nuLRFaDMFe0BhgQ1Fz7q7rCymDP2QsVuMNzvvERlxLGO2ycc3nzw8EripFc+ZUyfHV
         Kjw40EpE7ZHN+ZNkUimhpG3ycXtlKaS64BIQOWOEyNSlWpmdoDimHpUK9xQ5/2+InC
         MbZ8b+qVMECaYZwXn/bdSFqH1m7etWdIjCGfXqDvMYKi62ecIi+AKXszYA6uVoXEoO
         5BmmGWwx1cNy+5SsUQWXf0OyGnjW2qiKFRiDmlAg2znk6ufG5fgUWG9R1AYqWuxpPu
         7vzIZzUyrqxdQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] certs: Fix build error when CONFIG_MODULE_SIG_KEY is PKCS#11 URI
Date:   Fri, 21 Jan 2022 04:22:04 +0900
Message-Id: <20220120192205.525103-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULE_SIG_KEY is PKCS#11 URL (pkcs11:*), signing_key.x509
fails to build:

  certs/Makefile:77: *** target pattern contains no '%'.  Stop.

Due to the typo, $(X509_DEP) contains a colon.

Fix it.

Fixes: b8c96a6b466c ("certs: simplify $(srctree)/ handling and remove config_filename macro")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Makefile b/certs/Makefile
index f7041c29a2e0..0c459cfd09df 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -68,7 +68,7 @@ $(obj)/x509.genkey:
 endif # CONFIG_MODULE_SIG_KEY
 
 # If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
-ifneq ($(filter-out pkcs11:%, %(CONFIG_MODULE_SIG_KEY)),)
+ifneq ($(filter-out pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
 X509_DEP := $(CONFIG_MODULE_SIG_KEY)
 endif
 
-- 
2.32.0

