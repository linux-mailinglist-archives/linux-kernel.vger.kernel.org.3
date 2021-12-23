Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7788147E358
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbhLWMb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbhLWMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so3429633pjf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXoY750zV3KJiq6WySmMALkMC4HnGBrOATGYOZHzk7s=;
        b=dvMrkU44HKO8rzRIiEZa2SIabSVCp7NP4kJdVYAlaRIKD5wQOsZobqFxO4+1XoRshf
         iI7nfP4Y2g+8KDV37/rvTwlspc5az3m8YC5V08wYusq6x6ROkzag4SwoHFSOgr6yJoYC
         h1GEUJQumyZ0s+YemYZ7AvhCwhgWt8cKcOY57PFaKka9ogFiiS8DroEODHvPmuwlKIH2
         t60YHn9BLHRgMh2G5JQjnBuPhIfiPKn/jbamkz+HjPAUJ4lJ3CGUjFQwTSg/dciea1zj
         itsEsw2GCtBtpKaZAQmOvhTbU4S/tRAF5v9lrQREptHHyvvD3pRqtpQ4HivQplFgB/3W
         5u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXoY750zV3KJiq6WySmMALkMC4HnGBrOATGYOZHzk7s=;
        b=if+MyXP24kW5+PQry0V49g+RDDCabhep40FpG++JjVrBDf4EanhNLya+HjDQhxoZ8I
         5tpdLLVZPTECRunwnz0+voCRp6BbykbfbMSyYvRFIlsSOjQ+4OvRN2nAbp3OoRCILRa9
         dwnFezLqnv9P4r8dTSlJR8xoV2rDjpvlHd28/JIQt4xvYcNmuRGmYhxvdfc6ap52JNN9
         vUfpW3fN6pyrRnEofJwH+F/PXVVwEbFJkOunITBL2rB0WGmwAfwMewa8EW2TrZKfgmcS
         /8wOzqrL66ZeHY5SOx0jRmSrDw5KKWxATyJILeBl5udMzbly+FrhFVIJBAHbZTOThxlO
         RR5g==
X-Gm-Message-State: AOAM5308yK/HavBGZ0sDakMGXhQbV4dyoX7jE9kPnc2TYOAWk553Qw/J
        3JfPBvTlebkKJf26hQOBmdK8Wjn70Co=
X-Google-Smtp-Source: ABdhPJx6k2++QGmXf7DqC9k5ScFJzLc+I8M649wdgM6+EqgiDeoO3lojs76+8Lnsdu0v1VMSOgcQoQ==
X-Received: by 2002:a17:902:b718:b0:143:72b7:409e with SMTP id d24-20020a170902b71800b0014372b7409emr2186926pls.28.1640262682238;
        Thu, 23 Dec 2021 04:31:22 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id t8sm5417066pfj.26.2021.12.23.04.31.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:31:21 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/4] workqueue: cleanups for schedule callbacks part2
Date:   Thu, 23 Dec 2021 20:31:36 +0800
Message-Id: <20211223123140.3789-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit 6d25be5782e4 ("sched/core, workqueues: Distangle worker
accounting from rq lock") changed the schedule callbacks for workqueue.

It simplified the connection between scheduler and workqueue.  But it
caused some code useless and some comments outdated in workqueue which
needs to be cleaned up.

Patch1-3 are the cleanups based on the fact that 6d25be5782e4 changed
to use pool lock in wq_worker_sleeping().

Patch4 is based on the fact that schedule callbacks were changed to be
only called from schedule() which means all modification to nr_running
is on local CPU when the worker is concurrent managed.

Part1:
https://lore.kernel.org/lkml/20211207073543.61092-1-jiangshanlai@gmail.com/

Most patches of part1 are queued.

Lai Jiangshan (4):
  workqueue: Remove the mb() pair between wq_worker_sleeping() and
    insert_work()
  workqueue: Change the comments of the synchronization about the
    idle_list
  workqueue: Use wake_up_worker() in wq_worker_sleeping() instead of
    open code
  workqueue: Convert the type of pool->nr_running to int

 kernel/workqueue.c | 58 ++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

-- 
2.19.1.6.gb485710b

