Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB74E8073
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiCZK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiCZK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456755BD;
        Sat, 26 Mar 2022 03:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7C460B82;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81305C36AE5;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=/RJA2D1Ibpq79TzqVCMA7zkbXSOivMOodsfJk7S3Qmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q86UPSv8zRhM3lQr6i9Y9IkByBT9njgqHH+uLokHT9YsqWSPg2c/IIrDrdJtALKDI
         gi54RUQpqm3kKdyMEMd5oTIXyaKcxn+Ge+S2dxcbIEIHMMqMRhOLrIs+fnvthDuJGT
         kTZs+bhY82JoJizeT9DzZhvX1ShnylX2lcOlpVk4VTiXPJyaRAaNzFsDW3Mvxnvb6O
         CmEzu0Wp9OkjUc1RwrPgVgSR3pTgCVQZIY362ssJ2feCB+w6n4qFET0/qUdUZkm99s
         YbxrF90leklRIC0lTJ8V0L99yug53mHl8l9kVWfos0noA66oXZt8AlLR/h7PVovlDf
         4yOl8McvdUFMw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0g-6Q; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] docs: kernel_include.py: add sphinx build dependencies
Date:   Sat, 26 Mar 2022 11:27:22 +0100
Message-Id: <d30fc4fa422a13b7e1623d690945c46b58a55e79.1648290305.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648290305.git.mchehab@kernel.org>
References: <cover.1648290305.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files included by kernel-include should be added as build
dependencies, in order for sphinx-build to rebuild the corresponding
docs if any changes at the included file happens.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1648290305.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_include.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index f523aa68a36b..abe768088377 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -59,6 +59,7 @@ class KernelInclude(Include):
     u"""KernelInclude (``kernel-include``) directive"""
 
     def run(self):
+        env = self.state.document.settings.env
         path = os.path.realpath(
             os.path.expandvars(self.arguments[0]))
 
@@ -70,6 +71,8 @@ class KernelInclude(Include):
 
         self.arguments[0] = path
 
+        env.note_dependency(os.path.abspath(path))
+
         #return super(KernelInclude, self).run() # won't work, see HINTs in _run()
         return self._run()
 
-- 
2.35.1

