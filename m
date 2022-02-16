Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FD4B91C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiBPTvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:51:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiBPTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:51:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7122C3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B781CE28BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2B1C004E1;
        Wed, 16 Feb 2022 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645041079;
        bh=/kAffq5at/nvUe/Zf5JLZv0VEVC28bcRZ0RwVa1PKhY=;
        h=Date:From:To:Cc:Subject:From;
        b=IE9qtlys/BxiETwkUSn29269tmBrWHIPZ8XaXkUOMYvV0Y5p4MDDoc4SY+zpvaDc3
         j6PnArOxHNauKD7Cylr2fTwkawGbZ867vnF6csPhgX4JJ0CG4jQjq/qERq3yMzvV0u
         zQJGKzioDQt82vz3E5pPdemzwLHPjRQthxqaZs/Kgd7BW8m5WsBT0ksJKl+c/V32hz
         tlvmPu3jnNHCEnQPWN+mlwlSob8LeLPQfke5sLEouistHo8pxSMJk+7yuEZsHMfr73
         ZmxqT7LLO8CuYwUELtvEwOvk50GQY7x0WrzHXQ0hh2uLyHSz9loPcsscPF8rzb1Lw0
         DV/834Hag/Q4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 950A2400FE; Wed, 16 Feb 2022 16:51:17 -0300 (-03)
Date:   Wed, 16 Feb 2022 16:51:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf bpf: Defer freeing string after possible strlen()
 on it
Message-ID: <Yg1VtQxKrPpS3uNA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: I'm carrying this on my tree:

---

This was detected by the gcc in Fedora Rawhide's gcc:

  50    11.01 fedora:rawhide                : FAIL gcc version 12.0.1 20220205 (Red Hat 12.0.1-0) (GCC)
        inlined from 'bpf__config_obj' at util/bpf-loader.c:1242:9:
    util/bpf-loader.c:1225:34: error: pointer 'map_opt' may be used after 'free' [-Werror=use-after-free]
     1225 |                 *key_scan_pos += strlen(map_opt);
          |                                  ^~~~~~~~~~~~~~~
    util/bpf-loader.c:1223:9: note: call to 'free' here
     1223 |         free(map_name);
          |         ^~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

So do the calculations on the pointer before freeing it.

Fixes: 04f9bf2bac72480c ("perf bpf-loader: Add missing '*' for key_scan_pos")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 7ecfaac7536a1b1b..16ec605a9fe46a64 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1220,9 +1220,10 @@ bpf__obj_config_map(struct bpf_object *obj,
 	pr_debug("ERROR: Invalid map config option '%s'\n", map_opt);
 	err = -BPF_LOADER_ERRNO__OBJCONF_MAP_OPT;
 out:
-	free(map_name);
 	if (!err)
 		*key_scan_pos += strlen(map_opt);
+
+	free(map_name);
 	return err;
 }
 
-- 
2.34.1

