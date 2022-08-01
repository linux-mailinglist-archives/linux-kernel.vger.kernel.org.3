Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB963586B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiHAMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiHAMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:51:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E462A737
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:46:29 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C63243F138
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659357985;
        bh=3bPb0dad/oOvrex03/AgLvrUL+bomAiOTjep52WTUPk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=UnE1cfkNWUEbS3jSIaEO3tTKJ6WAA7/n7ol/gjyFm/Carz7srhCAnh9a7DdlmF7K0
         h2Pm8OOBsoY3+sJhXqsaBRUY7csKDJYma07UhU8TlN0efjfWGqMxCXqEzkcLfGny53
         59vZwy8+EYpj2S3H8CCROD4fIAADBAyv5mmEkIE9fTu8h9YYS2/7R1UnG1aIUe6Odh
         qWVAbM2LvGuMVy4PgaHKE3z+W3rR2UfSUE9EoijpjmzqCDe8dwuB5x1H2cNqPdrIKU
         yQNyyLz+XVUdZQu4n6CyBdC6r/ypP/y6oiBndKfnH66J0tgST8/gHTw+QcbFcQcABA
         z5/rU8RRzMVUw==
Received: by mail-ed1-f69.google.com with SMTP id m22-20020a056402431600b0043d6a88130aso2828774edc.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bPb0dad/oOvrex03/AgLvrUL+bomAiOTjep52WTUPk=;
        b=0jHgVFK/241jbr6zl67jEAyaw9t9VUfE22tQmf2IJZHx9yJXmc2oCDfMQkkLIqHM5n
         rz/fyZf1hTLgd2mt3a0BZYXZ85vZVdr29KtxuGzA0IayD4pGP/TxhSIFt+JaNku9cBgw
         K/Ykt5kRGLBy1WlOBzzXp3XgxAfSwcOwbONF2ImwGotAb5GJQeisTNbLwev4QS8+NtMT
         /HcY3L8bKI4x5GdMixmvYnakgfZ5vA+ddkFvv7Q8bC2xhATrDDcWWqcejsI0TRFFDM4a
         GGhvxi6Ient5MCYX18PhC+QwgDmssgjr2UtugvH3RXax/JGk7r0uAivmaFeMlRDUTt0b
         Us2w==
X-Gm-Message-State: AJIora/uxyB3NLRjRD2YikbmYKEhfVihSLomzwkNOeM0pJ2qsO6QTwhB
        qOMv5VfvUe3pdohlNcPmIwOLGHpKV5uWje3C7AFZ3ghv3BIXo6RmStSI1nE19UF26PswEmrgUfa
        s51ravshnh3T9CBQsZhK9FXxsCk0JL8HdiJnG5ofeDQ==
X-Received: by 2002:a17:907:1b09:b0:72f:d49e:6924 with SMTP id mp9-20020a1709071b0900b0072fd49e6924mr12342236ejc.15.1659357983395;
        Mon, 01 Aug 2022 05:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1siAb2whtG2DzEO1CK9FWYk3yYciUFIkpJRrwW0nZ4E8RV1QembUa/rlHkpipXv6aQPvEOryg==
X-Received: by 2002:a17:907:1b09:b0:72f:d49e:6924 with SMTP id mp9-20020a1709071b0900b0072fd49e6924mr12342227ejc.15.1659357983161;
        Mon, 01 Aug 2022 05:46:23 -0700 (PDT)
Received: from localhost.localdomain (p579d80fd.dip0.t-ipconnect.de. [87.157.128.253])
        by smtp.gmail.com with ESMTPSA id ay24-20020a056402203800b0043d3e06519fsm4393386edb.57.2022.08.01.05.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:46:22 -0700 (PDT)
From:   Kleber Sacilotto de Souza <kleber.souza@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Justin Iurman <justin.iurman@uliege.be>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>
Subject: [RESEND PATCH] selftests: net: fix IOAM test skip return code
Date:   Mon,  1 Aug 2022 14:46:15 +0200
Message-Id: <20220801124615.256416-1-kleber.souza@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioam6.sh test script exits with an error code (1) when tests are
skipped due to lack of support from userspace/kernel or not enough
permissions. It should return the kselftests SKIP code instead.

Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
---

Notes:
    - Reposting to CC netdev@
    - Keeping Justin's Review tag from the original post

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

