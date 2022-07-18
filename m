Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96557844E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiGRNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiGRNvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:51:21 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4EF27CF7;
        Mon, 18 Jul 2022 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JQ1BcUfxouI3x7W07R3yoAXKkCpX5WF1RnB+IIAlqOI=; b=QEQNwVnN6b3cocQ06CpKPUlH95
        vFMAB+v67cxzpssjvl0cMtgr+twBTvZdvGahsgZXZwte/XbpcZLpiuefeKHBc+rN3TS+hsL8OZ2SM
        qVyXRR8lBwNCpH+qyBHZzySYPvdtR24kW3ByfjVQor6CCScELpeouy9RwQGnbLNWrbNw=;
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oDR8z-002sTq-VC; Mon, 18 Jul 2022 15:50:47 +0200
Received: from [2a02:a31c:8144:c400::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oDR8y-0000N1-Cn; Mon, 18 Jul 2022 15:50:40 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.96)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1oDR8v-0009D8-0z;
        Mon, 18 Jul 2022 15:50:37 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        kernel test robot <lkp@intel.com>
Date:   Mon, 18 Jul 2022 15:50:34 +0200
Message-Id: <20220718135034.51457-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <0f226def-baf9-d6b2-2ee3-f6fae7d675f1@leemhuis.info>
References: <0f226def-baf9-d6b2-2ee3-f6fae7d675f1@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] certs: make system keyring depend on x509 parser
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code requires x509_load_certificate_list() to be built-in.

Fixes: 60050ffe3d77 ("certs: Move load_certificate_list() to be with the
asymmetric keys code")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202206221515.DqpUuvbQ-lkp@intel.com/
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/20220712104554.408dbf42@gandalf.local.home/
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 certs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 476755703cf8..bf9b511573d7 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -43,6 +43,7 @@ config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
 	depends on KEYS
 	depends on ASYMMETRIC_KEY_TYPE
+	depends on X509_CERTIFICATE_PARSER
 	help
 	  Provide a system keyring to which trusted keys can be added.  Keys in
 	  the keyring are considered to be trusted.  Keys may be added at will
-- 
2.36.1

