Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A995778D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 01:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiGQXdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 19:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiGQXdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 19:33:49 -0400
X-Greylist: delayed 1327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Jul 2022 16:33:48 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69A100A;
        Sun, 17 Jul 2022 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g9c6Fw5wegV7nRqLgN+7yazf4jmfsQdfONU8hlkeEdI=; b=X3mu+6Pz5w36at7DZfspAK8G7v
        XcvdCLxE18vzw/UEz46gBPs8kOxSDI/1rXQiV13AEtMjF2fWyYsGLhgKiHEzRr8u11fNncPlB+cuS
        ge/+r4IOSwEmOmYZUl6YUnJBFLT3TJBO8TCbkPZbriJ/ES7MVpBv9Lwk05qVQM8ujids=;
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oDDPw-002l3o-RJ; Mon, 18 Jul 2022 01:11:20 +0200
Received: from [2a02:a31c:8144:c400::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oDDPu-0007TW-WF; Mon, 18 Jul 2022 01:11:15 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.96)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1oDDPr-0008aZ-0d;
        Mon, 18 Jul 2022 01:11:11 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Mon, 18 Jul 2022 01:11:05 +0200
Message-Id: <20220717231105.33005-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.36.1
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

Fixes: 60050ffe3d770dd1df5b641aa48f49d07a54bd84
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
Otherwise, we get a build failure.

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

