Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2F47BE53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhLUKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhLUKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA6C061401
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-0005BB-O7; Tue, 21 Dec 2021 11:46:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-005nfv-0Z; Tue, 21 Dec 2021 11:46:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceg-0004BV-Qw; Tue, 21 Dec 2021 11:46:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] counter: ftm-quaddec: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:40 +0100
Message-Id: <20211221104546.214066-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=BLGgbKMWZQKSAyjRUdMvXiPE7PeMpJ6W8Y/gNVLaPbQ=; m=aj1hUrB8DlH//87Ydw8Bemkjf0cLnFHRoYJEeeBnUfI=; p=O6E+g1NOkcrJHwxshcrDT/kwLeZH9H/HJ0p6iqUb3Zc=; g=ba193b2403a26e3f2c830b4207aeb7b8d7652685
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsDIACgkQwfwUeK3K7AkjFwf/Z+s aPbKKu9y3QG6gzgKXVIXvCg/YvmgmrA/o+IEmMp7m1FyxUs2CVJ83/JQ1jNGZB6bjfHnT+5OzgzEU fKAoYdEbdIWQlHuXfxYv9Xa5FrvvKuvLzdSRqm1IPf7WM+gIeufwqBz4yykKHTwmOsgGOUJpdAMR8 v04MLAH41tkEfFJztxZFOYmVdQAqftuT1KOXc+Tek2tZwIuiecp6YKNhdVA05iCTVzxBb89vaLEvf uHCfovZ1yzhSJDVBx+jp3Ao0vGfJM41QVkn0Hqltdp+Qf51jBlqo4woG1ju5FRfp38VD2vRuReg7n v5get7KQuA9luvgKhF1qJSc834iyAgg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition. (In this case even a noop
because the offset is 0.)

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-60 (-60)
	Function                                     old     new   delta
	ftm_quaddec_set_prescaler                    612     600     -12
	ftm_quaddec_probe                            596     584     -12
	ftm_quaddec_get_prescaler                    156     144     -12
	ftm_quaddec_count_write                      232     220     -12
	ftm_quaddec_count_read                       152     140     -12
	Total: Before=5096, After=5036, chg -1.18%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 5ef0478709cd..b58a4f54e97b 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -33,6 +33,11 @@ struct ftm_quaddec {
 	struct mutex ftm_quaddec_mutex;
 };
 
+static inline struct ftm_quaddec *ftm_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct ftm_quaddec, counter);
+}
+
 static void ftm_read(struct ftm_quaddec *ftm, uint32_t offset, uint32_t *data)
 {
 	if (ftm->big_endian)
@@ -118,7 +123,7 @@ static void ftm_quaddec_disable(void *ftm)
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 *cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = ftm_from_counter(counter);
 	uint32_t scflags;
 
 	ftm_read(ftm, FTM_SC, &scflags);
@@ -131,7 +136,7 @@ static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 static int ftm_quaddec_set_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = ftm_from_counter(counter);
 
 	mutex_lock(&ftm->ftm_quaddec_mutex);
 
@@ -162,7 +167,7 @@ static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
 				  u64 *val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = ftm_from_counter(counter);
 	uint32_t cntval;
 
 	ftm_read(ftm, FTM_CNT, &cntval);
@@ -176,7 +181,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
 				   const u64 val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = ftm_from_counter(counter);
 
 	if (val != 0) {
 		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
@@ -292,7 +297,6 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	ftm->counter.num_counts = 1;
 	ftm->counter.signals = ftm_quaddec_signals;
 	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
-	ftm->counter.priv = ftm;
 
 	mutex_init(&ftm->ftm_quaddec_mutex);
 
-- 
2.33.0

