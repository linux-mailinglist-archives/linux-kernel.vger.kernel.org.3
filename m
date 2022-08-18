Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86A2598AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbiHRRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiHRRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:44:49 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE9696FD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:44:48 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 4C4FD5FD07;
        Thu, 18 Aug 2022 20:44:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660844686;
        bh=SPQown7D6eau6+lPgoeRlXVRqqpCJI7GDEyMPHoMJK8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=jR2ws1rykr2GX3Qp7N1cataO0iPtc6bli8ohSPrPYLInGR+BSZS83QXHE4hlHcVMw
         oHvZZQWzsT0vl8idnYgo6F7LMpzZ1SG99L2jO9BHi5xHu2OL7pU4LnpwT1K919EE9C
         fx0rOqMrR7+XAz93EDbh5l9CHfKK5JCFHV/10+tzjv5ynePfsfvjgeKz0CQ8qltCZH
         IpUM1/PFq/AbBIusvSzl4vG12KkEVfgqKbgt5dIR2ue2mHpKfYLarPw5uxmA9YLk4O
         CeC3D2g5yP2rIuEvwtfkJUfwBAjU3uwO65zVOP2Y3EgkO2Gky0zWiZJGRU18wMz5Cn
         MlxzRhxo2fy/A==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 18 Aug 2022 20:44:45 +0300 (MSK)
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
Thread-Index: AQHYsZwRTOzZdLxKvkqpBNcAgWIdzq20YtWAgAAaSQCAAB/4gIAAIcqA
Date:   Thu, 18 Aug 2022 17:44:23 +0000
Message-ID: <20220818174441.arh7otvrkzg5uk3s@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org> <Yv5eMcmNOmyLmd++@sirena.org.uk>
In-Reply-To: <Yv5eMcmNOmyLmd++@sirena.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <637D660D6248DF408AD56AA98766E706@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/18 13:09:00 #20118254
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Thu, Aug 18, 2022 at 04:43:45PM +0100, Mark Brown wrote:
> On Thu, Aug 18, 2022 at 02:49:20PM +0100, Marc Zyngier wrote:
>=20
> > I don't care much about regmap as a MMIO backend, but it strikes me as
> > odd that you end up with multiple ways of logging the same stuff (with
> > a memcpy in the middle of it).
>=20
> > Why can't this be done with a small amount of trace post-processing?
>=20
> At the minute we don't put the actual data for the bulk transfers into
> the trace so the information simply isn't there.

What do you think about the patch? Can we use the separate trace event
class, or do we have to add these tracepoints to some existing class, like
regmap_block?

Appreciate any thoughts and feedback.

--=20
Thank you,
Dmitry=
