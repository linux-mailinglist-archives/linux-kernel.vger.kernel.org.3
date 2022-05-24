Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE953304D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiEXSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiEXSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:15:01 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE46C54F;
        Tue, 24 May 2022 11:15:00 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 644AB5FD0C;
        Tue, 24 May 2022 21:14:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653416096;
        bh=k+4IFSFfBohrz26BOucBMVTZbZM85y1aZdQ3FK9koGs=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=ow8ZtzgKRarwjVUwlxZzJEjn7w8XqFa9mWwohNZYhGpB4WHTaEIADOLW+cd6y5quJ
         vNQUIjWHaM1Ygcyg9xqPZcNhgPwNGMcxpAj3PEumDoZNQvxOlFumWslh/xCGRBax16
         J+hoHpDAfNssOLFrAWFc17nWOLmKeNaI18m4G0gsn5lkzU8BazW7azlRUMQEbPKgVn
         FGnishSUqkgj41mZPeI0te0nuJ94vQ8urtqRZdyQYhj0e8tfCEAw0EQoRS+zgg2X5A
         80c9cA/7u7T8PfnWUGqLVPECPdbmG0Wn3P7J0dkEWgOIlAoe2LvzNfxrvkhsS0SgRa
         L1DxDn7JVedjA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 24 May 2022 21:14:45 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Thread-Topic: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Thread-Index: AQHYb5ohywOA3ErtcUWaOWHlaX8a+Q==
Date:   Tue, 24 May 2022 18:14:37 +0000
Message-ID: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/24 14:34:00 #19560786
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset resolves problems with iio_trigger_get() and
iio_trigger_register() call order in the different IIO drivers.

IIO trigger interface function iio_trigger_get() should be called after
iio_trigger_register() (or its devm analogue) strictly, because of
iio_trigger_get() acquires module refcnt based on the trigger->owner
pointer, which is initialized inside iio_trigger_register() to
THIS_MODULE.
If this call order is wrong, the next iio_trigger_put() (from sysfs
callback or "delete module" path) will dereference "default" module
refcnt, which is incorrect behaviour.

Changes v1->v2:
    - provide tag Fixes: for all patches

Dmitry Rokosov (5):
  iio:accel:bma180: rearrange iio trigger get and register
  iio:accel:kxcjk-1013: rearrange iio trigger get and register
  iio:accel:mxc4005: rearrange iio trigger get and register
  iio:chemical:ccs811: rearrange iio trigger get and register
  iio:humidity:hts221: rearrange iio trigger get and register

 drivers/iio/accel/bma180.c           | 3 ++-
 drivers/iio/accel/kxcjk-1013.c       | 4 ++--
 drivers/iio/accel/mxc4005.c          | 4 ++--
 drivers/iio/chemical/ccs811.c        | 4 ++--
 drivers/iio/humidity/hts221_buffer.c | 5 ++++-
 5 files changed, 12 insertions(+), 8 deletions(-)

--=20
2.36.0
