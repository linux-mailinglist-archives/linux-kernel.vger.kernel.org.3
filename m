Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539875AB3E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiIBOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiIBOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:43:46 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1303F1C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:04:55 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MK05G58gxzMprrk;
        Fri,  2 Sep 2022 16:04:02 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MK05G3jFtzlh8lB;
        Fri,  2 Sep 2022 16:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662127442;
        bh=DKeH0QBhZBlZkVXCcVJahDvxYW92XszACrnYqFmxnYI=;
        h=From:To:Cc:Subject:Date:From;
        b=EfJsWgTdzJFSh17SfLFoir/JpoLnCCHypKF5q5vYRUWLag1uuwBUDqyzwmBKlvKbU
         7WhguAmFg22688d5doyLVZAVTCIiZS9O/OvLuSmWVRZ5f5PYkT7e0KieoYF2L2a0Fy
         Bq6k8krMNSE2EA6IRZLaxMxyARdmWodzwwcqAlHM=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.0
Date:   Fri,  2 Sep 2022 16:04:00 +0200
Message-Id: <20220902140400.1617323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This change fixes a mis-handling of the LANDLOCK_ACCESS_FS_REFER right
when multiple rulesets/domains are stacked. The expected behaviour was
that an additional ruleset can only restrict the set of permitted
operations, but in this particular case, it was potentially possible to
re-gain the LANDLOCK_ACCESS_FS_REFER right.

Please pull this Landlock fix for v6.0-rc4 .  These changes merged
cleanly with your tree, and have been successfully tested in the latest
linux-next releases for a week.  This should be backported to v5.19 .

Regards,
 Mickaël

--
The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.0-rc4

for you to fetch changes up to 55e55920bbe3ccf516022c51f5527e7d026b8f1d:

  landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFER (2022-09-02 15:29:08 +0200)

----------------------------------------------------------------
Landlock fix for v6.0-rc4

----------------------------------------------------------------
Mickaël Salaün (1):
      landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFER

 security/landlock/fs.c                     |  48 ++++-----
 tools/testing/selftests/landlock/fs_test.c | 155 +++++++++++++++++++++++++++--
 2 files changed, 170 insertions(+), 33 deletions(-)
