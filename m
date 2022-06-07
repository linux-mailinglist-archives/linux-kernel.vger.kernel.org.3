Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6F541AE0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381109AbiFGVjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbiFGUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:50:33 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D4A1F77FC;
        Tue,  7 Jun 2022 11:39:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8FBF65FD02;
        Tue,  7 Jun 2022 21:39:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654627166;
        bh=KhjSexn3nEphWw72vrwnNoGa5BPxsszVKS1AlIdu0Pg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=lKIENIBWdBPmv1/xP3RgrpXxhDDPhM8YsjMNm+rOVxBDZVYiLJpGOC39kZtLb9yNL
         Fkbu5CemUtyNwX8xWogHNOc7WMlbLTxeVE6kQkxlfZUqR4d+HraVHjca7541oeWEMz
         r9wgSiVryplcBdJv9C5WHWos1RkdiofcRoDauGXMqz/bvq2w53IUugy6YvbuHm9S6H
         MGFqpKQ08vo3lxPHCl6vQl8pQB38XOCRQ/EiJgMp9G0rzw57/f+V64ZBTK5CMJXDxL
         X3oQaZ+PYrcFA3QFdTyvomXMyTWMcUxQcO3pWlhy/4sBzvVb1jYVU+o2bXb+owJI5t
         ggUd4B+KMApZA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  7 Jun 2022 21:39:26 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rockosov@gmail.com" <rockosov@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYep3lZdCBX5wfLkWR1miHp7T4Og==
Date:   Tue, 7 Jun 2022 18:39:18 +0000
Message-ID: <20220607183907.20017-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/07 15:55:00 #19701172
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of patch series about wrong trigger register() and get()
calls order in the some IIO drivers trigger initialization path:

https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.ru/

runtime WARN_ONCE() is added to alarm IIO driver authors who make such
a mistake.

When an IIO driver allocates a new IIO trigger, it should register it
before calling the get() operation. In other words, each IIO driver
must abide by IIO trigger alloc()/register()/get() calls order.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
Changes:
v1 -> v2: totally reworked the patch, used trig->list entry instead of
          trig->owner as driver registration indicator.
          It works perfectly for both builtin and built as a module
          drivers.

v2 -> v3: changed WARN() call to WARN_ONCE() to avoid warn spamming
          during deferred probe() as Andy suggested.
---
 drivers/iio/industrialio-trigger.c | 2 ++
 include/linux/iio/trigger.h        | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-=
trigger.c
index f504ed351b3e..d6277e72d515 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -581,6 +581,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *p=
arent,
 	if (trig->name =3D=3D NULL)
 		goto free_descs;
=20
+	INIT_LIST_HEAD(&trig->list);
+
 	trig->subirq_chip.name =3D trig->name;
 	trig->subirq_chip.irq_mask =3D &iio_trig_subirqmask;
 	trig->subirq_chip.irq_unmask =3D &iio_trig_subirqunmask;
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 4c69b144677b..03b1d6863436 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -93,6 +93,11 @@ static inline void iio_trigger_put(struct iio_trigger *t=
rig)
 static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig=
)
 {
 	get_device(&trig->dev);
+
+	WARN_ONCE(list_empty(&trig->list),
+		  "Getting non-registered iio trigger %s is prohibited\n",
+		  trig->name);
+
 	__module_get(trig->owner);
=20
 	return trig;
--=20
2.36.0
