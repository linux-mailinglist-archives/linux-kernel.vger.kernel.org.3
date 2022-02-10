Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C74B1955
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244960AbiBJXUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:20:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbiBJXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:20:38 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9B5F57;
        Thu, 10 Feb 2022 15:20:35 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 200so6608218qki.2;
        Thu, 10 Feb 2022 15:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OI8hrqvEfZeAPpQf8rC+vBfmKoqD6QuGtPPDNoK9uS4=;
        b=EQfXcPTDBcYmVj4+j4y/o25JVZVDwsWDx+EHUAOF3zMYUn3kQLX/MQfzHc/YKh7FN+
         wm3IVR3uXroLe/72PTmQlUcmmno8zHVeYAM0auen7rv+y/jThDNnkafJjcgmONPKaZx5
         gDKoXCQtUHorfeynZcINw3BfDvjNFg1UfPdLYBp9UNxk8+r/ONDMKXrWVWxHFGs4MioI
         4Qo6KmzZXo6xLcPq6A2malt5UGXvTQ0/AN4hdbapLw/4UqjI/nUuIbUbfUEXo9K8538z
         v9P/ZZOoEfZt7peFCpLO9LS5MNJS7WxJgbU0lBrAZ25AQUta31Bg+sR9XeKHm/qqs1wE
         GMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OI8hrqvEfZeAPpQf8rC+vBfmKoqD6QuGtPPDNoK9uS4=;
        b=UCYQSb3Pzs2xa8qitu7UTbrUwQ72zJbSk+i29PfseM5LzrMK5pODUFPc5fT9ERWToW
         7n+l6fe7qgjUuvyopYxxioJGZUtP/KmGGt1/V/yHS0euf0agDasPsuEYvLdjTlGKLA/G
         MszWX06Yk8G3YRjWSbckyKxh9r59szR28HtpqcTB9v7T6gkaCc2fNkBegr3g6fsvp/QH
         /cEIdxT+ub8P/1iPeLrvYtSjfZoe6+S2tJ8s34nTip0CepDri9Bq7MyUfkCFghgqf50E
         0254QeweafMDsuHT1ouRr6GcbyGlr4bktF1ZukHzcpUmcofYVn4Fh+EM8tieIVhZKUrh
         mSuQ==
X-Gm-Message-State: AOAM532jO7txafanMGY7sBYAGKS69YBNbzmYdQ65tzUOWafDfO/FZXXB
        NNg6A3cAs3qIgCotqJ/nG+M=
X-Google-Smtp-Source: ABdhPJyfmC4ftc0tGVwbWyGGCrs8QXCUCRrbYeGrdw/pzG5Dj57MnQrgDJcGdetfGIydZXZ3xW6zSg==
X-Received: by 2002:a05:620a:4043:: with SMTP id i3mr5211591qko.14.1644535235068;
        Thu, 10 Feb 2022 15:20:35 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id v12sm10661466qkl.74.2022.02.10.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:20:34 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 13/49] perf tools: replace bitmap_weight with bitmap_empty where appropriate
Date:   Thu, 10 Feb 2022 14:48:57 -0800
Message-Id: <20220210224933.379149-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code in builtin-c2c.c calls bitmap_weight() to check if any bit of
a given bitmap is set. It's better to use bitmap_empty() in that case
because bitmap_empty() stops traversing the bitmap as soon as it finds
first set bit, while bitmap_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/perf/builtin-c2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 77dd4afacca4..14f787c67140 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1080,7 +1080,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 		bitmap_zero(set, c2c.cpus_cnt);
 		bitmap_and(set, c2c_he->cpuset, c2c.nodes[node], c2c.cpus_cnt);
 
-		if (!bitmap_weight(set, c2c.cpus_cnt)) {
+		if (bitmap_empty(set, c2c.cpus_cnt)) {
 			if (c2c.node_info == 1) {
 				ret = scnprintf(hpp->buf, hpp->size, "%21s", " ");
 				advance_hpp(hpp, ret);
@@ -1944,7 +1944,7 @@ static int set_nodestr(struct c2c_hist_entry *c2c_he)
 	if (c2c_he->nodestr)
 		return 0;
 
-	if (bitmap_weight(c2c_he->nodeset, c2c.nodes_cnt)) {
+	if (!bitmap_empty(c2c_he->nodeset, c2c.nodes_cnt)) {
 		len = bitmap_scnprintf(c2c_he->nodeset, c2c.nodes_cnt,
 				      buf, sizeof(buf));
 	} else {
-- 
2.32.0

