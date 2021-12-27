Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E26E47FBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhL0Jqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3BC061397
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0006YR-G5; Mon, 27 Dec 2021 10:45:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-006u95-8I; Mon, 27 Dec 2021 10:45:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-0005V4-9o; Mon, 27 Dec 2021 10:45:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v2 09/23] counter: ftm-quaddec: Convert to counter_priv() wrapper
Date:   Mon, 27 Dec 2021 10:45:12 +0100
Message-Id: <20211227094526.698714-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Qqpt+RIrORwuC+ko5p/I1RZVPs6DxJb6yX67Xpe80y8=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=6pn1OojDAH74dd/doVZuAymC4K8Kkh3FuAv9xfxzgvs=; g=310c4b20e4d7bee8e70610ad57b3dedc48ab7907
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJiowACgkQwfwUeK3K7AlYhAf/RIG CVVSN+YRDtT7WCthhDgFyqqHnVHO6sPvFW5tsHvIgp4DmbSPxj8yWzK2Di0hjloj9pu0aKP4puk7W H5l75kPlarRNyVq1MF2H0iHaXb0XNXyOYHgJUpSxEE5W6b+Ojxt63DRYwxdCifUVSUUbfjQO4j1aA /wLfP3pfAyvFwtGoi2an92E+QD+05HSfAn75elkOL6vx8eBO4LUUz497/YgJgy7DS07PzkN9gkVbh 8re+8/uCqjW39MW8CpRaDjX4oaEFx7S0lqFEpFXtOghFQ2jNpyjP/xZ+giNLfhtkGp9cPqEyPfOPc EmfAJjAedRtE/piQlds4eHq/AyVLOYg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 9272f7b58beb..f5d92df6a611 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -118,7 +118,7 @@ static void ftm_quaddec_disable(void *ftm)
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 *cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = counter_priv(counter);
 	uint32_t scflags;
 
 	ftm_read(ftm, FTM_SC, &scflags);
@@ -131,7 +131,7 @@ static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 static int ftm_quaddec_set_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = counter_priv(counter);
 
 	mutex_lock(&ftm->ftm_quaddec_mutex);
 
@@ -162,7 +162,7 @@ static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
 				  u64 *val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = counter_priv(counter);
 	uint32_t cntval;
 
 	ftm_read(ftm, FTM_CNT, &cntval);
@@ -176,7 +176,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
 				   const u64 val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = counter_priv(counter);
 
 	if (val != 0) {
 		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
-- 
2.33.0

