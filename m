Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1F4BAE14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiBRALO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:11:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiBRALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:11:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E158E4A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:10:51 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y28-20020aa793dc000000b004e160274e3eso677775pff.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=daH+2gut1QW9kZErJcIx6WIChTci/r2UH1rfRtql99A=;
        b=q6FFpZFF3pNwD7OlZ/4hTa2+tIgGnbd0G+XzZL/u5K1MB7T5d3HgNPpm2WrpsJPGFI
         qbChI7Kpr1Y4OTN5CIt+CtbUwHq36Dd+XGnXtyuPffUh+44yH9JneNO90sOM503sq9Pt
         eZKwkuGVLEDIqmylXibuvfO4mWbfbCRMK5t+UM9Ilo+KyaG5HjwenZcHPW8R1weAluSt
         i263hDw9mxz0nZrOUc3z2zZ9m/JbUInIRuLVFBolt1BGTlkMdal9EsLlqJ9bYGB+yS5s
         5eibzP96XUS/1KgFsqhE0qyvdkm/TzDcixiWKzx+aATSw/NN755gez1zeV5N/3bhONkt
         Kp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=daH+2gut1QW9kZErJcIx6WIChTci/r2UH1rfRtql99A=;
        b=OS402md6wZ5izFw/mKAiu6fL8GuU76x6ydnerw0/uEzJtRnEBuf6Cf8o0sUuhulzCi
         sVaZKgxhpeecwo1CK1n9Mv1ND/Kzk62qop75VQTIKjgKNIh1sUnEnwLLIIH/JAXs/R9P
         8tejQ8ugX75jsjsUqRQ/NG1MQBNf4OIYMlTPxr9g1PQlFTKXC1EHvyYus2hRnjrs1X8m
         auC6zbweJVR+URmG8a4SoXsqjg2UV44rFD0U1VGaidTWwms7nJCNXu+VVUIUCH7We3aD
         5dqqirTx892xi9z1yt9PeAftg5sBVsY26xcROUhO2X5jJZzT4yxpf9ZWewsO+rD06p8j
         dZmg==
X-Gm-Message-State: AOAM533H73uHZJ/qlzU+HDtZ0tgoDqPleSIc5pkTQY49s2e1rhFIv9XK
        0oXEArw0IWPCH3/RTWri2h3Mu9qL27GD
X-Google-Smtp-Source: ABdhPJw6fTpwF9+VtM9cM6JfysP1jGMHMiG5w+LL8NIkGyT/Fp5ts9IYmAvlnIrXQpBFUhpxsnIfEpXhUeXQ
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:a17:90a:a50f:b0:1b8:e6ad:f63c with SMTP id
 a15-20020a17090aa50f00b001b8e6adf63cmr199698pjq.1.1645143045060; Thu, 17 Feb
 2022 16:10:45 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:10:16 +0000
In-Reply-To: <20220218001017.3500673-1-yuanchu@google.com>
Message-Id: <20220218001017.3500673-2-yuanchu@google.com>
Mime-Version: 1.0
References: <20220218001017.3500673-1-yuanchu@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/2] selftests/damon: add damon to selftests root Makefile
From:   Yuanchu Xie <yuanchu@google.com>
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
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

Currently the damon selftests are not built with the rest of the
selftests. We add damon to the list of targets.

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d08fe4cfe811..ffe453760a12 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += damon
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
-- 
2.35.1.265.g69c8d7142f-goog

