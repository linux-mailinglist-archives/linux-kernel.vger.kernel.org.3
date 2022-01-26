Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663EE49C344
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiAZFbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiAZFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:31:16 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4127DC06161C;
        Tue, 25 Jan 2022 21:31:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27A23282C35;
        Wed, 26 Jan 2022 05:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643175073; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=YOfgQExRnXZws1Kkx/XHQ9jUnvGUzFT9ZKFE05XWWUA=;
        b=l3zdk/nU4yugLEocKgpOuQYxGv7w4BlW55TEN588WU92NWXog/AEf8W0juSsrLoY5wHCGR
        ha5p0OnffLQZBUsLQPUtfRqg14grMWtHY9Ouqz4wglIznUZ4oTs8g8fikCnk2qxALl5YbM
        9OAmqMKvp2j3gnZpRWDTqkFElBmZ8qBRgHML6DIXvBLdETWL+F1Avg/BSPwNUlXcYipp90
        2rVzXmqoww4JoUIMNqBeghbanPdEBjeSk/k+nPwwrmoMoBJen1UCvnAnndOSOpFe8W6FG/
        ooSBqNxHPLu5oQucL2eFUO8Em74pgBWx0gkMiddK64waweaFUsfIaB5Cf66y4w==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v6 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Wed, 26 Jan 2022 08:31:01 +0300
Message-Id: <20220126053103.3261693-1-adeep@lexina.in>
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

Changes from v5:
- fix patch description
Changes from v4:
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

