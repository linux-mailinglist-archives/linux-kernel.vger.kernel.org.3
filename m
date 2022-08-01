Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E45866F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiHAJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:41:57 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A833718D;
        Mon,  1 Aug 2022 02:41:56 -0700 (PDT)
Received: from grover.sesame ([133.106.54.139]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 2719ejxv028043;
        Mon, 1 Aug 2022 18:40:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 2719ejxv028043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659346847;
        bh=pqPD7Wkp1lmpx2tsj9tFXaFAxHkMIWM8JQh0KzpxP3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5Ov1rwUlutthjiuHR1Yq5aJWbBNYAQAkDg5XHBr7KolJDHTKchJOJ2RIx/uPDbSc
         tfa8LctyA4OOJsS+x7rGSkpOpiUdRrj5RCtpWUWcLGSJV/BirjV8dna40u2MJgNzMF
         SbSkSFCgBUoj6IbUEh+Dmzvbr/0RSSICIBAFSsfk9CtpnR9uZ7Jns6oS3jqmo7kKjh
         CvFH6sSqrBzGMtZ3d4d3QJ6aRg0n6/BzEaQfT6ceOHfr8JD42bom8ekZ+qbjYpis1F
         nFQzlB8EudPrG8vTKvGaDZ+chwVqY1YMcO0y1vt8ZBYD/Bx0qUckp0IerKp9JYmOs6
         1jInkpqiXHFtQ==
X-Nifty-SrcIP: [133.106.54.139]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] modpost: add PATTERNS() helper macro
Date:   Mon,  1 Aug 2022 18:39:00 +0900
Message-Id: <20220801093902.1506297-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220801093902.1506297-1-masahiroy@kernel.org>
References: <20220801093902.1506297-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be useful to define a NULL-terminated array inside a function
call.

Currently, string arrays passed to match() are defined in separate
places:

    static const char *const init_sections[] = { ALL_INIT_SECTIONS, NULL };
    static const char *const text_sections[] = { ALL_TEXT_SECTIONS, NULL };
    static const char *const optim_symbols[] = { "*.constprop.*", NULL };

            ...

            /* Check for pattern 5 */
            if (match(fromsec, text_sections) &&
                match(tosec, init_sections) &&
                match(fromsym, optim_symbols))
                    return 0;

With the new helper macro, you can list the patterns directly in the
function call, like this:

            /* Check for pattern 5 */
            if (match(fromsec, PATTERNS(ALL_TEXT_SECTIONS)) &&
                match(tosec, PATTERNS(ALL_INIT_SECTIONS)) &&
                match(fromsym, PATTERNS("*.contprop.*")))
                    return 0;

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9e8ae2636ec1..c2949a1a0d5e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -746,6 +746,13 @@ static bool match(const char *string, const char *const patterns[])
 	return false;
 }
 
+/* useful to pass patterns to match() directly */
+#define PATTERNS(...) \
+	({ \
+		static const char *const patterns[] = {__VA_ARGS__, NULL}; \
+		patterns; \
+	})
+
 /* sections that we do not want to do full section mismatch check on */
 static const char *const section_white_list[] =
 {
-- 
2.34.1

