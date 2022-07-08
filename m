Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2A56BD71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiGHPmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiGHPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:42:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AD6EEB4;
        Fri,  8 Jul 2022 08:42:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31caffa4a45so130071637b3.3;
        Fri, 08 Jul 2022 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KyDl05vUDZC3KtpDAZZDk8Jclgf+fyUT4de3z8iw/dQ=;
        b=cqi3b3DaVyECgMdCiGJS2SrxHGMxunaaoMD/Spwx7tjpJ/GZV2HC3FWINA6pE347/Z
         oOy8O3mZv6thDHgupGhIXC6GHfRZmHUdKzCgigLkfcH5c28C/eO2VZxmdrNivV05t41r
         X8N3xNIHpyQGU5ggJAjnkvIVmZWf438knZk+F0jyeXwaMkmvc9vchouIcF05AZz/LqW1
         FSozO87b7MYP3awk+wRCDa7YceqeDkIJouOQ7eBGfHr43KIHwFhGiS5+SANXned+EpCV
         7uDvppmwX96H14kmcGpiIxuiv4707kAwWRGJbsbH0fMwMkKTqzm/2hS1iX1U7mQ6JxpT
         V12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KyDl05vUDZC3KtpDAZZDk8Jclgf+fyUT4de3z8iw/dQ=;
        b=ddiLApQdRP7b7Tbkmw4/uOLEyiXJyq87HBko5AQkiPQLaZnq16uXQanuRKcbFnT6n6
         5iYz1EPCSR7qg0/VBR8lcRqMEoxjWYOgnT5bPSZjI1ITlLFYcY7MXVDgm50lOWzTkB4g
         fxLBtXGhYqBuMlX6YsH3LeJ1zZ9SUWd5PJa9TEqGbyki7tQ6I0i4gROHY/xRL9s6LOCi
         EbZNakyKlpjhcFABWuxMHtpmssrfXuEQen5ndDZv/tyzzBv7Q8xkTkEPswr4K7CxdMSk
         QnsqE3grsAr04luvzDR+Dtow5kbC6Z0Q4S3hCLoXpL/O/kPlUYW5hbTHGjiGzyFSPoc8
         7kRA==
X-Gm-Message-State: AJIora9wJDCByCpMc1NqtFQDcFurZumHhCEnKQ+AGrrf48xaDWoSEAev
        b3n9bmKrSSRZoBcDgUZMC+J4UAKqjCuhIk3PMIQ=
X-Google-Smtp-Source: AGRyM1vmPDB28H0EnqVeiLVM6R4qsCAkf+yIt8PfwqQqxFb22AHdnNxw7QdMdTx52+0aMVNTu4WBRhb4a5zJ5nQM/iE=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr4972445ywa.131.1657294959944; Fri, 08
 Jul 2022 08:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220321163055.4058-1-pali@kernel.org> <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com> <20220707084840.jvsstvyx2ul5ltb6@pali>
 <YsgsH94PV/wAX0Vu@kroah.com> <20220708132621.4v2es73h52aq3izn@pali>
 <Ysg2RW0B/cLL3k+k@kroah.com> <20220708142001.7fciqnfckznlvsa4@pali>
In-Reply-To: <20220708142001.7fciqnfckznlvsa4@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 17:42:03 +0200
Message-ID: <CAHp75Vci1zeDV1axd_v_PLLPGfF5AzAzmmcegjD1djqnR6XUcA@mail.gmail.com>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 4:20 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Friday 08 July 2022 15:51:01 Greg Kroah-Hartman wrote:
> > On Fri, Jul 08, 2022 at 03:26:21PM +0200, Pali Roh=C3=A1r wrote:
> > > On Friday 08 July 2022 15:07:43 Greg Kroah-Hartman wrote:
> > > > On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Roh=C3=A1r wrote:
> > > > > On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote:

...

> > > > I'm not saying remove them, I'm saying let us not add any more
> > > > dependancies on them in order to keep new applications from ever wa=
nting
> > > > to use them.
> > >
> > > Last time you wrote to remove them. Now saying not to remove them. So=
 I
> > > do not understand you now.

There was a _new_ addition of the ugly SPD_CUST, that's what I believe
Greg opposes to. And I support that.

> > I'm sorry, I am totally lost.
>
> So look what you have wrote? Who is lost here is me.
>
> > How about starting over and resubmitting
> > the changes you want and we can go from there.
>
> What to resubmit? I do not understand you. In case you lost emails or
> accidentally removed them, you can look at them in archive, not? I hope
> that you do not want me to copy+paste all existing patches with all your
> quotes on them which you wrote into new emails.

That change that adds the new user of SPD_CUST?

In any case the best summary about BOTHER I ever read is this [1] (and
an initial steps in picocom [2]). And I believe that instead of
SPD_CUST we should get rid (or at least minimize) the problems with
BOTHER in user space.

[1]: https://github.com/npat-efault/picocom/blob/master/termios2.txt
[2]: https://github.com/jmesmon/picocom/issues/2



--=20
With Best Regards,
Andy Shevchenko
