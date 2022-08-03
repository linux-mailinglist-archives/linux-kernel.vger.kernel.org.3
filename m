Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A59588A19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiHCKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiHCKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:03:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2B1D0E4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:03:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so15908131plq.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cvAbQZ7UDpN6nHSUbSq141kAF5t3sXiSGCHIO0EWxys=;
        b=CPjTb9GrTf6Xxic2TqGthS1qTHHqntDZ37mKAJIkBLY5FA0EA6qoBJLkjG0egHCN03
         yH2gt43WBVDNRx0oeB6c2S3Ti2jHrFcB7YsYH1h1kAYYY/EqZw5cSh3+sT88hUS1EBLS
         vmlzUPfijSJ6qVxuqSdRrsU1hW4kFrcJNcPiLiJ0PDk9rVkmQtdoWghG2mClVWjMOvNz
         G58/rKkhMBx0D2aCNgqPDNnz7p/3poCQVKiA6HTDuYU3jik0cVfrmbQVuEMSJYl0isY6
         rVmusnIKyfTJ7jaOMIaCpkoTx176xcW7OdDUUgm8WtVa1maSXz8PB3qo57wX4iRN6n7n
         daFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cvAbQZ7UDpN6nHSUbSq141kAF5t3sXiSGCHIO0EWxys=;
        b=p6d5WHHriYMO3Gc6aB2m/6DP1Nd+Wfm72iskPzryU+ZwIQ+HSLuJlH3KgdKuea6tYp
         d+bDyjCSWuKTaTyAosJ4I8JKg4LCLNfxxV8xos8Jugs6DTNu03swZS6EG10Ob0lDrty0
         gFdCDiW+0S+ibImmIpGYM73YUgBJkz5cmxgimrooQMr8Npcz/q4lsTnC4rpG8H4vRUyu
         gcUnhVUaFKUZvoBsbK2M7vTWXTKUOkRWHC3wTtpq5kIFCj+OZi7LZIjCTj0f3dLHXAu0
         tFtKA3XUXnUOWHjILUSXZXxdXCSq0rPDNYGs52PWHU3cDxN9nhoZD1ceUlukpLir+O02
         BHtA==
X-Gm-Message-State: ACgBeo12F121TR7A0ODtGlMY4BlG3BYnQ9kTwtMon8jEecHlJ2uv9Aur
        KKoXdDUIQuBijc7ukxPbAOk=
X-Google-Smtp-Source: AA6agR6tCK2KRyOG1o40zhBecpXlbVFufMUl6A0DK/XqhDiWPLOaX65ZJGjYrEobuILR+V+A6mwCzQ==
X-Received: by 2002:a17:902:d50f:b0:16e:ecdd:98b8 with SMTP id b15-20020a170902d50f00b0016eecdd98b8mr13443805plg.22.1659521006830;
        Wed, 03 Aug 2022 03:03:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b0016f0939080asm1438111plw.249.2022.08.03.03.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 03:03:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.con.cn
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>
Subject: [RFC PATCH 0/4] propose a auto-run mode for ksm
Date:   Wed,  3 Aug 2022 10:03:06 +0000
Message-Id: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: xu xin <xu.xin16@zte.com.cn>

The following patch series bring a NEW running state "auto mode". In
traditional KSM, whether ksmd works scanning and merging or not
depends on the sysfs klob ksm_run.

Most of time, letting ksmd run is not very much needed, for example,
when memory is sufficient, because it increases the delays of COW for
user applications and also consume some cpu resource. 

Besides, the fixed pages_to_scan is not always good. When there are a
lot of same pages, the default pages_to_scan makes ksmd so slow to merge
them.

The four patches try to optimize the above two points with a auto mode.
It's a lightweight optimization to KSM.

xu xin (4):
  ksm: propose a auto-run mode of ksm
  ksm: implement scan-enhanced algorithm of auto mode
  ksm: let ksmd work automatically with memory threshold
  ksm: show ksmd status of auto mode

 mm/ksm.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 206 insertions(+), 6 deletions(-)

-- 
2.25.1

