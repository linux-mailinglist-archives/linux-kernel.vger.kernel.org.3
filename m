Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BEE490B81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiAQPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiAQPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:36:56 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB237C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:36:55 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id t5-20020aa7db05000000b00402670daeb9so3551052eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D5zXK5qLO3bVoV33LMvpL2FWcVowRu1hQWlgAbCJHpA=;
        b=a23bcaepPjQ8GwMvIrsqcO3I+qkNKOfqSDobYh1MxL8LIOlz/qdVxh3/H7KIxVjh9g
         aCxWffXmEFbz+MASZhEN0Vj57XEgCaSzaRx0S4dBykk+pz/n7qjlRSAvoy55Qq2OXl6K
         d9WXfD0Q665VK1vUPNTyOa87PrQSqZbS7EE/sHd3zJH/83S9JPfOxVJaAqSmx98F+9OU
         +Y5+fGIl02YPzR2Cab4Rk20KA8OIbGX8wFGzL2mPnQzRLrSEZqYF8NLhN4xqsbuQPqPO
         BMd2S8updu3JXiAiGqVHtKBCwjYlEAKCxo3rOOLFHhc1MRZE1GzsQ4fA0aHm+bo6/dSB
         T8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D5zXK5qLO3bVoV33LMvpL2FWcVowRu1hQWlgAbCJHpA=;
        b=ROgj/0Tlh5VkeowPXRDH9a9IY5cdA6nW92AaqgXSDA5x2B7YHNuY6qlHbF+IT4RD9p
         biYr+GglVXV/AJVj63g1okPC6TBSPkzsmZQUjNWnPMgpu/u3G4SIzHpml245SJx7+D4k
         dTc7sMTmYqtvNXKjaALim0+Ubzgpvx3RApMcyRMY6jpx1RkLawNQvlL+Def9bMxth1tu
         bpavQV02WH0fXv68WDqPdaaObw53+f+6orUpcxur8OO3qlxLWX93Tz0NmP4cel+7mAW/
         8kPyHSza/rWKcSliCX3MWrJukRd7p+pmw3yEzbkwdtK7Jf1HM/ogJ2QYcxTRFlkkFlKI
         SV0Q==
X-Gm-Message-State: AOAM530Khm3nK/ZaU6/zBxV5W/RYBkHN1MOMtDAA6wwxZ+Wlw/pCRcSY
        De7psV3k7Lx9m0Pf5kqb1swkUvla9GQ=
X-Google-Smtp-Source: ABdhPJxd3dOLO/LQXzlHqPYcESg0/0e88LR+c/jYGKyWKhvb7oXqqF7kk8c7SYga+TGXL7X55lHdVKCQ4pc=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a17:906:7301:: with SMTP id
 di1mr17404761ejc.94.1642433814284; Mon, 17 Jan 2022 07:36:54 -0800 (PST)
Date:   Mon, 17 Jan 2022 15:36:32 +0000
Message-Id: <20220117153634.150357-1-nogikh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 0/2] kcov: improve mmap processing
From:   Aleksandr Nogikh <nogikh@google.com>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de,
        nogikh@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent mmaps of the same kcov descriptor currently do not update the
virtual memory of the task and yet return 0 (success). This is
counter-intuitive and may lead to unexpected memory access errors.

Also, this unnecessarily limits the functionality of kcov to only the
simplest usage scenarios. Kcov instances are effectively forever attached
to their first address spaces and it becomes impossible to e.g. reuse the
same kcov handle in forked child processes without mmapping the memory
first. This is exactly what we tried to do in syzkaller and
inadvertently came upon this behavior.

This patch series addresses the problem described above.

v1 of the patch:
https://lore.kernel.org/lkml/20211220152153.910990-1-nogikh@google.com/

Changes from v1 to v2:
- Split into 2 commits.
- Minor coding style changes.

v2 of the patch:
https://lore.kernel.org/lkml/20211221170348.1113266-1-nogikh@google.com/T/

Changes from v2 to v3:
- The first commit now implements purely non-functional changes.
- No extra function is introduced in the first commit.

Aleksandr Nogikh (2):
  kcov: split ioctl handling into locked and unlocked parts
  kcov: properly handle subsequent mmap calls

 kernel/kcov.c | 98 ++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

-- 
2.34.1.703.g22d0c6ccf7-goog

