Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8705A2038
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiHZFQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiHZFQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:16:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B752468
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:16:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r22so449503pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PdzAck8H6TTellhEIC00YbxrxMoIOkkFKnJpRC4ha9o=;
        b=Upu2hz6KsiZui2GhlxlMKDnE23aqRUTR7laNVCIDqhR4NR10aTiV3JFYpvHS3kh6bH
         EkBj+ITddoCvf+BBiD65urTHi3YqiE/Ye2nTnPrr6JoS2ra1XKsIEyNM2w5WMeNi9tDU
         S5IQyXUJFtTGhP8VpeALtiMovckdTETj0c4nHHHPIQkx3dp4BrM7Yyp02MlF/e49viaQ
         3n1DuYAO1wAaX4YM+Uc0RUuarj7etUO3uyoi8V/JeVgeEe1mSIl8yxj18KRoj4ithBH4
         EF5N248Ilym0a4sNBCIbykFdgC0+oIZlvZ7LuLgkcqn4Lgp5GAi6VpZJabIirw4f7n35
         +3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PdzAck8H6TTellhEIC00YbxrxMoIOkkFKnJpRC4ha9o=;
        b=2VogLBV0AFvAYIgmMPtuUbbAygXAZQTqVDDUfhXdRIQ1dy6NHIxL8clVVIf0Vh9pC5
         oVMl8/F257j8T93PVYFpdNXPMmCWI3TdM/gTwTpjo5E+CBfg8s+8u2P/v6lB1P8C5tks
         nKnjQakWUdn3Q2k1sP2ZpMq1mxgxbS2PFWNJQKQ+2vj4eg7soN/S35N3zNjyDPMJoCrc
         ZDP+BAN2qW7fRC8VCh3UFnmr60vLmd+HLmoO1tzUdOic5qx7wGgouBJ+OwcEUg5OHXaU
         ovTrba6ZyVUwu75Aoq3TKQSDVW+9Gymt40dJ/6rMjOGbp0mFVkgTgGdSX6xGry0PTUFn
         wMtA==
X-Gm-Message-State: ACgBeo1erw9aEXz3LYyMWErqfabyqxdOKnd0tWtHswUCk2XRz7/iZ+PM
        42Zrwp7HeZxInsHt8NR//skkAQ==
X-Google-Smtp-Source: AA6agR5ly+Fty/T/+GmNjsVJ6J5APSrNGr24N2jQIK+bRlE2Xnn0tvKE2Ol7fIzOR6zonNV+vC/vsA==
X-Received: by 2002:a63:6a05:0:b0:42a:3b5d:8084 with SMTP id f5-20020a636a05000000b0042a3b5d8084mr1933159pgc.281.1661490970369;
        Thu, 25 Aug 2022 22:16:10 -0700 (PDT)
Received: from localhost (n058152048222.netvigator.com. [58.152.48.222])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0016a6caacaefsm505705plf.103.2022.08.25.22.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 22:16:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ali Saidi <alisaidi@amazon.com>, Leo Yan <leo.yan@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH RESEND v6] perf: Add SNOOP_PEER flag to perf mem data struct
Date:   Fri, 26 Aug 2022 13:16:03 +0800
Message-Id: <20220826051603.174792-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ali Saidi <alisaidi@amazon.com>

Add a flag to the perf mem data struct to signal that a request caused a
cache-to-cache transfer of a line from a peer of the requestor and
wasn't sourced from a lower cache level.  The line being moved from one
peer cache to another has latency and performance implications. On Arm64
Neoverse systems the data source can indicate a cache-to-cache transfer
but not if the line is dirty or clean, so instead of overloading HITM
define a new flag that indicates this type of transfer.

Update notes:

This patch is to sync the headers between kernel and user space, commit
2e21bcf0514a ("perf tools: Sync addition of PERF_MEM_SNOOPX_PEER") for
updating kernel header has been merged in the mainline code.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
---
 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 03b370062741..581ed4bdc062 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1313,7 +1313,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.34.1

