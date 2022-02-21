Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8C4BD425
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbiBUDXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiBUDXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:23:11 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111511FA7A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:22:49 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a19so28633925qvm.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QwOZbHpajeyz0p06fb10Ujh/XEXPgXF6n8U5+LgZSc=;
        b=e92Xw27J/Uhex0kT07/57dXDN0318JPh2Bv1uXlLmXdi30E6Iqhs736jLTL5yX0hsQ
         9odI0B1g1h77BNnS6I9IblmGk2jOwo3ehSKOb0R5p2tkuGkWX1FEj44d70xtJtjCBXlr
         MbRKx5pbgPUz3vWaAegNW+QPR7n2qhlbdd86mNUPcjGYoctwWbeBU8B17yBqnQzvajBK
         gfvsI0nI6r/7B6/VePvmBQZs3mlJ/a11FoiWfd39EW3/28hftsS6qS2+ryxhNvHE9T9j
         kdiFen+sXxBZnT3WDHDwAKBSEd4328mDoKUCHS046JitW7kNOp6h8Mj+kAJ0VSwKhiCw
         VBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QwOZbHpajeyz0p06fb10Ujh/XEXPgXF6n8U5+LgZSc=;
        b=tHNtnrZCPW2QKczmb80sJAOIcMbWVltLJNJpgTOkEmg4qFFQT39NpBjp+As0CVhJZ4
         WXrHxo5JKxhb0POlWn+1PSH7P4yrUAX3ZZz9DIaL6nRetrjeYVY+kMjOcsk0VsYP4+WC
         VQDCvHLgEiFDiv38pu9OHTtmYw+a09rPx1DMek8DqT3wgiQI4Wv18MmNI3ug+XklSB/r
         a/KJkRocaV/NipY5tGfbzSHaEKNOqpFWa7yuYY6pBfc8T+CET7EseuIzMdyxqn7PfKvm
         y6PmD2ZX/QzL6QTlmp4Kss43qpnL+EII1q3UhQIFgrbO+SnFeWSu1LtBgvuKqWUqRlCt
         W+tw==
X-Gm-Message-State: AOAM5332t1Qq53/S5S1/u5zm2jI4M76Uang8iTzvhPEdmNjoEMqXfbgn
        0KQutHFOiARDz96G0Tj5rd4AAzU9xDw=
X-Google-Smtp-Source: ABdhPJzr5dmiiqi5Ey2E+dkWHeLymd3GZxQEPMMBI9T80GmCmCHqN5+AAjwpBFVczOzfzIKyzFv3NA==
X-Received: by 2002:ad4:4673:0:b0:425:741d:a273 with SMTP id z19-20020ad44673000000b00425741da273mr14048586qvv.110.1645413768291;
        Sun, 20 Feb 2022 19:22:48 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r3sm25128933qkm.56.2022.02.20.19.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 19:22:47 -0800 (PST)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     bsingharora@gmail.com, akpm@linux-foundation.org
Cc:     deng.changcheng@zte.com.cn, linux-kernel@vger.kernel.org,
        balbir@linux.vnet.ibm.com, xu.xin16@zte.com.cn
Subject: [PATCH resend] kernel: Make taskstats available via genetlink per namespace
Date:   Mon, 21 Feb 2022 03:22:02 +0000
Message-Id: <20220221032202.1925507-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217093945.1904085-1-xu.xin16@zte.com.cn>
References: <20220217093945.1904085-1-xu.xin16@zte.com.cn>
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

Currently, the application getdelays cannot get taskstats in a net
namespace. The returned error is just like the following:
-sh-4.4# ps -ef | tail -5
root       186     2  0 09:23 ?        00:00:00 [kworker/2:1H]
root       187     2  0 09:23 ?        00:00:00 [kworker/0:2-eve]
root       190   183  0 09:23 ?        00:00:00 -sh
root       198   190  0 09:25 ?        00:00:00 ps -ef
root       199   190  0 09:25 ?        00:00:00 tail -5
-sh-4.4#
-sh-4.4# ./getdelays -d -p 186 -v
print delayacct stats ON
debug on
Error getting family id, errno 0

As more and more applications are deployed in containers like Docker,
it is necessary to support getdelays to be used in net namespace.
Taskstats is safe for use per namespace as genetlink checks the
capability of namespace message by netlink_ns_capable().

Make taskstats available via genetlink per namespace.

Reported-by: Changcheng Deng <deng.changcheng@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 kernel/taskstats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..4d6bcaaf52a0 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -664,6 +664,7 @@ static struct genl_family family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.ops		= taskstats_ops,
 	.n_ops		= ARRAY_SIZE(taskstats_ops),
+	.netnsok	= true,
 };
 
 /* Needed early in initialization */
-- 
2.25.1

