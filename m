Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC557511D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbiD0PuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiD0Pt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:49:57 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98524091A;
        Wed, 27 Apr 2022 08:46:43 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1651074399;
        bh=ejBbquEAOj9E04zXC9/qxWwR4aQAaZqeDAsYUlRZtQ8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=BK1/LENVx4zM+c/64+RTUy1eD+C8G2RX6VCxzmtxel4h/gnjqhAU6G5Ye+1ux+geI
         oEQ7DK05kuhF34Dql4t2Btd0fdaDBIcwdn1oAuK9px8GQS5WaDHbzph0ZCpO41E88Z
         Dn/YDNHKXinnoyNJTJpFgBiuqtoSpdsaOT8hRrJuHrhxjB61BgzxqmttBoGxJxWYhl
         smjV8m3DOWuH1E9IBO8XEIXlAH4ZA9eN0DRBe85LfpLG35z0yrOjPsYUbAhgtAOCql
         tXSYUpewSEkVJswnRbXclAIO5ZFdZy8LaS9Y31QS2G3iKR5ebD8I7T952AYHu6bRGo
         17Jc2xKw/sMZQ==
To:     Marcel Holtmann <marcel@holtmann.org>
From:   Juerg Haefliger <juergh@protonmail.com>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Juerg Haefliger <juergh@protonmail.com>
Subject: Re: [PATCH] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Message-ID: <_GyJWTeZu6emLzFDC3fwvOlBC6CqO2OT6cl_P8DnD9DHXND2rEgLQu6naToxpYZzorpJVZXkVJ1JB3ASqcRSncyBCcov8084Q8YABhoDCL4=@protonmail.com>
In-Reply-To: <7E038C77-771A-415D-B963-128EB5DD9D48@holtmann.org>
References: <20220427063504.384540-1-juergh@protonmail.com> <7E038C77-771A-415D-B963-128EB5DD9D48@holtmann.org>
Feedback-ID: 10260306:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, April 27th, 2022 at 14:49, Marcel Holtmann <marcel@holtmann.o=
rg> wrote:

>
>
> Hi Juerg,
>
> > The ath3k driver loads patch and configuration files so add MODULE_FIRM=
WARE
> > macros to povide that information via modinfo.
> >
> > Signed-off-by: Juerg Haefliger juergh@protonmail.com
> > ---
> > drivers/bluetooth/ath3k.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index 88262d3a9392..56e9a64177ae 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver"=
);
> > MODULE_VERSION(VERSION);
> > MODULE_LICENSE("GPL");
> > MODULE_FIRMWARE(ATH3K_FIRMWARE);
> > +MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
> > +MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");
>
>
> since when do we allow GLOB pattern matching here?

Not sure when that was first introduced but:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D75729e110e680687668fd5b4bdd7b25c92e9c00d

...Juerg


> Regards
>
> Marcel
