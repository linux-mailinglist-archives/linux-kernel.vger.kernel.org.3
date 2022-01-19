Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F317B49431C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357575AbiASWjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357571AbiASWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:39:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:39:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso7649202ybp.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XjZ8RB+d8sPw+5fg9bVN+IlJz/1P9+DvWQVKceaoJM8=;
        b=IMnzcAVPPKnkgartfgzwhfE/Czy118XD3wc4hE6frBNinfoLxD8DZDVqmIMcYDMNkG
         cSLYcY8dJ7ClIqbSgFmhfnKX+JZo1v1Z2vTAJxveyH5fr8RQQ7GJTnLh6Sya67YqEB8q
         qV9wU7DujsyTqUA0M9UB+Oz8p+ItETXMHueHX9fI/va/7UNlLDJDF5QZFp+ic2TdRXh5
         fqCYZ8euqOROAi2ZJK0d9WNLEk9OuOSccMknef3tq0SrBCYFUHir3VBT0VrbkZGky91d
         MGFb7NwAitkA57xELb4IofHM6WFd/tna8p5K2wAlfCpjUvZA9gSoJIDr8n+I2S6i7Ios
         Q3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XjZ8RB+d8sPw+5fg9bVN+IlJz/1P9+DvWQVKceaoJM8=;
        b=cIeFhfyHB68p0uCEcFE/+0Lp3Mk+DJIHy5cR0UTnOhU9sn6sdmXnA1GsYkycEUXzwe
         bicM7MzcEnDFt1DHmU6GxD3ULDEXXgauSF7z+7IGwNRdhY0MyWXjKZDAnfT/c3a0NjUJ
         uCv791ZYqgf83PAlFoa9/bp4hgmFs/DCXeb7lw5Lu7aViCuo/hJwkv92GVr7zY55ECKu
         g+C5/H3Xnj+yR4Or6e/F2QLMAikwqUCwm3KRGyNgufN0qornH5uUQYXNoSYCL0O4/DXT
         +NLNbgzGU1cSxay2KJcOr1abCeezD097kz7VpX/DW4KLPAq/hVzKLTfXemDqvk25R6YI
         7YiA==
X-Gm-Message-State: AOAM533VnwjZbd4o7PG/gTG09BvtgB7+V8uyl9I1FrIDzDtJIrigzaFL
        xHrYj2xC2JC6yQ56JTXzyYcCg0yXaNg=
X-Google-Smtp-Source: ABdhPJyFJJZd0mG2HMhp5pIHQ6oM/or/6lOkH1TWxkueh7x93iikQYU2fYa7BXOvTHIRvP1utG7Y0pI+gxI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5c51:e66a:40e8:adec])
 (user=surenb job=sendgmr) by 2002:a25:4b85:: with SMTP id y127mr40046753yba.181.1642631984383;
 Wed, 19 Jan 2022 14:39:44 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:39:38 -0800
Message-Id: <20220119223940.787748-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 0/2] Fix warnings in psi
From:   Suren Baghdasaryan <surenb@google.com>
To:     hannes@cmpxchg.org
Cc:     peterz@infradead.org, mingo@redhat.com, ebiggers@kernel.org,
        tj@kernel.org, willy@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset fixes warnings in the psi module visible only in the below
configurations:
CONFIG_PSI=y && CONFIG_CGROUPS=n
CONFIG_PSI=y && CONFIG_PROC_FS=n
Reproduced using clang version 14.0.0.

The patches are based on sched/urgent branch:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent

Suren Baghdasaryan (2):
  psi: Fix "no previous prototype" warnings when CONFIG_CGROUPS=n
  psi: Fix "defined but not used" warnings when CONFIG_PROC_FS=n

 include/linux/psi.h | 11 +++----
 kernel/sched/psi.c  | 79 +++++++++++++++++++++++----------------------
 2 files changed, 46 insertions(+), 44 deletions(-)

-- 
2.34.1.703.g22d0c6ccf7-goog

