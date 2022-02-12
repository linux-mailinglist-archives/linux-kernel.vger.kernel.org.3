Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA74B365B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiBLQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:19:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbiBLQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:19:32 -0500
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4387B181;
        Sat, 12 Feb 2022 08:19:29 -0800 (PST)
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 21CGIeGG032289;
        Sun, 13 Feb 2022 01:18:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 21CGIeGG032289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644682721;
        bh=Jsb9UGtQqwRz1mO97LtkCwDjiroMA4vQBbLGqoWONso=;
        h=From:To:Cc:Subject:Date:From;
        b=UsL0jAYTuz4cki8NtqU0+/cdwpzrBrhfKh0W7VxXAvXI64PuCSQuZfbzyMzMnJCEc
         kZY6GnOQaRsF4dzmsCpMnys+5JfTVqtObTis6kSR7eS9DUnHY7K9qi0+q0nHiwiZLp
         8rciGbY3zDINSRmuFmNu4IQ+5k3yAWQbHD4c7qZqPVnyosD76N97iopv6192UJUmPu
         1pTKlkVyKzfRhFzDOXC32zYDXy79B2GAadtQ2+TYZTliZY+6fv7Cx9SkSQg7utRftp
         gVN5HtfsPWxJLIx68BuIqrg1FDAxOu/gZuwXTrGp+5rGKTB8y2WepUUSorEXfA8Xe6
         Vu2YKTBw/TT2w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] kconfig: add fflush() before ferror() check
Date:   Sun, 13 Feb 2022 01:18:37 +0900
Message-Id: <20220212161837.2235261-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As David Laight pointed out, there is not much point in calling
ferror() unless you call fflush() first.

Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index d3c3a61308ad..94dcec2cc803 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -979,6 +979,7 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
 
 	fprintf(out, "\n$(deps_config): ;\n");
 
+	fflush(out);
 	ret = ferror(out); /* error check for all fprintf() calls */
 	fclose(out);
 	if (ret)
@@ -1097,6 +1098,7 @@ static int __conf_write_autoconf(const char *filename,
 		if ((sym->flags & SYMBOL_WRITE) && sym->name)
 			print_symbol(file, sym);
 
+	fflush(file);
 	/* check possible errors in conf_write_heading() and print_symbol() */
 	ret = ferror(file);
 	fclose(file);
-- 
2.32.0

