Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF364DBA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358159AbiCPVdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358166AbiCPVco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:32:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310F2AE2F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e5a3c1384cso24935267b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DuIs8YDVZ+FUMK/eJrsH1Ol6kQ1ErHXTTPKm8dwtCDY=;
        b=qFM55vPPyVaTFZa6kKJVrPMllDMUjRNpqwlMmOmDcPlqGqlZnRgFm90OQ/CO08cIMI
         ozQ/bQaFkgY6tBLchUOHwG5cpuV7XQUp3DlFqSxMoJeo9HYsXFotdyInje2ISR96cYQN
         LM45pBenpgqvAz7wiBXGrQYNTwXSy3N/8foxmJA9QcViS2Q9E6oQbYNGbEyzrl3kPKe5
         Vdth5nPe7IUQq+DLP6KJoLdgGYAdZGyuoOQivb0qDhbjrTGKvlrUlVSe4MOpDj6YjYSZ
         sglDm0vtSzTiuyLqNmx0vUupCP0818ajsmD+wSomc8LH3tydX+mZ9Y7CoJJyg/Og5Y/P
         i6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DuIs8YDVZ+FUMK/eJrsH1Ol6kQ1ErHXTTPKm8dwtCDY=;
        b=26TL2v7eTDIiyhrItR/qyghCtW/963OjvWypf7kzjoimq2RmbADSqgTB8e7N4fXvEA
         7VlKXFHBIeld6mClK5YL0d3At2E0QyUjbuwS3MAo3SyDuZj6beSe1aVmdUhvuB+sjZVj
         4nL5k+I4ZwpEXF3uP4FJsbdl9BUpN74WBbqoyMqN0tnZExykhQt4nKDrITIv3tzozG8A
         FzwciKAOcOPVB3V3C1gxlC6YZnqJPU8I6+SqYONvExtOrUZ+/AxH083gonz9LsNIdAAZ
         0gxKmDSqn3XCR+p18I8BlLaVmZ1lG6RHhm7t96qQFsP8wFaNUt9dG/xri8KIXYV+wcaB
         3FjA==
X-Gm-Message-State: AOAM530JL3rspRZ6z7xEQb4TLFd/lgL3na4CyZQOBX+1fFHeVRSnf5p2
        M/XfSOhU0xjIgF45nufculwiutOo
X-Google-Smtp-Source: ABdhPJxlpI62VPESYGOV1YEH34zeiz353mKPg634ySFjExFhciP8pMKE9Jokvx3Dw4zKp9xShXZvESy+gQ==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:7dae:6503:2272:5cd1])
 (user=morbo job=sendgmr) by 2002:a0d:d50f:0:b0:2e5:bada:3948 with SMTP id
 x15-20020a0dd50f000000b002e5bada3948mr939764ywd.314.1647466281406; Wed, 16
 Mar 2022 14:31:21 -0700 (PDT)
Date:   Wed, 16 Mar 2022 14:31:18 -0700
Message-Id: <20220316213118.2352683-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] soc: qcom: smem: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang emits the following warnings:

drivers/soc/qcom/smem.c:847:41: warning: format specifies type 'unsigned
short' but the argument has type 'unsigned int' [-Wformat]
                        dev_err(smem->dev, "bad host %hu\n", remote_host);
                                                     ~~~     ^~~~~~~~~~~
                                                     %u
./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
        dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                               ~~~     ^~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
drivers/soc/qcom/smem.c:852:47: warning: format specifies type 'unsigned
short' but the argument has type 'unsigned int' [-Wformat]
                        dev_err(smem->dev, "duplicate host %hu\n", remote_host);
                                                           ~~~     ^~~~~~~~~~~
                                                           %u
./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
        dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                               ~~~     ^~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~

The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for ints and unsigned
ints.

Link: ClangBuiltLinux/linux#378
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/soc/qcom/smem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e2057d8f1eff..a98b5f395d15 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -844,12 +844,12 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 			continue;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
-			dev_err(smem->dev, "bad host %hu\n", remote_host);
+			dev_err(smem->dev, "bad host %u\n", remote_host);
 			return -EINVAL;
 		}
 
 		if (smem->partitions[remote_host]) {
-			dev_err(smem->dev, "duplicate host %hu\n", remote_host);
+			dev_err(smem->dev, "duplicate host %u\n", remote_host);
 			return -EINVAL;
 		}
 
-- 
2.35.1.723.g4982287a31-goog

