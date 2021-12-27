Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0547FB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhL0Jqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhL0JqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:46:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D05C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:46:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZY-0006Y9-6Y; Mon, 27 Dec 2021 10:45:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZR-006u8i-S2; Mon, 27 Dec 2021 10:45:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZQ-0005TD-NW; Mon, 27 Dec 2021 10:45:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 00/23] counter: cleanups and device lifetime fixes
Date:   Mon, 27 Dec 2021 10:45:03 +0100
Message-Id: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=SxVgmXbyxjhEaCeg8YYh/d1GfTLHDyxY3rU5Ni7M7q8=; m=lDJ9oimaumvVMf6LuLDghZ8q49IJcoSs+Sh0dJ8yevo=; p=DgO0boJVbutOmTZZAuLM5idPKK18eYUUS1wpOK5FECg=; g=8c2a373fe70a4d470ffff53a680efaa861272d9e
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJiuoACgkQwfwUeK3K7AkFWAgAldZ dB/+zZX+l5ITGgWnHQcAJrg+Grz44RoG8IrgeiOl36wHN2Ggc6V0LU5o7FWX607kCD4Z6U1BpQao7 80ARSmTSk+R0F1nsoxm8J/81ZeVWeJ3sEHsPwjhm3UCCM5moEBL9AO4X/2rxcR8C0VT8UY2gmtEi4 kB/abt0l0zRSLUN9uSY0B97/7anGy+0vmk1JNlJ8sZKNPdJnKFpPg8P6XioDzbmihCO8JpaXNf39p BsOT7hNrtguXrRMVYtduBTJ48YDZVjnVH++VPhBz4SCHFpZfJ80KuQ+SJg2cMXZ8pq6djb+gXA2Ah sO8b/MWdPTzYBFwr7u/U+cxc/vEXnYQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is v2 of this series, it's goal is to fix struct device lifetime issues as
pointed out in patch #13. The patches up to patch #12 are only prepatory and
cleanup patches. Patch #13 provides the needed functions to fix the issues in
all drivers (patches #15 to #22). The last patch removes the then unused API
calls.

The changes compared to v1 is only build fixes that I missed to include in v1,
they were only in my working copy. Additionally I changed:

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index cdc6004a7e77..3f7dc5718423 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -27,7 +27,7 @@ static DEFINE_IDA(counter_ida);
 
 struct counter_device_allochelper {
 	struct counter_device counter;
-	unsigned long privdata[0];
+	unsigned long privdata[];
 };
 
 static void counter_device_release(struct device *dev)

The stm32-timer-cnt driver was used to test
this series, the other drivers are only compile tested.


To complete the information from the v1 thread: There are a few more
issues I found while working on this patch set:

 - 104_QUAD_8 depends on X86, but compiles fine on ARCH=arm. Maybe
   adding support for COMPILE_TEST would be a good idea.

 - 104-quad-8.c uses devm_request_irq() and (now) devm_counter_add(). On
   unbind an irq might be pending which results in quad8_irq_handler()
   calling counter_push_event() for a counter that is already
   unregistered. (The issue exists also without my changes.)

 - I think intel-qep.c makes the counter unfunctional in
   intel_qep_remove before the counter is unregistered.

 - I wonder why counter is a bus and not a class device type. There is
   no driver that would ever bind a counter device, is there? So
   /sys/bus/counter/driver is always empty.

Do whatever you want with this list, I won't address these in the near
future.

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
 drivers/counter/104-quad-8.c                 |  93 +++++-----
 drivers/counter/counter-core.c               | 168 +++++++++++++------
 drivers/counter/ftm-quaddec.c                |  37 ++--
 drivers/counter/intel-qep.c                  |  46 ++---
 drivers/counter/interrupt-cnt.c              |  38 +++--
 drivers/counter/microchip-tcb-capture.c      |  44 ++---
 drivers/counter/stm32-lptimer-cnt.c          |  51 +++---
 drivers/counter/stm32-timer-cnt.c            |  48 +++---
 drivers/counter/ti-eqep.c                    |  47 +++---
 include/linux/counter.h                      |  15 +-
 11 files changed, 348 insertions(+), 249 deletions(-)


base-commit: a7904a538933c525096ca2ccde1e60d0ee62c08e
-- 
2.33.0

