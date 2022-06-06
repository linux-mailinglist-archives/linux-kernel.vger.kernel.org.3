Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF853E3C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiFFH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiFFH5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:57:13 -0400
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D5B49A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:57:11 -0700 (PDT)
Received: by mail-pl1-f193.google.com with SMTP id q18so11497364pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFsqbk6G+07sypxIVSsJ+0YpchiOwAeL3HVxLxbvp0M=;
        b=AhXOeDr4HDyurJ2dRKlBACteavlAl2ogi2CW9uhj/QCJCdnlpY2bBBQR1TojsYEhUV
         8Nk6yZTkGlW2jmiUFs366ZYzCYO34GqTo5GAiUfA1lYG0xkCga8nD+A+dIr1+iCox0dL
         W9G9ATpNCpdBhPklYtV5OQZpgStl962JKnHqrZ38qEymchW///eWlYkromyOoS9lncHW
         VZcIFnYLYM3RqWa6H9EgJqgD1BUc3Z128UCxqnGurJ7NEIsHK/CtKlz+C2as9jGr6Awn
         Y+85UIz3isGe4eZEMPAKaBeTWTRKAj53q2OVsAJRyQESkwPk5SHAnwZ9VDJYBqym8H+k
         RWNA==
X-Gm-Message-State: AOAM530zOqEJVYTG+CRbtZD3Mh1QMl/xJ1UW6E53ODUhu6H9/yPi5VHj
        tDv9XvvbHdaGGiG5VZ9v8CSy3B51L7/PW1s=
X-Google-Smtp-Source: ABdhPJx5u/0R/YumGEXyAtiWf+/1zu1gEFfy1gAAfyXtI9N1inu0YAkutP49eEJeZsknyULpzUbgxQ==
X-Received: by 2002:a17:903:110e:b0:167:8847:5d9d with SMTP id n14-20020a170903110e00b0016788475d9dmr1231199plh.3.1654502231286;
        Mon, 06 Jun 2022 00:57:11 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b0015e8d4eb213sm9893125plb.93.2022.06.06.00.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 00:57:10 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, ast@kernel.org, mhiramat@kernel.org,
        jolsa@kernel.org
Cc:     sunliming@kylinos.cn, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] fprobe/samples: make sample_probe static
Date:   Mon,  6 Jun 2022 15:56:59 +0800
Message-Id: <20220606075659.674556-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of fprobe_example.c, so marks it static.

Fixes the following warning:

sparse warnings: (new ones prefixed by >>)
>> samples/fprobe/fprobe_example.c:23:15: sparse: sparse: symbol 'sample_probe'
was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 samples/fprobe/fprobe_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 24d3cf109140..123cfd83d4c6 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -20,7 +20,7 @@
 
 #define BACKTRACE_DEPTH 16
 #define MAX_SYMBOL_LEN 4096
-struct fprobe sample_probe;
+static struct fprobe sample_probe;
 
 static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
 module_param_string(symbol, symbol, sizeof(symbol), 0644);
-- 
2.25.1

