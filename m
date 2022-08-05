Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01BA58AF6E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiHESBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiHESAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:00:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32BC1260C;
        Fri,  5 Aug 2022 11:00:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u12so2635929qtk.0;
        Fri, 05 Aug 2022 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4FpWqw9KDL4te8Y1a2j6cWDYoInxilQc57WR6jmkxYM=;
        b=ZPwuuxotQz8JY/f5zETxBCz+Vmxug62tZZ5HxSaAbMWgYSZjd2PgqJX8lKsLcoLS96
         UmCTvZyVTB7AoTjP7g00/7wEmyAD9U2zgZM3MRWPBp5pv+Y/ZdZN3umfWQJTX4+qkAV/
         1FUvjbuQeRrBFE+XUCgf+C1Jk7j0oHGdFPaHD6ZOySR/ZeJnx70YOS1R3ft0OVDd81CM
         KBepRchRs0PmmFGQISTGDfA5aWmgIRqZnIvaP1itAz7W6GTKLWzkSUenjNBr8UhdtxAw
         9ksgTr8/is+bFvTL0ZoT17UGQptrx/wQmHSWnvD3FBZqMwcfUJYZuIBE11wi6CWjBMOv
         PM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4FpWqw9KDL4te8Y1a2j6cWDYoInxilQc57WR6jmkxYM=;
        b=6dyoJl6MS69hPlGYVWAwxUPuzpNVSt4SFHgaPWwvSQ/XkAKpWBKg0om6hxCkikbZuY
         ZvUj6J24PYFFzWaYao1THI78hsaO7J4EfZDglPUl1+8ldEtP+ajTZLNHnKB1bty+vdt4
         NFeESy4Fj9QLX9KzCQZ4Q9Ir671fVfGEpjEgnNGAKxzkXAzUtdVR84p8ABH4aJgXDpEI
         JXantAYPdu6ZSFQhRXsNiIjPFW9n9bOjcHkEgf8KhHS5aGqdDexUtRejYtRhMT9XDH8G
         2Tfm+qlSLIW3rEEUBPoeCApgnhdwQC7LMpWdLyGt24D+PuZECWkyMRoUiMuCh9UPzbP/
         P/HA==
X-Gm-Message-State: ACgBeo2BEtWOZoUPl7n2m+y6lTgHEU2tyiFY29qVZaFy1fQYoxdIvxV+
        SIRzOrbsl/z95gN5Ql/dRquxcX2hEzaLxKMpT3k=
X-Google-Smtp-Source: AA6agR5zPaHs541tDF34TbSaWnDGtMJwMbTfoUUH2+qekAz6EpMV40V6nfnw/vzhzyOLOZIcrwCbA2EC8/CDxIho5Uk=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr883714qtj.384.1659722421632; Fri, 05 Aug
 2022 11:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru> <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75Vcn6JCDDvugop2Ho1cayLi1CX78O42v3GifvnuSY5fvPA@mail.gmail.com>
 <20220805140430.c773smfzxg5zcj4b@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75VeHXemqJH6rCfH5Tvoq=nDBM4d9nGr-b6LN-fKMEEvyfA@mail.gmail.com> <20220805162100.q4ol4go3ozefmqt6@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220805162100.q4ol4go3ozefmqt6@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 19:59:43 +0200
Message-ID: <CAHp75Ved+vu5MjN3ATbSYUJ1eWZupwPnV+aVv=8_KfVGJjdAKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 6:21 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> On Fri, Aug 05, 2022 at 06:03:12PM +0200, Andy Shevchenko wrote:

...

> Oh, got it. Thanks a lot for detailed explanation. I'll attach both of
> them: my HZ units series and your str_read_write() patchset.

s/patchset/single patch/
The I2C patches mustn't be included (they are actually rejected,
that's why you haven't seen the first patch in the Linux Next).

-- 
With Best Regards,
Andy Shevchenko
