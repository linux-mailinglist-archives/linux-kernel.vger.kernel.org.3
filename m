Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF0570E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiGLACB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGLAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:01:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744222CDF4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:01:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c936387fbso56362037b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UbrLjyWpKURQ7kneERVRt0vmSfJ+MsRa3+RTDwDzOxA=;
        b=jdWIDsW9ls7D7eFnaJ5VssudCChz11UFAzuZQnxj08R1Z9BiucUqCJcVSh5MVFtunZ
         L4MylUfu6alwXORkkAo1DszTi9QfNzAm42cOQegYHAjN/q1amRTV+8R7BIdQo8A4SSon
         36jRzbUdC2AnH5qSgAslRoGRgZ4eseqM31OJhjacC2A0TzAuFIn78BaYEf0etG9MYVIE
         hDshcWnkoH9H5L8TBlJNL7KYyfbZEx2wvMYh96KoWIOEnc/NV5NjsjCmVeOhFUSpi44s
         BjopRFaRdmOAMzR86n0mPPiJxcEDhh51Dvnlbw6UcrrH833gdBMRnaou5wf1bmFFzYiE
         5hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UbrLjyWpKURQ7kneERVRt0vmSfJ+MsRa3+RTDwDzOxA=;
        b=Fr6FUZ8+N6mk/6AJdhEMcp8i8GgKieVhBvAQk7q1RxaeBY3cq5JfCmsaeJO1FPv+2o
         ijUy1om5ROfxqxpjqO8P3oNJ7VNBFH1xbT/tGFdCWT0rfVkqMmn7/OWtefimZLBZ8S6D
         /nGtlM5BLCb9cuLBxIV08C+8cGD/ucBw/bq5aH3NBeh0RsRiROZISifmWvKCDlVH4uoo
         mhNG0ZNLK1r2AMT80omFpIRcs0wNUXtQUlgA4U7asHSkY3gumFbYx2t2x3cKyuUiIaQ9
         hzWqsRVwd7cMWFJLrVrXWdqK/O0nzDtcsuLsxuRehCWaF6YmGe0BcCUtKF7Fl/nND+xa
         62dw==
X-Gm-Message-State: AJIora9Q0eT2KCQPCHeW8VPabuzYSa3FVK13VQRvN/bMsPLC4CTXEFX2
        vY44IaSs9qKCFgl4SthFMR9U3eg215Hv08fciQ==
X-Google-Smtp-Source: AGRyM1vhb3Soxi/cqk9BCGRX6HlpYhwrheWS5s0NH23TJeWILjzFPIzs7xMTniM2mVE0SHcCCGoRb7agVcrJWq3stw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:4bd0:f760:5332:9f1c])
 (user=justinstitt job=sendgmr) by 2002:a25:e7d8:0:b0:66f:5d93:d750 with SMTP
 id e207-20020a25e7d8000000b0066f5d93d750mr4234302ybh.216.1657584115692; Mon,
 11 Jul 2022 17:01:55 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:01:52 -0700
Message-Id: <20220712000152.2292031-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] nfp: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Stitt <justinstitt@google.com>,
        Fei Qin <fei.qin@corigine.com>, Yu Xiao <yu.xiao@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Leon Romanovsky <leon@kernel.org>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter these warnings:
| drivers/net/ethernet/netronome/nfp/nfp_app.c:233:99: error: format
| specifies type 'unsigned char' but the argument has underlying type
| 'unsigned int' [-Werror,-Wformat] nfp_err(pf->cpp, "unknown FW app ID
| 0x%02hhx, driver too old or support for FW not built in\n", id);
-
| drivers/net/ethernet/netronome/nfp/nfp_main.c:396:11: error: format
| specifies type 'unsigned char' but the argument has type 'int'
| [-Werror,-Wformat] serial, interface >> 8, interface & 0xff);

Correct format specifier for `id` is `%x` since the default type for the
`nfp_app_id` enum is `unsigned int`. The second warning is also solved
by using the `%x` format specifier as the expressions involving
`interface` are implicity promoted to integers (%x is used to maintain
hexadecimal representation).

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_app.c  | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_app.c b/drivers/net/ethernet/netronome/nfp/nfp_app.c
index 09f250e74dfa..bb3f46c74f77 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_app.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_app.c
@@ -230,7 +230,7 @@ struct nfp_app *nfp_app_alloc(struct nfp_pf *pf, enum nfp_app_id id)
 	struct nfp_app *app;
 
 	if (id >= ARRAY_SIZE(apps) || !apps[id]) {
-		nfp_err(pf->cpp, "unknown FW app ID 0x%02hhx, driver too old or support for FW not built in\n", id);
+		nfp_err(pf->cpp, "unknown FW app ID 0x%02x, driver too old or support for FW not built in\n", id);
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 4f88d17536c3..43b9e75a34a5 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -392,7 +392,7 @@ nfp_net_fw_find(struct pci_dev *pdev, struct nfp_pf *pf)
 	/* First try to find a firmware image specific for this device */
 	interface = nfp_cpp_interface(pf->cpp);
 	nfp_cpp_serial(pf->cpp, &serial);
-	sprintf(fw_name, "netronome/serial-%pMF-%02hhx-%02hhx.nffw",
+	sprintf(fw_name, "netronome/serial-%pMF-%02x-%02x.nffw",
 		serial, interface >> 8, interface & 0xff);
 	fw = nfp_net_fw_request(pdev, pf, fw_name);
 	if (fw)
-- 
2.37.0.144.g8ac04bfd2-goog

