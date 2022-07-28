Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E058584758
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiG1U5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiG1U53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5877A79;
        Thu, 28 Jul 2022 13:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A5460F1B;
        Thu, 28 Jul 2022 20:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077D9C433D6;
        Thu, 28 Jul 2022 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659041845;
        bh=AiJ624A7q3U6WLzMdmIephz/BFMnF/PLuTlRBValYJE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=f9NXutg5sUhhvUtx2Rzpl+1l3cpDR43ykx+a3yxGudBggfKW+3RP3pDlxGJY1C9e+
         FP4RPyL3J2DiPRManOkQYvLStP4n7E+a8ALVJVNJ2bc/wHR3iTHeLGuKkSNdeF+ISN
         xO+UNStJDZCjkN5SDkdFwut7OKiv6yj1G6xtHaEU=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 16:57:04 -0400
Subject: [PATCH v1 1/5] maintainer-pgp-guide: use key terminology consistent with
 upstream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v1-1-c48fb06cb9af@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=11287;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=AiJ624A7q3U6WLzMdmIephz/BFMnF/PLuTlRBValYJE=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJIe/TCZFPFe6gKH/kaviXwBStWhpSlL1nAqbWRtXmHzqaFj
 +oEHHaUsDGJcDLJiiixl+2I3BRU+9JBL7zGFmcPKBDKEgYtTACZiocbwz07ww66gGLmedSc3BXgtqc
 83XnIubBP3yfplNmKTCwQ65jAyNH4L7CjPaZ87u8Fn6xSl3h12FptOXUqbHXI2tbTQSf4fMwA=
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

GnuPG does not use the word "master key" when referring to the subkey
marked with the "certification" capability. Our use of this term was not
only inconsistent, but also misleading, because in real life "master
keys" are able to open multiple locks made for different keys, while PGP
Certify key has no such capability.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 29e7d7b1cd44..cdd108f50fe7 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -133,45 +133,55 @@ daily cronjob::
 Check the full path to your ``gpg`` or ``gpg2`` command and use the
 ``gpg2`` command if regular ``gpg`` for you is the legacy GnuPG v.1.
 
-.. _master_key:
+.. _protect_your_key:
 
-Protect your master PGP key
-===========================
+Protect your PGP key
+====================
 
 This guide assumes that you already have a PGP key that you use for Linux
 kernel development purposes. If you do not yet have one, please see the
 "`Protecting Code Integrity`_" document mentioned earlier for guidance
 on how to create a new one.
 
-You should also make a new key if your current one is weaker than 2048 bits
-(RSA).
-
-Master key vs. Subkeys
-----------------------
-
-Subkeys are fully independent PGP keypairs that are tied to the "master"
-key using certifying key signatures (certificates). It is important to
-understand the following:
-
-1. There are no technical differences between the "master key" and "subkeys."
-2. At creation time, we assign functional limitations to each key by
-   giving it specific capabilities.
-3. A PGP key can have 4 capabilities:
-
-   - **[S]** key can be used for signing
-   - **[E]** key can be used for encryption
-   - **[A]** key can be used for authentication
-   - **[C]** key can be used for certifying other keys
-
-4. A single key may have multiple capabilities.
-5. A subkey is fully independent from the master key. A message
-   encrypted to a subkey cannot be decrypted with the master key. If you
-   lose your private subkey, it cannot be recreated from the master key
-   in any way.
-
-The key carrying the **[C]** (certify) capability is considered the
-"master" key because it is the only key that can be used to indicate
-relationship with other keys. Only the **[C]** key can be used to:
+You should also make a new key if your current one is weaker than 2048
+bits (RSA).
+
+Understanding PGP Subkeys
+-------------------------
+
+A PGP key rarely consists of a single keypair -- usually it is a
+collection of independent subkeys that can be used for different
+purposes based on their capabilities, assigned at their creation time.
+PGP defined four capabilities that a key can have:
+
+- **[S]** keys can be used for signing
+- **[E]** keys can be used for encryption
+- **[A]** keys can be used for authentication
+- **[C]** keys can be used for certifying other keys
+
+The **[C]** (certification) key is often called the "master" key, but
+this terminology is misleading because it implies that the Certify key
+can be used in place of any of other subkey on the same chain (like a
+physical "master key" would). For this reason, this guide will refer to
+it as "the Certify key" to avoid any ambiguity.
+
+It is critical to fully understand the following:
+
+1. All subkeys are fully independent from each other. If you lose a
+   private subkey, it cannot be restored or recreated from any other
+   private key on your chain.
+2. With the exception of the Certify key, there can be multiple subkeys
+   with identical capabilities (e.g. you can have 2 valid encryption
+   subkeys, 3 valid signing subkeys, but only one valid certification
+   subkey). All subkeys are fully independent -- a message encrypted to
+   one **[E]** subkey cannot be decrypted with any other **[E]** subkey
+   you may also have.
+3. A single subkey may have multiple capabilities (e.g. your **[C]** key
+   can also be your **[S]** key).
+
+The key carrying the **[C]** (certify) capability is the only key that
+can be used to indicate relationship with other keys. Only the **[C]**
+key can be used to:
 
 - add or revoke other keys (subkeys) with S/E/A capabilities
 - add, change or revoke identities (uids) associated with the key
@@ -180,7 +190,7 @@ relationship with other keys. Only the **[C]** key can be used to:
 
 By default, GnuPG creates the following when generating new keys:
 
-- A master key carrying both Certify and Sign capabilities (**[SC]**)
+- One subkey carrying both Certify and Sign capabilities (**[SC]**)
 - A separate subkey with the Encryption capability (**[E]**)
 
 If you used the default parameters when generating your key, then that
