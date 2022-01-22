Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0FB496B91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiAVJtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:49:18 -0500
Received: from mail.hust.edu.cn ([202.114.0.240]:58590 "EHLO hust.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229773AbiAVJtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:49:17 -0500
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 20M9mYeN013481-20M9mYeQ013481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 22 Jan 2022 17:48:39 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Salah Triki <salah.triki@gmail.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hid: elo: fix memory leak in elo_probe
Date:   Sat, 22 Jan 2022 17:48:26 +0800
Message-Id: <20220122094827.684542-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

When hid_parse in elo_probe fails, it forgets to call usb_put_dev to
decrease the refcount.

Fix this by adding usb_put_dev in the error handling code of elo_probe

Fixes: fbf42729d0e9 ("HID: elo: update the reference count of the usb device structure")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/hid/hid-elo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 8e960d7b233b..9b42b0cdeef0 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -262,6 +262,7 @@ static int elo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	return 0;
 err_free:
+	usb_put_dev(udev);
 	kfree(priv);
 	return ret;
 }
-- 
2.25.1

