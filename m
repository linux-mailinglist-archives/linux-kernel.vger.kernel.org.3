Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F47598A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbiHRRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344776AbiHRRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:18:17 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FA8632A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:16:00 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C1FDA5FD07;
        Thu, 18 Aug 2022 20:03:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660842189;
        bh=atXpTlwNr2VDFs9Q61PO9a8prLefTCao1wO5y6uExg0=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=tEs7q3aYiwGnbqBFVe+MnHxp+B0OKjYH6KvyJcMqI41PoNCNd78dWsrI6dYw4Abzs
         O5vPMthR/i4Dj2LV+uNQaJ5CRuI8UBEZEYbyfDEPQytxXpysGzzKBW8mVl9nj/g//Q
         oMuZqSdORfjN+xM/tCH12azZ2k2lXTyonTV9WIQE3dUiWsheekGC9rnIusksikDaNK
         zEQoLWGBohr7oaottclVATIWkTRTy3vqkeODEsRme5Q55ou5m9KstpoRTf0wI1s4M6
         XTXvxoGdtTBnsloz6WzEjRgBZKMUOZjhQdr7aFm6qxIgi10WXX/n+Gkq/Fl/jzvgJc
         4IpyZ00useUjA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 18 Aug 2022 20:03:08 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Marc Zyngier <maz@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
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
Thread-Index: AQHYsZwRTOzZdLxKvkqpBNcAgWIdzq20YtWAgAAaSQCAADYjgA==
Date:   Thu, 18 Aug 2022 17:02:46 +0000
Message-ID: <20220818170305.kxtgpmulyditol6r@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org>
In-Reply-To: <87mtc1wtjz.wl-maz@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A8E25C78C2041488D21CB9D2855371C@sberdevices.ru>
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

Hello Marc,

Thank you for quick feedback. Please find my comments below.

On Thu, Aug 18, 2022 at 02:49:20PM +0100, Marc Zyngier wrote:

[...]

> > > Currently, only one-register io operations support tracepoints with
> > > value logging. For the regmap bulk operations developer can view
> > > hw_start/hw_done tracepoints with starting reg number and registers
> > > count to be reading or writing. This patch injects tracepoints with
> > > dumping registers values in the hex format to regmap bulk reading
> > > and writing.
>=20
> I don't care much about regmap as a MMIO backend, but it strikes me as
> odd that you end up with multiple ways of logging the same stuff (with
> a memcpy in the middle of it).
>=20
> Why can't this be done with a small amount of trace post-processing?

Sorry, actually, I don't get you. What do you mean by "same stuff"?
For now, regmap bulk I/O operations don't log data buffers, because
current regmap trace classes don't have a dynamic trace arrays inside.
We should use dynamic array here because bulk I/O operations can vary
buffer size from call to call.
Function memcpy() is used to copy original buffer data to a trace array
when tracepoint is enabled. In other words, per my understanding,
when tracepoint is disabled we do not call TP_fast_assign instructions.

Trace event documentation says about dynamic array:

 *   __dynamic_array: This is similar to array, but can vary its size from
 *         instance to instance of the tracepoint being called.
 *         Like __array, this too has three elements (type, name, size);
 *         type is the type of the element, name is the name of the array.
 *         The size is different than __array. It is not a static number,
 *         but the algorithm to figure out the length of the array for the
 *         specific instance of tracepoint. Again, size is the number of
 *         items in the array, not the total length in bytes.
 *
 *         __dynamic_array( int, foo, bar) is similar to: int foo[bar];
 *
 *         Note, unlike arrays, you must use the __get_dynamic_array() macr=
o
 *         to access the array.
 *
 *         memcpy(__get_dynamic_array(foo), bar, 10);
 *
 *         Notice, that "__entry" is not needed here.

BTW, I've tried to use the already existing TRACE CLASS regmap_block, but
it's difficult to integrate dynamic array to that, because sometimes we
do not have a reg data (for example, regmap_hw_read_start event).

[...]

--=20
Thank you,
Dmitry=
