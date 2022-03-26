Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974554E806F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiCZK31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiCZK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636994F479;
        Sat, 26 Mar 2022 03:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C274F60BA5;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96547C3410F;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=4xYDm8jiOGCxidWbMBbnubCB80y407Lrcoc3O9x9bTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLn0aW4S35JWxm7QulfteOw5UXPdQW6wwkoUyPVUqB0Cv27GOnTzBSBmpXaZWnnq3
         7Fw7rQn1+lmoe4lYFeMUMkHiV3S/mTandfR9G40O7bsxTyAZ8uoYHDYcindFUdugIZ
         VXFhs+FLd4BMvAV9MzM2s8uCur22o0bQhAvi4+9iFVPegS9JtJnJzwQlZckSnC8Lk+
         wc7y5UjKyftmuvIisK5608iy1b2CJpmd6hsUI/G2nBzAWTnZnZWvltZpJF8r/MtsEw
         IhyChcKEFQFEAbh5j7lUZtgSdhizvApDwhRl9Vvqg7PMg/HoSDlcnXrizydSnfM1Ty
         +8Te195rzKcrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0c-4x; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] docs: kernel_abi.py: add sphinx build dependencies
Date:   Sat, 26 Mar 2022 11:27:21 +0100
Message-Id: <10bc3d3bc74f514a539cd3b48b9d287d2b6f99e2.1648290305.git.mchehab@kernel.org>
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

Ensure that Sphinx-build will handle the files parsed by
get_abi.pl as dependencies. This way, if they are touched,
the ABI output will be regenerated.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1648290305.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_abi.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 4392b3cb4020..efab9b14a9f5 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -128,6 +128,7 @@ class KernelCmd(Directive):
         return out
 
     def nestedParse(self, lines, fname):
+        env = self.state.document.settings.env
         content = ViewList()
         node = nodes.section()
 
@@ -154,6 +155,9 @@ class KernelCmd(Directive):
                     self.do_parse(content, node)
                     content = ViewList()
 
+                    # Add the file to Sphinx build dependencies
+                    env.note_dependency(os.path.abspath(f))
+
                 f = new_f
 
                 # sphinx counts lines from 0
-- 
2.35.1

