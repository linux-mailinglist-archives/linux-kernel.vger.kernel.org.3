Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFF49B871
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbiAYQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353392AbiAYQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:16:47 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE75C061769
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:16:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D558280BDF;
        Tue, 25 Jan 2022 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643127255; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=alWzfi1MKEuU9d1hu1mhFpKqqmhmtWV0WV3Nk7Rkdgs=;
        b=cUNTOhSBJ6zN8EPd3IzMo1VAj0oreQA58uEDLw5qMzQqRpthZj/2XZ+jNUk220EDn545A9
        pxvaD2ngszsYREuyPRqFa65pgneuvsX85ieGL8gyjy5PjWiOdI5aPpTVxN86LZdr0d416E
        mXaCiqwxx+ZudoY5FMEPnt17ltqbXnqKlTKRu55zpiKxY3pdhH96tDUjEuPntwx2+Rap9t
        lnd2lSL89aG44GZvHBPYDoFVnYwZrv/FLBcly+hNRRH4J0UhwDWVkuLExF4llmW4BwsEM+
        JLPQWsOhO7n/VGyy+40eFVRR20W/aykJZ4/ICzjPKgXqGDUAKwzfxR7FN3CMZw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v5 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Tue, 25 Jan 2022 19:13:59 +0300
Message-Id: <20220125161401.729179-1-adeep@lexina.in>
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

Changes from v4:
- fix patch desription
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

