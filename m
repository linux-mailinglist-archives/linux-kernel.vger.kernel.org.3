Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E698A5318B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiEWT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiEWT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:27:53 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B32A30AF;
        Mon, 23 May 2022 12:07:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 9CFAF5FD07;
        Mon, 23 May 2022 22:07:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653332846;
        bh=DrfX8UyaYPB32fRXUNLHoBD1zfkxh/digB1yu9RXR7s=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=NqZB2zZTgdwirIhjrJekfdnaV7AyyaQj70JGkn5Wd3ESXRqFLreEZm/f+c3y1apr+
         3AqY+t52bmjTEpRum0pRCQfNxn6eQNrSr/I7x9990T5XNMTKpMK2FXX7pSXSTHlqau
         Nq18myE+dxtvWGhnoQv5Kw4QuUWyVq8khQGgywWoNmGNhjgQLknwMMPe+vcsWo9ks9
         vy77Y5Oo79No/9tlwOGygSsBw7jfpUZSNJZHGZNu0/x9WdakGaScuKUflXNENlTKyk
         bhmq52LHBirx6Ex4YEbrfDMT5V/ZMyLVFvnk5gv89PWFaEUj6XDO4b4EZ3/gDmr0ow
         a9ZdLahWZshZA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 23 May 2022 22:07:15 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] iio: treewide: rearrange iio trig get/register
Thread-Topic: [PATCH v1 0/5] iio: treewide: rearrange iio trig get/register
Thread-Index: AQHYbsP3wjZLsbk+IECvoYYw88GylK0siI6AgAAYMwA=
Date:   Mon, 23 May 2022 19:06:19 +0000
Message-ID: <20220523190704.3bz33f43yk5bohh4@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
 <CAHp75VeuAxMWknoG28v8k-gKCpUQFJbwpq+pTaTVPeY45vQo2w@mail.gmail.com>
In-Reply-To: <CAHp75VeuAxMWknoG28v8k-gKCpUQFJbwpq+pTaTVPeY45vQo2w@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <904E8D114B7BB449A15C52EDAC985098@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/23 11:48:00 #19537323
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:40:27PM +0200, Andy Shevchenko wrote:
Hello Andy,

Thank you for quick feedback.

On Mon, May 23, 2022 at 07:40:27PM +0200, Andy Shevchenko wrote:
> > If this call order is wrong, the next iio_trigger_put() (from sysfs
> > callbacks or rmmod) will derefence "default" module refcnt, which is
>=20
> dereference
Ah... good catch.

> > completely incorrect.
>=20
> Cool set! But it sounds like a set of fixes, can you add a Fixes tag
> to each of the patches?
Sure, no problem, will provide Fixes tags in the next version.

--=20
Thank you,
Dmitry=
