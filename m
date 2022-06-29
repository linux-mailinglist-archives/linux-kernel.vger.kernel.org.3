Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51355FC12
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiF2Jdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiF2Jdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:33:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD320377E3;
        Wed, 29 Jun 2022 02:33:42 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h187so24688498ybg.0;
        Wed, 29 Jun 2022 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BKKIDmKINFtmhQ17SHtmZTkRGbCuHTr5r7Yhe66KIY4=;
        b=f6spaehLxpWzi/XSul6A3a8ORG5DdJfpinMAIaS52nmM2sRAvR+v/TAZb0EvAxYTtr
         YfTtAwWfzQnO3FuDov7CXZiP7V781+RRoIE4B4bPanjQQownBvVgWPyzqO9ZV9VCfdTx
         tfESmh0BJj9ABPBI2WQMnBF1X8PYm7G5NqPJvT7DE+BD8JXMm4+fuJbciIOWfx+Gn+eG
         32ytIZu7m/ZUZX4up+VwzliGSb/N4L+TWkRM6RpqzMrESJVJN1QKexvqKEpkXk5buTSD
         6ubAh8XBoEDFo79KIXs3lp2T4YaWyI3tR0wxZeRvcrJBiodbPJCffEe3ptawbm7a7MMx
         ecbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BKKIDmKINFtmhQ17SHtmZTkRGbCuHTr5r7Yhe66KIY4=;
        b=X++C1Bt68FbkLunckDT8e7yJ9VcG5xIgQKtosAmRT6LvglnzAT95CEzxG100s2DNmb
         /pBUAwRc5LzP2KuAmAszWi4uzXm/8E/j19bx+9AIeXs1QqBCwSl2dyVYSbYMfKbXRx0M
         QLWDLbhW25zjGttpby1u3fyD6fGcEgm+mSVQj3YJ/WuBHUEZmVrcMIrOv1MpGlFRrW+O
         Q3QvIlk8gt0UeAT8mgUmkEgDQ3j9D5x73Dqs7EOxtGTz2MxIhniAzSC8ztUTGNoxwlhW
         2Xe27Xax1rmfhqnBWMWqGVVUFyK47yaKSnN6oBEIxx8FmprWwJqJuoMMoGppNAtzRo6L
         FOZw==
X-Gm-Message-State: AJIora9YRGsNPylYDDyAiLqAUdhQh45DK142w4a2MhMuIPinV6O9nV6V
        +I+yIgB5mFfT5abJrXBzSkVeeG/u0Q9Re+IaiQM=
X-Google-Smtp-Source: AGRyM1vUXH3y9FnUdZz96MJXG7qZqUEXMCtkcxuWK7rRRJjQ0tncgo+/IRN2wnKV6ZF1wnFhhmIezoAc9YbOscx5UHY=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr2286716ybg.79.1656495221896; Wed, 29
 Jun 2022 02:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
 <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com> <CAHp75Vf36sFqX1SL4Sjz6ZgNXP41Nom0Q1s6Psgv9WMFkKtGtg@mail.gmail.com>
 <29b084c-183b-4a84-2376-2c88eff7d5a@linux.intel.com>
In-Reply-To: <29b084c-183b-4a84-2376-2c88eff7d5a@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 11:33:04 +0200
Message-ID: <CAHp75VevfptcsTTkFvCRsJRxuKX6aJ2zQ5LyH0O8wP+aB4xXHw@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: 8250_dw: Rework ->serial_out() LCR write
 retry logic
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Wed, Jun 29, 2022 at 10:47 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Tue, 28 Jun 2022, Andy Shevchenko wrote:
> > On Tue, Jun 28, 2022 at 3:43 PM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > Currently dw8250_verify_write() (was dw8250_check_lcr()) nullifies th=
e
> > > benefit from differentiated ->serial_out() by having big if tree to
> > > select correct write type.
> > >
> > > Rework the logic such that the LCR write can be retried within the
> > > relevant ->serial_out() handler:
> > >   1. Move retries counter on the caller level and pass as pointer to
> > >      dw8250_verify_write()
> > >   2. Make dw8250_verify_write() return bool
> > >   3. Retry the write on caller level (if needed)
> >
> > I'm wondering if it's possible to utilize one of iopoll.h macro here
> > instead of copying retries and that not-so-obvious IO poll write.
>
> Eh, are you suggesting I should do write as a side-effect inside one of
> the iopoll.h macros? Because those available seem to only read?
>
> Or should I create another macro there which writes too?

It seems to me that it would be a macro on top of iopoll's one which
will take an op read and op write arguments depending on the case.
Note, for that special case you would need a custom write op instead
of simple __raw_writeq().

Try and if it looks better, convert, otherwise it would be nice to
hear why it won't fly in your opinion.

--=20
With Best Regards,
Andy Shevchenko
