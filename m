Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C051C4814BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhL2PqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhL2PpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:45:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7012C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:45:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8N-0006qH-59; Wed, 29 Dec 2021 16:44:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-007KGg-4a; Wed, 29 Dec 2021 16:44:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8C-00011n-1t; Wed, 29 Dec 2021 16:44:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Date:   Wed, 29 Dec 2021 16:44:18 +0100
Message-Id: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=28251; h=from:subject; bh=h3czhjUec1Ade3yFKIbQkI/CKJnIWTZQXXi4IgnP3is=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIIL2sO6MtsUZAWlmEwUJNMg5nK0U8QdxoWirkvN heK3b4+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCCwAKCRDB/BR4rcrsCQx3B/ 4157AMyP7NlNzILvIlj7RA5YsD1x0+qq1tuBMnI3SIFofNP+HgYLy9endMAx3hy1SQ7EZraO7cUFwz fwGUowTaaJeiieE/YG9dyHHYugL0RrLTMQBuVytzHqRJkKYPuxrzmmrX97eDQJ2IOXc1kwwpz6dBlL DSJ15QAAk5Q9HYjiGwB7i5ZIFceJjCp3O1sSzrbv1lTpfjvNRkO7ASermni9mLLsVfh5fiphz9WL1M EAjQ13j20hYyWryWWHm1pYinrimtdhJUaObHnxzzO38XYNQYKuxBOtmHHY/ra4XKmnogZh/QopQtlv QEy7s3HrlHObYmMxUBOsy3BxH6qXaY
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

this is v3 of my series to fix device lifetime issues in the counter
framework. This hopefully addresses all things pointed out for v2.

Note this depends on 60f07e74f86b (which is in next) now. Full diffstat
below.

