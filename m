Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC958CFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244452AbiHHVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiHHVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100F1AF3B;
        Mon,  8 Aug 2022 14:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A0660F42;
        Mon,  8 Aug 2022 21:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1465AC43470;
        Mon,  8 Aug 2022 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659994323;
        bh=A9375CUslLLzBRLppAdcbV4Xp1zIhYndjn1o38kpK1g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=q2KimLvmGjOhrLqaD/MyhdxHcr+y8RMhSbHJ86OqE5ngLOocAuY4z2c00upcLnKGb
         xfd038hMY7DdKpO/dE6buQe6mJSffEPGTSt88Cp4cEOpDljlTbO4lnx7EV+gsIE1Ik
         9Z6TGGz3qa0IwI6IPRRWmyHjDWtKyIGOiRqBkgyw=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 08 Aug 2022 17:31:51 -0400
Subject: [PATCH v2 3/5] maintainer-pgp-guide: update ECC support information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v2-3-e3e6954affb6@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-fe10a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=A9375CUslLLzBRLppAdcbV4Xp1zIhYndjn1o38kpK1g=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJI+NlyqvxCoHf36snKgX/lN68mqgdelf2n6bGQzVvdN2p+z
 lndmRykLgxgXg6yYIkvZvthNQYUPPeTSe0xh5rAygQxh4OIUgIm8y2dkOBAe/aOFL9I3/8Q0tbUTJX
 JDowSlvTkntryoPnlMj0XxE8N/55z7756nR3RGJM9lZhc0PnbB6WRWZez2jofPRYxsX/7lBQA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ECC sections with the latest details, now that Yubikeys are able
to support ED25519 curves. Tweak a few links to smartcard devices to
reflect the latest URL changes.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index ead5bc815017..bf288925973e 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -228,11 +228,9 @@ separate signing subkey::
     recommend that you create an ECC signing subkey for your kernel
     work.
 
-    If for some reason you prefer to stay with RSA subkeys, just replace
-    "ed25519" with "rsa2048" in the above command. Additionally, if you
-    plan to use a hardware device that does not support ED25519 ECC
-    keys, like Nitrokey Pro or a Yubikey, then you should use
-    "nistp256" instead or "ed25519."
+    Note, that if you plan to use a hardware device that does not
+    support ED25519 ECC keys, you should choose "nistp256" instead or
+    "ed25519."
 
 
 Back up your Certify key for disaster recovery
@@ -438,7 +436,8 @@ functionality. There are several options available:
 - `Yubikey 5`_: proprietary hardware and software, but cheaper than
   Nitrokey Pro and comes available in the USB-C form that is more useful
   with newer laptops. Offers additional security features such as FIDO
-  U2F, among others, and now finally supports ECC keys (NISTP).
+  U2F, among others, and now finally supports NISTP and ED25519 ECC
+  keys.
 
 `LWN has a good review`_ of some of the above models, as well as several
 others. Your choice will depend on cost, shipping availability in your
@@ -451,7 +450,7 @@ geographical region, and open/proprietary hardware considerations.
     Foundation.
 
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
-.. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
+.. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nkpr2-nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/products/yubikey-5-overview/
 .. _Gnuk: https://www.fsij.org/doc-gnuk/
 .. _`LWN has a good review`: https://lwn.net/Articles/736231/

-- 
b4 0.10.0-dev-fe10a
