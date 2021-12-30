Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB3481D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhL3PDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbhL3PDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B6C06175B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cS-0W; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-007VKz-DF; Thu, 30 Dec 2021 16:03:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxM-0007hh-E9; Thu, 30 Dec 2021 16:03:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 10/23] counter: ti-eqep: Convert to counter_priv() wrapper
Date:   Thu, 30 Dec 2021 16:02:47 +0100
Message-Id: <20211230150300.72196-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; h=from:subject; bh=clJiyVXIrRIZYJmMECycG/pD3PRCe3LwdrG+txBx0IM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmIWd0YnByq4yiZTr/5UV94QLdILGFtEk06Rwp/ jvyq6cGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JiAAKCRDB/BR4rcrsCXW9B/ 9FyidRAqCzRmkrchrtsYfBM24iZXYWOH8n976OTeY37jh5lfPFJT6slwsCIQNrdLpLnpobYjfJtabR pBW7xq7GUzDkRmHknG5x7zkUM4Vfwk54q2RVipe72AO1BO6z03/co1A+c7cs8CW77RNLqvwWL1yf7q 7F9JjAGurUwU6CTbCpvgNMwhy0Zh78ULvPFAUQbL88kohZJW2tFduXhfBO4h6lgtq01eMxYqt67a7L ptxiB9zbwE0BbShSWmtuJePMcMdxJvTBfCAa2m7f0TUC4fNcwx8PH+Mb6QZnnx+DavQSjVR10x/GTR OjJz8zvVQRSnJZI8uCeN9lU9nHfB7c
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: David Lechner <david@lechnology.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 9e0e46bca4c2..2c70b900a6cf 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -89,7 +89,7 @@ struct ti_eqep_cnt {
 
 static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_device *counter)
 {
-	return container_of(counter, struct ti_eqep_cnt, counter);
+	return counter_priv(counter);
 }
 
 static int ti_eqep_count_read(struct counter_device *counter,
-- 
2.34.1

