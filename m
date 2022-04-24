Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D5750D4B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiDXTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiDXTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:52 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510366471;
        Sun, 24 Apr 2022 12:10:13 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o5t019069;
        Mon, 25 Apr 2022 04:08:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o5t019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827332;
        bh=xmbqEDC+KtGt1J30nfqDvMBENgRiG6uXKvfO4rQS4b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwvmRmU1DB7j7YdfjGyZcPCgs3f2ie/cSp5NVFbIAPMFaFR0aZQVrqpsbc+3sE/mU
         LuKWBru6a3N4d68aAJsg7In3Bg8fxClnk002VVW/rXWREzBnOgTAlDYGNd+1hlcu1/
         lz2hh3RgK47U8qWmhFT2XyIGlGG8Lpjo2l/RdhGJDdOs1DF5GIvWmECyvMM5n3O6cX
         k539SvQXc5yJieEarPk1MPq8M8eBkVsL1Vmi16PjU95d9FjX5GCSlIUSq6dHJ6bl/p
         WpiRoTGXDl+xJZLzuO1xS77EDSb1ADonE4JCsjxH8fFWw9st8iQ0l32NF+7AcAwXzB
         V46JRtf198uzw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 01/27] modpost: use snprintf() instead of sprintf() for safety
Date:   Mon, 25 Apr 2022 04:07:45 +0900
Message-Id: <20220424190811.1678416-2-masahiroy@kernel.org>
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

Use snprintf() to avoid the potential buffer overflow, and also
check the return value to detect the too long path.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 522d5249d196..141370ebbfd3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2560,6 +2560,7 @@ int main(int argc, char **argv)
 
 	for (mod = modules; mod; mod = mod->next) {
 		char fname[PATH_MAX];
+		int ret;
 
 		if (mod->is_vmlinux || mod->from_dump)
 			continue;
@@ -2578,7 +2579,12 @@ int main(int argc, char **argv)
 		add_moddevtable(&buf, mod);
 		add_srcversion(&buf, mod);
 
-		sprintf(fname, "%s.mod.c", mod->name);
+		ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
+		if (ret >= sizeof(fname)) {
+			error("%s: too long path was truncated\n", fname);
+			continue;
+		}
+
 		write_if_changed(&buf, fname);
 	}
 
-- 
2.32.0

