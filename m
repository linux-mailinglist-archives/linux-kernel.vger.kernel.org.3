Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAC4E3E26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiCVMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiCVMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:11:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C576A075
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:09:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p5so11858923pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxQUt6kteHv1h0kyZTG1IpbSwTi6AWyZnPXori84sbQ=;
        b=QFHiIW3cKS7+5RikyG4DHyJNxycBqwrsWXd5z82wRuzQviwoU2jZRWPH9e1d9Un/wU
         JpQmkidZeccZ3LsF7VcytVOPpnhmTTMgwKanV2t3Pp7C1fSD5aHCSEShlCxbgZjDYOGh
         uW5kR5cf2KdRXXITKAMNc1NMBven4QvnD9JzHuwHfKQsAZL1EhJSqJhU700SlupK92uN
         1ip0Yg1RAVgzla0TiE89sfeE3LeOpKHthOJCpKFbTCEeos7kDFllBJIClRRwP74GvsHY
         a+VIvs7NBlmmslhjKRp4y0wR8JLQSFg+8mkb++FfzUdShFBWwA0EpYKNj3h01So1QTpa
         e2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxQUt6kteHv1h0kyZTG1IpbSwTi6AWyZnPXori84sbQ=;
        b=et5Oxb6vjyk+ZtHhZh2ogiuC1Ktod97vACKmqsgEBKZ59lmdOmdjUp5hqylr2nMcnx
         p7djIyhrroua4rN4ibxOIzBLVbv/rHjgijtQzkWR9rzVRpSvM7cbFvkrvzTy9eq+VDkB
         lNLjQOkLyNObg9+stWUXaMrS0ve2OQwhW1pnmaQQ12IhZGg13gcts87TExqQh/9e9Cfg
         LdH5D/CdHV/agfxABFSQj/0wiRmswtg8lfG5k97QvQfh2wC1HNrgG5dFQl0W3ursqOyf
         tLXwOFm5SK1+YEWvjhprFbyiuiy4H17I3Z6qFBfedy+DrbvW3I8WgUIV8TuVbYaD/1Zs
         X8MA==
X-Gm-Message-State: AOAM531DKWujDyI9wKMVzGmKzxWQEH/jSLdmO4rJttnELGi6FwG1YYMl
        uG7Xf8zG21F8g79cv3ZMLPyPAQ==
X-Google-Smtp-Source: ABdhPJwYrDfHcoYGYkh7zikbUoeeUf4CG+256KgttT9inXN4q5i7p0H4qU2v77YEwvjUWVMp1c7Saw==
X-Received: by 2002:a63:dc08:0:b0:381:3c1e:485f with SMTP id s8-20020a63dc08000000b003813c1e485fmr21277931pgg.311.1647950984996;
        Tue, 22 Mar 2022 05:09:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:09:44 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 0/6] perf/core: Fixes and cleanup for cgroup events
Date:   Tue, 22 Mar 2022 20:08:28 +0800
Message-Id: <20220322120834.98637-1-zhouchengming@bytedance.com>
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

This patchset starts from the v1 RFC patch[1] that try to fix a race
problem between perf_cgroup_switch() and perf_cgroup_attach(), then
change the usage of perf_cgroup_from_task() to use stable cpuctx->cgrp
in perf_cgroup active time start and stop for the similar reason. Then
remove some obselete comments and some code cleanup.

[1] https://lore.kernel.org/lkml/20220308135948.55336-1-zhouchengming@bytedance.com/

v2:
 - split into two patches to fix the race problem for easier review
 - use cpuctx->cgrp when start ctx time and delete unused task argument
 - use cpuctx->cgrp when update ctx time from cgroup perf_event
 - always set cpuctx->cgrp when the first cgroup event enabled
 - remove obselete comments

Chengming Zhou (6):
  perf/core: Fix incosistency between cgroup sched_out and sched_in
  perf/core: Introduce percpu perf_cgroup
  perf/core: Don't pass task around when ctx sched in
  perf/core: Use stable cpuctx->cgrp when update perf cgroup time
  perf/core: Always set cpuctx cgrp when enable cgroup event
  perf/core: Don't need event_filter_match when merge_sched_in()

 kernel/events/core.c | 218 ++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 158 deletions(-)

-- 
2.20.1

