Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC97C481D90
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhL3PES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbhL3PDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40587C061763
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxQ-0000cK-69; Thu, 30 Dec 2021 16:03:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxL-007VKV-F7; Thu, 30 Dec 2021 16:03:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxK-0007fw-3q; Thu, 30 Dec 2021 16:03:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 00/23] counter: cleanups and device lifetime fixes
Date:   Thu, 30 Dec 2021 16:02:37 +0100
Message-Id: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; h=from:subject; bh=AOu1ipuy51ViJtY8+UrNDZQ8jBgMAGOEi7FVF4Yd7rI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcn5BHBaiDQ8cEt776wfv9nWuKqQqGj/puI+WcPv PA8RpYSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3J+QAKCRDB/BR4rcrsCUcSCA CfKRDdmC0XRJCNVa+WlilBBS1clYGRm99fyrJzTeKcvzB+TkcfWtSl4Mt3rxrI8MprDol2cltD3Ixg 2othS8Ec3bbw2oJUAMPXjA0bkSczWGlPshbUUmgbCl8f3GUhO24I5JUqXJFDaVzjkOGMxCAnu/440k XYcWqGeV7lJeGaBx+DpV5e/abV1DJY9KvJqNh1ZLdHvCTDZtTTPIkABJTS7+MwCrpgNHsrgO+UGSkF AOm4dgHzzKEwYu4cq6hH64t9qm3XrR/7819gHuYSybV+vf3oomYh+eMFXpVDsI4cVmqBQWBIHoNsxb 5ssNycrLJCAUZLiIYykybN0h3bPHk1
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

On Thu, Dec 30, 2021 at 02:19:25PM +0100, Greg Kroah-Hartman wrote:
> Please rebase and resend the series against my char-misc-next branch.

this series is just v3 taken via b4 to collect the latest acks into
account and then rebased to Greg's char-misc-next.

Uwe Kleine-König (23):
  counter: Use container_of instead of drvdata to track counter_device
  counter: ftm-quaddec: Drop unused platform_set_drvdata()
  counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
  counter: Provide a wrapper to access device private data
  counter: 104-quad-8: Convert to counter_priv() wrapper
  counter: interrupt-cnt: Convert to counter_priv() wrapper
  counter: microchip-tcb-capture: Convert to counter_priv() wrapper
  counter: intel-qep: Convert to counter_priv() wrapper
  counter: ftm-quaddec: Convert to counter_priv() wrapper
  counter: ti-eqep: Convert to counter_priv() wrapper
  counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
  counter: stm32-timer-cnt: Convert to counter_priv() wrapper
  counter: Provide alternative counter registration functions
  counter: Update documentation for new counter registration functions
  counter: 104-quad-8: Convert to new counter registration
  counter: interrupt-cnt: Convert to new counter registration
  counter: intel-qep: Convert to new counter registration
  counter: ftm-quaddec: Convert to new counter registration
  counter: microchip-tcb-capture: Convert to new counter registration
  counter: stm32-timer-cnt: Convert to new counter registration
  counter: stm32-lptimer-cnt: Convert to new counter registration
  counter: ti-eqep: Convert to new counter registration
  counter: remove old and now unused registration API

 Documentation/driver-api/generic-counter.rst |  10 +-
 drivers/counter/104-quad-8.c                 |  91 ++++-----
 drivers/counter/counter-core.c               | 186 ++++++++++++++-----
 drivers/counter/ftm-quaddec.c                |  36 ++--
 drivers/counter/intel-qep.c                  |  46 ++---
 drivers/counter/interrupt-cnt.c              |  38 ++--
 drivers/counter/microchip-tcb-capture.c      |  44 ++---
 drivers/counter/stm32-lptimer-cnt.c          |  51 ++---
 drivers/counter/stm32-timer-cnt.c            |  48 ++---
 drivers/counter/ti-eqep.c                    |  31 ++--
 include/linux/counter.h                      |  15 +-
 11 files changed, 355 insertions(+), 241 deletions(-)


base-commit: e75a58db41df67e6282104aaae073bc8b43b8dc8
-- 
2.34.1

