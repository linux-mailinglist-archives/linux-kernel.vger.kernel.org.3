Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC658185B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbiGZR2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiGZR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:28:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326022B61F;
        Tue, 26 Jul 2022 10:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5029B818CD;
        Tue, 26 Jul 2022 17:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AA4C433C1;
        Tue, 26 Jul 2022 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658856481;
        bh=OeeqVHYRFCRbXXvIvZzsym2JbtgrWaLKkYhMqGRpjJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9eddGvQJFqGOuIQ2REO2OYJRFgIOT9X+E58uAQEPkzOPfXfWJtpazo6h1dt9AxAC
         THF+oCj0DmzdZyS6Pq4N/r1h+fb/rmiVmzxWGzAHoRiohbfoMZh3nfi88fvktNwcHW
         UnZrnLpUSNFY1lzZVe+LITZnDwlWH4mOkxc5EzI+Q8g6mZnrT9IjedMKqGRumt5pnW
         chJIuHnhAcIr1uT60UPDidE9BTur9y9N8ejqQmn2o25IGXoxZyzeafPv+g7ZowXM+t
         AhK1KyACXAQhnciLvjbfeHUnroqXQ6yQHYwj2xjmcgsUl2eLxV/uvCZ/SwMD7+bm4y
         MWDHPzzDpwGqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FF7140374; Tue, 26 Jul 2022 14:27:58 -0300 (-03)
Date:   Tue, 26 Jul 2022 14:27:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, pc@us.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC v3 01/17] perf kwork: New tool
Message-ID: <YuAkHkxgYyvdHKOO@kernel.org>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
 <20220709015033.38326-2-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709015033.38326-2-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 09, 2022 at 09:50:17AM +0800, Yang Jihong escreveu:
> The perf-kwork tool is used to trace time properties of kernel work
> (such as irq, softirq, and workqueue), including runtime, latency,
> and timehist, using the infrastructure in the perf tools to allow
> tracing extra targets.
> 
> This is the first commit to reuse perf_record framework code to
> implement a simple record function, kwork is not supported currently.

So, since I have to fix some issues I'm adding small stylistic changes,
starting with this:


- multiline if/for blocks need {}

- remove needless spaces between variable declaration + initialization.

- Arnaldo

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f3552c56ede3c501..bfa5c53f1273c631 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -49,9 +49,10 @@ static void setup_event_list(struct perf_kwork *kwork,
 				break;
 			}
 		}
-		if (i == KWORK_CLASS_MAX)
+		if (i == KWORK_CLASS_MAX) {
 			usage_with_options_msg(usage_msg, options,
 					       "Unknown --event key: `%s'", tok);
+		}
 	}
 	free(str);
 
@@ -59,10 +60,12 @@ static void setup_event_list(struct perf_kwork *kwork,
 	/*
 	 * config all kwork events if not specified
 	 */
-	if (list_empty(&kwork->class_list))
-		for (i = 0; i < KWORK_CLASS_MAX; i++)
+	if (list_empty(&kwork->class_list)) {
+		for (i = 0; i < KWORK_CLASS_MAX; i++) {
 			list_add_tail(&kwork_class_supported_list[i]->list,
 				      &kwork->class_list);
+		}
+	}
 
 	pr_debug("Config event list:");
 	list_for_each_entry(class, &kwork->class_list, list)
@@ -125,7 +128,6 @@ int cmd_kwork(int argc, const char **argv)
 		.force               = false,
 		.event_list_str      = NULL,
 	};
-
 	const struct option kwork_options[] = {
 	OPT_INCR('v', "verbose", &verbose,
 		 "be more verbose (show symbol address, etc)"),
