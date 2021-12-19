Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A447A121
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhLSP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:29:45 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:42151 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhLSP3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:29:44 -0500
X-QQ-mid: bizesmtp52t1639927777tulnilm6
Received: from localhost.localdomain (unknown [223.72.42.161])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 19 Dec 2021 23:29:36 +0800 (CST)
X-QQ-SSF: 01000000000000506000B00A0000000
X-QQ-FEAT: oyH2oFCiE0o4f8xhyy/tB5mhS0MG34dl1UMgfyw9fD+P7O6vEVQ4XE6KsQaTe
        +Ld5LDvs//wl4FAMgiRgr/mSsfFfD1GMjRj/H5XGtmiyi067TgQb1JTR8nc5jcDItNUWItW
        n5QyU+Ck/4g1YuOdvsbtpAkCXbewHLV5E55xQO+RasO6fhfOAiIF8Vn3+FErnc+AcK17vKH
        vP6ryCTzlcfg+W0zluDiyRbN3mjQt/1W8VcKG2d1kQgbEnUYHJBGZw8+lkVAhWIZhwOJzxt
        Oki3rOQwQ+VGLHjcmcwhUlX8dKZSM87IMLGTQLI6FFyjMt7cwwrogZW2Q=
X-QQ-GoodBg: 0
From:   gchen@itskywalker.com
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Chen Gang <gchen@itskywalker.com>
Subject: [PATCH] kernel: time: Return ENXIO instead of ENODEV when call smp_call_function_single fail in clockevents_unbind
Date:   Sun, 19 Dec 2021 23:29:29 +0800
Message-Id: <20211219152929.479876-1-gchen@itskywalker.com>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:itskywalker.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Gang <gchen@itskywalker.com>

smp_call_function_single will return -ENXIO for failure, so ENXIO needs
to be as the default value of cu.res for return instead of ENODEV.

Signed-off-by: Chen Gang <gchen@itskywalker.com>
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d20..59b83bee03e6 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -416,7 +416,7 @@ static void __clockevents_unbind(void *arg)
  */
 static int clockevents_unbind(struct clock_event_device *ced, int cpu)
 {
-	struct ce_unbind cu = { .ce = ced, .res = -ENODEV };
+	struct ce_unbind cu = { .ce = ced, .res = -ENXIO };
 
 	smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
 	return cu.res;
-- 
2.24.0.308.g228f53135a

