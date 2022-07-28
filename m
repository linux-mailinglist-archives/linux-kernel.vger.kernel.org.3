Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF158475B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiG1U5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiG1U5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2178219;
        Thu, 28 Jul 2022 13:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE33461865;
        Thu, 28 Jul 2022 20:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CC8C43470;
        Thu, 28 Jul 2022 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659041846;
        bh=+yWtLXs1Zq1z9BhFpIxlo5zOYx6a+00PO/tsLikHY7I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QVWc14yNV0R8Jiqd6bgGJ+4DJ8b1CYQhZMxnQE4eTnVh3VsScJw/yTs7wpFANSybY
         ALi4nSFe+jpoMhtLak5d9qvOUIAK94Z+z+hgLk1fBQSBfxSbrSaPcJFtBUXBMP4NM2
         KhZWpLP5xWMd/4TVjHFsgxeOHjmRp3z4Bka/wTOI=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 16:57:06 -0400
Subject: [PATCH v1 3/5] maintainer-pgp-guide: update ECC support information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v1-3-c48fb06cb9af@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=+yWtLXs1Zq1z9BhFpIxlo5zOYx6a+00PO/tsLikHY7I=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJIe/TDtZA3RLup0Ugk/erEurenM6RlCbdZqYtXWS/aLF85j
 yuvpKGVhEONikBVTZCnbF7spqPChh1x6jynMHFYmkCEMXJwCMBElLUaGs1KTfr8OW5NgXC/06XO0Zu
 Pe671Lltu+L3wuv6tky2ZvRYb/sc33F6faOP/LW+2VyH08rUB+77Gc2se7OI/E3zn0elslHwA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 01112ac7723e..62b0bab5d7c5 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -227,11 +227,9 @@ separate signing subkey::
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
@@ -437,7 +435,8 @@ functionality. There are several options available:
 - `Yubikey 5`_: proprietary hardware and software, but cheaper than
   Nitrokey Pro and comes available in the USB-C form that is more useful
   with newer laptops. Offers additional security features such as FIDO
-  U2F, among others, and now finally supports ECC keys (NISTP).
+  U2F, among others, and now finally supports NISTP and ED25519 ECC
+  keys.
 
 `LWN has a good review`_ of some of the above models, as well as several
 others. Your choice will depend on cost, shipping availability in your
@@ -450,7 +449,7 @@ geographical region, and open/proprietary hardware considerations.
     Foundation.
 
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
-.. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
+.. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nkpr2-nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/products/yubikey-5-overview/
 .. _Gnuk: https://www.fsij.org/doc-gnuk/
 .. _`LWN has a good review`: https://lwn.net/Articles/736231/

-- 
b4 0.10.0-dev-49460
