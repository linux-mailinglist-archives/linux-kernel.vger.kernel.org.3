Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E639589961
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiHDIku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiHDIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA16525C72
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:40:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso4827678pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=a2oIHkAvkJO2cSfKWxioTgiamZhg17v1e6s9LLinDPg=;
        b=p9gBnon7Qe4+n3jGGSchfH2hlPUh1qW2IZZUkGROGiAQBP615zModVjmiJdo1pXP7t
         eI9kTMaHionxfwUx+d6J1/GPODQWR5hVB3IQ4ZF1bPX0EQd5y4l5iTeBhntKTdJImMXz
         0uw5hMUF3hpAUVhFS4mmoGkds6WvqVJHDS9BMyxNXs6KdqnIrTBTh7858/Rzvy1w2OP9
         RD5l1j4JMA/e1xX7KIhVp8EKUICQvemMlLwlRzMsJ+PU37vVhEO9rC94+7Vi64El0/uy
         nJjEQJkmVqCkqj4yEFWhclu176syv+CVEbtmNb61sS5OQDQdM+KDdgGXQbEPip9NMi0e
         F4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=a2oIHkAvkJO2cSfKWxioTgiamZhg17v1e6s9LLinDPg=;
        b=ikAu3xYyMs5wXhZ5HWi5tNvTsq9s9nxTcxB4R0s1FEacrqNMD4T3b3kcS03n73MKN3
         PhToe37OxTjb4yKyQVLyLNg3RjtsOOGW2YUf6lgGRgt+YzlIMH9Y7E3O60V39v/bw4x3
         u4HEmDnAWiI3tDFYPT0odHrpuwi7PSM6j40dcZ+rAqct442Z9roSLOUEtXkHOguQ5oUS
         2+j389jkM41Wxl7xliXNpkT7n2Wq/OijEQtKb7RsVsMhWnmXuxTBY0/pH6KR/lyNZWg5
         vxMkzK5AmSE5OjhV6U6quShug99jJi7rYjnipihFnD0JOqUB9xLPoFo51GvMiYjZFOpD
         fdow==
X-Gm-Message-State: ACgBeo2qJHXgvnn36DScDeDHcN/uxA8UkkX9o2D+rI1fNHML+Tm2bjsD
        KcjbArCWQhzziym4+6cyhbPL5zPO3TI=
X-Google-Smtp-Source: AA6agR7bbCaDD0oTap6AzaKjr4WaHeIizvt92qD+b8YbUMYrIEWjGkzBhPMaThBzMqGq/HUsnzD9wg==
X-Received: by 2002:a17:90b:4a07:b0:1f5:1aff:4ab with SMTP id kk7-20020a17090b4a0700b001f51aff04abmr9575816pjb.216.1659602442783;
        Thu, 04 Aug 2022 01:40:42 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0015e8d4eb2easm233783plg.308.2022.08.04.01.40.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:42 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [RFC PATCH 0/8] workqueue: Fix for prematurely wakeups and cleanups
Date:   Thu,  4 Aug 2022 16:41:27 +0800
Message-Id: <20220804084135.92425-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Patch1-3 are fixes for prematurely wakeups and patch4-8 are cleanups.

Patch2 fixes when prematurely wakeup happens after kthread_bind_mask().
Patch3 fixes when prematurely wakeup happens before kthread_bind_mask().
Patch1 prepares for patch2-3.

Like Petr's patch[1], a completion is introduced to do the synchronization,
but the synchronization is done in a different direction which allows the
newly created worker itself do some initialization instead of the manager
and allows for a more simplified code.
(The changed synchronization direction is not necessarily better.)

And make workqueue code less dependence on the semantics that kthread
provides.


[1]: https://lore.kernel.org/all/20220622140853.31383-1-pmladek@suse.com/
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tejun Heo <tj@kernel.org>,
Cc: Petr Mladek <pmladek@suse.com>
Cc: Michal Hocko <mhocko@suse.com>,
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Wedson Almeida Filho <wedsonaf@google.com>

Lai Jiangshan (8):
  workqueue: Unconditionally set cpumask in worker_attach_to_pool()
  workqueue: Make create_worker() safe against prematurely wakeups
  workqueue: Set PF_NO_SETAFFINITY instead of kthread_bind_mask()
  workqueue: Set/Clear PF_WQ_WORKER while attaching/detaching
  workqueue: Use worker_set_flags() in worker_enter_idle()
  workqueue: Simplify the starting of the newly created worker
  workqueue: Remove the outer loop in maybe_create_worker()
  workqueue: Move the locking out of maybe_create_worker()

 kernel/workqueue.c          | 123 +++++++++++++++---------------------
 kernel/workqueue_internal.h |  11 +++-
 2 files changed, 60 insertions(+), 74 deletions(-)

-- 
2.19.1.6.gb485710b

