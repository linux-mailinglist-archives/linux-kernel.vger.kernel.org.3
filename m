Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E505A5308CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355642AbiEWFbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbiEWFbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:31:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC98B492
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:31:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 379D71F383;
        Mon, 23 May 2022 05:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653283865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uphm0Y/N5CG4YBHQqvTXWrYN71GenUf/+ErGraqLDVw=;
        b=oe0ld5c9q1l5HfqybFBHAgBmpX6oV8nAMIA4HoOXTmFMJ77+3cGiMQBN0qk2K42kg1vs2g
        qEK2g3iFiJQ3xcrOBBkzSMsjO7ZWSWfjFHQtbtfBWdxyl/TKls8B4agxhcTSg/Oa0vUKW2
        yjrm6zLfrK/fxscwCKTbJCKyry4z0Rs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F2313A5F;
        Mon, 23 May 2022 05:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sVReAxkci2K2bAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 23 May 2022 05:31:05 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.19-rc1
Date:   Mon, 23 May 2022 07:31:04 +0200
Message-Id: <20220523053104.22814-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19-rc1-tag

xen: branch for v5.19-rc1

It contains:

- a series for the Xen scsifront/scsiback pv drivers to decouple the
  PV interface from kernel internals
- a patch to harden the Xen scsifront PV driver against a malicious
  backend driver
- a series to simplify Xen PV frontend driver ring page setup
- a series to support Xen setups with multiple domains created at boot
  time to tolerate Xenstore coming up late
- two small cleanup patches

Thanks.

Juergen

 Documentation/ABI/testing/sysfs-driver-xen-blkback |   4 +-
 .../ABI/testing/sysfs-driver-xen-blkfront          |   2 +-
 arch/x86/xen/enlighten_pv.c                        |   2 -
 drivers/block/xen-blkfront.c                       |  57 ++----
 drivers/char/tpm/xen-tpmfront.c                    |  18 +-
 drivers/gpu/drm/xen/xen_drm_front.h                |   9 -
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c        |  43 ++---
 drivers/net/xen-netfront.c                         |  85 +++------
 drivers/pci/xen-pcifront.c                         |  19 +-
 drivers/scsi/xen-scsifront.c                       | 199 ++++++++++++++-------
 drivers/usb/host/xen-hcd.c                         |  65 ++-----
 drivers/xen/gntdev-dmabuf.c                        |  13 +-
 drivers/xen/grant-table.c                          |  12 +-
 drivers/xen/xen-front-pgdir-shbuf.c                |  18 +-
 drivers/xen/xen-scsiback.c                         |  82 ++++++++-
 drivers/xen/xenbus/xenbus_client.c                 |  82 ++++++---
 drivers/xen/xenbus/xenbus_probe.c                  |  91 +++++++---
 include/xen/grant_table.h                          |   2 -
 include/xen/interface/grant_table.h                | 161 ++++++++++-------
 include/xen/interface/io/ring.h                    |  19 +-
 include/xen/interface/io/vscsiif.h                 | 133 +++++++++++++-
 include/xen/interface/io/xs_wire.h                 |  37 +++-
 include/xen/xenbus.h                               |   4 +-
 sound/xen/xen_snd_front_evtchnl.c                  |  44 ++---
 sound/xen/xen_snd_front_evtchnl.h                  |   9 -
 25 files changed, 734 insertions(+), 476 deletions(-)

Juergen Gross (25):
      xen: update vscsiif.h
      xen/scsiback: use new command result macros
      xen/scsifront: use new command result macros
      xen/scsifront: harden driver against malicious backend
      xen: update grant_table.h
      xen/grant-table: never put a reserved grant on the free list
      xen/blkfront: switch blkfront to use INVALID_GRANT_REF
      xen/netfront: switch netfront to use INVALID_GRANT_REF
      xen/scsifront: remove unused GRANT_INVALID_REF definition
      xen/usb: switch xen-hcd to use INVALID_GRANT_REF
      xen/drm: switch xen_drm_front to use INVALID_GRANT_REF
      xen/sound: switch xen_snd_front to use INVALID_GRANT_REF
      xen/dmabuf: switch gntdev-dmabuf to use INVALID_GRANT_REF
      xen/shbuf: switch xen-front-pgdir-shbuf to use INVALID_GRANT_REF
      xen: update ring.h
      xen/xenbus: add xenbus_setup_ring() service function
      xen/blkfront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/netfront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/tpmfront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/drmfront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/pcifront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/scsifront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/usbfront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/sndfront: use xenbus_setup_ring() and xenbus_teardown_ring()
      xen/xenbus: eliminate xenbus_grant_ring()

Luca Miccio (1):
      xen: add support for initializing xenstore later as HVM domain

Maximilian Heyne (1):
      x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid

SeongJae Park (1):
      xen-blk{back,front}: Update contact points for buffer_squeeze_duration_ms and feature_persistent

Stefano Stabellini (1):
      xen: sync xs_wire.h header with upstream xen
