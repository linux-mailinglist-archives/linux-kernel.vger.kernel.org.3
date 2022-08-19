Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFF599E47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349691AbiHSPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349672AbiHSPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:22:49 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676AFF8F7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:22:45 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id AE21A5FD04;
        Fri, 19 Aug 2022 18:22:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660922563;
        bh=EMBve9wbcn8yZMUeLom/7Ix55XMEtKZL/pTQ98Vj45o=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=NJVVmlsv/vKJF2Auaj8pzRaBQSnxJOdTw1TnAsQXOcxWUamA//d+18p/qULCEGeuW
         GmB4IvBk0b5UHsuPUYy2T1WSF2GJdZzpd5j1oPzIIq49n9SW/9rp55KUGzVIbaaBKK
         aCFqLj/DF6ThRjBMNX5sSx4/ZrL5/HoZNUwDipm8XsV9/PhwUQ3L0tVWwaREzk2jZA
         TZNe7hMtvd50M4NDF8eKI/SS9GgUqHtnUJti0DIr1q+B3nHVLHdR9avsY/jUCwmW/r
         S0X0Or7y7+PCJvBByV/MWgTsP6sIQoPZ9Tq9sYUJhd9qyFakIXS9SBLFmkorx6THsa
         A34pokTXjXyEw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 Aug 2022 18:22:42 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Thread-Topic: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Thread-Index: AQHYsZwRTOzZdLxKvkqpBNcAgWIdzq20YtWAgAAaSQCAAB/4gIAAIcqAgAE0NICAABeIAIAAFDSAgAAKtoA=
Date:   Fri, 19 Aug 2022 15:22:14 +0000
Message-ID: <20220819152239.yofi3yu5oojgrsox@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org> <Yv5eMcmNOmyLmd++@sirena.org.uk>
 <20220818174441.arh7otvrkzg5uk3s@CAB-WSD-L081021.sigma.sbrf.ru>
 <Yv99E0mrPI0qG66I@sirena.org.uk>
 <20220819133200.xvpjzatkub4yxnsh@CAB-WSD-L081021.sigma.sbrf.ru>
 <Yv+hwyrQtBjc69Yd@sirena.org.uk>
In-Reply-To: <Yv+hwyrQtBjc69Yd@sirena.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6530040F10735747BB0C06A92324ABF9@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/19 07:02:00 #20132955
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:44:19PM +0100, Mark Brown wrote:
> > > I didn't realise that was even a question, but then there seems to be
> > > some discussion I've not seen given the CCing going on.  The biggest
> > > issue is do we even want the overhead but I'll need to find time to l=
ook
> > > at this properly.
>=20
> > No any additional discussion before. I've added your address to all ema=
ils
> > which I sent.
>=20
> I assume you copied in Thomas, Rasmus and Marc for some reason?

No reason, sorry for make misunderstanding here.
I have listed other regmap discussions and added them to get more opinions.

>=20
> > Why do you think it this patch will bring overhead to regmap? AFAK, whe=
n
> > tracepoint is disabled, tracepoint fast assign operation shouldn't be
> > executed. In other words, memcpy will not be applied.
>=20
> To repeat I have not yet looked at your patch properly, one concern is
> how we handle the marshalling which regmap does.

Okay, no problem

--=20
Thank you,
Dmitry=
