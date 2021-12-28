Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CE3480D30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhL1VJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:09:21 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:55101 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhL1VJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:09:20 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 2Jign9Hrmw2Xx2JignvJl9; Tue, 28 Dec 2021 22:09:19 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 28 Dec 2021 22:09:19 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        jose.exposito89@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] HID: magicmouse: Fix an error handling path in magicmouse_probe()
Date:   Tue, 28 Dec 2021 22:09:17 +0100
Message-Id: <b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the timer introduced by the commit below is started, then it must be
deleted in the error handling of the probe. Otherwise it would trigger
once the driver is no more.

Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-magicmouse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index eba1e8087bfd..b8b08f0a8c54 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -873,6 +873,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
+	del_timer_sync(&msc->battery_timer);
 	hid_hw_stop(hdev);
 	return ret;
 }
-- 
2.32.0

