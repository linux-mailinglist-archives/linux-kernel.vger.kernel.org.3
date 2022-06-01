Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3F53AC30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356436AbiFARs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiFARs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:48:56 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677846B0AA;
        Wed,  1 Jun 2022 10:48:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D63725FD02;
        Wed,  1 Jun 2022 20:48:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654105728;
        bh=SxukWBQmvI6xsER3OQeJrQgKcUlDX1d1f4Bcndax7+8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=DAR6NmYNYFzfiVbpZOlY+ekb5FSOyJGqz0CXUCy+djImXnhODeadqRkr7sseD0YGK
         gWwq5hBDiAOD0jGtuZV9SXIOz4dUu43vMg8Twb2fl967OtXRPNos0htF+vZMmnySea
         9H15D8XGUy3+xTbPGTi1GYCP/DgRFHPhX6bQAM8t0ecIxSv23+ZtAWQuiWNHryJdkR
         6pRhocsvW5crGLFmg6C6j/QDi4Q7tibD3s2uBMa8+z6YzkBcAjP9jDJoL+KY/zjdsd
         vWKdI3kcs1q5d9IPL+OxwrTsUFznEPm1q4oRKT4MPknDV+O25xtiwzeIRqjolNq2Pz
         FhfaBWYw/7wZQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  1 Jun 2022 20:48:48 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Thread-Topic: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Thread-Index: AQHYdd/Pt2zXEFx7c0Or/RCut5+rEA==
Date:   Wed, 1 Jun 2022 17:48:32 +0000
Message-ID: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/01 07:23:00 #19635587
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To provide a new IIO trigger to the IIO core, usually driver executes the
following pipeline: allocate()/register()/get(). Before, IIO core assigned
trig->owner as a pointer to the module which registered this trigger at
the register() stage. But actually the trigger object is owned by the
module earlier, on the allocate() stage, when trigger object is
successfully allocated for the driver.

This patch moves trig->owner initialization from register()
stage of trigger initialization pipeline to allocate() stage to
eliminate all misunderstandings and time gaps between trigger object
creation and owner acquiring.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/industrialio-trigger.c | 46 ++++++++++++++++--------------
 include/linux/iio/iio.h            | 10 +++++--
 include/linux/iio/trigger.h        | 21 +++++++-------
 3 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-=
trigger.c
index f504ed351b3e..143c8f360499 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -64,13 +64,10 @@ ATTRIBUTE_GROUPS(iio_trig_dev);
=20
 static struct iio_trigger *__iio_trigger_find_by_name(const char *name);
=20
-int __iio_trigger_register(struct iio_trigger *trig_info,
-			   struct module *this_mod)
+int iio_trigger_register(struct iio_trigger *trig_info)
 {
 	int ret;
=20
-	trig_info->owner =3D this_mod;
-
 	trig_info->id =3D ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
 	if (trig_info->id < 0)
 		return trig_info->id;
@@ -101,7 +98,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info=
,
 	ida_simple_remove(&iio_trigger_ida, trig_info->id);
 	return ret;
 }
-EXPORT_SYMBOL(__iio_trigger_register);
+EXPORT_SYMBOL(iio_trigger_register);
=20
 void iio_trigger_unregister(struct iio_trigger *trig_info)
 {
@@ -552,8 +549,9 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 	trig->subirqs[d->irq - trig->subirq_base].enabled =3D true;
 }
