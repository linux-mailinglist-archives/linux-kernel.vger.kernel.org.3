Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89450D4B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiDXTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiDXTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:52 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513AD64FD;
        Sun, 24 Apr 2022 12:10:13 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o5v019069;
        Mon, 25 Apr 2022 04:08:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o5v019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827333;
        bh=3DIZA5tkupZU8nSODyVIXDfuTgtxrNBwn6P7Zx7N+eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCXh4znvO5zwPPKyyC3CS9SOV50mqKBXy98fAlzkkA7vAoktlG03qFYL58N5wq1hx
         FA7bG5V4Kr8i2ma5nLNpa+kz7dHMArIIIeaojFYveiL1K3WwvUjXPIlNMkB9FlH5Ve
         HtRJ8HFc6OOC5NqtZGPcAR1HoN9i7TVwM6ZAh9HyCCF5NQ1X6FDITOATMc4LyZw1fX
         OC/IqqU/WLJHI59YDjqxFluY8hqSyPgQ06exIqHkSkw4h2S1W+pvVVWEkO0OXyoefF
         EBykLgJh/ZHhl16Pm1gjmX7nWJr6lw7m0dpL9hdKhsR7JPFfgDmeORiq9TNxPqjZ5R
         fDKcXddu15GGw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 03/27] modpost: remove stale comment about sym_add_exported()
Date:   Mon, 25 Apr 2022 04:07:47 +0900
Message-Id: <20220424190811.1678416-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description,

  it may have already been added without a
  CRC, in this case just update the CRC

... is no longer valid.

In very old days, this function was used to update the CRC as well.

Commit 040fcc819a2e ("kbuild: improved modversioning support for
external modules") started to use a separate function (sym_update_crc)
for updating the CRC.

The first part, "Add an exported symbol" is correct, but it is too
obvious from the function name. Drop this comment entirely.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f0d48f65fb33..c7cfeeb088f7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -387,10 +387,6 @@ static void sym_update_namespace(const char *symname, const char *namespace)
 	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 }
 
-/**
- * Add an exported symbol - it may have already been added without a
- * CRC, in this case just update the CRC
- **/
 static struct symbol *sym_add_exported(const char *name, struct module *mod,
 				       enum export export)
 {
-- 
2.32.0

