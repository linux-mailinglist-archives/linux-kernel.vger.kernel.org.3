Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3654E9136
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbiC1J1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiC1J13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:27:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86F326CD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:25:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDA14210EB;
        Mon, 28 Mar 2022 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648459544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yQbLNcQn+EiEzAZTSL8mffrkODdEvNwwdtkHcD/qU6Y=;
        b=GZcWtx+aRlz0jeqVGgVLpB3nivf/6DCZxAsbwtR65d54qS4c6DNgv94yx3SmzlwlaSISIZ
        2r9spbhm8V+PuMe3QK7TlQMBk9uEPj5Q5Vua10oefIhIlAyFaUbSI8ZbqfAdPMHWokkPS9
        G3FFbffyPXHh8Vs+juV7bpRILlAtFXc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C581413B08;
        Mon, 28 Mar 2022 09:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KdzVLhh/QWLGKAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 28 Mar 2022 09:25:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.18-rc1
Date:   Mon, 28 Mar 2022 11:25:44 +0200
Message-Id: <20220328092544.14418-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc1-tag

xen: branch for v5.18-rc1

It contains the following patches:

- A bunch of minor cleanups
- A fix for kexec in Xen dom0 when executed on a high cpu number
- A fix for resuming after suspend of a Xen guest with assigned PCI
  devices
- A fix for a crash due to not disabled preemption when resuming as
  Xen dom0


Thanks.

Juergen

 arch/x86/xen/apic.c                         |   2 +-
 arch/x86/xen/pmu.c                          |  10 +-
 arch/x86/xen/pmu.h                          |   3 +-
 arch/x86/xen/setup.c                        |   2 +-
 arch/x86/xen/smp_hvm.c                      |   6 ++
 arch/x86/xen/smp_pv.c                       |   2 +-
 arch/x86/xen/time.c                         |  24 ++++-
 drivers/block/xen-blkfront.c                |   8 +-
 drivers/char/tpm/xen-tpmfront.c             |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c |   2 +-
 drivers/input/misc/xen-kbdfront.c           |   4 +-
 drivers/net/xen-netfront.c                  |  13 ++-
 drivers/pci/xen-pcifront.c                  |   2 +-
 drivers/scsi/xen-scsifront.c                |   4 +-
 drivers/usb/host/xen-hcd.c                  |   4 +-
 drivers/xen/balloon.c                       |   3 +-
 drivers/xen/gntalloc.c                      |   2 +-
 drivers/xen/gntdev-dmabuf.c                 |   2 +-
 drivers/xen/grant-table.c                   | 151 ++++------------------------
 drivers/xen/manage.c                        |   4 +-
 drivers/xen/pvcalls-front.c                 |   6 +-
 drivers/xen/sys-hypervisor.c                |   5 +-
 drivers/xen/xen-front-pgdir-shbuf.c         |   3 +-
 include/xen/grant_table.h                   |  13 +--
 net/9p/trans_xen.c                          |   8 +-
 sound/xen/xen_snd_front_evtchnl.c           |   2 +-
 26 files changed, 94 insertions(+), 193 deletions(-)

Dongli Zhang (1):
      xen: delay xen_hvm_init_time_ops() if kdump is boot on vcpu>=32

Jakub Kądziołka (1):
      xen: don't hang when resuming PCI device

Jiapeng Chong (1):
      x86/xen: Fix kerneldoc warning

Juergen Gross (3):
      xen/grant-table: remove gnttab_*transfer*() functions
      xen/grant-table: remove readonly parameter from functions
      xen: fix is_xen_pmu()

Wang Qing (1):
      xen: use time_is_before_eq_jiffies() instead of open coding it

jianchunfu (1):
      arch:x86:xen: Remove unnecessary assignment in xen_apic_read()

zhanglianjie (1):
      drivers/xen: use helper macro __ATTR_RW
