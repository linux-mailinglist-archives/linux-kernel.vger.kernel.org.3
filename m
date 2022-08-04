Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1858A003
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiHDRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiHDRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:46:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF101147C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659635189; x=1691171189;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=I5D1a4UZV44LwqUu3iIdrVtuXEKbxqsE2BElo/08fM4=;
  b=FIfV3sT4axISF95hCjIXLARi1ziTMFMi59877dNNd6z8aPa1d5DzscNH
   I2rbhrUthkl3/kB15zORRvleMSRy8Ts3k1zw//CCpU458w9Pf8k4w8zit
   GJEoNUB3aNWoRbQi/JAJtNm/ZZWjAZ29ryThQ3l/+LdrdgvP2YbZwqtAZ
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Aug 2022 10:46:28 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 10:46:28 -0700
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 4 Aug 2022 10:46:28 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH] scripts/clang-tools: Remove DeprecatedOrUnsafeBufferHandling check
Date:   Thu, 4 Aug 2022 10:46:14 -0700
Message-ID: <1659635174-2376-1-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This `clang-analyzer` check flags the use of memset(), suggesting a more
secure version of the API, such as memset_s(), which does not exist in
the kernel:

  warning: Call to function 'memset' is insecure as it does not provide
  security checks introduced in the C11 standard. Replace with analogous
  functions that support length arguments or provides boundary checks such
  as 'memset_s' in case of C11
  [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 scripts/clang-tools/run-clang-tools.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index f754415a..1337ced 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -51,6 +51,7 @@ def run_analysis(entry):
         checks += "linuxkernel-*"
     else:
         checks += "clang-analyzer-*"
+        checks += ",-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
     p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
-- 
2.7.4

