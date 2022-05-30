Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7195538588
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbiE3PyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiE3Pxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:53:41 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7100354024;
        Mon, 30 May 2022 08:30:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 73C3E5FD09;
        Mon, 30 May 2022 18:30:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653924655;
        bh=jr+OOY0S+miBWxqmHW55g/CC6ijTl8TyiythAQvO0a4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=NK7UT0TGrSJwgvodu9LQPbmiGzhtYjGOb6tuB2HaPRfgjZxtsEPtgbGcHwq7doSYv
         wPHl4MgrmoKMg8Qa0IYrkqcryxMDsvw5nFSHof1pRWBV1ycUJhKCXR/Z6IKWNGS+j5
         AKUYk6YUYXVOQkRl5RnIQfAw2l4pCTDrii9W54WTly7+9uhApFiQsVE0uJ7Yx2uVC4
         lS6QfpezmCPqrkJm4HHxSsfpKqgnWiU0A2iVVbplxQSMHbWlcT4XSmWP4EjfQcwCkv
         XvNuSCm4I+KQpZaAXiTdJLaKjGx8d4cL6o8syleFgBgTHTSdYwpysf5uQIStYnU1Lc
         YuKitZAXjMSzA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 30 May 2022 18:30:49 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Thread-Topic: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Thread-Index: AQHYb5ohywOA3ErtcUWaOWHlaX8a+a00WgwAgAMI6QA=
Date:   Mon, 30 May 2022 15:29:57 +0000
Message-ID: <20220530153044.y4r4zmxdbyev3tla@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
 <20220528181004.286e696d@jic23-huawei>
In-Reply-To: <20220528181004.286e696d@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4D985FC56E388429BF6B2AC7CB7A57F@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/30 10:43:00 #19620716
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On Sat, May 28, 2022 at 06:10:04PM +0100, Jonathan Cameron wrote:
> > If this call order is wrong, the next iio_trigger_put() (from sysfs
> > callback or "delete module" path) will dereference "default" module
> > refcnt, which is incorrect behaviour.
>=20
> Hi Dmitry,
>=20
> Series applied to the fixes-togreg branch of iio.git and marked for stabl=
e.
>=20

Thank you!

> Do you think it's also worth adding a runtime warning in iio_trigger_get(=
)
> on !trig->owner so that we catch any cases of this introduced in the futu=
re?
>=20

Good point, it will help other kernel developers to avoid such mistake.
I'll prepare new patchset with that.

--=20
Thank you,
Dmitry=
