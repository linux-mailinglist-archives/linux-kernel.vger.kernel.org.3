Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A85A1063
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiHYM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbiHYM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:27:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB8B2874
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z16so5603639wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ila7dO+0naAC7pik/BSrv/RJAUqzJmJgiT9+mebfzyM=;
        b=IkDuU8yej3eHmdrVmkxekXX5Qjxdvk5lHSqada5fCjbpyFI7Bgd9X8y4yCkEwgVKOM
         5uBsm7z0xlk3w2NTdw/wr7osHjhXda0viWh6kFqKIYeTbbXymyZZA6grPi6qm+4dUuEo
         iKrJcXyvfFnw006F4qSUH5J8UvqTbe+OuE1s3wdaVja1YhpXBzngE+HTkr55ijwiI88P
         ck5ssqQw+QWqjjhaJ++BxJOePJlAucY5/rFJSefPuQKKdXnVl+fswvDsKGiX7CXcW+6k
         LOhFBMq2OfW7BBv8M3yfXOPaG7AmCmFldDWWsIuoi6w0CzvYZHiiVbMVGWZe0LsHntLX
         4/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ila7dO+0naAC7pik/BSrv/RJAUqzJmJgiT9+mebfzyM=;
        b=amo1idjBc015uQ/xe+hwoaM5baz8cBMOmXSkN0ivYhisJ9dblFctnnTdfBHleHx2mf
         IxAFV/gh6NKUcO7h9dB4STkKcQzYGpqAGOtCJD/6iDLIq/mvUQB76WLbsChJ4RDoWJWC
         FciPh8CN0oVJGkrh6kS94ShzquGkWJeutaKr4UtMKKTX6HouISkutw7lN5k/pJZuAhKb
         9wUvBu/5teOVVuJn5Ll7qRKllczgwTOxqXBhqP+qauCxvIdo6wqgnrWMbfOpPzyO7ndk
         936nwBXuuuzWZIxApWyAMcgAf4x8YCw/4SwErSzNt7wEoXpSmixt8rbIV+udxWtpBYT8
         tPPg==
X-Gm-Message-State: ACgBeo0f5hJBUmPThwu2gJNX+d5GHBypHexcvRbW5ISr//7kmreOSb/X
        2V3tsJ+N7SMaqiomrRYm0DDuEg==
X-Google-Smtp-Source: AA6agR6SYAnEBykTAAZjXYl0OkmM3PJt+9g7Ky/0AMdhsFQA5H/emhCjgbpR0RIjHCrcBmV6Z5Q3fA==
X-Received: by 2002:a5d:4f81:0:b0:21e:2cd7:25df with SMTP id d1-20020a5d4f81000000b0021e2cd725dfmr2239459wru.439.1661430450002;
        Thu, 25 Aug 2022 05:27:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:55dd:3519:10d3:b07b])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a5ee64cc98sm5417809wmr.33.2022.08.25.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:27:29 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4] sched/fair: fixes in presence of lot of sched_idle tasks
Date:   Thu, 25 Aug 2022 14:27:22 +0200
Message-Id: <20220825122726.20819-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset gathers somes cleanups but also improvements and fixes for
scheduling UCs that involved a lot of sched_idle tasks. In such case, the
sched_idle tasks impact significantly the behavior of other tasks whereas
they should not. These patches don't impact other "normal" UCs.

 have foudn these changes while studying Zhang's problem [1] but AFAICT,
 these patches don't fix his problem.

[1] https://lore.kernel.org/lkml/20220810015636.3865248-1-zhangsong34@huawei.com/

Vincent Guittot (4):
  sched/fair: make sure to try to detach at least one movable task
  sched/fair: cleanup loop_max and loop_break
  sched/fair: move call to list_last_entry() in detach_tasks
  sched/fair: limit sched slice duration

 kernel/sched/core.c  |  6 +-----
 kernel/sched/fair.c  | 29 +++++++++++++++++------------
 kernel/sched/sched.h |  6 ++++++
 3 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.17.1

