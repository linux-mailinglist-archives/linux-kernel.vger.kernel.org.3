Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26358C584
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiHHJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiHHJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:27:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B713F15;
        Mon,  8 Aug 2022 02:27:06 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M1W3b1YWPz1M8bN;
        Mon,  8 Aug 2022 17:23:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 17:27:03 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 17:27:03 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/2] perf kvm: Fix subcommand matching error
Date:   Mon, 8 Aug 2022 17:24:07 +0800
Message-ID: <20220808092408.107399-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220808092408.107399-1-yangjihong1@huawei.com>
References: <20220808092408.107399-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, diff, top, buildid-list and stat use strncmp to match subcommands.
As a result, matching does not meet expectation.

For example:
  # perf kvm diff1234
  # Event 'cycles'
  #
  # Baseline  Delta Abs  Shared Object  Symbol
  # ........  .........  .............  ......
  #

  # Event 'dummy:HG'
  #
  # Baseline  Delta Abs  Shared Object  Symbol
  # ........  .........  .............  ......
  #
  # echo $?
  0
  #

Invalid information should be returned, but success is actually returned.

Solution: Use strstarts to match subcommands.

After:
  # perf kvm diff1234

   Usage: perf kvm [<options>] {top|record|report|diff|buildid-list|stat}

      -i, --input <file>    Input file name
      -o, --output <file>   Output file name
      -v, --verbose         be more verbose (show counter open errors, etc)
          --guest           Collect guest os data
          --guest-code      Guest code can be found in hypervisor process
          --guestkallsyms <file>
                            file saving guest os /proc/kallsyms
          --guestmodules <file>
                            file saving guest os /proc/modules
          --guestmount <directory>
                            guest mount directory under which every guest os instance has a subdir
          --guestvmlinux <file>
                            file saving guest os vmlinux
          --host            Collect host os data

  # echo $?
  129
  #

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 3696ae97f149..7d9ec1bac1a2 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1638,14 +1638,14 @@ int cmd_kvm(int argc, const char **argv)
 		return __cmd_record(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
 		return __cmd_report(file_name, argc, argv);
-	else if (!strncmp(argv[0], "diff", 4))
+	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
 		return cmd_diff(argc, argv);
-	else if (!strncmp(argv[0], "top", 3))
+	else if (!strcmp(argv[0], "top"))
 		return cmd_top(argc, argv);
-	else if (!strncmp(argv[0], "buildid-list", 12))
+	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
 		return __cmd_buildid_list(file_name, argc, argv);
 #ifdef HAVE_KVM_STAT_SUPPORT
-	else if (!strncmp(argv[0], "stat", 4))
+	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
 		return kvm_cmd_stat(file_name, argc, argv);
 #endif
 	else
-- 
2.30.GIT

