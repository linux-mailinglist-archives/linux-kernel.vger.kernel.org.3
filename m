Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00F46E66E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhLIKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:18:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45902 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLIKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:18:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2D30CE2534
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B50BC004DD;
        Thu,  9 Dec 2021 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639044920;
        bh=A+OrEiZotiNirthjpCKq+4CYt+y1YtIhR8anR7ZhYnA=;
        h=Date:From:To:cc:Subject:From;
        b=SHJzVnxLYT9DGNFeSGPo6teimsGYrpUBkM5yIPXlgBSXrlJa0S7rWiGyn4JaOow5R
         tT25pKkKr3kW+oKupyNgqf7hQCc5WRjb/nL0eRiKO7yQDweBqqhFC6Bm3B/7+DMr2l
         LxoKXULOOyu1ObIooKh5zbjEacSZ7mBPEsqfzfY9sSeJf3SmKE3tNsa1gw8MHzSt14
         7LOiMy/3849Z9mT3vJ/ApAlNGcSoIwxmmo6py+ta0hL1B25rKzHFDDeAX6pJPd3Xq/
         U9pqL48P4UFz5puMNaNO+3ljIGg0ld8+jKsIb/Ko/m2IkgZb3UWRWhHiVD9tOlLLr/
         3sPxa+/xPV3ZQ==
Date:   Thu, 9 Dec 2021 11:15:17 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2112091110510.16505@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fixes for HID subsystem.

=====
- fixes for various drivers which assume that a HID device is on USB
  transport, but that might not necessarily be the case, as the device
  can be faked by uhid. (Greg, Benjamin Tissoires)
- fix for spurious wakeups on certain Lenovo notebooks (Thomas 
  Weiﬂschuh)
- a few other device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (2):
      HID: sony: fix error path in probe
      HID: bigbenff: prevent null pointer dereference

Greg Kroah-Hartman (6):
      HID: add hid_is_usb() function to make it simpler for USB detection
      HID: wacom: fix problems when device is not a valid USB device
      HID: check for valid USB device for many HID drivers
      HID: add USB_HID dependancy on some USB HID drivers
      HID: add USB_HID dependancy to hid-chicony
      HID: add USB_HID dependancy to hid-prodikeys

Hans de Goede (2):
      HID: quirks: Add quirk for the Microsoft Surface 3 type-cover
      HID: Ignore battery for Elan touchscreen on Asus UX550VE

Thomas Weiﬂschuh (1):
      HID: intel-ish-hid: ipc: only enable IRQ wakeup when requested

xiazhengqiao (1):
      HID: google: add eel USB id

 drivers/hid/Kconfig                     | 10 +++++-----
 drivers/hid/hid-asus.c                  |  6 ++----
 drivers/hid/hid-bigbenff.c              |  2 +-
 drivers/hid/hid-chicony.c               |  3 +++
 drivers/hid/hid-corsair.c               |  7 ++++++-
 drivers/hid/hid-elan.c                  |  2 +-
 drivers/hid/hid-elo.c                   |  3 +++
 drivers/hid/hid-ft260.c                 |  3 +++
 drivers/hid/hid-google-hammer.c         |  2 ++
 drivers/hid/hid-holtek-kbd.c            |  9 +++++++--
 drivers/hid/hid-holtek-mouse.c          |  9 +++++++++
 drivers/hid/hid-ids.h                   |  3 +++
 drivers/hid/hid-input.c                 |  2 ++
 drivers/hid/hid-lg.c                    | 10 ++++++++--
 drivers/hid/hid-logitech-dj.c           |  2 +-
 drivers/hid/hid-prodikeys.c             | 10 ++++++++--
 drivers/hid/hid-quirks.c                |  1 +
 drivers/hid/hid-roccat-arvo.c           |  3 +++
 drivers/hid/hid-roccat-isku.c           |  3 +++
 drivers/hid/hid-roccat-kone.c           |  3 +++
 drivers/hid/hid-roccat-koneplus.c       |  3 +++
 drivers/hid/hid-roccat-konepure.c       |  3 +++
 drivers/hid/hid-roccat-kovaplus.c       |  3 +++
 drivers/hid/hid-roccat-lua.c            |  3 +++
 drivers/hid/hid-roccat-pyra.c           |  3 +++
 drivers/hid/hid-roccat-ryos.c           |  3 +++
 drivers/hid/hid-roccat-savu.c           |  3 +++
 drivers/hid/hid-samsung.c               |  3 +++
 drivers/hid/hid-sony.c                  | 24 ++++++++++++++++++------
 drivers/hid/hid-thrustmaster.c          |  3 +++
 drivers/hid/hid-u2fzero.c               |  2 +-
 drivers/hid/hid-uclogic-core.c          |  3 +++
 drivers/hid/hid-uclogic-params.c        |  3 +--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  6 ++++--
 drivers/hid/wacom_sys.c                 | 19 +++++++++++++------
 include/linux/hid.h                     |  5 +++++
 36 files changed, 146 insertions(+), 36 deletions(-)

-- 
Jiri Kosina
SUSE Labs

