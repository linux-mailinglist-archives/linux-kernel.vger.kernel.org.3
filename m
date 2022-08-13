Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E4591A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiHMMz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 08:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHMMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 08:55:55 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191C1659F;
        Sat, 13 Aug 2022 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1660395351;
        bh=dyow3US29L7nNIIk0kYwgU2gRtwkK4FjWK+fdpeBaf0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=V+8gGTH67CEmzO3koupap3I054Opwb0SEWoTc4YedJlhT5Z2aXp3gPKdwkTQLqH9R
         12xgPEo4WAdMUZVshtLLv77ep9mFRfVtXfXbbVo4/AwvirlRLVI3caylIf9+/XPCYc
         ivF/EGIbsJSMqx6JPAbrr1RIYkTlgOQB5ni2S7ow=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9CB831287AE3;
        Sat, 13 Aug 2022 08:55:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qo_7n3QqTPpQ; Sat, 13 Aug 2022 08:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1660395351;
        bh=dyow3US29L7nNIIk0kYwgU2gRtwkK4FjWK+fdpeBaf0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=V+8gGTH67CEmzO3koupap3I054Opwb0SEWoTc4YedJlhT5Z2aXp3gPKdwkTQLqH9R
         12xgPEo4WAdMUZVshtLLv77ep9mFRfVtXfXbbVo4/AwvirlRLVI3caylIf9+/XPCYc
         ivF/EGIbsJSMqx6JPAbrr1RIYkTlgOQB5ni2S7ow=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 53ABA1287AA7;
        Sat, 13 Aug 2022 08:55:50 -0400 (EDT)
Message-ID: <62ef6e3d028a5182f4485d6201a126bbf4ca659c.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 5.19+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 13 Aug 2022 13:55:46 +0100
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

Mostly small bug fixes and trivial updates.  The major new core update
is a change to the way device, target and host reference counting is
done to try to make it more robust (this change has soaked for a while
to try to winkle out any bugs).

[my key just expired so you'll need to do the dane update thing I
showed you]

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Bart Van Assche (3):
      scsi: core: Call blk_mq_free_tag_set() earlier
      scsi: core: Make sure that targets outlive devices
      scsi: ufs: core: Increase the maximum data buffer size

Colin Ian King (2):
      scsi: megaraid_sas: Remove redundant variable cmd_type
      scsi: FlashPoint: Remove redundant variable bm_int_st

Daniil Lunev (1):
      scsi: ufs: ufs-pci: Correct check for RESET DSM

Dmitry Bogdanov (2):
      scsi: target: core: De-RCU of se_lun and se_lun acl
      scsi: target: core: Fix race during ACL removal

Ming Lei (2):
      scsi: core: Simplify LLD module reference counting
      scsi: core: Make sure that hosts outlive targets

Peter Wang (1):
      scsi: ufs: core: Correct ufshcd_shutdown() flow

Slark Xiao (1):
      scsi: pm8001: Fix typo 'the the' in comment

Steffen Maier (1):
      scsi: zfcp: Fix missing auto port scan and thus missing target ports

William Dean (1):
      scsi: lpfc: Check the return value of alloc_workqueue()

And the diffstat:

 drivers/s390/scsi/zfcp_fc.c                 | 29 ++++++++++++++++++--------
 drivers/s390/scsi/zfcp_fc.h                 |  6 ++++--
 drivers/s390/scsi/zfcp_fsf.c                |  4 ++--
 drivers/scsi/FlashPoint.c                   |  4 ++--
 drivers/scsi/hosts.c                        | 18 +++++++++++-----
 drivers/scsi/lpfc/lpfc_init.c               |  2 ++
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  3 +--
 drivers/scsi/pm8001/pm8001_hwi.c            |  2 +-
 drivers/scsi/scsi.c                         |  9 +++++---
 drivers/scsi/scsi_scan.c                    |  9 ++++++++
 drivers/scsi/scsi_sysfs.c                   | 29 +++++++++++++++-----------
 drivers/target/target_core_alua.c           |  3 +--
 drivers/target/target_core_device.c         | 32 ++++++++++-------------------
 drivers/target/target_core_pr.c             | 28 ++++++++-----------------
 drivers/target/target_core_stat.c           | 10 ++++-----
 drivers/target/target_core_xcopy.c          |  2 +-
 drivers/ufs/core/ufshcd.c                   |  7 ++-----
 drivers/ufs/host/ufshcd-pci.c               | 17 +++++++++++----
 include/scsi/scsi_device.h                  |  2 ++
 include/scsi/scsi_host.h                    |  3 +++
 include/target/target_core_base.h           |  4 ++--
 21 files changed, 124 insertions(+), 99 deletions(-)

James