Things that could be further improved:

 - 104_QUAD_8 depends on X86, but compiles fine on ARCH=arm. Maybe
   adding support for COMPILE_TEST would be a good idea.

 - 104-quad-8.c uses devm_request_irq() and (now) devm_counter_add(). On
   unbind an irq might be pending which results in quad8_irq_handler()
   calling counter_push_event() for a counter that is already
   unregistered. (The issue exists also without my changes.)

 - I think intel-qep.c makes the counter unfunctional in
   intel_qep_remove before the counter is unregistered.

 - counter_sysfs_add() allocates several small structures using
   devm_kcalloc for counter->dev. Not sure this could be optimized.
   Another ugly aspect here is, that counter->dev has no name, so the
   trace generated by the devres_log event contains several "(null)":

     sh-124     [000] d..1.   439.921733: devres_log: 40000000.timer:counter ADD f0ecfb01 devm_action_release (8 bytes)
     sh-124     [000] d..1.   439.921741: devres_log: (null) ADD 44be06af devm_kzalloc_release (64 bytes)
     sh-124     [000] d..1.   439.921750: devres_log: (null) ADD 16ad25f5 devm_kzalloc_release (8 bytes)
     sh-124     [000] d..1.   439.921755: devres_log: (null) ADD 7d22db15 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921760: devres_log: (null) ADD 34aefeea devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921764: devres_log: (null) ADD f347e9c0 devm_kzalloc_release (8 bytes)
     sh-124     [000] d..1.   439.921768: devres_log: (null) ADD 960e132d devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921772: devres_log: (null) ADD 7b4c8adc devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921776: devres_log: (null) ADD 0931ec34 devm_kzalloc_release (7 bytes)
     sh-124     [000] d..1.   439.921782: devres_log: (null) ADD c8c6c1c3 devm_kzalloc_release (15 bytes)
     sh-124     [000] d..1.   439.921788: devres_log: (null) ADD d1bb5baf devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921791: devres_log: (null) ADD 94029520 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921796: devres_log: (null) ADD 1dcc6eeb devm_kzalloc_release (25 bytes)
     sh-124     [000] d..1.   439.921801: devres_log: (null) ADD d37b87ec devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921805: devres_log: (null) ADD 660be81a devm_kzalloc_release (28 bytes)
     sh-124     [000] d..1.   439.921810: devres_log: (null) ADD e6691ecf devm_kzalloc_release (15 bytes)
     sh-124     [000] d..1.   439.921815: devres_log: (null) ADD 0b8e2064 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921818: devres_log: (null) ADD b4dd5e7f devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921827: devres_log: (null) ADD 3eaaec2a devm_kzalloc_release (25 bytes)
     sh-124     [000] d..1.   439.921834: devres_log: (null) ADD e519abf5 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921841: devres_log: (null) ADD 92663a7b devm_kzalloc_release (28 bytes)
     sh-124     [000] d..1.   439.921845: devres_log: (null) ADD 7835b138 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921849: devres_log: (null) ADD 2dfa4f94 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921853: devres_log: (null) ADD 561fde6a devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921856: devres_log: (null) ADD 6f8b5fa6 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921860: devres_log: (null) ADD 39e5a4e8 devm_kzalloc_release (19 bytes)
     sh-124     [000] d..1.   439.921865: devres_log: (null) ADD f9156a41 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921868: devres_log: (null) ADD d2d5ce75 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921872: devres_log: (null) ADD 36d78a89 devm_kzalloc_release (23 bytes)
     sh-124     [000] d..1.   439.921877: devres_log: (null) ADD 2f5c179f devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921880: devres_log: (null) ADD 72cf7389 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921885: devres_log: (null) ADD f9badaa6 devm_kzalloc_release (20 bytes)
     sh-124     [000] d..1.   439.921889: devres_log: (null) ADD 0bac4bae devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921892: devres_log: (null) ADD e25a23bb devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921896: devres_log: (null) ADD 77c03a96 devm_kzalloc_release (21 bytes)
     sh-124     [000] d..1.   439.921901: devres_log: (null) ADD fbcf25d4 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921905: devres_log: (null) ADD 430046b3 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921909: devres_log: (null) ADD cb0566d5 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921912: devres_log: (null) ADD 5ec7bdc6 devm_kzalloc_release (52 bytes)
     sh-124     [000] d..1.   439.921916: devres_log: (null) ADD a8d30cb3 devm_kzalloc_release (20 bytes)
     sh-124     [000] d..1.   439.921926: devres_log: (null) ADD 655cd641 devm_kzalloc_release (80 bytes)
     sh-124     [000] d..1.   439.921931: devres_log: (null) ADD 7211e558 devm_kzalloc_release (12 bytes)
     sh-124     [000] d..1.   439.921934: devres_log: (null) ADD 1402f677 devm_kzalloc_release (12 bytes)
     sh-124     [000] d..1.   439.921937: devres_log: (null) ADD edc5c5b1 devm_kzalloc_release (68 bytes)
     sh-124     [000] d..1.   439.921941: devres_log: (null) ADD 5c7d0a3d devm_kzalloc_release (20 bytes)
     sh-124     [000] d..1.   439.922509: devres_log: 40000000.timer:counter ADD fb446f1c devm_action_release (8 bytes)

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
 drivers/counter/counter-core.c               | 186 ++++++++++++++-----
 drivers/counter/ftm-quaddec.c                |  36 ++--
 drivers/counter/intel-qep.c                  |  46 ++---
 drivers/counter/interrupt-cnt.c              |  38 ++--
 drivers/counter/microchip-tcb-capture.c      |  44 ++---
 drivers/counter/stm32-lptimer-cnt.c          |  51 ++---
 drivers/counter/stm32-timer-cnt.c            |  48 ++---
 drivers/counter/ti-eqep.c                    |  31 ++--
 include/linux/counter.h                      |  15 +-
 11 files changed, 356 insertions(+), 242 deletions(-)

