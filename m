Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112B948C79D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354823AbiALPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:50:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38400 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354866AbiALPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:50:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFFBF1F3C7;
        Wed, 12 Jan 2022 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642002611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8keHR1XaAKInjFYgnWSsZR+jlQEPAubyqwgiql5VcGw=;
        b=ovl8zmjJfmx4RZ+OjxyHHNCsSMuiKjDOVZyKgzvirgUioObquWnbz3t4xRcfTGhWARHaam
        1H7vjFc1ZEjUc6SXAZxMj6z0mYs2T+aMRcjU+kAf6Ldlb64Y9XYNznQGq8Jtzoxo0BEAJu
        kynAt7vmmTnZBGA6CenJO8x5UovHs/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BE8413B75;
        Wed, 12 Jan 2022 15:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6aHqILP43mHKMAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 12 Jan 2022 15:50:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.17-rc1
Date:   Wed, 12 Jan 2022 16:50:11 +0100
Message-Id: <20220112155011.1990-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17-rc1-tag

xen: branch for v5.17-rc1

It contains the following patches:

- a fix of the Xen gntdev driver
- a fix for running as Xen dom0 booted via EFI and the EFI framebuffer
  being located above 4GB
- a series for support of mapping other guest's memory by using zone
  device when running as Xen guest on Arm 

Thanks.

Juergen

 Documentation/devicetree/bindings/arm/xen.txt |  14 +--
 arch/arm/xen/enlighten.c                      | 132 ++++++++++++++++++++++++--
 arch/x86/xen/vga.c                            |  12 ++-
 drivers/xen/Kconfig                           |   2 +-
 drivers/xen/balloon.c                         |  20 ++--
 drivers/xen/gntdev.c                          |   6 +-
 drivers/xen/unpopulated-alloc.c               |  87 ++++++++++++++++-
 include/xen/balloon.h                         |   3 +
 include/xen/interface/xen.h                   |   3 +
 include/xen/xen.h                             |  16 ++++
 10 files changed, 259 insertions(+), 36 deletions(-)

Jan Beulich (1):
      xen/x86: obtain upper 32 bits of video frame buffer address for Dom0

Oleksandr Andrushchenko (1):
      xen/gntdev: fix unmap notification order

Oleksandr Tyshchenko (6):
      xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
      arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
      xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
      xen/unpopulated-alloc: Add mechanism to use Xen resource
      arm/xen: Read extended regions from DT and init Xen resource
      dt-bindings: xen: Clarify "reg" purpose
