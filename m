Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA55A2213
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbiHZHjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbiHZHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:39:20 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8E9D13D;
        Fri, 26 Aug 2022 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1661499555;
        bh=xbq4JSkJ3q4yhKrUImOqVqkALOzpDY+WNKe5bh9TfsE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=iFYzrZ3KL4kE56bco4SbddMqnXMMhxbDGoJT2RHMo+n/SpBGk4fb5uTBVNcJvJ4Tl
         VCDHXU4U6skLqBvB8kBQZoetqAYQ6Z4LGTTB+Gy9eQHX1Rd7qyyjnJTSAitarFbF9R
         6VGIVjcM44xsuTbD1ExOfNODa9v+YcKLaMUdua/0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D5B5C1280E04;
        Fri, 26 Aug 2022 03:39:15 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pEhvqNtTl1gI; Fri, 26 Aug 2022 03:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1661499555;
        bh=xbq4JSkJ3q4yhKrUImOqVqkALOzpDY+WNKe5bh9TfsE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=iFYzrZ3KL4kE56bco4SbddMqnXMMhxbDGoJT2RHMo+n/SpBGk4fb5uTBVNcJvJ4Tl
         VCDHXU4U6skLqBvB8kBQZoetqAYQ6Z4LGTTB+Gy9eQHX1Rd7qyyjnJTSAitarFbF9R
         6VGIVjcM44xsuTbD1ExOfNODa9v+YcKLaMUdua/0=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E54EC1280AD2;
        Fri, 26 Aug 2022 03:39:13 -0400 (EDT)
Message-ID: <042650172f59fca9836fe523ce14a07daccc4f2d.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 08:39:10 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10 fixes.  Of the three core changes, the two large ones are a complete
reversion of the async rework and an ALUA timing rework (the latter
shouldn't affect non-ALUA paths).  The remaining patches are all small
and all but one in drivers.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alim Akhtar (1):
      scsi: ufs: host: ufs-exynos: Make fsd_ufs_drvs static

Bart Van Assche (2):
      scsi: sd: Revert "Rework asynchronous resume support"
      scsi: ufs: core: Reduce the power mode change timeout

Brian Bunker (1):
      scsi: core: Allow the ALUA transitioning state enough time

Guixin Liu (2):
      scsi: megaraid_sas: Remove unnecessary kfree()
      scsi: megaraid_sas: Fix double kfree()

Kiwoong Kim (1):
      scsi: ufs: core: Enable link lost interrupt

Mike Christie (1):
      scsi: core: Fix passthrough retry counter handling

Saurabh Sengar (1):
      scsi: storvsc: Remove WQ_MEM_RECLAIM from storvsc_error_wq

Tony Battersby (1):
      scsi: qla2xxx: Disable ATIO interrupt coalesce for quad port ISP27XX

And the diffstat:

 drivers/scsi/megaraid/megaraid_sas_base.c   |  8 +--
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  1 -
 drivers/scsi/qla2xxx/qla_target.c           | 10 +---
 drivers/scsi/scsi_lib.c                     | 47 +++++++++-------
 drivers/scsi/sd.c                           | 84 +++++++----------------------
 drivers/scsi/sd.h                           |  5 --
 drivers/scsi/storvsc_drv.c                  |  2 +-
 drivers/ufs/core/ufshcd.c                   |  9 +++-
 drivers/ufs/host/ufs-exynos.c               |  2 +-
 include/ufs/ufshci.h                        |  6 +--
 10 files changed, 60 insertions(+), 114 deletions(-)

With full diff below.

James

---



