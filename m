Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFF5A7D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiHaMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiHaMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:40:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99961DA3;
        Wed, 31 Aug 2022 05:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B607BB82077;
        Wed, 31 Aug 2022 12:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D537BC433D7;
        Wed, 31 Aug 2022 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661949647;
        bh=TPSgl0I2qWuKYC5cFtJ2UDufyO2SqJMLBEL1mtc1IZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=K28Wx2IBN5YI4BT3HcgU5dtMPA6/Smwouty2BafiJeBXCnUipgktQ6of/M+JQH2nN
         8lqlJnGWglNTmfvP3l6HC1B1OLyy+SKOQf6bQnkSxRTzHYIUg7Hysfw+M8Lcv0YbeB
         EYHp/8sDD5HhJxHKl9rVI63EzEto8jzVxvCYa4lgY5lORQmyti8Y124MzSCryh/PqH
         CbRVKG1M+jELswfW2chwNCWz9OhHyyO/g1eYrbkI91wCuH8N+N2wXZkw4gINcPBySr
         sgOJEXYfIfnEKG9s8IMLzQ25+kGwZkaHeG68Pesf0w0e4jcXP25hu0KAVZKQvt6GCZ
         mp98dII/CUBSA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Hongtao Yu <hoy@fb.com>, Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf script: Skip dummy event attr check
Date:   Wed, 31 Aug 2022 14:40:41 +0200
Message-Id: <20220831124041.219925-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

Hongtao Yu reported problem when displaying uregs in perf script
for system wide perf.data:

  # perf script -F uregs | head -10
  Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.

The problem is the extra dummy event added for system wide,
which does not have proper sample_type setup.

Skipping attr check completely for dummy event as suggested
by Namhyung, because it does not have any samples anyway.

Reported-by: Hongtao Yu <hoy@fb.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 13580a9c50b8..304d234d8e84 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -566,6 +566,8 @@ static struct evsel *find_first_output_type(struct evlist *evlist,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_dummy_event(evsel))
+			continue;
 		if (output_type(evsel->core.attr.type) == (int)type)
 			return evsel;
 	}
-- 
2.37.2

