Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561BA47A0D2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhLSOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 09:08:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55404 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhLSOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 09:08:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFCD11F395;
        Sun, 19 Dec 2021 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639922885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VDaoOhXTAE6mvKzI3VQ0G2/m0imu0+bEFk1/v6du8uA=;
        b=yXNOPm80Y/JQY0lG3Fx+3PjX/lEMh0vmC2wUVKADk5UOXyyYu6AnRhDppyBjYkWIaSm7U3
        wIVyFRoK8S+pvIS45YDPAAin3ZBWz4EPBQemE3CjRXMNEaRvgfNEayfrYdhG6NykbuDS1p
        jV/o9N8ypMliUKZ10DZSglgq9iB/i7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639922885;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VDaoOhXTAE6mvKzI3VQ0G2/m0imu0+bEFk1/v6du8uA=;
        b=2hlKg5+RjEMT9/95OEL3OD8RkDoGHID05sRt9HNYMhIFRGSxAklhuh6+eWSmnLUgNYf63N
        zpwzcvfC2rVvbhAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A376B133FE;
        Sun, 19 Dec 2021 14:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q+WFJ8U8v2ECSAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 19 Dec 2021 14:08:05 +0000
Date:   Sun, 19 Dec 2021 15:08:08 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.16-rc6
Message-ID: <Yb88yFbu5LkRigfz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

aaand the last one for this week: two urgent IRQ subsystem fixes for
5.16.

Please pull,
thx.

---

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.16_rc6

for you to fetch changes up to 94185adbfad56815c2c8401e16d81bdb74a79201:

  PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error (2021-12-14 13:23:32 +0100)

----------------------------------------------------------------
- Clear the PCI_MSIX_FLAGS_MASKALL bit too on the error path so that it
is restored to its reset state

- Mask MSI-X vectors late on the init path in order to handle
out-of-spec Marvell NVME devices which apparently look at the MSI-X mask
even when MSI-X is disabled

----------------------------------------------------------------
Stefan Roese (1):
      PCI/MSI: Mask MSI-X vectors only on success

Thomas Gleixner (1):
      PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error

 drivers/pci/msi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
