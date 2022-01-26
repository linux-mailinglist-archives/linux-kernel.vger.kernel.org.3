Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5E49C4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiAZHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiAZHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:39:18 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714EC06161C;
        Tue, 25 Jan 2022 23:39:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CCD72832BD;
        Wed, 26 Jan 2022 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643182756; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=1XYhJxhLEI0jsKVRFSc/Ptb0Uc4+hTv/fs8LypLKz2A=;
        b=sRvZWniWIBHHgXzU7mbdd4K32ZDmPz3ZTuPfFNO4eMNZNpi6sWK9xlpx594CoAt7JahT9v
        P6Gukon9p9HcNVj1Ie7OV9dRisLciLin944MHv7jYco/6dunCnPX5pqjOknHO30yEkUHmp
        fbo520kxnzpvzhzSOuY7bmol2oUhDpB7GCfu0mhEia4diwv8Iq1cAHRb02MCUwB3c5PySK
        8UfsOqRQdfoteKnMD/clILhd98eZnpdrLl/vvEMSxbeSTNeZb8gBzJDqH5iN6ZJeolKBgq
        6WRQLFa7ilH1DOm5hcXrGeIkoqFkvqwXa+f45czs/tlM0MXbrE0X7HnJwd/ocg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v7 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Wed, 26 Jan 2022 10:39:03 +0300
Message-Id: <20220126073905.3637841-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar
to RTL8822CS with hci_ver = 0x0a observed on the Tanix TX6 Android set-top
box and JetHome JetHub H1.

While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some
cases the kernel could not initialize it. However, manually resetting the
adapter via gpio allows it to start correctly.
Apparently at system start the adapter is in an undefined state (including
the unknown state of gpio after starting uboot). A forced reset helps to
initialize the adapter in most cases. Experimentally it was found that
100ms is enough to reset.
So, add power reset via enable-gpios in h5_btrtl_open function.

Changes from v6..v4:
- fix patch description
Changes from v3:
- add has_msft_ext option
Changes from v2:
- align the patches for bluetooth-next
Changes from v1:
- remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable

Vyacheslav Bocharov (2):
  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open

 drivers/bluetooth/btrtl.c  | 8 ++++++++
 drivers/bluetooth/hci_h5.c | 5 +++++
 2 files changed, 13 insertions(+)

-- 
2.30.2

