Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129E590BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiHLGIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiHLGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:08:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792CA4B2F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:08:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso16329pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=NCnhv/pEtaSBg9KIMYsJIwv7lSODCZztiNlzGMGUZ8Y=;
        b=aDS02WJdXoQC143tgj0melrqXUgyvbrHHE4veytzxZcs6hJWZ4p74lpt8BUNbfJycM
         GM0SbqBvEQ+MocPZbYHzAmOM7uMpdDtfx7B7gshPpYRo7BSX6QeBbxXH/F6tRzstoXOP
         Hq4YqwHMXAN3y7YN81WjpiH4XShsd0D+4ncyGd5jdK8rawjojFI1G1FkxH/bPy+WuZI0
         3orDNesOSve0KTyzbJZ0m9wTPCS8SQLVoBNGZSRlDfp9qeLTdtqkGr8JVPChRNlh1ysn
         UtLQBAgFp1AvLbElP1y8UwT6Jt8J3bvSMIfo4BG8RQ8TdMM4qq6kTHc1KGbXVGpWmh/E
         MNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=NCnhv/pEtaSBg9KIMYsJIwv7lSODCZztiNlzGMGUZ8Y=;
        b=KyRumCUS1hs2p4Ux3ABR2+BfRzN/A3jB4vLYM3TfiTGoQLB/wxEp+PlksHs3wJbhih
         Q9TuCLh1tIBdWZ5o54hnqyQUmA7cyM/wkLGIhhuLRQFmY13GTi0MLLM3l8zePBY3SUSs
         vwQV1gbsV2Bq//fYPoTVhi6vTCCIxam3uPCkACTgCBdPzV6cTSl4d04HrgZYoozOALiB
         vu8qYQgLLLvlwmlK839WtBhNtwVogMMQh0mJPsMDYMwY2EGKzt9HJnVkiENGe7XLf3Hd
         +PtMYFXLAg3qq/w8r7Cicy4CY7/KrSujYRO7Hsd74n7DmEwfnYbyEtn0hkrE/J5UZO37
         m/Cg==
X-Gm-Message-State: ACgBeo1orrZXx9OUuz2xeR0gDve3f65ZsqtDPQ3pz1noeadfQUhTWZYu
        hqhbs8V9Rc+Sdk2XNdC+9UCAPf2jv6lS65BP60fFqw==
X-Google-Smtp-Source: AA6agR7Xt4qn1yBLEPFZTYt/U7/0q/yFxy7kIlS7Q+rgxokejkk2oPVoC6/9viPfXENo6HDPfVYCT4phxhutqB/fmNE=
X-Received: by 2002:a17:90b:1d86:b0:1f7:31c6:1cce with SMTP id
 pf6-20020a17090b1d8600b001f731c61ccemr2595669pjb.192.1660284519440; Thu, 11
 Aug 2022 23:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220725080240.106619-1-jsd@semihalf.com> <d2be49af-71e4-978b-fe00-8b8fca6f80b5@linux.intel.com>
In-Reply-To: <d2be49af-71e4-978b-fe00-8b8fca6f80b5@linux.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Fri, 12 Aug 2022 08:08:28 +0200
Message-ID: <CAOtMz3OR7LspGvXUo-KWNk=1+nYXDAPZy1YV-WtCOL_ihaVyEw@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: Introduce cooldown timer to AMDPSP driver
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        wsa@kernel.org, rrangel@chromium.org, mw@semihalf.com,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 9 sie 2022 o 14:05 Jarkko Nikula <jarkko.nikula@linux.intel.com>
napisa=C5=82(a):
>
> Hi
>
> Sorry the delay, this slipped through my eyes during vacation. Couple
> minor comments below.
>
> On 7/25/22 11:02, Jan Dabros wrote:
> > In order to optimize performance, limit amount of back and forth
> > transactions between x86 and PSP. This is done by introduction of
> > cooldown period - that is window in which x86 isn't releasing the bus
> > immediately after each I2C transaction.
> >
> > In order to protect PSP from being starved while waiting for
> > arbitration, after a programmed time bus is automatically released by a
> > deferred function.
> >
> > Signed-off-by: Jan Dabros <jsd@semihalf.com>
> > ---
> >   drivers/i2c/busses/i2c-designware-amdpsp.c | 68 +++++++++++++++++----=
-
> >   1 file changed, 53 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/b=
usses/i2c-designware-amdpsp.c
> > index b624356c945f..2e1bb5ae72c3 100644
> > --- a/drivers/i2c/busses/i2c-designware-amdpsp.c
> > +++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/io-64-nonatomic-lo-hi.h>
> >   #include <linux/psp-sev.h>
> >   #include <linux/types.h>
> > +#include <linux/workqueue.h>
> >
> >   #include <asm/msr.h>
> >
> > @@ -15,6 +16,8 @@
> >   #define PSP_MBOX_OFFSET             0x10570
> >   #define PSP_CMD_TIMEOUT_US  (500 * USEC_PER_MSEC)
> >
> > +#define PSP_I2C_COOLDOWN_TIME_MS 100
> > +
>
> "cooldown" distract me thinking thermal management. Would semaphore
> reservation time/timer fit better?

Yes, it makes sense. I will change this here and in the commit message
to "semaphore reservation timer".

>
> > +static void release_bus_now(void)
> > +static void psp_release_i2c_bus_deferred(struct work_struct *work)
> > +static DECLARE_DELAYED_WORK(release_queue, psp_release_i2c_bus_deferre=
d);
> > +
>
> I'd use the same namespace here. Perhaps _now can be dropped from the
> name since the release_bus and release_bus_deferred are near to each
> other and _deferred variant implies it's called after timeout.

Right, release_bus_now -> release_bus.

>
> > +     /*
> > +      * Send a release command to PSP if the cooldown timeout elapsed =
but x86 still
> > +      * owns the ctrlr.
> > +      */
>
> Replace "ctrlr" -> "control" here since then it doesn't lead to think
> is't some technical object like register etc.

This is about "controller" not "control", but I think your comment is
still applicable.

Best Regards,
Jan
