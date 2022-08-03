Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4E58884B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiHCHwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiHCHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:52:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF9F22B20
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:52:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 46D3D1FA1D;
        Wed,  3 Aug 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659513147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sr704n3E+uzEfLfboBuOTEXvE58GeQo8M8jf8i1d0wo=;
        b=AebRSCnYhod5FFONkbzTNUZTBG3L/F4GVPo3Z4G21ul82l+lNmkK7r8ZoBiyd1054aEHGC
        BgQxd2/AuRViZxMvU+OYN+hX+91qd+i2D1MSV6UaZ7yMig4XgS5EN4LqpBvVPmFtwD1oz/
        OamEmK+LOcnTU8KuSx0xdDYGIqOj0Cs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EC4713AD8;
        Wed,  3 Aug 2022 07:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a/roBTsp6mKPWAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 03 Aug 2022 07:52:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.0-rc1
Date:   Wed,  3 Aug 2022 09:52:26 +0200
Message-Id: <20220803075226.2400-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc1-tag

xen: branch for v6.0-rc1

It contains:

- a series fine tuning virtio support for Xen guests, including removal
  the now again unused "platform_has()" feature.

- a fix for host admin triggered reboot of Xen guests

- a simple spelling fix

Thanks.

Juergen

 MAINTAINERS                            |  8 --------
 arch/arm/xen/enlighten.c               |  4 +++-
 arch/s390/mm/init.c                    |  4 ++--
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++--
 arch/x86/xen/enlighten_hvm.c           |  4 +++-
 arch/x86/xen/enlighten_pv.c            |  5 ++++-
 drivers/virtio/Kconfig                 |  4 ++++
 drivers/virtio/Makefile                |  1 +
 drivers/virtio/virtio.c                |  4 ++--
 drivers/virtio/virtio_anchor.c         | 18 ++++++++++++++++++
 drivers/xen/Kconfig                    |  9 +++++++++
 drivers/xen/grant-dma-ops.c            | 10 ++++++++++
 drivers/xen/manage.c                   |  2 +-
 drivers/xen/xen-front-pgdir-shbuf.c    |  4 ++--
 include/asm-generic/Kbuild             |  1 -
 include/asm-generic/platform-feature.h |  8 --------
 include/linux/platform-feature.h       | 19 -------------------
 include/linux/virtio_anchor.h          | 19 +++++++++++++++++++
 include/xen/xen-ops.h                  |  9 +++++++++
 include/xen/xen.h                      |  8 --------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 ---------------------------
 22 files changed, 90 insertions(+), 84 deletions(-)

Juergen Gross (4):
      virtio: replace restricted mem access flag with callback
      kernel: remove platform_has() infrastructure
      xen: don't require virtio with grants for non-PV guests

Ross Lagerwall (1):
      xen/manage: Use orderly_reboot() to reboot

Zhang Jiaming (1):
      xen: Fix spelling mistake
