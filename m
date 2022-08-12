Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223C9590ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiHLKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiHLKLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1294F1572C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a8so570251pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=aYgtpe2qKchqYAVeaGiRPsk+O8CEAY4+LBGWObOMEO0=;
        b=Xuiun91BGib/zGfk8+xs/x42MxJnyZVMMGYUsQSaU70f3rzjFyRUvo3ep6P2yD3O8M
         erT+nwafT8sNELNBpih76eDx+wI5kRBqmDpGtu7p4yw5zUzEalosFQbHocoyTm3HELTc
         jP0gSfo+d/WOTxfoUZlDdft2/BkiJICBz0+0EemLlQg5Moh3nHW0nvUok6+CoOn0D1cV
         6k+sUe5Usd91nnc2ogQKcE8JvTbu1w/W+KtPbEkB9bsQTPPnXS/foTOAn9Sbr5WXcmei
         P9ol9ggHPExmzkcJq8Hl6HjVK87NPEUYmZQPoxncdoXmEMKlNyMjVDt2QreEwsZzkUJY
         vsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=aYgtpe2qKchqYAVeaGiRPsk+O8CEAY4+LBGWObOMEO0=;
        b=PiyZKupOBW3/AGJBGFxHURFdrAufQZm8thCkcKgRQhDAlshEaU3o1+GQVQRTxTydwY
         ae8UpLkeTy9bD93JwpLV0pgQhpRsOTiQKJUeqvbE5XIboWb2K5JKobyfxmlDlsagYdD6
         /qjt59wUbcJ/ynEgf56XNN57X5RSiYpO5GG4T/emr6ghn2ODAolt4czN6N5Kr6LRVSJf
         hRixL1RdnL76vnLtxL8k83AB059+iAyW/P9P6+hNVjlJi1GuekRiHWmrBP8JHVfUSbEh
         5oMG/lF2/tT0ITv1DeFQzK0MZPlBANbwLnstXHEHLTN6mLtRJe8xSCWF7pKuXQ70GsyR
         OKPQ==
X-Gm-Message-State: ACgBeo0quLgMOFeOK3jyVVz+mOwUvMLmqfN7DefXmeh+jEoUNYc4TGWl
        RCR5RlRy6DrhlYO0vbh6iIw=
X-Google-Smtp-Source: AA6agR4Q7sWDYiFEdIaeHOgye9LDGjiiTXSD+0nlr16pHDJZFMeVUlzOS/Yui26vYMrKOvjTRkhPpg==
X-Received: by 2002:a17:902:e54c:b0:171:4b29:d1e with SMTP id n12-20020a170902e54c00b001714b290d1emr3327280plf.39.1660299068440;
        Fri, 12 Aug 2022 03:11:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 20-20020a621814000000b0052a297324cbsm1215561pfy.41.2022.08.12.03.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:11:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn
Subject: [PATCH v2 0/5] propose auto-run mode of ksm and its tests
Date:   Fri, 12 Aug 2022 10:11:02 +0000
Message-Id: <20220812101102.41422-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

The following patch series bring a NEW running state "auto mode". In
traditional KSM, whether ksmd works scanning and merging or not
depends on the sysfs klob ksm_run.

Most of time, letting ksmd run is not very much needed, for example,
when memory is sufficient, because it increases the delays of COW for
user applications and also consume extra cpu resource. Besides, the fixed
pages_to_scan is not always good. When there are a lot of same pages,
the default pages_to_scan makes ksmd so slow to merge them.

The four patches try to optimize the above two points with a auto mode.
It's a lightweight optimization to KSM, not like uksm or pksm and so on.

The tests show:
	The convergence time of merging time of auto-mode reduces can low to
	HALF of normal-mode. The cpu consumption of auto-mode also get less
	than normal-mode.

There are two type of TEST which have different shape of samepage areas.
One is full-samepages vm areas, and the other is sparse-samepage areas.
Both of the madvise area'size are 300MB.

Here is test log:
****************** TEST 1 ******************
Now the shape of memory area is full-samepages:
[xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]

Start to test normal-run ksmd...
ksm current cpu total slice: 15274
ksm normal-run's merging time: 45.596018 seconds
ksm current cpu total slice: 16370
Start to test auto-run ksmd...
ksm auto-run's merging time: 17.599391 seconds
ksm current cpu total slice: 16488

****************** TEST 2 ******************
Now the shape of memory area is sparse-samepages:
[xx]          [xx]          [xx]   

Start to test normal-run ksmd...
ksm current cpu total slice: 16532
ksm normal-run's merging time: 21.625451 seconds
ksm current cpu total slice: 16833
Start to test auto-run ksmd...
ksm auto-run's merging time: 17.684379 seconds
ksm current cpu total slice: 16950

Change log
==========
for v2:
	1. We adjust the scan-enhanced algorithm, abstract its implementation
	into a single function, which is clearer and smoother.
	2. Add tests of auto-mode of ksm to verify the effectiveness.

xu xin (5):
  ksm: add a auto-run mode of ksm
  ksm: implement scan-enhanced algorithm
  ksm: let ksmd auto-work with memory threshold
  ksm: show ksmd status for auto mode
  ksm: add tests of ksm auto mode

 mm/ksm.c                                   | 250 ++++++++++++++++++-
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/test-ksm-auto.c | 273 +++++++++++++++++++++
 4 files changed, 519 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/vm/test-ksm-auto.c

-- 
2.25.1

