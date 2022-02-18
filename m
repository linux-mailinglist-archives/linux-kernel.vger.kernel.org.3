Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBF4BB6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiBRK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:27:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiBRK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:27:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F8389E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:26:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m7so8216619pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6n56412XkU3cVeHo6hCtYyL1En8oEnrT0LI9PHtRQKk=;
        b=qZeAPcCyvBIo+T+9s+LRJtCfoZjxGRuKEhvu5IUL/6YC+70/BETeTNFTYNzlW4BZ0y
         16vTX9BbC7msF3IAUMzbeZ0CUtR4VpPsWtOZPMjE7Gd7GQ83y8ASnu2F3PkmR8zodPDf
         n0e+qfSi/NZ3/C5XVXY+0nhXu/J4zaqLGb3JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6n56412XkU3cVeHo6hCtYyL1En8oEnrT0LI9PHtRQKk=;
        b=6BsSbWHeqm2g6AXzMSjeHjsVGSjCagKoQynjI+n28wq5shSdrEsbNVrZu3oXtwM+fy
         ThTl4ynBtLysXIQuvTRxwRX/wXa4TxKKQV7Qw63RaP7FmEhBzffmCk587gD+PAe5wdL8
         oZg768b7jLWMoB5jsXbODmvhzYhMYytXk7+V7sOrqCmDUoSuyl/eGfwVbZL10XfpS3sm
         3xwL/5Fe/U0dmLWkplbGRRP8NJgvEWRWwQQREeugSqXPCDb6jnuzLAWaTTM/f3TXqeyi
         WqtVD1Is0d7AsLhgBxjL5HmdDlVWjC1WHRLfFX1BNa/nq8EOtbXJKHzjhxcUj/QcwLf/
         zkSQ==
X-Gm-Message-State: AOAM532U0MedikobckioNOylVnCU8SpxJVAF5zIdPxG9vRTjSc1ZbNOr
        IW95Fwjo1S+cN5XkOCwbbrMrEQ==
X-Google-Smtp-Source: ABdhPJwuVBXUZpK+hSCOU/2l/R/2lXyT9XqbtWvaqaQsEhYCtzyFSucUiJIAdYb3woEmZZoQER4eDQ==
X-Received: by 2002:a17:902:d708:b0:14d:cf6a:a9a3 with SMTP id w8-20020a170902d70800b0014dcf6aa9a3mr7013845ply.118.1645180001784;
        Fri, 18 Feb 2022 02:26:41 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id k13sm2767696pfc.176.2022.02.18.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:26:41 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     akpm@linux-foundation.org
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/3] Rebase DAMON_RECALIM for NUMA system
Date:   Fri, 18 Feb 2022 19:26:08 +0900
Message-Id: <20220218102611.31895-1-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Current DAMON_RECALIM is not compatible with the NUMA memory system. To
proactively reclaim memory, DAMON_RECLAIM kernel thread(kdamond) has to wake up
before kswapd does reclaim memory. However, the current watermark for proactive
reclamation is based on entire system free memory. So, though the one memory
node is fully used, kdamond is not waked up.

These patches clarify watermarks of DAMOS and enable monitoring per NUMA node
proactive reclamation on DAMON_RECLAIM.

Jonghyeon Kim (3):
  mm/damon: Rebase damos watermarks for NUMA systems
  mm/damon/core: Add damon_start_one()
  mm/damon/reclaim: Add per NUMA node proactive reclamation by
    DAMON_RECLAIM.

 include/linux/damon.h |   3 +
 mm/damon/core.c       |  39 +++++++++--
 mm/damon/reclaim.c    | 147 ++++++++++++++++++++++++++++++------------
 3 files changed, 140 insertions(+), 49 deletions(-)

-- 
2.17.1

