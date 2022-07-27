Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B8582346
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiG0Jh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiG0Jhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:37:51 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281D47BA0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:37:45 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2590E3F0ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658914664;
        bh=hILhH7/kC6Kccs7jjUf20npcM9l6uxbNnqr7pxtXMH8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=B+qIGBBtBzJ6obhiob11BqwfBd5/VxIa8s578Gq2cewITr1Y/+j1IuNUbsdIDmbvV
         FhSy278+3U8VBAZ8JOb0IOdxaUnsYKVd6pqvYZkPPVDbT33I9VYixprajE89rkTMju
         yp9YcjZ5LwLlSw+oo7/bWXSSh/r3IGgR1q+EtxpqkJ9etajzeaXlyBNQRjcNJj1nBm
         4KO7vIG2jmubU/zs60RmQzjE52U3NWsfp/xKJFCU56kuZxKWTqO6lcc7Sc8GKUFJvd
         oHPhup/8m80gOod7V2ytTH+Op5FTiekIZtKOpYh+tc6g5JgFUQpt7TNBu+J5L0EnYU
         HgyBle5k+UacA==
Received: by mail-ed1-f71.google.com with SMTP id o2-20020a056402438200b0043ccb3ed7dfso30647edc.22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hILhH7/kC6Kccs7jjUf20npcM9l6uxbNnqr7pxtXMH8=;
        b=M2W7lKYzctJZQb40kgiqbwqsOWtCmbo55imi/OLhfqfQhxVfkYRlU9NuXsD12j4OD/
         5b2EiqjgQZf7jdNK0CgL2MxpzA77l9HVfX1G7cOaEzkdNbqmjqDnqCHG6hzbSRw90ieD
         WVgjr9soV35G2vsO4MtkR2ZbbHUakopuRHBoX/ADBf8WKPh0tv4DXucnZLGqoxujZLjh
         AniHn3DJjjfdkammc7BB4DG5q0CMolaaX4afWIAhdtUsgkcs5GXLFhTeKPamjnL3ZY8s
         YQhKJ/faWI+OTTPz3oz20dlf/8wYO0Sd2eMG+S8DErSg/sBiwbyYQeBeN1TXR/0ROahU
         QbbQ==
X-Gm-Message-State: AJIora9fUZAVSZNPoJQeew51/LyJjslCyxhBTicVrJ0XT9dunp3P3bGO
        3QCKnIlrkDI+dMWMwVpWSIbpR4mYpRa9qBysPm6579KtF4MNg0NfGuAMKP4092Efmn1bS03QZXt
        gL0XM6E8FkDzbECta2NQ6RD8C/XaaDLYDGPLPS7pSmg==
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id n4-20020aa7c784000000b0043acaa875b9mr21256939eds.311.1658914663786;
        Wed, 27 Jul 2022 02:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLLbtz3ZSxyKsrW5QpuIdirXzcFPHDjvKcNtHAMHHwrM5te/71ixtY2CwMWYC9MbKlNZozJw==
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id n4-20020aa7c784000000b0043acaa875b9mr21256922eds.311.1658914663607;
        Wed, 27 Jul 2022 02:37:43 -0700 (PDT)
Received: from callisto.. (p579d80fd.dip0.t-ipconnect.de. [87.157.128.253])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090669c600b0072a815f569bsm7440928ejs.185.2022.07.27.02.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:37:43 -0700 (PDT)
From:   Kleber Sacilotto de Souza <kleber.souza@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Justin Iurman <justin.iurman@uliege.be>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] selftests: net: fix IOAM test skip return code
Date:   Wed, 27 Jul 2022 11:37:42 +0200
Message-Id: <20220727093742.115882-1-kleber.souza@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioam6.sh test script exits with an error code (1) when tests are
skipped due to lack of support from userspace/kernel or not enough
permissions. It should return the kselftests SKIP code instead.

Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
---
 tools/testing/selftests/net/ioam6.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index a2b9fad5a9a6..4ceb401da1bf 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -117,6 +117,8 @@
 #        | Schema Data         |                                     |
 #        +-----------------------------------------------------------+
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
 
 ################################################################################
 #                                                                              #
@@ -211,7 +213,7 @@ check_kernel_compatibility()
     echo "SKIP: kernel version probably too old, missing ioam support"
     ip link del veth0 2>/dev/null || true
     ip netns del ioam-tmp-node || true
-    exit 1
+    exit $ksft_skip
   fi
 
   ip -netns ioam-tmp-node route add db02::/64 encap ioam6 mode inline \
@@ -227,7 +229,7 @@ check_kernel_compatibility()
          "without CONFIG_IPV6_IOAM6_LWTUNNEL?"
     ip link del veth0 2>/dev/null || true
     ip netns del ioam-tmp-node || true
-    exit 1
+    exit $ksft_skip
   fi
 
   ip link del veth0 2>/dev/null || true
@@ -752,20 +754,20 @@ nfailed=0
 if [ "$(id -u)" -ne 0 ]
 then
   echo "SKIP: Need root privileges"
-  exit 1
+  exit $ksft_skip
 fi
 
 if [ ! -x "$(command -v ip)" ]
 then
   echo "SKIP: Could not run test without ip tool"
-  exit 1
+  exit $ksft_skip
 fi
 
 ip ioam &>/dev/null
 if [ $? = 1 ]
 then
   echo "SKIP: iproute2 too old, missing ioam command"
-  exit 1
+  exit $ksft_skip
 fi
 
 check_kernel_compatibility
-- 
2.34.1

