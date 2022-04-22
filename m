Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FE50B3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445869AbiDVJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445877AbiDVJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:13:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F144E8D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:10:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so9507298pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RcYU2l3Mf+ndc1CA+8jypEWEXqIahxo9T2ZjrElfFtU=;
        b=TmQ06wH3tn6ayOI1gsUpAHFoMiXuaJjt3R3T8E3OM1PSntFIvXGcA5AUT1gkoPGXnJ
         5WugjIFMFRj6O3uywDDvTALgCz5r9Koj1cd2XzI+jgBD6kKaga1gjztCn7Ye7+6sgQaE
         KJkhdVs+xvn+8S4GgDTADUE+YzZ/2JIx/RQWJvZlYEOMtqC9idRPPP9Skr5iADurwQga
         u3AvvdVQT1GKvTZiWM3DT1w6e+y5VzGAVHWFq9XjLsVX6S3GaQiOjA/7WTpekN4K6iiT
         nQAF35GP5dJ03eieMYDeJwVJrABu7Qp3GQEQJ0AK7PViEyyX8rVzBumpLEffsZNFTHZz
         sSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RcYU2l3Mf+ndc1CA+8jypEWEXqIahxo9T2ZjrElfFtU=;
        b=AjvWywCUaHuqkx7np46qbHVvgezjgSJsMBTMGuhdufEPFt/cQcd+RfnIsiuBS/VZ4W
         aBc1i4155U9OB43qr6D0WmP2QtzxI9eNezUEMSkDM7HFLMlh+M6O/7mSMflOIZW/Y3un
         fIixIbp7+p9ZNkgjn4ob7hWc4ylzYaucACD+SokXFkqoXtAKRtRQF8JNJvPUoa4axqm7
         TlS5o2uam2/lZmrSZhP0/yejcLUcj/27WlvxZazOwDSYW6xeS9AMCu0wy9bRa19zAanl
         2CsR+0qNABov3xTqmYMw7mO/eh//C9/xYXMRQtFyvLBh3XiiUEE1UjbncyHdnCvuzV17
         j66g==
X-Gm-Message-State: AOAM5317XquOXG4Qw8MNwTuyNj3Uh4NF3xPBizsZJM4OeW3wgJGgjEk5
        eZNt7jdM1d7DxSKY46U83iAXyw==
X-Google-Smtp-Source: ABdhPJz4fT1I7iNw5RlursGDiN34rX83aj7VnUw2XQvC4YA3uNTDqbWSv54HHCBmtNGXuGOLUVjm+Q==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr3579539plh.136.1650618606034;
        Fri, 22 Apr 2022 02:10:06 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id oe7-20020a17090b394700b001d8995368a9sm559239pjb.35.2022.04.22.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:10:05 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 0/2] Avoid obvious double update_rq_clock warning
Date:   Fri, 22 Apr 2022 17:09:42 +0800
Message-Id: <20220422090944.52618-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are about the kernel scheduler:

patch 1: fixed the issue that kernel may trigger WARN_DOUBLE_CLOCK warning.
patch 2: removed some no longer needed comments in the deadline scheduler
and cleaned up the code.

v2:
   - Added double_rq_clock_clear_update inline helper to clear RQCF_UPDATED
     of rq->clock_update_flags.
   - split into two separate patches.

[1] https://lore.kernel.org/lkml/20220418090929.54005-1-jiahao.os@bytedance.com/

Hao Jia (2):
  sched/core: Avoid obvious double update_rq_clock warning
  sched/dl: Remove some comments and adjust code in push_dl_task

 kernel/sched/core.c     |  6 +++---
 kernel/sched/deadline.c |  8 +-------
 kernel/sched/rt.c       |  5 +++--
 kernel/sched/sched.h    | 31 +++++++++++++++++++++++++++----
 4 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.32.0

