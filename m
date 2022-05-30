Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD45E5384EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiE3P2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbiE3P2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:28:04 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283575C76E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:30:55 -0700 (PDT)
Received: from workstation5.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0EB0A3F179;
        Mon, 30 May 2022 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653921051;
        bh=kGr+sHiM/aD7enc3bCpxceMk5/JEGeGT7T2oSpmoiTU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=SlQC+zgzKYbEWX0c5PBVAxZNo+0uVBaJmFTmjP5YyNBHJUoZsLqIa+aVho7Co9Azi
         NXw7QNW7z8EWmnSK8eeZTzJEnQA8k19AeuZdl8YssSR4OnZEfa5CKfjynCjGXgQDQZ
         23XQhJIA/K3BovCR+4wfiROqboPuxUHMlU3JxaWq5CuXwlfIm21P63TJwN8dpwJCWl
         R4C1sh+MhcB/DQlfX+htOXJERqCqFkGPudoNua+oQDqyY/jLEzl8eMn6wxpwc50JAb
         2yxxHIvZXdPpCDNV31qy5501DoVdPqDb3on77gVgaK62417ynqVOncbcnLbCH7FKN5
         fR5G5N2IB4vWQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [BUG] scripts/checkpatch.pl: incorrect parsing of commit message
Date:   Mon, 30 May 2022 16:30:21 +0200
Message-Id: <20220530143021.43645-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following text from a commit message

    "Building on RISC-V results in an error

        cc: error: ‘-march=native’: ISA string must begin with rv32 or rv64"

results in a false positive in scripts/checkpatch.pl:

    ERROR: Unrecognized email address:
    'error: ‘-march=native’: ISA string must begin with rv32 or rv64"'

If a line does not start in column 1 and does not contain an email
address, it is obviously not a Cc: tag and checkpatch.pl should not
indicate an error.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 507c146..bbf4650 100644
--- a/meson.build
+++ b/meson.build
@@ -17,7 +17,10 @@ pktgen_conf = configuration_data()
 # set up some global vars for compiler, platform, configuration, etc.
 cc = meson.get_compiler('c')
 
-add_project_arguments('-march=native', language: 'c')
+target = target_machine.cpu_family()
+if (target != 'riscv64')
+    add_project_arguments('-march=native', language: 'c')
+endif
 
 if get_option('enable-avx') and cc.has_argument('-mavx')
     add_project_arguments('-mavx', language: 'c')
-- 
2.36.1

