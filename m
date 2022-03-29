Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E214EB0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiC2Prb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiC2Pr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E9B3A721
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:45:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d30so854407pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBWbnx9nmzpAVk+ZjuUdTpMYBLq8k4If2dmnAQXSRqs=;
        b=CAlgzMvhKAuMBP/KNFNTLpGMzTNRw/jYBSJHv9/OXpabr64KZM2xwneiShOr2va39m
         CIxaq0Wp5DRppuVj+7eStv93DZ5PDZRXJdeCrNwy6O+U9acfEg2mC8/6/9KOCEESP1F2
         2xn5DXtmr0vr1//0yuIcgFqgnd+/ldRQjqtPDcfKid+7a/er8uhKS+02120dtLnSRLuu
         yBrjtK/0p4WQciARh/7hfX/qV49payYKLzPaXPBTv6QuLSu8Wx401aFUDWIzCpohRpjx
         SmajDmBcOmDru3W6XB1xLty3R4BBBgn89IBHDNJNB9sibTsB1+x9OmvcaMMo29g/kGOR
         Vn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBWbnx9nmzpAVk+ZjuUdTpMYBLq8k4If2dmnAQXSRqs=;
        b=xKdYy5PeXhvHznlg/C+UVwNlA/SncrYlKj/XqYvn/XwnlJ+tMOx/vZPbMOk5zHp6Ax
         yCka2PzGrJUAzbe/1ybSZLahsLmKQRhWmKPL8vIHnTMXlIFM9xhOUdBV5FhXTy1xG7rA
         MZqq5ENka8OdSQ0GFxlaYbJk1BQPDLZl0aJc5bfwCv9+Lv5ESUrpMH3JtQPhjySKDnaJ
         eJoFiJExwC5fed+nsymcbMzWJLluYFDvvRvqub6GgdTO/tDwh91DH170oNC3uuNKPGRi
         qorQ59637IWgFb5CQcywPNXoBBvNAaSqvbl6eVSFD1AYbxllixdlNqSoOkJv+ToNKl2Z
         ICOg==
X-Gm-Message-State: AOAM531pQBehkAgwtqDgPgjmus1MUUnFssm1NLFcYXgwvzk2h9LzX1KG
        BNelQF37xcU8cheolGXynZL7FQ==
X-Google-Smtp-Source: ABdhPJzz19Rg+Su10Np5HFxc79yFW1oMkdOJLvHJr7FrwyKx+yX7c483JS7yzqqD2oF7eq7kBNbMwg==
X-Received: by 2002:a17:90b:4b89:b0:1c8:105a:2262 with SMTP id lr9-20020a17090b4b8900b001c8105a2262mr178749pjb.225.1648568744396;
        Tue, 29 Mar 2022 08:45:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:45:43 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 0/4] perf/core: Fixes for cgroup events
Date:   Tue, 29 Mar 2022 23:45:19 +0800
Message-Id: <20220329154523.86438-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset mainly fix a race problem between cgroup_migrate_execute()
and perf_cgroup_sched_out/in().

v4:
 - delete patch 3 in v3 that remove event_filter_match() in
   merge_sched_in(), which is wrong since the hybrid system
   implemented PMU specific filter_match callback. Thanks Kan.

v3:
 - put two fix patches together in patch 4
 - delete percpu cpu_perf_cgroup, just use cpuctx->cgrp to compare
 - reorganize these patches' order

v2:
 - split into two patches to fix the race problem for easier review
 - use cpuctx->cgrp when start ctx time and delete unused task argument
 - use cpuctx->cgrp when update ctx time from cgroup perf_event
 - always set cpuctx->cgrp when the first cgroup event enabled
 - remove obselete comments

v1:
 - https://lore.kernel.org/lkml/20220308135948.55336-1-zhouchengming@bytedance.com/


Chengming Zhou (4):
  perf/core: Don't pass task around when ctx sched in
  perf/core: Use perf_cgroup_info->active to check if cgroup is active
  perf/core: Fix perf_cgroup_switch()
  perf/core: Always set cpuctx cgrp when enable cgroup event

 kernel/events/core.c | 209 +++++++++++--------------------------------
 1 file changed, 52 insertions(+), 157 deletions(-)

-- 
2.35.1

