Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8870F4D172C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbiCHMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiCHMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:23:46 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193939B8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:22:50 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id f38so37419457ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 04:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t74z3Ledcqn/BjWg4UYz5jIdch9UIZsmQgsmq8I4viE=;
        b=rOteJ3tCwmeSpilhF/Dqlni5/TYQs+OS2AgxTmeaoqKCkYKo2LCFvRMx0v9/BSlas2
         0mCCTgv+me8Ujd0OnnGludU1xmtnSTEkDNGbMhzD2mbYWJaCo1gBrSP5UXMzrO8h4953
         lSvuXfwnvMcfCwAgj3Y0ESuhsonOEQNROfo26L6QaZ5eKCPfpmNeL5HJjKccP9use3hc
         g7ufy2NSPTRIuHDUTB96HuNbmTXrdlyc5ZHIaPP4XHGsHBAOUqhEa3etBOchVzSvCDeF
         OL0i2P0YQoff6WQtCrpNhKqQt5WOF0/6RaJfztknhVOVezHUZzEsL83eF74B7EeXs4rt
         taEg==
X-Gm-Message-State: AOAM533sM8UL3N5x0nhxkQqFH04Ou3jU6iquCPxtmCbVTNRdXrhKhepk
        wn//uSyG8D8z+AP3HixD/74MVyuvNBspT9joh8g=
X-Google-Smtp-Source: ABdhPJzjpjQgtJmWlHSSqgciN5yInmcVjGdlPUmkfq4OpPtACKidNlJoNnvF5OuTeCy5cbkCZDuDRmWBDB5ikjDkoDc=
X-Received: by 2002:a25:d2d0:0:b0:628:7d69:b598 with SMTP id
 j199-20020a25d2d0000000b006287d69b598mr12215707ybg.381.1646742169835; Tue, 08
 Mar 2022 04:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAHp75Vcht_T5kUJu5zjmsUvn+mN+8D5vWBUvRXKTfo+2ocHOTg@mail.gmail.com>
 <CAMZ6RqK=yxLwVnotZuGRiao4Vu4eFEfVXfPaZV1r4rEOmQARig@mail.gmail.com> <CAHp75VfS0wSB+5dXHvoYfQqe0qEW0dOXGChunqu7PX0BZ4orMA@mail.gmail.com>
In-Reply-To: <CAHp75VfS0wSB+5dXHvoYfQqe0qEW0dOXGChunqu7PX0BZ4orMA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 8 Mar 2022 21:22:38 +0900
Message-ID: <CAMZ6Rq+Esmr4s6eTQPwEX3hjhCDTVgt-wDU=zTaE8gJxBZHg2g@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 8 Mar 2022 at 01:33, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 7, 2022 at 4:06 PM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> > On Mon. 7 Mar 2022 at 22:40, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Mar 7, 2022 at 1:00 PM Alexander Lobakin
> > > <alexandr.lobakin@intel.com> wrote:
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Date: Fri, 4 Mar 2022 20:46:08 +0200
> > > > > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > > > > <mailhol.vincent@wanadoo.fr> wrote:
>
> ...
>
> > > > > Have you fixed W=1 warnings?
> > > > > Without fixing W=1 (which makes much more sense, when used with
> > > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > > >
> > > > How is this connected?
> > >
> > > By priorities.
> > > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
> >
> > *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> > if speaking of priorities.
>
> > I do not understand why I should be forbidden to fix a W=2 in the
> > file which I am maintaining on the grounds that some code to which
> > I do not care still has some W=1.
>
> It's not forbidden. I said something different.
>
> Whatever, thank you for doing it, perhaps we will have less noise in W=2 case.

Great! So does it mean you are withdrawing your NAK?
Or do you still have concern on the patch itself?


Yours sincerely,
Vincent Mailhol
