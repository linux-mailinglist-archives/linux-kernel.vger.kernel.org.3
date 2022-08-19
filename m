Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243C599D02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349006AbiHSNcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348671AbiHSNcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:32:08 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B7EEF14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:32:05 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 1BD2A5FD0B;
        Fri, 19 Aug 2022 16:32:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660915924;
        bh=fvZMpSkmVXE8JbV74/mqonq9g4N0G3wgPa0Gz1QhuLE=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=orcSMiInMFBEOGPW+iwTvsiSrIhXsT49OoXu+47k1+AXca8nJydbOCql2ADgyJMjz
         2ffDJ7/HT8yYBW0ITMmdvnsPkXv1HvJNZ21MALHA0c8Iwya1n3uF95MghWvgrXX45b
         Ox2H0XcIeL9ytvz9PgtoiivdNcfotpO175AOBUENL7ljHpyCj0/IpjJ9KWA9S8NLpD
         RMQUfiz0fnvx97Ht8QSC5BRN0k4LiomKeERGgtXy92MqoUAebiq3zoCWwvTCUCCVlw
         h9uhjgZeI80FuvUn2/Uh9mwJgBQCdmZ32xLXwQfwJwSjaJqS5HDeTDc8O/WJEQ2Kzb
         XcyO8e5A8QK0w==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 Aug 2022 16:32:03 +0300 (MSK)
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
Thread-Index: AQHYsZwRTOzZdLxKvkqpBNcAgWIdzq20YtWAgAAaSQCAAB/4gIAAIcqAgAE0NICAABeIAA==
Date:   Fri, 19 Aug 2022 13:31:35 +0000
Message-ID: <20220819133200.xvpjzatkub4yxnsh@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org> <Yv5eMcmNOmyLmd++@sirena.org.uk>
 <20220818174441.arh7otvrkzg5uk3s@CAB-WSD-L081021.sigma.sbrf.ru>
 <Yv99E0mrPI0qG66I@sirena.org.uk>
In-Reply-To: <Yv99E0mrPI0qG66I@sirena.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32B8EC764526834D84C3377FBC825ACD@sberdevices.ru>
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

On Fri, Aug 19, 2022 at 01:07:47PM +0100, Mark Brown wrote:
> On Thu, Aug 18, 2022 at 05:44:23PM +0000, Dmitry Rokosov wrote:
> > On Thu, Aug 18, 2022 at 04:43:45PM +0100, Mark Brown wrote:
>=20
> > > At the minute we don't put the actual data for the bulk transfers int=
o
> > > the trace so the information simply isn't there.
>=20
> > What do you think about the patch? Can we use the separate trace event
> > class, or do we have to add these tracepoints to some existing class, l=
ike
> > regmap_block?
>=20
> I didn't realise that was even a question, but then there seems to be
> some discussion I've not seen given the CCing going on.  The biggest
> issue is do we even want the overhead but I'll need to find time to look
> at this properly.

No any additional discussion before. I've added your address to all emails
which I sent.
I've asked about the bulk tracepoints patch. As I understood Marc's questio=
n
about multiple ways of logging the same stuff, the main concern is patch
adding additional trace event class "regmap_block_io" and doesn't use alrea=
dy
existing classes. I've tried to inject bulk transfer data hexdumping to
regmap_block trace event class, but it has some difficult and ugly
conditions should be applied. That's why I would prefer to discuss
implementation proposed by patch if possible.

Why do you think it this patch will bring overhead to regmap? AFAK, when
tracepoint is disabled, tracepoint fast assign operation shouldn't be
executed. In other words, memcpy will not be applied.

--=20
Thank you,
Dmitry=
