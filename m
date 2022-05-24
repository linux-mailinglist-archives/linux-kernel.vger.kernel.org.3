Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751E532D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiEXP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiEXP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:28:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7E9CCBB;
        Tue, 24 May 2022 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653406091; x=1684942091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A7gIGAfJIQqa6vlkFL9sRzu2NI/6aKt9AlcZ26DQd+Q=;
  b=GM4xEePwFJzB886AsE8466+z/fFecICgDaH1t824vJck4JK8rcQNFEbC
   i7l9i5vxcUTnUS8/LN7Hb4eDoGRGHrakM4dR7BQqfrHLCaZyfZ6KGaUB+
   1Pmt/XEwBBtE6IoDnYhlWgT+zZH34no4heUc34r0CcU9nrITH+9eNl5p3
   tvNPkxYJTU/Fs3UpK3Fhq1VNpCAYaVV9xXrxoqoO8cnV7VSEZI0GuqZxR
   gIsDcTNROyZPg9wMUUJ0QIp+flIG6M5o2TgmqelpYiXOPKu+6TXJt3To9
   qd5+EIWmauawu4IMOarwxrUumrX+gloc7SUmCR8IEAHj46Zz34K7sOuoG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="334208404"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="334208404"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 08:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="663953145"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 08:27:54 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 24OFRrPX032311;
        Tue, 24 May 2022 16:27:53 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Michal Nazarewicz <mina86@mina86.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: fix removing numeric suffixes
Date:   Tue, 24 May 2022 17:27:18 +0200
Message-Id: <20220524152718.331773-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the `-z unique-symbol` linker flag or any similar mechanism,
it is possible to trigger the following:

ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL

The reason is that for now the condition from remove_dot():

if (m && (s[n + m] == '.' || s[n + m] == 0))

which was designed to test if it's a dot or a '\0' after the suffix
is never satisfied.
This is due to that `s[n + m]` always points to the last digit of a
numeric suffix, not on the symbol next to it (from a custom debug
print added to modpost):

param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'

So it's off-by-one and was like that since 2014.

Fix this for the sake of any potential upcoming features, but don't
bother stable-backporting, as it's well hidden -- apart from that
LD flag, it can be triggered only with GCC LTO which never landed
upstream.

Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6f5c605ab0fb..fd04ba057490 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1905,7 +1905,7 @@ static char *remove_dot(char *s)
 
 	if (n && s[n]) {
 		size_t m = strspn(s + n + 1, "0123456789");
-		if (m && (s[n + m] == '.' || s[n + m] == 0))
+		if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
 			s[n] = 0;
 	}
 	return s;
-- 
2.36.1

