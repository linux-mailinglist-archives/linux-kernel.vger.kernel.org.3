Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D84950DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbiATPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:04:02 -0500
Received: from giacobini.uberspace.de ([185.26.156.129]:60438 "EHLO
        giacobini.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbiATPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:04:00 -0500
Received: (qmail 17099 invoked by uid 990); 20 Jan 2022 15:03:56 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Soenke Huster <soenke.huster@eknoes.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: fix null pointer deref in device_find_child
Date:   Thu, 20 Jan 2022 16:02:46 +0100
Message-Id: <20220120150246.6216-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-1.698639)
X-Rspamd-Score: -0.298639
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Thu, 20 Jan 2022 16:03:56 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to device_for_each_child, device_find_child should not ooops
if parent->p is NULL. While fuzzing the Bluetooth subsystem, I got a null
pointer dereference in next_device, which is prevented by this change.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=215497
Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
I found this while fuzzing the bluetooth subsystem and reported this bug
in bugzilla. As I feel more like a kernelnewbie, I am not sure whether
this needs to be patched in driver core, or is just an issue of the
bluetooth subsystem itself. If the latter is the case: sorry for the
spam!

A similar fix was applied in 014c90dbb9b6 ("driver core: prevent
device_for_each_child from oopsing") for device_for_each_child, which is
mentioned in the docstring of device_find_child as similar function.

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bb957b11861..654d904631f9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3780,7 +3780,7 @@ struct device *device_find_child(struct device *parent, void *data,
 	struct klist_iter i;
 	struct device *child;
 
-	if (!parent)
+	if (!parent || !parent->p)
 		return NULL;
 
 	klist_iter_init(&parent->p->klist_children, &i);
-- 
2.34.1