Range-diff against v2:
 1:  0f73d029e55f !  1:  164f6fc76500 counter: Use container_of instead of drvdata to track counter_device
    @@ Commit message
         There are no other users of drvdata, so the call to dev_set_drvdata can
         go away, too.
     
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/counter-core.c ##
 2:  b2c4b1d30034 !  2:  3808b34176ed counter: ftm-quaddec: Drop unused platform_set_drvdata()
    @@ Commit message
         The driver doesn't ever use platform_get_drvdata, so drop this unused
         call.
     
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/ftm-quaddec.c ##
 3:  ac333fe0f34e !  3:  54a846344f2f counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
    @@ Commit message
         The driver doesn't ever use platform_get_drvdata, so drop this unused
         call.
     
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/microchip-tcb-capture.c ##
 4:  adef4157e314 !  4:  c57b20dbdb7d counter: Provide a wrapper to access device private data
    @@ Commit message
         individually makes fixing device lifetime issues result in easier to
         review patches.
     
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/counter-core.c ##
 5:  c428105f13b1 !  5:  a81b257613f1 counter: 104-quad-8: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/104-quad-8.c ##
 6:  c72800db0f05 !  6:  a57ac51c8499 counter: interrupt-cnt: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/interrupt-cnt.c ##
 7:  d9fb86250b87 !  7:  2f227060747f counter: microchip-tcb-capture: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/microchip-tcb-capture.c ##
 8:  0d1e999aa274 !  8:  0d917f687039 counter: intel-qep: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/intel-qep.c ##
 9:  a2ffdf7dbac1 !  9:  82ad8f3060e2 counter: ftm-quaddec: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/ftm-quaddec.c ##
10:  95c643c47795 <  -:  ------------ counter: ti-eqep: Convert to counter_priv() wrapper
 -:  ------------ > 10:  0ed4c223ae8e counter: ti-eqep: Convert to counter_priv() wrapper
11:  6960d9cf21d2 ! 11:  caff57fb76ad counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/stm32-lptimer-cnt.c ##
12:  deeca3a39ff5 ! 12:  c45c494ed207 counter: stm32-timer-cnt: Convert to counter_priv() wrapper
    @@ Commit message
     
         This is a straight forward conversion to the new counter_priv() wrapper.
     
    +    Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/stm32-timer-cnt.c ##
