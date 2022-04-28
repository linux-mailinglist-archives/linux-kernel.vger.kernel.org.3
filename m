Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1103513C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351572AbiD1UEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiD1UEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:04:36 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973774868;
        Thu, 28 Apr 2022 13:01:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 65EF75FD03;
        Thu, 28 Apr 2022 23:01:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1651176076;
        bh=Osnnz3SGQ3g/VbQYJdclIP+f6CEdAQIARqwCtbhZApE=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=oNpfdTYiFBwtPAF/VzIe5X6+HaR/Mw4kAZ1M/9iS0hjgbUSNuFcK0lAoHFrODtCuC
         DHWuX/XEU89eNzO3cOTHMhE3GQGu9z6k8At5ELDc0k/VpZgHfaubEdYinkjaxxU0Bf
         oQC1Q6Mmw7rqYfi4sx3UVrwEzrw2KgACEO+f7RROqfwPT1Oef3qmJfGm0HWuy3zgY/
         RM3OuPBuujIc47wqa0dZmajNUbZWxOHuvEUFIfYOTfd+fish+23fodcDI6ZzY8UEVl
         od3JTlXTQy4Mr9eGRUacBciLz498j71YQlu9jVdKChOD/1LLIYF2Wb3+GVhaxgHtd1
         /DnM21t9+zlIg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 28 Apr 2022 23:01:14 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "minchan@kernel.org" <minchan@kernel.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@chromium.org" <axboe@chromium.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mnitenko@gmail.com" <mnitenko@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: Re: [PATCH v2] zram: remove double compression logic
Thread-Topic: [PATCH v2] zram: remove double compression logic
Thread-Index: AQHYWh39fkxoPWqFH028+oB3r+sQB60Dbc4AgAIhEIA=
Date:   Thu, 28 Apr 2022 20:01:12 +0000
Message-ID: <20220428200107.hz65qvxf2aoz27q2@cab-wsm-0029881>
References: <20220427100345.29461-1-avromanov@sberdevices.ru>
 <YmkpSC/gJf7Cg2Ym@google.com>
In-Reply-To: <YmkpSC/gJf7Cg2Ym@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93E992117724AD41B9856520CDF1E0BD@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/28 14:34:00 #19338612
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply!

On Wed, Apr 27, 2022 at 08:30:16PM +0900, Sergey Senozhatsky wrote:
> On (22/04/27 13:03), Alexey Romanov wrote:
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index cb253d80d72b..4be6caf43b1d 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1153,9 +1153,8 @@ static ssize_t debug_stat_show(struct device *dev=
,
> > =20
> >  	down_read(&zram->init_lock);
> >  	ret =3D scnprintf(buf, PAGE_SIZE,
> > -			"version: %d\n%8llu %8llu\n",
> > +			"version: %d\n%8llu\n",
> >  			version,
> > -			(u64)atomic64_read(&zram->stats.writestall),
> >  			(u64)atomic64_read(&zram->stats.miss_free));
> >  	up_read(&zram->init_lock);
>=20
> I think this also has to bump `version` to 2, since format of the
> file has changed.

Yes, I'll do that in the next patch.

Minchan, do you have any suggestions on this patch?=20
I want to fix Sergey suggestion and sumbit next patch.=
