Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB825A639C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3Mjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiH3Mja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:39:30 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03CED000;
        Tue, 30 Aug 2022 05:39:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x14so4091521qvr.6;
        Tue, 30 Aug 2022 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zp/jtnNPEt1RrKfIwCxhUvK4JbyBJ9OH33KEFyXyuNk=;
        b=W1hcE0qw83zhQH2KOtVW8eTefMPwL9lP3wymeNEet08ADhtCy0ULRXbUymOItPEyAF
         moNePdyCGfKfncZw3ZrNzdWMmyIhnpqi6oobgH4DdhWGKwoFyeXiYRBTZ4kZUnSmswEB
         mojZc8B0WU9YlRLBHdYQ8Zlv1eYZxxW39YYeX5EchdskLG8OrJyDuhbQqoQLh/VGzgNP
         nWwjDhqHVaNOQrTpcN/OT5W02CAlUzaUUDlNed9BTmQn0GjyytRAr8CczoLGZmpRJgoV
         WeyBs7UP+gKnMkD08w+IqgTqHEOJ7aX41FKhATr35OQqzTnur7DiiiuX43at2wLMDJbf
         FCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zp/jtnNPEt1RrKfIwCxhUvK4JbyBJ9OH33KEFyXyuNk=;
        b=yAYu5kofZ226zz8/RdgU5SYKGdc+Eobgbqr9a81L9/UHahOu/7VVH/c7SHnf31SLtw
         Frx4eOD+0Rako9jZy6svrDtufNs8MSmgK4xlUxiXvURPvGvm/u2wJEeXGFQyRj0KILPO
         0PQLhhaRplVPgfBpd+htxacC+afXLupwOF2UwKwgZeiAyGqPzpfmLem2IeP0jzq9rQBI
         IAqoeL43GKYmcyDarvoS6XN9RW3KF9nZEfHH6TOyxuiQUCkuBsOuSlHZfBIk4uOoIbU4
         AvK1MnRjo6EtyrR5g7tfmWit0nowljpQJ470LZBfTXLYIlzyc9or1E6Cm6Qu4i0i8MyQ
         fkTw==
X-Gm-Message-State: ACgBeo1CampYFrcRon0Ic99G4bDVIJJt6sinKhOyUP8XyLoDXWD/0J0V
        xgVYsgOeYzHnRxR0ARy2GqnHGdvQH+2/NsUU7s8Jx6Lr7R8=
X-Google-Smtp-Source: AA6agR6hDeaLaUA1lmSdjTlFVfEdSt6HoXJz6Pz5fXMcu5XZd31+1XDh8QDpNTyUVUSuQD2C9aWvitWWKvemhgGcThA=
X-Received: by 2002:a05:6214:c22:b0:497:10a8:3067 with SMTP id
 a2-20020a0562140c2200b0049710a83067mr14773223qvd.48.1661863143577; Tue, 30
 Aug 2022 05:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
 <20220825091707.8112-2-ilpo.jarvinen@linux.intel.com> <Yw4CP8y3b9E9XV0K@kroah.com>
In-Reply-To: <Yw4CP8y3b9E9XV0K@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 15:38:27 +0300
Message-ID: <CAHp75VfQHhPoO3Rpk=o1c2qPJB-tc_6G41n6iz3sv_gP44PLUw@mail.gmail.com>
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

On Tue, Aug 30, 2022 at 3:31 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 25, 2022 at 12:17:05PM +0300, Ilpo J=C3=A4rvinen wrote:
> > A very common pattern in the drivers is to advance xmit tail
> > index and do bookkeeping of Tx'ed characters. Create
> > uart_xmit_advance() to handle it.
> >
> > Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> > Fixes: 2d908b38d409 ("serial: Add Tegra Combined UART driver")
>
> This commit only adds a new function, it does not "Fix" anything :(

I'm wondering how to tell stable maintainers about dependencies of
(not yet applied) patches? In practice I saw that contributors use
Fixes tag for the entire chain (for the preparatory patches + the real
fix) when it's not easy / in a nice way to rebase to have a one-patch
fix followed by refactoring, etc.

--=20
With Best Regards,
Andy Shevchenko
