Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF744F969B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiDHN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiDHN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:28:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93713B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649424388; x=1680960388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6JrpX5dESDXVdafOm6RvFXszoz4IdJc1N9aj6Tn5J0=;
  b=dFQjbthmqDs7xtoo20jgsqhCKuho3BfaAqkFXWAPgTZE+Kg14hSPFo60
   K3W+EaIK7DRTXBTVVsVecH+5pWIjDy5rXM0ozG8ReGwhtApMlt7JTN7ve
   Cp7oEQnS1Ni1rw/Nrhfcp7Oio1JLjmqwjqLZ8VPb51sWuTiVnJLt7AZy+
   q49YpLtC4gHyYxLcGJzTxwi9vnxPkX8n6ZRi5kUrQBuyPdzyObIi58pBD
   YRqVhmWQGhdZB7oH5muqkaeiiztFjkZU/GTNcyJNhLl3B8MX+4nP2WEXQ
   7ztyHmF91e6T82YDMwJo7JxvQROroD9pw/RNZD6TDYrIhJ6O6TrUXTn04
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260428168"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260428168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="524773949"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2022 06:26:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix perf's libperf_print callback
Date:   Fri,  8 Apr 2022 16:26:25 +0300
Message-Id: <20220408132625.2451452-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eprintf does not expect va_list as the 4th parameter.
Use veprintf because it does.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 2f6b67189b42..6aae7b6c376b 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -434,7 +434,7 @@ void pthread__unblock_sigwinch(void)
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
-	return eprintf(level, verbose, fmt, ap);
+	return veprintf(level, verbose, fmt, ap);
 }
 
 int main(int argc, const char **argv)
-- 
2.25.1

