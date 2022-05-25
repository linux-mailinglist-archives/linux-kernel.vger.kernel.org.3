Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31053534283
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiEYRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiEYRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:53:49 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9922DFB4;
        Wed, 25 May 2022 10:53:32 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id F0B8E5FD08;
        Wed, 25 May 2022 20:53:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653501209;
        bh=En3Np2u2djTMEVwwxBwoJJkxFH8AqiHFqQ265Nknr8o=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=EOeeYFyNtIC1PrWeiDG9ODbItxIuP0Rc4ssRlCd8eIecElXctQ7jHLBbqkSEgThD3
         +xWvClg/WXHssF2/hWx1/ECjrAEdixt9xrpXjpxb3gwiw13jj+a3bimC08KKpbmrNs
         ACgELy2KcYz/VHuArMMa/pTIOEQ+2R38fnPYpBdltRJu23Dsht1zl3froF5O/SyAgH
         NvabuYIeibhaFCub4VRlTDS1cQizZU/XjX2NIxOCVo4Ap/xR1r/XG16g6ZHfPXj8rt
         e/hMhVNHIOcQ4x9JQezltS8kH5IqQmw4Zx1eu7eRNbFWrBycqrmjnjZp3vgkwME9Tt
         Mo4bgBNmWyTVQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 25 May 2022 20:53:26 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYVASOybrxT0DjfUWoYWuGUlWOX6z4bouAgAnb/gCAIkALgIAGKs0AgAUw8QA=
Date:   Wed, 25 May 2022 17:53:11 +0000
Message-ID: <20220525175322.36umsxjwioyfcsac@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-3-ddrokosov@sberdevices.ru>
 <20220420115023.00006a25@Huawei.com>
 <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220518122515.aby5lbb4xusr6pdt@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220522113654.0e3c0023@jic23-huawei>
In-Reply-To: <20220522113654.0e3c0023@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CF6C5E8D08B4941B4A2F1C04D4EB0B2@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/25 08:39:00 #19569940
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 11:36:54AM +0100, Jonathan Cameron wrote:
> > Syscall delete_module() tries to stop module first and after calls
> > driver exit() function (which executes devm_* handlers inside, includin=
g IIO
> > trigger unregister). It means we have the chicken or the egg dilemma he=
re.
> > Module can't be unloaded until module refcnt is not zero and we can't
> > execute IIO trigger unregister (decrease module refcnt) only when modul=
e
> > refcnt is zero.
> > I suppose the possible solution to such a problem is a different semant=
ic
> > for internal triggers (inside driver itself) and external drivers (like
> > hwtimer trigger). What do you think?
>=20
> Potentially though it's going to be tricky as a driver doesn't generally
> have any way to know they are internal and we need to be careful not to
> underflow the reference counts.  We could hid a flag somewhere and
> add an iio_trigger_get_same_owner() or something that sets that flag allo=
wing
> us to decide not to drop the reference count it if is automatically unass=
ociated.
> In the path where you get:
> 1) iio_trigger_get_same_owner() on probe
> 2) sysfs write changes to another trigger.
> 3) sysfs write back to original trigger
> it is reasonable to assume the need to clear the trigger
> before driver removal is possible, whereas clearing the trigger associati=
on
> if only step 1 happened is no intuitive.

I will try to prepare the rfc patch if you don't mind. I propose to
continue further discussion there.

>=20
> >=20
> > The second one issue is located in the different IIO drivers. Some modu=
les
> > call iio_trigger_get() before iio_trigger_register(), trig->owner is no=
t
> > initialized to the right value (THIS_MODULE) and we don't acquire refcn=
t
> > for proper driver object.
>=20
> Ah. Good point. I guess we missed that when we were moving over to
> automated setting of the module.
>=20

Already submitted v2 patchset here:
https://lore.kernel.org/linux-iio/20220524181150.9240-1-ddrokosov@sberdevic=
es.ru/

--=20
Thank you,
Dmitry=