13:  a9ccb6fac99f ! 13:  8427cd271336 counter: Provide alternative counter registration functions
    @@ drivers/counter/counter-core.c
      
     +struct counter_device_allochelper {
     +	struct counter_device counter;
    -+	unsigned long privdata[];
    ++
    ++	/*
    ++	 * This is cache line aligned to ensure private data behaves like if it
    ++	 * were kmalloced separately.
    ++	 */
    ++	unsigned long privdata[] ____cacheline_aligned;
     +};
     +
      static void counter_device_release(struct device *dev)
    @@ drivers/counter/counter-core.c: int counter_register(struct counter_device *cons
     +	struct counter_device_allochelper *ch;
     +	struct counter_device *counter;
     +	struct device *dev;
    -+	int id, err;
    ++	int err;
     +
     +	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
     +	if (!ch) {
    @@ drivers/counter/counter-core.c: int counter_register(struct counter_device *cons
     +
     +	/* Acquire unique ID */
     +	err = ida_alloc(&counter_ida, GFP_KERNEL);
    -+	if (err < 0) {
    ++	if (err < 0)
     +		goto err_ida_alloc;
    -+	}
     +	dev->id = err;
     +
    ++	mutex_init(&counter->ops_exist_lock);
    ++	dev->type = &counter_device_type;
    ++	dev->bus = &counter_bus_type;
    ++	dev->devt = MKDEV(MAJOR(counter_devt), dev->id);
    ++
     +	err = counter_chrdev_add(counter);
     +	if (err < 0)
     +		goto err_chrdev_add;
     +
     +	device_initialize(dev);
    -+	/* Configure device structure for Counter */
    -+	dev->type = &counter_device_type;
    -+	dev->bus = &counter_bus_type;
    -+	dev->devt = MKDEV(MAJOR(counter_devt), id);
    -+
    -+	mutex_init(&counter->ops_exist_lock);
     +
     +	return counter;
     +
    @@ drivers/counter/counter-core.c: int counter_register(struct counter_device *cons
     +{
     +	put_device(&counter->dev);
     +}
    ++EXPORT_SYMBOL_GPL(counter_put);
     +
     +/**
     + * counter_add - complete registration of a counter
    @@ drivers/counter/counter-core.c: int counter_register(struct counter_device *cons
     +	int err;
     +	struct device *dev = &counter->dev;
     +
    -+	get_device(&counter->dev);
    -+
     +	if (counter->parent) {
     +		dev->parent = counter->parent;
     +		dev->of_node = counter->parent->of_node;
    @@ drivers/counter/counter-core.c: int counter_register(struct counter_device *cons
     +		return err;
     +
     +	/* implies device_add(dev) */
    -+	err = cdev_device_add(&counter->chrdev, dev);
    -+
    -+	return err;
    ++	return cdev_device_add(&counter->chrdev, dev);
     +}
     +EXPORT_SYMBOL_GPL(counter_add);
     +
      /**
       * counter_unregister - unregister Counter from the system
       * @counter:	pointer to Counter to unregister
    +@@ drivers/counter/counter-core.c: void counter_unregister(struct counter_device *const counter)
    + 
    + 	mutex_unlock(&counter->ops_exist_lock);
    + 
    +-	put_device(&counter->dev);
    ++	if (counter->legacy_device)
    ++		put_device(&counter->dev);
    + }
    + EXPORT_SYMBOL_GPL(counter_unregister);
    + 
     @@ drivers/counter/counter-core.c: int devm_counter_register(struct device *dev,
      }
      EXPORT_SYMBOL_GPL(devm_counter_register);
    @@ drivers/counter/counter-core.c: int devm_counter_register(struct device *dev,
     +	counter_put(counter);
     +}
     +
    ++/**
    ++ * devm_counter_alloc - allocate a counter_device
    ++ * @dev: the device to register the release callback for
    ++ * @sizeof_priv: size of the driver private data
    ++ *
    ++ * This is the device managed version of counter_add(). It registers a cleanup
    ++ * callback to care for calling counter_put().
    ++ */
     +struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv)
     +{
     +	struct counter_device *counter;
    @@ drivers/counter/counter-core.c: int devm_counter_register(struct device *dev,
     +}
     +EXPORT_SYMBOL_GPL(devm_counter_alloc);
     +
    ++/**
    ++ * devm_counter_add - complete registration of a counter
    ++ * @dev: the device to register the release callback for
    ++ * @counter: the counter to add
    ++ *
    ++ * This is the device managed version of counter_add(). It registers a cleanup
    ++ * callback to care for calling counter_unregister().
    ++ */
     +int devm_counter_add(struct device *dev,
     +		     struct counter_device *const counter)
     +{
14:  7ae52f5b75f4 ! 14:  f841ae4f8909 counter: Update documentation for new counter registration functions
    @@ Commit message
         In order to replace the counter registration API also update the
         documentation to the new way.
     
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## Documentation/driver-api/generic-counter.rst ##
    @@ Documentation/driver-api/generic-counter.rst: order to communicate with the devi
     -it to the counter_unregister function. Similarly, the
     -devm_counter_register function may be used if device memory-managed
     -registration is desired.
    -+A counter_device structure is supposed to be allocated using counter_alloc()
    -+and may be registered to the system by passing it to the counter_add()
    -+function, and unregistered by passing it to the counter_unregister function.
    -+There are device managed variants of these functions: devm_counter_alloc() and
    ++A counter_device structure is allocated using counter_alloc() and then
    ++registered to the system by passing it to the counter_add() function, and
    ++unregistered by passing it to the counter_unregister function. There are
    ++device managed variants of these functions: devm_counter_alloc() and
     +devm_counter_add().
      
      The struct counter_comp structure is used to define counter extensions
15:  02e54fed5b4e ! 15:  db635ea62ba4 counter: 104-quad-8: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/104-quad-8.c ##
    @@ drivers/counter/104-quad-8.c: MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt
      	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
      	unsigned int preset[QUAD8_NUM_COUNTERS];
      	unsigned int count_mode[QUAD8_NUM_COUNTERS];
    +@@ drivers/counter/104-quad-8.c: static struct counter_count quad8_counts[] = {
    + 
    + static irqreturn_t quad8_irq_handler(int irq, void *private)
    + {
    +-	struct quad8 *const priv = private;
    ++	struct counter_device *counter = private;
    ++	struct quad8 *const priv = counter_priv(counter);
    + 	const unsigned long base = priv->base;
    + 	unsigned long irq_status;
    + 	unsigned long channel;
    +@@ drivers/counter/104-quad-8.c: static irqreturn_t quad8_irq_handler(int irq, void *private)
    + 			continue;
    + 		}
    + 
    +-		counter_push_event(&priv->counter, event, channel);
    ++		counter_push_event(counter, event, channel);
    + 	}
    + 
    + 	/* Clear pending interrupts on device */
     @@ drivers/counter/104-quad-8.c: static irqreturn_t quad8_irq_handler(int irq, void *private)
      
      static int quad8_probe(struct device *dev, unsigned int id)
    @@ drivers/counter/104-quad-8.c: static int quad8_probe(struct device *dev, unsigne
      
      	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
     -			       priv->counter.name, priv);
    -+			       counter->name, priv);
    ++			       counter->name, counter);
      	if (err)
      		return err;
      
16:  728494402580 ! 16:  3ef149d41223 counter: interrupt-cnt: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/interrupt-cnt.c ##
17:  fe5266b17ded ! 17:  ad4a85dc9f99 counter: intel-qep: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/intel-qep.c ##
18:  e2610d673a23 ! 18:  192c5bba00e4 counter: ftm-quaddec: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
    - ## drivers/counter/104-quad-8.c ##
    -@@ drivers/counter/104-quad-8.c: static struct counter_count quad8_counts[] = {
    - 
    - static irqreturn_t quad8_irq_handler(int irq, void *private)
    - {
    --	struct quad8 *const priv = private;
    -+	struct counter_device *counter = private;
    -+	struct quad8 *const priv = counter_priv(counter);
    - 	const unsigned long base = priv->base;
    - 	unsigned long irq_status;
    - 	unsigned long channel;
    -@@ drivers/counter/104-quad-8.c: static irqreturn_t quad8_irq_handler(int irq, void *private)
    - 			continue;
    - 		}
    - 
    --		counter_push_event(&priv->counter, event, channel);
    -+		counter_push_event(counter, event, channel);
    - 	}
    - 
    - 	/* Clear pending interrupts on device */
    -@@ drivers/counter/104-quad-8.c: static int quad8_probe(struct device *dev, unsigned int id)
    - 	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
    - 
    - 	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
    --			       counter->name, priv);
    -+			       counter->name, counter);
    - 	if (err)
    - 		return err;
    - 
    -
      ## drivers/counter/ftm-quaddec.c ##
     @@
      	})
    @@ drivers/counter/ftm-quaddec.c: static struct counter_count ftm_quaddec_counts =
      {
     +	struct counter_device *counter;
      	struct ftm_quaddec *ftm;
    --
    + 
      	struct device_node *node = pdev->dev.of_node;
      	struct resource *io;
      	int ret;
19:  fa10a9c1f369 ! 19:  8df134fb3723 counter: microchip-tcb-capture: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/microchip-tcb-capture.c ##
20:  f697f9a17e6d ! 20:  ec4c0c5e183f counter: stm32-timer-cnt: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/stm32-timer-cnt.c ##
21:  4368748521cc ! 21:  2b800479151d counter: stm32-lptimer-cnt: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/stm32-lptimer-cnt.c ##
22:  47485ea4bac8 ! 22:  97a2e4aac286 counter: ti-eqep: Convert to new counter registration
    @@ Commit message
         struct device.
     
         Fixes: f213729f6796 ("counter: new TI eQEP driver")
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/ti-eqep.c ##
23:  eb26d7efeede ! 23:  db76bf498f3f counter: remove old and now unused registration API
    @@ Commit message
         Usage of counter_register() yields issues in device lifetime tracking. All
         drivers were converted to the new API, so the old one can go away.
     
    +    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## drivers/counter/counter-core.c ##
    @@ drivers/counter/counter-core.c: static dev_t counter_devt;
      /**
       * counter_alloc - allocate a counter_device
       * @sizeof_priv: size of the driver private data
    +@@ drivers/counter/counter-core.c: void counter_unregister(struct counter_device *const counter)
    + 	wake_up(&counter->events_wait);
    + 
    + 	mutex_unlock(&counter->ops_exist_lock);
    +-
    +-	if (counter->legacy_device)
    +-		put_device(&counter->dev);
    + }
    + EXPORT_SYMBOL_GPL(counter_unregister);
    + 
     @@ drivers/counter/counter-core.c: static void devm_counter_release(void *counter)
      	counter_unregister(counter);
      }

base-commit: a7904a538933c525096ca2ccde1e60d0ee62c08e
prerequisite-patch-id: 9459ad8bc78190558df9123f8bebe28ca1c396ea
-- 
2.34.1

