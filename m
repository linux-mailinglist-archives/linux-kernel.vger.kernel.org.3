Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21257584760
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiG1U6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiG1U5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:57:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9795877574;
        Thu, 28 Jul 2022 13:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39698B82593;
        Thu, 28 Jul 2022 20:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C0C4347C;
        Thu, 28 Jul 2022 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659041846;
        bh=KVD7HjeOiAY1TaMMP3/tdJDHP/1E9ZXiaHqWbd9BwC8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qUzKWxt6XuxavOPFtS4QkQiLSW4OtJ75MRWfn3aahgjuFdq9qjG/gdUHuDlXsn3OI
         w6xIv4GLgzTGVP0t3AAEe7B+lrrX3cW9bkreUQravZOTLErOfdyX7+0z5jKkzpARTW
         EHbt1xYoHC0NJPwOtRfrC8G70SFGiN058FC4mzog=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 16:57:07 -0400
Subject: [PATCH v1 4/5] maintainer-pgp-guide: add a section on PGP-signed patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v1-4-c48fb06cb9af@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=KVD7HjeOiAY1TaMMP3/tdJDHP/1E9ZXiaHqWbd9BwC8=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJIe/TDLevMkkymqWD2AWXWNpu0GroQYzda9YeKHFimmX96t
 7lrRUcrCIMbFICumyFK2L3ZTUOFDD7n0HlOYOaxMIEMYuDgFYCKRfYwMM5bOvz8latqRqvolvpmxSb
 36V7P+39rY8O9w7pVjQQ5HrzMyXJNaL6PYYu1nyLigqfj63aydt7SU/9WVFazZm9Tge2w6DwA=
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

With more developers beginning to use b4 and patatt, add a section to
the guide that talks about setting up and using patatt for PGP-signing
patch submissions.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 62b0bab5d7c5..2ce38e5d547d 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -674,6 +674,7 @@ remote end.
 
 .. _`Agent Forwarding over SSH`: https://wiki.gnupg.org/AgentForwarding
 
+.. _pgp_with_git:
 
 Using PGP with Git
 ==================
@@ -817,6 +818,63 @@ You can tell git to always sign commits::
 
 .. _verify_identities:
 
+
+How to work with signed patches
+-------------------------------
+
+It is possible to use your PGP key to sign patches sent to kernel
+developer mailing lists. Since existing email signature mechanisms
+(PGP-Mime or PGP-inline) tend to cause problems with regular code
+review tasks, you should use the tool kernel.org created for this
+purpose that puts cryptographic attestation signatures into message
+headers (a-la DKIM):
+
+- `Patatt Patch Attestation`_
+
+.. _`Patatt Patch Attestation`: https://pypi.org/project/patatt/
+
+Installing and configuring patatt
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Patatt is packaged for many distributions already, so please check there
+first. You can also install it from pypi using "``pip install patatt``".
+
+If you already have your PGP key configured with git (via the
+``user.signingKey`` configuration parameter), then patatt requires no
+further configuration. You can start signing your patches by installing
+the git-send-email hook in the repository you want::
+
+    patatt install-hook
+
+Now any patches you send with ``git send-email`` will be automatically
+signed with your cryptographic signature.
+
+Checking patatt signatures
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If you are using ``b4`` to retrieve and apply patches, then it will
+automatically attempt to verify all DKIM and patatt signatures it
+encounters, for example::
+
+    $ b4 am 20220720205013.890942-1-broonie@kernel.org
+    [...]
+    Checking attestation on all messages, may take a moment...
+    ---
+      ✓ [PATCH v1 1/3] kselftest/arm64: Correct buffer allocation for SVE Z registers
+      ✓ [PATCH v1 2/3] arm64/sve: Document our actual ABI for clearing registers on syscall
+      ✓ [PATCH v1 3/3] kselftest/arm64: Enforce actual ABI for SVE syscalls
+      ---
+      ✓ Signed: openpgp/broonie@kernel.org
+      ✓ Signed: DKIM/kernel.org
+
+.. note::
+
+    Patatt and b4 are still in active development and you should check
+    the latest documentation for these projects for any new or updated
+    features.
+
+.. _kernel_identities:
+
 How to verify kernel developer identities
 =========================================
 

-- 
b4 0.10.0-dev-49460