=20
-static __printf(2, 0)
+static __printf(3, 0)
 struct iio_trigger *viio_trigger_alloc(struct device *parent,
+				       struct module *this_mod,
 				       const char *fmt,
 				       va_list vargs)
 {
@@ -581,6 +579,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *p=
arent,
 	if (trig->name =3D=3D NULL)
 		goto free_descs;
=20
+	trig->owner =3D this_mod;
+
 	trig->subirq_chip.name =3D trig->name;
 	trig->subirq_chip.irq_mask =3D &iio_trig_subirqmask;
 	trig->subirq_chip.irq_unmask =3D &iio_trig_subirqunmask;
@@ -601,8 +601,9 @@ struct iio_trigger *viio_trigger_alloc(struct device *p=
arent,
 }
=20
 /**
- * iio_trigger_alloc - Allocate a trigger
+ * __iio_trigger_alloc - Allocate a trigger
  * @parent:		Device to allocate iio_trigger for
+ * @this_mod:		module allocating the trigger
  * @fmt:		trigger name format. If it includes format
  *			specifiers, the additional arguments following
  *			format are formatted and inserted in the resulting
@@ -610,18 +611,20 @@ struct iio_trigger *viio_trigger_alloc(struct device =
*parent,
  * RETURNS:
  * Pointer to allocated iio_trigger on success, NULL on failure.
  */
-struct iio_trigger *iio_trigger_alloc(struct device *parent, const char *f=
mt, ...)
+struct iio_trigger *__iio_trigger_alloc(struct device *parent,
+					struct module *this_mod,
+					const char *fmt, ...)
 {
 	struct iio_trigger *trig;
 	va_list vargs;
=20
 	va_start(vargs, fmt);
-	trig =3D viio_trigger_alloc(parent, fmt, vargs);
+	trig =3D viio_trigger_alloc(parent, this_mod, fmt, vargs);
 	va_end(vargs);
=20
 	return trig;
 }
-EXPORT_SYMBOL(iio_trigger_alloc);
+EXPORT_SYMBOL(__iio_trigger_alloc);
=20
 void iio_trigger_free(struct iio_trigger *trig)
 {
@@ -636,10 +639,11 @@ static void devm_iio_trigger_release(struct device *d=
ev, void *res)
 }
=20
 /**
- * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
+ * __devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
  * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
  * automatically freed on driver detach.
  * @parent:		Device to allocate iio_trigger for
+ * @this_mod:		module allocating the trigger
  * @fmt:		trigger name format. If it includes format
  *			specifiers, the additional arguments following
  *			format are formatted and inserted in the resulting
@@ -649,7 +653,9 @@ static void devm_iio_trigger_release(struct device *dev=
, void *res)
  * RETURNS:
  * Pointer to allocated iio_trigger on success, NULL on failure.
  */
-struct iio_trigger *devm_iio_trigger_alloc(struct device *parent, const ch=
ar *fmt, ...)
+struct iio_trigger *__devm_iio_trigger_alloc(struct device *parent,
+					     struct module *this_mod,
+					     const char *fmt, ...)
 {
 	struct iio_trigger **ptr, *trig;
 	va_list vargs;
@@ -661,7 +667,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct devic=
e *parent, const char *fm
=20
 	/* use raw alloc_dr for kmalloc caller tracing */
 	va_start(vargs, fmt);
-	trig =3D viio_trigger_alloc(parent, fmt, vargs);
+	trig =3D viio_trigger_alloc(parent, this_mod, fmt, vargs);
 	va_end(vargs);
 	if (trig) {
 		*ptr =3D trig;
@@ -672,7 +678,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct devic=
e *parent, const char *fm
=20
 	return trig;
 }
-EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
+EXPORT_SYMBOL_GPL(__devm_iio_trigger_alloc);
=20
 static void devm_iio_trigger_unreg(void *trigger_info)
 {
@@ -680,10 +686,9 @@ static void devm_iio_trigger_unreg(void *trigger_info)
 }
=20
 /**
- * __devm_iio_trigger_register - Resource-managed iio_trigger_register()
+ * devm_iio_trigger_register - Resource-managed iio_trigger_register()
  * @dev:	device this trigger was allocated for
  * @trig_info:	trigger to register
- * @this_mod:   module registering the trigger
  *
  * Managed iio_trigger_register().  The IIO trigger registered with this
  * function is automatically unregistered on driver detach. This function
@@ -693,19 +698,18 @@ static void devm_iio_trigger_unreg(void *trigger_info=
)
  * RETURNS:
  * 0 on success, negative error number on failure.
  */
-int __devm_iio_trigger_register(struct device *dev,
-				struct iio_trigger *trig_info,
-				struct module *this_mod)
+int devm_iio_trigger_register(struct device *dev,
+			      struct iio_trigger *trig_info)
 {
 	int ret;
=20
-	ret =3D __iio_trigger_register(trig_info, this_mod);
+	ret =3D iio_trigger_register(trig_info);
 	if (ret)
 		return ret;
=20
 	return devm_add_action_or_reset(dev, devm_iio_trigger_unreg, trig_info);
 }
-EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
+EXPORT_SYMBOL_GPL(devm_iio_trigger_register);
=20
 bool iio_trigger_using_own(struct iio_dev *indio_dev)
 {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 07025d6b3de1..853daa191b3c 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -669,9 +669,13 @@ static inline void *iio_priv(const struct iio_dev *ind=
io_dev)
=20
 void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_pr=
iv);
-__printf(2, 3)
-struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
-					   const char *fmt, ...);
+
+#define devm_iio_trigger_alloc(parent, fmt, ...) \
+	__devm_iio_trigger_alloc((parent), THIS_MODULE, (fmt), ##__VA_ARGS__)
+__printf(3, 4)
+struct iio_trigger *__devm_iio_trigger_alloc(struct device *parent,
+					     struct module *this_mod,
+					     const char *fmt, ...);
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
  * @indio_dev:		IIO device structure for device
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 4a008b952710..5abec8df5a18 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -135,16 +135,10 @@ static inline void *iio_trigger_get_drvdata(struct ii=
o_trigger *trig)
  * iio_trigger_register() - register a trigger with the IIO core
  * @trig_info:	trigger to be registered
  **/
-#define iio_trigger_register(trig_info) \
-	__iio_trigger_register((trig_info), THIS_MODULE)
-int __iio_trigger_register(struct iio_trigger *trig_info,
-			   struct module *this_mod);
+int iio_trigger_register(struct iio_trigger *trig_info);
=20
-#define devm_iio_trigger_register(dev, trig_info) \
-	__devm_iio_trigger_register((dev), (trig_info), THIS_MODULE)
-int __devm_iio_trigger_register(struct device *dev,
-				struct iio_trigger *trig_info,
-				struct module *this_mod);
+int devm_iio_trigger_register(struct device *dev,
+			      struct iio_trigger *trig_info);
=20
 /**
  * iio_trigger_unregister() - unregister a trigger from the core
@@ -172,8 +166,13 @@ void iio_trigger_poll_chained(struct iio_trigger *trig=
);
=20
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
=20
-__printf(2, 3)
-struct iio_trigger *iio_trigger_alloc(struct device *parent, const char *f=
mt, ...);
+#define iio_trigger_alloc(parent, fmt, ...) \
+	__iio_trigger_alloc((parent), THIS_MODULE, (fmt), ##__VA_ARGS__)
+
+__printf(3, 4)
+struct iio_trigger *__iio_trigger_alloc(struct device *parent,
+					struct module *this_mod,
+					const char *fmt, ...);
 void iio_trigger_free(struct iio_trigger *trig);
=20
 /**
--=20
2.36.0
