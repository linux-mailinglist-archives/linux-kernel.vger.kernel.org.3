Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538904E2F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiCURur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiCURuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:50:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE6A1CFF1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:49:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so130923137b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EfaFOAjTPM5RAgOXYIyeEo3JBWHCWxVtr2STLBqFs7s=;
        b=XezFlHzxJB2Eg24lT23dIi1UOjH1SC9rD0AzLHQc2tEXmBwhaht9zUDBLON/lvPCV5
         1Fil2ITDxsCx+153W6MRIKG+umsGpiiTtrYdo/8ZyKWAo46J2d+bahS1RLgek8hSC5II
         o2ZCDXsnbEykSiI56nnXDAlXYMojAtIhDCFEj2q5sYXVBewtjVbi/en0173Y+6ColLQj
         tofapO3SyQtYiF7Wu9go37pUalfBIrD1sxIv9WFQsjNQflLO6iiwKmpo+YdbkTW5N/su
         vvQ8zjGqb63uA+vmD7NDG0fG5Mq3/PH1q4r+YMCr3FBln0C55ceInba9U9VUyapfDVCh
         xHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EfaFOAjTPM5RAgOXYIyeEo3JBWHCWxVtr2STLBqFs7s=;
        b=Rhbd6i3ytYuusAKLSY8XuniBJ8rcBrU2wXA5pKFF1HdFxHfVaw99n2ltuwkd9bCYqp
         ZW/5JmDI9d87uiBp25hJY8rkiJVxi5cIYz3grvHJSZ0OwMvn0Yt6/zF0OSArer7fezCG
         hYvStyMiCgfjYS80lh/pVyvd7zbw/21eP9Yln30N+fsSKmNtfNxhjY5rjeEt4/l3CczN
         uvPPjEu0ydrU6081Jt3jsGvrIcH8nHEc0ifZsQpEXlysg3eNYSMtx5eyMsRud4CQygTP
         glUyIgkJcjnA7NJuFaAsYMLpYHCFCiMosUIBRIridAnBsvH4O46ELFHKkjIQvB0NQrjF
         QUIA==
X-Gm-Message-State: AOAM533j/VeQQuMEXcdzjyjn0xABy34NaTDhJmVR0JFZAuJt6W5JyDyT
        ZNMhhnP939ITTpWLSfui69eV5UGu
X-Google-Smtp-Source: ABdhPJzXwGBbgCHT+vdwAS30l2sFHl+TVGAD3H33rlJfbVU9f5mzjAhSlqZjPldQ38H+fdwgEfRJ+m69AQ==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:27bd:2eea:bd8:2ea5])
 (user=morbo job=sendgmr) by 2002:a25:2043:0:b0:633:6cee:4aee with SMTP id
 g64-20020a252043000000b006336cee4aeemr22966645ybg.628.1647884957542; Mon, 21
 Mar 2022 10:49:17 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:49:12 -0700
In-Reply-To: <20220316213118.2352683-1-morbo@google.com>
Message-Id: <20220321174912.164113-1-morbo@google.com>
Mime-Version: 1.0
References: <20220316213118.2352683-1-morbo@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
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
        autolearn=ham autolearn_force=no version=3.4.6
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
updates the format character to the correct one and change type of
remote_host to "u16" to match with other types.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/soc/qcom/smem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e2057d8f1eff..9dd325df5682 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -819,7 +819,7 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
-	unsigned int remote_host;
+	u16 remote_host;
 	u16 host0, host1;
 	int i;
 
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
2.35.1.894.gb6a874cedc-goog

