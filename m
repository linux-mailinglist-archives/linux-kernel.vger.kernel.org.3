Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94C533EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiEYOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245643AbiEYOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:05:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D78D6BD;
        Wed, 25 May 2022 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653487435; x=1685023435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FdNkUTr3XASwSCxYa3ivhvPYt8r8WXycJZ613rnDCeE=;
  b=K60NM2e227WWOO6sPbV2DViC1WmF2xeMeRGlN4g6SSkO4aSc31uTT2UJ
   LROC/FmaLr1X0fmPByESBhqoemKfLICFdoGN1OxReaBTsrJegSh6orBmB
   1jkgA7G9hwbQ3u749ybOlbkK1TeMDXIdH6u/+0/nC6PDjsJjCE07wpqo5
   CYjdZ3NGzyobXDMKvXELmS/YCV1199mGh7SYmg92xG9+XYPn+34AKi1PN
   uxrkBGGijP3/NyXV/a9KLqaN8RV5q9pnEa9mxQw7ve2hG7niuD36XD3FG
   PxeEWMx7zFKJXpzA1RTCFY+o45bb/sdTL4E8n1hGw1IdnqfRpPJQr6onl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="299154465"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="299154465"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="717694868"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga001.fm.intel.com with ESMTP; 25 May 2022 07:03:52 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH] perf jevents: Fix event syntax error caused by ExtSel
Date:   Wed, 25 May 2022 22:04:10 +0800
Message-Id: <20220525140410.1706851-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

In the origin code, when "ExtSel" is 1, the eventcode will change to
"eventcode |= 1 << 21”. For event “UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
its "ExtSel" is "1", its eventcode will change from 0x1E to 0x20001E,
but in fact the eventcode should <=0x1FF, so this will cause the parse
fail:

  # perf stat -e "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS" -a sleep 0.1
event syntax error: '.._RxL_CREDITS_CONSUMED_VN0.DRS'
                                  \___ value too big for format, maximum is 511

On the perf kernel side, the kernel assumes the valid bits are continuous.
It will adjust the 0x100 (bit 8 for perf tool) to bit 21 in HW.

DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");

So the perf tool follows the kernel side and just set bit8 other than bit21.

Fixes: fedb2b518239 ("perf jevents: Add support for parsing uncore json files")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index cee61c4ed59e..e597e4bac90f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -605,7 +605,7 @@ static int json_events(const char *fn,
 			} else if (json_streq(map, field, "ExtSel")) {
 				char *code = NULL;
 				addfield(map, &code, "", "", val);
-				eventcode |= strtoul(code, NULL, 0) << 21;
+				eventcode |= strtoul(code, NULL, 0) << 8;
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
 				addfield(map, &je.name, "", "", val);
-- 
2.25.1

