Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8905355E8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiEZWA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiEZWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:00:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34202E64CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:00:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q18so2538306pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L13M0F9NxiPHveFjyllGolTcp/lf7VfViNUmkBL3NJ4=;
        b=fxMVfzAma/2UFbX6F1qGIb1S1cQQL4VJIyvgH8veXhWk0USTVuf66u3uaYwgP5ruEt
         Y3ci3u3oDbv7zjFtf22escAhE63im+kHFjlI4om/p8hcFuK2QKsY5SRbqQbZ6VxbvATv
         Y72ub3RthKUis/RR8bgyynD7eF2ybhIYjmDE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L13M0F9NxiPHveFjyllGolTcp/lf7VfViNUmkBL3NJ4=;
        b=Numzn3tLTIhVQOUmnV89uIhucPGfFK3RYH06psEcxkNcLGhWv8nXJYNHLUBd+WBZ4b
         N1CwKeCwyDuRK1DtRhRUfZ75ztV9WPCJuPoaM53F12vodITR/awZE/R0yGnZKbztK4DK
         hej8oGS+MtrIdayzEGV/8Drk+6v0L3r/lsMyZve4PzsxACGFeNnCasMCaSiLNiAb70P4
         TEbmC2kQT06VQAeXw/F5wcd/D1UG7LMYPnBV/tszM2f2esFYnJHdSZpqNGG7Rk/rzRVC
         XRfsaldtTgUfV8iuvQ23Udnw08la77y6YJbCxX0XU069H/ZVh8alxIo0RbVWH26mV+5n
         zp8w==
X-Gm-Message-State: AOAM533ZZQMSldyN5LPua4KZVubRbwozVDfkcjRqn/wLuome3t3tDypU
        3sJL1xFnTMoLHdL2IYWFUYsMvQ==
X-Google-Smtp-Source: ABdhPJzl2g7FolrIOk1zz8wkb91x2ngGdzB1+xPref5V3e98KigQ18H0nesZ8aP4aB+RMO4QZEH2DQ==
X-Received: by 2002:a17:90b:4c4c:b0:1df:bab5:4f56 with SMTP id np12-20020a17090b4c4c00b001dfbab54f56mr4765771pjb.202.1653602422718;
        Thu, 26 May 2022 15:00:22 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090ad51100b001e269bb6bedsm127225pju.38.2022.05.26.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 15:00:22 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [RESEND PATCH v3 0/1] Binder: add TF_UPDATE_TXN to replace outdated txn
Date:   Thu, 26 May 2022 15:00:17 -0700
Message-Id: <20220526220018.3334775-1-dualli@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

Resend [Patch v3] with cover letter in case my previous email failed
to reach the maillist (no comments for 2 weeks).

The previous comments of the old patch can be found at the following link:
https://lore.kernel.org/lkml/CANBPYPjkNWsO94nuG1TkR1DgK2W2kBxiJTriyVB7S3czHTZ1Yg@mail.gmail.com/

I copy and paste the key information here for your convenience.

* Question #1

Note, your subject does not say what TF_UPDATE_TXN is, so it's a bit
hard to determine what is happening here.  Can you clean that up a bit
and sumarize what this new addition does?
How was this tested?

* Answer #1 ===

A more descriptive summary has been added to the new version of patch.

*  Question #2

How was this tested?

* Answer #2

Old kernel: without this TF_UPDATE_TXN patch
New kernel: with this TF_UPDATE_TXN patch
Old apps: without setting TF_UPDATE_TXN
New apps: if (flags & TF_ONE_WAY) flags |= TF_UPDATE_TXN;

1. Compatibility: New kernel + Old apps, to verify the original
behavior doesn't change;

2. Compatibility: Old kernel + New apps, to verify the original
behavior doesn't change;

3. Unit test: New kernel + New apps, to verify the outdated oneway
binder transaction is actually superseded by the latest one (by
enabling BINDER_DEBUG logs);

4. Stress test: New kernel + New apps sending oneway binder
transactions repeatedly, to verify the size of the available async
binder buffer over time, and if the transactions fail as before
(due to async buffer running out).

* Question #3

Did checkpatch pass this?  Please always use --strict and fix up all the
issues that it reports as this is not a normal kernel coding style.

* Answer #3

Yes, the latest version has passed "./scripts/checkpatch.pl --strict"

* Changelog

v3:
  - Add this changelog required by "The canonical patch format"
v2:
  - Fix alignment warnings reported by checkpatch --strict
  - Add descriptive summary in patch subject

Li Li (1):
  Binder: add TF_UPDATE_TXN to replace outdated txn

 drivers/android/binder.c            | 85 ++++++++++++++++++++++++++++-
 drivers/android/binder_trace.h      |  4 ++
 include/uapi/linux/android/binder.h |  1 +
 3 files changed, 87 insertions(+), 3 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

