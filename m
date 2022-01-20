Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24489494D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiATLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiATLhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:37:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAE7C061574;
        Thu, 20 Jan 2022 03:37:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m4so27288080edb.10;
        Thu, 20 Jan 2022 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+9KG1ejug9d7PKyaSuxXeGZzeAwlL2R9CLfOVNzwU0=;
        b=IEGFW5Aty8Jq3kD5qLDZJJ01zyIedpi/a5T3kGStzkA28rb0Ewp/qZpLRhdOF4vUaU
         n0NPZrseq/xKHiit/4QFtk+pQZkmLDmdrPgc30Mngo4UG7NDzeOhkmBohx5Hycq0jsge
         QhFgVrhYUGJI05k7uiZ0laOQ9Kw+OgPeU0ZF67hLkR8sCBkCCyYdM8sLjWcob6/H6oPv
         wkreo8xCmgUiEkXr5QplCbnrN/Suhsvv1pmHMfXlOfn/pH78YewbqgWUouev3/vkOk4K
         Skqj1yrLCm76uYTO9+OGoXG4RLzTZMhhrxYjNkDb90YJ1RsqE9t4cHTSiR/c2VF8HZv3
         Rhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+9KG1ejug9d7PKyaSuxXeGZzeAwlL2R9CLfOVNzwU0=;
        b=8F0E2mIivSWww67ZHg64nqCo7hhqfQ1tRrsJ1d7IZigz7ReQMXp4fA23Ra2+MfJaNo
         CzqiYWYAqqQirTdkIDf2RnZWV3JVAJkR7C91nHM0g8w6a1TcqgMhJUfxBzfAPPCJ+aGs
         lGBnyXCUPmKBzz+idFL/MQdXnYe0V8tWzcKt8VcejfBu3PGvfsFvLUWfpaRboO7Zleum
         zvuWnEOCBuEkixQGPS68Woje5ojgzoJEL82cMplunHMyXyeTB3mkGYxB63Ndb0bb7BDM
         d0p7YXFe3sELoMq4k0H3IySc/YaSPYO2hNroLy5vMZLubUQwrS6JLBuR1Ijy73nWLL1z
         zpYA==
X-Gm-Message-State: AOAM532dLaYvziTLnBwvS0C9uQ/e4akN/kAVRHFjxNseHIz9d4nAQL1z
        cu+OexrC7APDD27MpKdmiiQMblgoWm4=
X-Google-Smtp-Source: ABdhPJzi6IDLCcShRFRpHUMQCcpfTvVDyTQTf/fG2LvUL9co/gEYk+iMaohOdix3ntnDbBQEu7CIKQ==
X-Received: by 2002:a50:a6ce:: with SMTP id f14mr35068118edc.105.1642678659750;
        Thu, 20 Jan 2022 03:37:39 -0800 (PST)
Received: from kwango.local (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id g12sm1174420edv.89.2022.01.20.03.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 03:37:39 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 5.17-rc1
Date:   Thu, 20 Jan 2022 12:37:48 +0100
Message-Id: <20220120113748.26602-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc1

for you to fetch changes up to a0b3a15eab6bc2e90008460b646d53e7d9dcdbbb:

  ceph: move CEPH_SUPER_MAGIC definition to magic.h (2022-01-13 13:40:07 +0100)

There is a trivial conflict caused by removal of ceph_kvmalloc()
helper that went though the akpm tree.  I pushed the resolution to
for-linus-merged just in case.

----------------------------------------------------------------
The highlight is the new mount "device" string syntax implemented
by Venky Shankar.  It solves some long-standing issues with using
different auth entities and/or mounting different CephFS filesystems
from the same cluster, remounting and also misleading /proc/mounts
contents.  The existing syntax of course remains to be maintained.

On top of that, there is a couple of fixes for edge cases in quota
and a new mount option for turning on unbuffered I/O mode globally
instead of on a per-file basis with ioctl(CEPH_IOC_SYNCIO).

----------------------------------------------------------------
Colin Ian King (1):
      rbd: make const pointer spaces a static const array

Jeff Layton (4):
      ceph: drop send metrics debug message
      ceph: don't check for quotas on MDS stray dirs
      ceph: add new "nopagecache" option
      ceph: move CEPH_SUPER_MAGIC definition to magic.h

Kotresh HR (1):
      ceph: Fix incorrect statfs report for small quota

Venky Shankar (6):
      libceph: generalize addr/ip parsing based on delimiter
      libceph: rename parse_fsid() to ceph_parse_fsid() and export
      ceph: new device mount syntax
      ceph: record updated mon_addr on remount
      doc: document new CephFS mount device syntax
      ceph: mount syntax module parameter

Xiubo Li (1):
      ceph: remove redundant Lsx caps check

 Documentation/filesystems/ceph.rst |  25 +++++-
 drivers/block/rbd.c                |   5 +-
 fs/ceph/caps.c                     |   3 +-
 fs/ceph/file.c                     |  24 ++++--
 fs/ceph/metric.c                   |   2 -
 fs/ceph/quota.c                    |  17 ++++
 fs/ceph/super.c                    | 169 ++++++++++++++++++++++++++++++++++---
 fs/ceph/super.h                    |  28 +++---
 include/linux/ceph/libceph.h       |   3 +-
 include/linux/ceph/messenger.h     |   2 +-
 include/uapi/linux/magic.h         |   1 +
 net/ceph/ceph_common.c             |  18 ++--
 net/ceph/messenger.c               |  15 ++--
 13 files changed, 255 insertions(+), 57 deletions(-)
