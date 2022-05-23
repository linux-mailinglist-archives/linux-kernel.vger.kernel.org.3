Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB33B531AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbiEWQnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiEWQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:42:44 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585B743492;
        Mon, 23 May 2022 09:42:38 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 87F9A5FD03;
        Mon, 23 May 2022 19:42:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653324154;
        bh=mWIoukga0+tGfS/FAdtt7NB8imysAOdX12ZSaxFpX+0=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=DKY+QJ14EQbPIZzARpRPEtRlv9S+5tf9D9MRjvsoRLTPwK0DsAlOgQaM8ePcAdtQl
         V47RU7xqaIuD5JxOMQ1JFrzZDnBtKv0tGebbiA7nHbtbx4MHMX7UOC/ii+1AGFEEPM
         ZdTHNPPwmF0SBvBc/cGU/tts6a5bRtVRds52tWEyeY9Im811MbAqD5Xti1T0KMhWlc
         IKSFP+f9TE2pAYLzB8VzU11BtK1YFttGlV1n50Ax3bYPREX/FqlMXAhVTVSIPEUANL
         YxozHHvAPRlYNeGUaHztV2sQxYS2zr0PX3432zh/tM5n64Np8exp+cWrsMHCmZAkPk
         gdD0hLe805zvg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 23 May 2022 19:42:28 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
        "sean@geanix.com" <sean@geanix.com>,
        "linmq006@gmail.com" <linmq006@gmail.com>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 0/5] iio: treewide: rearrange iio trig get/register
Thread-Topic: [PATCH v1 0/5] iio: treewide: rearrange iio trig get/register
Thread-Index: AQHYbsP3wjZLsbk+IECvoYYw88GylA==
Date:   Mon, 23 May 2022 16:41:35 +0000
Message-ID: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/23 07:03:00 #19535618
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
callbacks or rmmod) will derefence "default" module refcnt, which is
completely incorrect.

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