@@ -192,9 +202,6 @@ for example::
     uid           [ultimate] Alice Dev <adev@kernel.org>
     ssb   rsa2048 2018-01-23 [E] [expires: 2020-01-23]
 
-Any key carrying the **[C]** capability is your master key, regardless
-of any other capabilities it may have assigned to it.
-
 The long line under the ``sec`` entry is your key fingerprint --
 whenever you see ``[fpr]`` in the examples below, that 40-character
 string is what it refers to.
@@ -215,9 +222,9 @@ strong passphrase. To set it or change it, use::
 Create a separate Signing subkey
 --------------------------------
 
-Our goal is to protect your master key by moving it to offline media, so
-if you only have a combined **[SC]** key, then you should create a separate
-signing subkey::
+Our goal is to protect your Certify key by moving it to offline media,
+so if you only have a combined **[SC]** key, then you should create a
+separate signing subkey::
 
     $ gpg --quick-addkey [fpr] ed25519 sign
 
@@ -230,8 +237,8 @@ your new subkey::
 
     GnuPG 2.1 and later has full support for Elliptic Curve
     Cryptography, with ability to combine ECC subkeys with traditional
-    RSA master keys. The main upside of ECC cryptography is that it is
-    much faster computationally and creates much smaller signatures when
+    RSA keys. The main upside of ECC cryptography is that it is much
+    faster computationally and creates much smaller signatures when
     compared byte for byte with 2048+ bit RSA keys. Unless you plan on
     using a smartcard device that does not support ECC operations, we
     recommend that you create an ECC signing subkey for your kernel
@@ -244,8 +251,8 @@ your new subkey::
     "nistp256" instead or "ed25519."
 
 
-Back up your master key for disaster recovery
----------------------------------------------
+Back up your Certify key for disaster recovery
+----------------------------------------------
 
 The more signatures you have on your PGP key from other developers, the
 more reasons you have to create a backup version that lives on something
@@ -300,7 +307,7 @@ will use for backup purposes. You will need to encrypt them using LUKS
 -- refer to your distro's documentation on how to accomplish this.
 
 For the encryption passphrase, you can use the same one as on your
-master key.
+PGP key.
 
 Once the encryption process is over, re-insert the USB drive and make
 sure it gets properly mounted. Copy your entire ``.gnupg`` directory
@@ -319,7 +326,7 @@ far away, because you'll need to use it every now and again for things
 like editing identities, adding or revoking subkeys, or signing other
 people's keys.
 
-Remove the master key from  your homedir
+Remove the Certify key from your homedir
 ----------------------------------------
 
 The files in our home directory are not as well protected as we like to
@@ -334,7 +341,7 @@ think.  They can be leaked or stolen via many different means:
 Protecting your key with a good passphrase greatly helps reduce the risk
 of any of the above, but passphrases can be discovered via keyloggers,
 shoulder-surfing, or any number of other means. For this reason, the
-recommended setup is to remove your master key from your home directory
+recommended setup is to remove your Certify key from your home directory
 and store it on offline storage.
 
 .. warning::
@@ -343,7 +350,7 @@ and store it on offline storage.
     your GnuPG directory in its entirety. What we are about to do will
     render your key useless if you do not have a usable backup!
 
-First, identify the keygrip of your master key::
+First, identify the keygrip of your Certify key::
 
     $ gpg --with-keygrip --list-key [fpr]
 
@@ -359,7 +366,7 @@ The output will be something like this::
           Keygrip = 3333000000000000000000000000000000000000
 
 Find the keygrip entry that is beneath the ``pub`` line (right under the
-master key fingerprint). This will correspond directly to a file in your
+Certify key fingerprint). This will correspond directly to a file in your
 ``~/.gnupg`` directory::
 
     $ cd ~/.gnupg/private-keys-v1.d
@@ -369,13 +376,13 @@ master key fingerprint). This will correspond directly to a file in your
     3333000000000000000000000000000000000000.key
 
 All you have to do is simply remove the .key file that corresponds to
-the master keygrip::
+the Certify key keygrip::
 
     $ cd ~/.gnupg/private-keys-v1.d
     $ rm 1111000000000000000000000000000000000000.key
 
 Now, if you issue the ``--list-secret-keys`` command, it will show that
-the master key is missing (the ``#`` indicates it is not available)::
+the Certify key is missing (the ``#`` indicates it is not available)::
 
     $ gpg --list-secret-keys
     sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
@@ -404,7 +411,7 @@ file, which still contains your private keys.
 Move the subkeys to a dedicated crypto device
 =============================================
 
-Even though the master key is now safe from being leaked or stolen, the
+Even though the Certify key is now safe from being leaked or stolen, the
 subkeys are still in your home directory. Anyone who manages to get
 their hands on those will be able to decrypt your communication or fake
 your signatures (if they know the passphrase). Furthermore, each time a
@@ -627,10 +634,10 @@ Other common GnuPG operations
 Here is a quick reference for some common operations you'll need to do
 with your PGP key.
 
-Mounting your master key offline storage
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Mounting your safe offline storage
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-You will need your master key for any of the operations below, so you
+You will need your Certify key for any of the operations below, so you
 will first need to mount your backup offline storage and tell GnuPG to
 use it::
 
@@ -644,7 +651,7 @@ your regular home directory location).
 Extending key expiration date
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The master key has the default expiration date of 2 years from the date
+The Certify key has the default expiration date of 2 years from the date
 of creation. This is done both for security reasons and to make obsolete
 keys eventually disappear from keyservers.
 

-- 
b4 0.10.0-dev-49460
