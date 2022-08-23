Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49DB59ED4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiHWU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiHWU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:28:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34980EBD;
        Tue, 23 Aug 2022 13:02:38 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10483540otb.6;
        Tue, 23 Aug 2022 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8bau2TXRrZKeJhPFcC8W9KtfZ4MQyFla4E+DjQSW6uE=;
        b=GbyDZvPOc3JMfcAJs2BH7uEB0W+WV4FmqW0rADnEGHo4+9DQjVYBNqTovBq9149WYB
         S7LpwRMV0gtEXvHrCwA6vjSABAZJMDPfnRp784RsgTRGh6CA/pKsmeJdyXzFJWxls7O2
         SNzml90+l7AkxIVDrgWIr3S0sWxjR3pxitJyzdlv84SsCUKzjVOX4Xw/vyJPiYNdtssi
         nj14NpNBxY+q5d1QDgtcx5gvbLaW6q+nnWzcbXwsEp1Th3jdwc3+0ApCCSUrTxJBerh0
         VYFuREjlbsCgpBg3WXJ5+fj0lqwJ8t8aQngC+/1opd1UR4p5kVipGO5LJDM+g7H8UJXX
         20Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8bau2TXRrZKeJhPFcC8W9KtfZ4MQyFla4E+DjQSW6uE=;
        b=19cNwk44E4iQfyW29HndYMyugwgqh69TJGas08MzbLK/nm2ynQYSLgtN/m6j+mu5xJ
         q++lv2NfhKSYOaKKOiDTzfOQw2j77vs/h6Il1jq9QziiDoIrZFPmEh1RwODggIz9zRdV
         QJ2pjxkh7OAlfAwtW9IIrKmJCssm0eA7k275a9gR340fVjb42opy+eSyQQrwoX8vJtTg
         /tJW78TDEYqGC2iR+R9Z5jlA+UiGooGy5att4+NKnzT7xidaFD19IGLB5NxTCuz1jE20
         GgVOhexp+33bFsIxQs+WOUrFQ9gTKbJ1FHo3hJT1oqk/DnbRJ88Pi0dXB0LEcDO512jW
         Luog==
X-Gm-Message-State: ACgBeo0p6j4ST9jwjC+LgLxiiDXvSqPpLg+Mpfiw2+22p7Tk6CHKXyU1
        oijk0t8IYzPNYaBL1mkwsBU=
X-Google-Smtp-Source: AA6agR5Gr6QSRj/ESdHOG1BM3JeEExT4UC/hG42YuHE35l0X2SrBP4Od61EPkzjWIRDYMZ4Z2d/MLA==
X-Received: by 2002:a05:6830:1e09:b0:638:8984:b49e with SMTP id s9-20020a0568301e0900b006388984b49emr10267108otr.368.1661284957410;
        Tue, 23 Aug 2022 13:02:37 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:4ca1:8e5f:8b29:974d])
        by smtp.gmail.com with ESMTPSA id u15-20020a056870d58f00b0010e046491f8sm4050216oao.57.2022.08.23.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:02:36 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: taint the kernel when of unittest runs
Date:   Tue, 23 Aug 2022 15:01:52 -0500
Message-Id: <20220823200152.3465751-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Frank Rowand <frank.rowand@sony.com>

Make OF unittest trigger the new TAINT_TEST taint when OF unittest runs.
Due to OF unittest not being intended to run on production systems, and
potentially causing problems (or security issues like leaking kernel
addresses), the kernel's state should not be considered safe for
production use after OF unittest runs.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Follow the precedent set by KUnit tests in v6.0-rc1:
  commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
  commit 2852ca7fba9f ("panic: Taint kernel if tests are run")

 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eafa8ffefbd0..4f8cc1b21ac4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3467,6 +3467,9 @@ static int __init of_unittest(void)
 
 	pr_info("start of unittest - you will see error messages\n");
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+
 	/* adding data for unittest */
 
 	if (IS_ENABLED(CONFIG_UML))
-- 
Frank Rowand <frank.rowand@sony.com>

