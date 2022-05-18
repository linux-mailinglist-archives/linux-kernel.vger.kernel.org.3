Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81352B56C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiERIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiERIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:45:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277E133277;
        Wed, 18 May 2022 01:45:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k30so1650804wrd.5;
        Wed, 18 May 2022 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cajtq/WCCYY+Uzv177x/wTfPz35hSuCd8u3Ec2e4AOQ=;
        b=aHTdStFe5NRbSQREHiQSU+A6Q7nqKkqfDryBo32bfI2egWwMPE0X3YHRWU9Kjrmxk+
         7MFCPuN24HBjFAKgkvcySKE7dAPrUYtYeqAj7NyFaSzjNqmnygt8YuqP+BeNryvLs1M0
         Oh2RU3o1tXXrye7A22ihl1SNcHD74N6fXtHIlEAKjLusGQx1V/MJOQA1QVXD4i+/n7rv
         2WoKzuKW72yUpasATnk9zqBPDl6pXC6ozrSAblkZMISNuCfxY1tWzdD4WzMogLGkxS3J
         0GVwlwnZNKoZ0vTwtgd0QyJYyiWulCqqhQKNM1pU+xFClwPETPxBfJVvYnR6KjlTjqaK
         wQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cajtq/WCCYY+Uzv177x/wTfPz35hSuCd8u3Ec2e4AOQ=;
        b=Twl97t+FLmyOq2zWzFtY2sRwqHmKXxHQz+dJv7cBi0cGP4/5caFMuUjff/ZguUVEGZ
         1xkHUmgOyitUblDtw/9VO4gTtGgyCPw0WuFEsU8dUN9RtQ5y0OTx2gEm6dBENnCCEBzZ
         HKIUGHUFiYl5P1labVqxB+lNb0N+BzWPNRRxyrrsh0nPX87isk0+C2iqzmhXto6ZysRI
         I8LphDrYUK4GS7MydkiggDz2v2VFj4CzCG4gItLUHAmUQNvuDnm9CrhDtVEoMyydPoG4
         hBeHh2dPZJ+O8zIpcRjEePbumCaR3GP05wik76mYC1a3HyOt+UQAmCXKK/k8dbiisdf7
         dsAA==
X-Gm-Message-State: AOAM531Y88KsUooUSSUtEbbr8bDFSks3q1jL9nxNOoPh503lasoaiWNp
        wAT4oQ2XO9VN6hf9uOBJZGE=
X-Google-Smtp-Source: ABdhPJy+jzxaUQm1PdxdFGCsAK/RXRQls9XoisZOu97pRzrOPADdNoGvXXMtH5aa16qydr9vPPjWPQ==
X-Received: by 2002:a05:6000:2a2:b0:20c:734f:d38a with SMTP id l2-20020a05600002a200b0020c734fd38amr22705633wry.417.1652863538304;
        Wed, 18 May 2022 01:45:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d28-20020adfa41c000000b0020e5b4ebaecsm1431579wra.4.2022.05.18.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:45:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: remove redundant store to value after multiply
Date:   Wed, 18 May 2022 09:45:36 +0100
Message-Id: <20220518084536.508514-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is no need to store the result of the multiply back to variable value
after the multiplication. The store is redundant, replace *= with just *.

Cleans up clang scan build warning:
warning: Although the value stored to 'value' is used in the enclosing
expression, the value is never actually read from 'value'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 83da499dd6ec..70e38278986d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1010,7 +1010,7 @@ static u64 rapl_compute_time_window_atom(struct rapl_package *rp, u64 value,
 	 * where time_unit is default to 1 sec. Never 0.
 	 */
 	if (!to_raw)
-		return (value) ? value *= rp->time_unit : rp->time_unit;
+		return (value) ? value * rp->time_unit : rp->time_unit;
 
 	value = div64_u64(value, rp->time_unit);
 
-- 
2.36.1

