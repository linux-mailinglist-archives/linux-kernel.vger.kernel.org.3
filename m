Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4A4E6CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbiCYDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiCYDza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:55:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE333A3B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:53:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z16so5505133pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvRXa6alu94TqhKYu6X1Xgmr+rthOKW30ixcNTESHCo=;
        b=5UkMKELTIxQzOGIGTFOozNs5XUOb5JzOfrf9IF67osC3rUYWA5h9i8F7MtDfHhIjd0
         vtYuklbtm24k7jYIp8zgnewYxfK39JB38sbvdlesq/K0uCXWotx1rtxk9jguOPvwps7/
         oN/TWOqKoeQC2F2HKFQT85bt2HGQ5T+6ClsBj9niASvL+o89djEiHJjV6Z6ZwQOqU7hO
         y2a9dFoPHrrxefc6bDVQJDw8GtZBvlfKFjglCd2IJ6sF6RODFJOyogqRwZ1Fs57O5vlK
         31hNRqbkO17kJozFCYi3j4QTqa8mHa8tTv/jZhsnvWQrO99/1LBaZxbzOdgo5oJRPvCj
         2lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvRXa6alu94TqhKYu6X1Xgmr+rthOKW30ixcNTESHCo=;
        b=G10izqAEfZjP8d2Yryzc5ETfSjsLJvEwlF4gp+Nto3tG9H6tJjRu9gJgdhXXcNR9P9
         QEUJ4jbeOg0Uv8V0OWmw6gIzpiUZNfa4ABivJsX5lQ+Y55Kx31ZdJtRGZJv4oFhV+zSD
         XVb02gMsZjAEasTMhS/PrALon66gV3Y6ERiKWY23dQ+S5oyCP0+2BE3Od2fkrAebZSME
         119kiM61bwo1bkYgi6VVmFxCpILH6+qgZfrRcPOxRyoLWf3L3ojxMqdus6yJtR9ztCsh
         7NDPBXnuiG2DTXDC6FYWaFiJwvZmG/Pn+WhaVCEHtDYloHbzFfYSdgUKEvhqowhxyFBE
         2jQQ==
X-Gm-Message-State: AOAM533xhpCTD8CffAfUlxFbKf8EUEZHrIUP87uZo8MPYjw7lx6XNnQA
        fcT/S46Q+NKaiQtXo79hVD5WXQ==
X-Google-Smtp-Source: ABdhPJwwzuRlN+4cwGj4yJ5TwudOy/S1v+SJWXqEX3GmDZ8kMMTEz1CZ1Hxf22pX5tLCxCI4OcR9Pw==
X-Received: by 2002:a05:6a00:2386:b0:4fa:e772:ebac with SMTP id f6-20020a056a00238600b004fae772ebacmr7915963pfc.75.1648180436500;
        Thu, 24 Mar 2022 20:53:56 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:53:55 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 0/5] perf/core: Fixes and cleanup for cgroup events
Date:   Fri, 25 Mar 2022 11:53:13 +0800
Message-Id: <20220325035318.42168-1-zhouchengming@bytedance.com>
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

Chengming Zhou (5):
  perf/core: Don't pass task around when ctx sched in
  perf/core: Use perf_cgroup_info->active to check if cgroup is active
  perf/core: Don't need event_filter_match in merge_sched_in()
  perf/core: Fix perf_cgroup_switch()
  perf/core: Always set cpuctx cgrp when enable cgroup event

 kernel/events/core.c | 212 +++++++++++--------------------------------
 1 file changed, 52 insertions(+), 160 deletions(-)

-- 
2.20.1

