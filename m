Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4454D4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350409AbiFOWu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbiFOWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:50:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62F5639B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:50:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i64so12712779pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZARD2x9eyZCfZ+dfh8M5Up8qD+yjJUJ9LiMSuxfBxc=;
        b=Wdp8mX+AR4ZI/kD3Vg8QMEIVmxFDmiI0nCE1j53DTe8civ2SPRVmf5GxqWZAlwsyms
         pizsy28ib0PLBfaVK802MueQHaccUnBGFKFJW4z8Ocm1qolB4HDuPp9GyGie4KPz2E8T
         R9o8yvCI3csyeCXJ5cMX+ynSPp6SoRiAnE1xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZARD2x9eyZCfZ+dfh8M5Up8qD+yjJUJ9LiMSuxfBxc=;
        b=p40si3gj/XVEnJ6q0jH5Uxe95cWeo3j8UoiAVjIuQnThp5yI+QET95nwG3xVe2YGDd
         INqWlMJ+8nMyAawGR3IQDPE58dKBiJy5wrsmfuBQ/jUMCJTlRTvqr0tQ8Sv1VCuxXqo3
         U9+6hT1oQdd3ZZhwMJCn2g94VV8HLXLANDef5LmYHhd94J/+p2RDCGO0yqpT2WHQ6vTL
         K0rbhe+24qJSvwfRl/6KM4QVQBSPGXNDPUoFRwQqFdgc6ugzjHqSsie7E16ThEyYju8S
         MTNc5EhvNUnEPcgs5w9J0hb++bOHSDyq7Blc725nhfA6ZMaWYMMaL7m8SHt0gZfTFI2D
         g0cA==
X-Gm-Message-State: AJIora/S2EaAihRdRigmN6AUROtc4IU22uSGA7SlR2k8UOh3UQQ7U9Q+
        1XoGq0cHbgPZwcwsz9fbIgsS7Q==
X-Google-Smtp-Source: AGRyM1tGVOD1GtPWD2tbra8HbW1Im7OvjyBC8ay7TuKXFTeOXbBqDacgQPiqzfvBAk5iNHcRuKtekA==
X-Received: by 2002:a05:6a00:4515:b0:522:cc82:79d2 with SMTP id cw21-20020a056a00451500b00522cc8279d2mr1681189pfb.61.1655333451924;
        Wed, 15 Jun 2022 15:50:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:6db4:3c00:379:4cf6])
        by smtp.gmail.com with UTF8SMTPSA id h189-20020a62dec6000000b0050dc762813csm177651pfg.22.2022.06.15.15.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:50:51 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 1/3] LSM: SafeSetID: fix userns bug in selftest
Date:   Wed, 15 Jun 2022 15:50:44 -0700
Message-Id: <20220615225044.706911-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure how this bug got in here but its been there since the original
merge. I think I tested the code on a system that wouldn't let me
clone() with CLONE_NEWUSER flag set so had to comment out these
test_userns invocations.

Trying to map UID 0 inside the userns to UID 0 outside will never work,
even with CAP_SETUID. The code is supposed to test whether we can map
UID 0 in the userns to the UID of the parent process (the one with
CAP_SETUID that is writing the /proc/[pid]/uid_map file).

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 tools/testing/selftests/safesetid/safesetid-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 4b809c93ba36..111dcbcc0491 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -194,7 +194,7 @@ static bool test_userns(bool expect_success)
 			printf("preparing file name string failed");
 			return false;
 		}
-		success = write_file(map_file_name, "0 0 1", uid);
+		success = write_file(map_file_name, "0 %d 1", uid);
 		return success == expect_success;
 	}
 
-- 
2.36.1.476.g0c4daa206d-goog

