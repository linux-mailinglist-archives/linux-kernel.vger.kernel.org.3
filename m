Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B95450FEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350129AbiDZNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbiDZNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:19:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E889232A;
        Tue, 26 Apr 2022 06:16:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so19152286wrh.7;
        Tue, 26 Apr 2022 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRODyzlBTk01xvrOEks740Gzbq9VjDsaK05Mtw4QOdU=;
        b=LkeeL3FcpVQHWGI4HG20tlBjq2GniD6HYqV+WWnn/V1HI7fUuchcwZqYj9rSfIBGyw
         8Rzu/oxzUwMhZeGuG/B//W9XeA4L4Iw23ar+pBMj22HqAws5J0z9AT4UvTFyLyel+lbt
         WvCU5G8IqHv9RP8mCuperVGqWyRjCu0r+Vx/pBIC0WPc9sTuQkvppcdDA/9LrPDE+BLj
         eqkfdCHIgrtLJww7kJHM2nAjMVYxH2+oYxSQIyp/vAZVhnH+5WqWNzz3FDQOS7zTipx4
         3YNQ+X5zEsUafrlVLZ96beo7D4sFAUfBgtTQrgL9cidnD0bBksiZnQD8Yzz33fRy8oDg
         A9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRODyzlBTk01xvrOEks740Gzbq9VjDsaK05Mtw4QOdU=;
        b=DUPjwu4FuLqSR01mZWymiuTrsgaQkKVbpMyw5J4O4z/YrGTZX1klqLi15vPIJgoytq
         sNvxOAuVL0N5UXw/ocbQzzaOAWRxaQ33Yh/E7y/7A+wSl7/iN+8JK9yajD4ra/qNx76g
         v3cQrb8tgyuYWygj5X2ZoFgt3DOWkhWsj15OAQaCDq33lq/tAjzxzA+MGYuRPBEKmTG2
         UGH6RZLcbTozuf1xVv/TZiFAcuZdkeU5AtPAtVjBNUUlA6IOKzRk2CywsXmCHv6TXY2u
         1RBmNXfxJxp9ql5hPv7EoGs8D64ORD2xu6WosEksfh9clyz8A9NWt/0TOWgRrsxBUQVr
         oepQ==
X-Gm-Message-State: AOAM533T09nk5SvPwC2aRnIUtMxModfpQHTvNudXkV6i137gTTr1nnzM
        ANW+MEwxUVk8VGb1T5Hc+L74lNkxZ2Ceiw==
X-Google-Smtp-Source: ABdhPJyb+06Sy+02im/xCvRnlgxLNVxjDn0E6dnwv0XselqjlFHkvP5mN41L7ogSN49wEZx7yHgQtw==
X-Received: by 2002:a05:6000:86:b0:20a:d7be:e09b with SMTP id m6-20020a056000008600b0020ad7bee09bmr10430910wrx.398.1650978968341;
        Tue, 26 Apr 2022 06:16:08 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm14723968wmb.48.2022.04.26.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:16:07 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Fix file pointer leak
Date:   Tue, 26 Apr 2022 14:16:07 +0100
Message-Id: <20220426131607.1520483-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if a fscanf fails then an early return leaks an open
file pointer. Fix this by fclosing the file before the return.
Detected using static analysis with cppcheck:

tools/power/x86/turbostat/turbostat.c:2039:3: error: Resource leak: fp [resourceLeak]

Fixes: eae97e053fe3 ("tools/power turbostat: Support thermal throttle count print")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e6779f599a8e..db431b31c4df 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2035,9 +2035,9 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
 	if (!fp)
 		return -1;
 	ret = fscanf(fp, "%lld", &tmp);
+	fclose(fp);
 	if (ret != 1)
 		return -1;
-	fclose(fp);
 	*cnt = tmp;
 
 	return 0;
-- 
2.35.1

