Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1948D585
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiAMKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiAMKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:14:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5DCC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:14:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x83-0007tK-Gn; Thu, 13 Jan 2022 11:14:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x81-00A3Dd-Ow; Thu, 13 Jan 2022 11:14:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x80-0002tF-F0; Thu, 13 Jan 2022 11:14:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/2] mfd: twlx030: i2c remove callback cleanup
Date:   Thu, 13 Jan 2022 11:14:28 +0100
Message-Id: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; h=from:subject; bh=h1AGTbJiqD6mNVPm86tnmKjfzwpli/WoUAJ8VpKyJz4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh3/t1ozSKdNQiQvwLzA8pStVPmFR4uHP0sIea4Rzg 0IrRIaWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYd/7dQAKCRDB/BR4rcrsCQnCB/ 4vshV+1qe4siSLghsoe8xVQ1vEYOoCo1npRqsyt0PDccBXGOsHPUDc1zTLf+/YL+UpwGt//fYCY0II Zpg0O/7O9bX7BnoxJp3/8R0oBQ9OG6dLRgwiHkWXStxEVAhY8E9IPHeig6J2Xy1BGD+ts8uyF3A1Me zyxs1w0oJ/45OQdfc/7/hSW1/T4KCaYX4cGyVe9NQWbPxAh0/T/8da6npEXrSC9sj2ls/dMJdXgTbB fODYPprqVwG0nXeDGjG1q27bUnhawvEkdKl5XmVAXDZXHVuRlKyWoB7uv1G116sIA7UX8xFVhcmOEc LoAnX0hd0RqpDbEI3oNUUl4TPJt6lQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the remove paths of the twl4030 chip can fail and then returns an error
code in twl_remove() early. This isn't a good thing, because the device
will still go away with some resources not freed.
For the twl6030 this cannot happen, and the first patch is just a small
cleanup. For the twl4030 the situation is improved a bit: When the
failure happens, the dummy slave devices are removed now.

Note that twl4030_exit_irq() is incomplete. The irq isn't freed and
maybe some more cleanup is missing which might boom if an irq triggers
after the device is removed. Not sure that twl6030_exit_irq() is better
in this regard.

I noticed this issue because I work on making i2c_driver::remove return
void as returning a value != 0 there is almost always an error attached
to wrong expectations.

Best regards
Uwe

Uwe Kleine-König (2):
  mfd: twl6030: Make twl6030_exit_irq() return void
  mfd: twl4030: Make twl4030_exit_irq() return void

 drivers/mfd/twl-core.c    | 8 ++------
 drivers/mfd/twl-core.h    | 4 ++--
 drivers/mfd/twl4030-irq.c | 7 ++-----
 drivers/mfd/twl6030-irq.c | 3 +--
 4 files changed, 7 insertions(+), 15 deletions(-)

base-commit: 455e73a07f6e288b0061dfcf4fcf54fa9fe06458
-- 
2.34.1

