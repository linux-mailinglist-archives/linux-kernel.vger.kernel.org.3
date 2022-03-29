Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463BC4EAF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiC2Osm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiC2Osj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:48:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E555C7666F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32951B8181A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9004BC2BBE4;
        Tue, 29 Mar 2022 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648565212;
        bh=NI2Az7Mki6uKWg/mQRI5kFlwEnKHbVW29uFiWe61tUs=;
        h=Date:From:To:Cc:Subject:From;
        b=Ug75xzT5715xtp36K62YjK3JN71MnScjuz4nliC/zhbc8D8oGvcvn80H+qMnh0wpw
         LbAvdyB66T7CSxkdkgFzSTC5NVrG4b7caWbaHctsuR1UeteoN79FYvGo00TBOVD20j
         mLb/L7XWJoL0E3dpsAkMQnX+txmPDllQ9PrF+Fn7WLQstE3+Umct1rCRfTxjzzG5M5
         tZfX5Kw5I1LX6k3nzGE+T0arRJfwo64ZFJ2s8W8PCie2s+QnoAa+d5dsAlUXT87+vJ
         35dDdz2oCaM/BPMEzZYMjckWvSyxk2B8WvqIJh8KVxJ0Z8hABLUMevAEWQgw7GWzsW
         Bna4shemNu33Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A28640407; Tue, 29 Mar 2022 11:46:49 -0300 (-03)
Date:   Tue, 29 Mar 2022 11:46:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mauricio =?iso-8859-1?Q?V=E1squez?= <mauricio@kinvolk.io>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI PATCH 1/1] perf tools: Update copy of libbpf's hashmap.c
Message-ID: <YkMb2SAIai2VeuUD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this patch in the perf tools tree.

- Arnaldo

---

To pick the changes in:

  fba60b171a032283 ("libbpf: Use IS_ERR_OR_NULL() in hashmap__free()")

That don't entail any changes in tools/perf.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
  diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h

Not a kernel ABI, its just that this uses the mechanism in place for
checking kernel ABI files drift.

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mauricio Vásquez <mauricio@kinvolk.io>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hashmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 3c20b126d60d869a..aeb09c2887162d16 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -75,7 +75,7 @@ void hashmap__clear(struct hashmap *map)
 
 void hashmap__free(struct hashmap *map)
 {
-	if (!map)
+	if (IS_ERR_OR_NULL(map))
 		return;
 
 	hashmap__clear(map);
@@ -238,4 +238,3 @@ bool hashmap__delete(struct hashmap *map, const void *key,
 
 	return true;
 }
-
-- 
2.35.1

