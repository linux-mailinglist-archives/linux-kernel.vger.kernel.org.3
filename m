Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287585A6428
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiH3Mzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiH3MzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:55:08 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7404FCA17;
        Tue, 30 Aug 2022 05:54:41 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j6so4799217qvu.10;
        Tue, 30 Aug 2022 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=SnrztBqfZL2rLznKVmAq3adfHOBCsmZV7kR61San/Ko=;
        b=ewcbf6vMRM0qdxVSwJ6otoPPDQhovvHsVdpGFV7lA2fEdexPxt4mus/Bz5SWp9Uq+W
         E/l8IGh1xYQaHoartZKymoJ+Bi0gYT+PIx1a3BYKX6VoNZeMptx54HH601DbQHwKLAQE
         aro9XYS/p+TbRSZ+7Fb0hV4nm0bXMH7P2i23qX0+0IHmqx6urjFEANZT0qCn/uo3tLhN
         bm6xbyDKkAaKB1ObEuOi4cLUh3LBQDdCVlNL7XhCBngWNL3cE/fyUnQy7PtQJHPLW7fn
         hoBMSja0o4wxczBzg+nKEH4yJs9hs8WTa5pa5qjHYealNknQR9WaEpTSnLouEgFaFk7K
         JWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=SnrztBqfZL2rLznKVmAq3adfHOBCsmZV7kR61San/Ko=;
        b=5sFK5FBUQBd27v/qwVu/SC2R62oj+3oMrMotpAab6Tmderr/qU9L+dS/7V1JALNfhm
         pwm8n0HLT1gj42fgFflKj6Q+joaCYI3CU7qple0eV8az8UYQUKE8R/pL9bF1x576ogLz
         gZpsz7ORk9+Ezv2XVTUnnZWTIbbQaC49mIqNg0Ee849iq9XKHvi0opiQmPB3tyhwnPk3
         t/i5RRDy3vxCNPOEv1FrTRUZ8pqJmNFbNilNdZbwtf9Oc9hffaDvw9BTZhQWqn2dirDz
         hW9jamG0nQNJT/e5U6OIzKgVp4HYxXjXvObty6Je8cWV6B/RyRDwEvQt2OUalhr9I7eK
         NjLA==
X-Gm-Message-State: ACgBeo1uPmhDO9EliW48Nh3W4SWxi+xv77nkxcqQWYW0ilTNbl5FeSN9
        9zh0Bei2O466/zDYTs8nG5B+MdcE17Yh8dL9BME=
X-Google-Smtp-Source: AA6agR4hNfo27nnJ0tHPMm5V/qO48rPNKGzJOIMBX/e21erUKvQwoMohBMfuYfWQIqo67B1xkF8bbGGb9EzAs5Ed/dc=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr14739784qvb.97.1661864058833; Tue, 30
 Aug 2022 05:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
 <20220825091707.8112-2-ilpo.jarvinen@linux.intel.com> <Yw4CP8y3b9E9XV0K@kroah.com>
 <CAHp75VfQHhPoO3Rpk=o1c2qPJB-tc_6G41n6iz3sv_gP44PLUw@mail.gmail.com> <Yw4HALWWOWabR/l9@kroah.com>
In-Reply-To: <Yw4HALWWOWabR/l9@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 15:53:43 +0300
Message-ID: <CAHp75VcdqwnKq80H7tzeyS_ior+FCHPH23wQZfvivn-6wRx1pA@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: Create uart_xmit_advance()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Alan Cox <alan@linux.intel.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
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

On Tue, Aug 30, 2022 at 3:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Aug 30, 2022 at 03:38:27PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 30, 2022 at 3:31 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Aug 25, 2022 at 12:17:05PM +0300, Ilpo J=C3=A4rvinen wrote:

...

> > I'm wondering how to tell stable maintainers about dependencies of
> > (not yet applied) patches? In practice I saw that contributors use
> > Fixes tag for the entire chain (for the preparatory patches + the real
> > fix) when it's not easy / in a nice way to rebase to have a one-patch
> > fix followed by refactoring, etc.
>
> It's as if no one has ever had this issue before and wrote it down for
> all to read and know what to do in the future.
>
> {sigh}
>
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> If you don't know the git id, just use the subject line and it should
> work the same.
>
> greg "why even write documentation?" k-h

It's good we have it, thanks for writing!
From time to time even experienced developers need to re-read documentation=
.

--=20
With Best Regards,
Andy Shevchenko
