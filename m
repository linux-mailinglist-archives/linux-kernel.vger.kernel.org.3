Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94E058D918
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiHINGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:06:33 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2036301;
        Tue,  9 Aug 2022 06:06:30 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id AC0675FD04;
        Tue,  9 Aug 2022 16:06:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660050387;
        bh=ssKIxzC2ShU+SldXTFLlZ+Dl4JtHvn5shdrgSl9CPWU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=YIkdsG6Uo+IvPRMcbEF06rySeQtKa8HrH0sSVjoP+r4iN9dZOgPXF9g9+TDysF47W
         D3joVgxDEmGTSe39ymnYUZQJeRut9xMv+2oZenwoNT27amlZs/VoXOyx+RXYcYvQyj
         GgV50iRCR5JYVOhFw/eEEwf4obOs+Kr+ZigRgC2jDmSkOw/9S/0fPSgNo3qRlzUv8V
         I8T8sWgA+5fIA1Q65zGRply8Eo+WbTsP2NhjdslAukMOc7i0nep7I6toL+tBiIZ+Fq
         Tbz26HSAaLsNpsPO3HM0BlBDqKRhOkSVUPWQbeJfOaFWSNUO8BhWL/BaVnBr2pAD64
         Sdv8i5fTw+Nxw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  9 Aug 2022 16:06:26 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "minchan@kernel.org" <minchan@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@chromium.org" <axboe@chromium.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mnitenko@gmail.com" <mnitenko@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: Re: [PATCH v5] zram: remove double compression logic
Thread-Topic: [PATCH v5] zram: remove double compression logic
Thread-Index: AQHYYGSpGpTThyrzfUuEhSUG0yum7a2m55QAgAAG+YA=
Date:   Tue, 9 Aug 2022 13:06:19 +0000
Message-ID: <20220809130543.4dnh5aa3kdxbmzje@cab-wsm-0029881.sigma.sbrf.ru>
References: <20220505094443.11728-1-avromanov@sberdevices.ru>
 <YvJV8rU9bkqiy9iA@google.com>
In-Reply-To: <YvJV8rU9bkqiy9iA@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38CDFADF862CFF44A37B5B0A2247FDE0@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/09 10:46:00 #20084579
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Tue, Aug 09, 2022 at 09:41:22PM +0900, Sergey Senozhatsky wrote:
> On (22/05/05 12:44), Alexey Romanov wrote:
> > @@ -1975,7 +1954,6 @@ static int zram_add(void)
> >  	if (ZRAM_LOGICAL_BLOCK_SIZE =3D=3D PAGE_SIZE)
> >  		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
> > =20
> > -	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
>=20
> By the way, why did it remove QUEUE_FLAG_STABLE_WRITES bit?

Minchan asked me to add this change and this description:

"Since b09ab054b69b, zram has used QUEUE_FLAG_STABLE_WRITES to prevent
buffer change between 1st and 2nd memory allocations. Since we remove
second trial memory allocation logic, we could remove the STABLE_WRITES
flag because there is no change buffer to be modified under us"

This seems to be logical.

--=20
Thank you,
Alexey=
