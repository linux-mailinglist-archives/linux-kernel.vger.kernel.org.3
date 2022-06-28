Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431ED55CBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbiF1Ljp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiF1Ljm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:39:42 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593EB873;
        Tue, 28 Jun 2022 04:39:42 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-318889e6a2cso113657047b3.1;
        Tue, 28 Jun 2022 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=noX9Qw20rdOUnrhd7rCBZDR35mgpbR/5H4GWJxhK7U4=;
        b=MydxI/IpeL1O2h+GMMYUVYNmZbIO8GvAHD8ZtgTZF5Jp/3rzZqM/b7wR88QbDa2N2I
         c0+YnUKNV7SKdgwODbz9f4zAEn5xalOwLVyjSTOQ16c2mC9epB3YJXm72Kf9PiIGLCQF
         ChQWnUmcBekLRuk+8j+MldPcN5daqIsMHTOLWhlQ4q1NI96cdeXUyRODYppdAEolW74T
         ze8rpyYtP8RoCf1kkHXneV00kFXZEZ5pSybf1Uu3zSIyEuPQp/5nwCqfx+9kHHp5XmZY
         58pwL7IR00LgSZVFsDu+M1sTsU/cDqPV+7NBiXoTXJPK8YlsTa19o0tgKLuyxOQIAIp+
         tCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=noX9Qw20rdOUnrhd7rCBZDR35mgpbR/5H4GWJxhK7U4=;
        b=ukc1ht+uRv9LRePKrzWa/NcMRLkLQnSkoJNPvkfnuC2YrOhPEWZdAT1mycXUjXI0DG
         d3W5tOd+R+lC3Ua9jLPHFzzWjXK4DhApSOSobLyIZ8IXNeqPvtzk0Ky5+AZnF5yOHKpM
         JYlkhKRMfz1HcOY2jyxZ+zj+bA6SRT3kEyGd5diLNScn5YTecOxnEYmeVYubghhEn8CQ
         ykr1a8wlZWa6oJG563b7fBNkdfnWeyhKcAG45+Ke2vlMtBFsg6no+BEPWnPJWiqAiC3k
         6Zz0JqsiCZNHyRHAkbIuR2wLLNMGSiQAuqIWQomb0gDIveFJIPeGIHXC/ahji6y8hAGi
         QyKQ==
X-Gm-Message-State: AJIora8HJ3AIBQGn3TIubVTO/jkR4b8JpZFmhyU9yDA2GoIlEHjGSCd+
        L8doPjlcHytrJGqBMfh2KeLlu7NaOsCt6OdcoRU=
X-Google-Smtp-Source: AGRyM1twnswZ9JqoJHs1fX5c6Gm2ANTedCBCoTCUbVfvSldG9JYX/PyIYeWGl/YIFplhCKkPhpP0xdLE829xXZvYHOg=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr20792966ywj.195.1656416381294; Tue, 28
 Jun 2022 04:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
 <20220628095136.fhtjjjkj3mre7hwa@pali> <20220628095942.rbpl2iocxoqtzxiy@pali>
In-Reply-To: <20220628095942.rbpl2iocxoqtzxiy@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 13:39:03 +0200
Message-ID: <CAHp75VeHNERyPAam_-u7+ykYxcUM_N-YT6kBAh+hG+7WNW31SA@mail.gmail.com>
Subject: Re: [PATCH] serial: mvebu: Apply old baudrate to termios
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
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

On Tue, Jun 28, 2022 at 12:01 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Tuesday 28 June 2022 11:51:36 Pali Roh=C3=A1r wrote:
> > On Tuesday 28 June 2022 12:41:55 Ilpo J=C3=A4rvinen wrote:

> > > A fallback baud rate was derived from old termios but got never appli=
ed
> > > to (new/current) termios. Old termios is dropped once ->set_termios()
> > > call chain completes, only termios persists the values. Encode also t=
he
> > > old baud rate into termios.
> > >
> > > Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baud=
rate")
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >
> > Hello! Could you explain a bit more what is this patch fixing? I have
> > not caught it yet. Do you have a test scenario which can demonstrate
> > this issue? Because I have tested this driver more deeply (on Mox
> > and Espressobin) and I have not seen any remaining issue with reporting
> > incorrect baudrate.
>
> Ou, now I see where is the issue. Patch which I tested and which fixes
> reporting baudrate is not in kernel tree yet and it looks like I totally
> forgot to sent it to ML. I will send it. Sorry for confusion.

Shouldn't the Ilpo's applied anyway to fix the current code base?

--=20
With Best Regards,
Andy Shevchenko
