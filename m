Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2164D174F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbiCHMeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiCHMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:34:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71E24F1A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:33:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bi12so25777656ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAaq8TAi09HiM99QMVjo0FKj2a1AT4mipZnzrhF2hUU=;
        b=JBv81n9mJNQkHzzTThDRmDDsJo5hM7oKrmjgpbDWu40kmUVQC/crLzEGJTkwnyR/2G
         VsXi1wXYWSpHGdLmL+CNpon2jvo68msvjVGFLcGs32c0id00oMQIoioWDWF/5HPoD+d6
         x2RolM6V3VZSr9tgTVhgPvEoZhCvQkPMgcHajveqZNCjSNdcTSL1kIxr56H6VlnP/tcR
         +mrJcBviLkkCXUHxqzPCi7TkhrXGON2x3X+R/2K7KzkTCcQm40czeImLhasYRxvKTup0
         jvGLdnn3yJnNGsiFqWOp3J/FJH9rGgcwyWIFt15gYXEta2fPMCaBDAR3D7JxKl6IUKO1
         47aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAaq8TAi09HiM99QMVjo0FKj2a1AT4mipZnzrhF2hUU=;
        b=B+A8UPRAoKzKwQy9On/nqyxSUwWyygdPimQnsketkKEX3Y+T8lbERROVhr4L2EPZ44
         UXJqukalspZLUajgituFtWWQXCoCK5Zuz+FXnxdY0DCvUctqrVPJ3npv55v7oqXGatNW
         EzbO7BJEHDjJX7XG8v3NZfD3awHNqYRMRz3pmvooDj/ipEm340kRsy28CxL54WOf5zNT
         aObfdf5wVdd9Ulj6Smm9fuZEHZI6NXVhbcS/xGqU05QedlfZLs9VszN35jfZR3jQV/8c
         OeCjYARZjG7QeT88L0dbIgecXcOyXuuB80FtDAQuffT2Vb1iK41kMNFKbpfOkwHXgL5C
         XSmw==
X-Gm-Message-State: AOAM530ZNGDdOI6FCfvxkpsUoowZlsOPS5tgZ2sQdm3QzjDjtYdYmS4B
        ijbU3mkMh3+vDmVcbYdxGq0JbeqQIf0bWUXycW0=
X-Google-Smtp-Source: ABdhPJzYKthOu0uylrKNEZgEZ0gDFYZLfl6/2e9omUKgQQAhfB2yeInYg3maEQ3ilEc9TgbcR+SOXXvP5lmBQquyKeE=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr13441805ejc.132.1646742810744; Tue, 08
 Mar 2022 04:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAHp75Vcht_T5kUJu5zjmsUvn+mN+8D5vWBUvRXKTfo+2ocHOTg@mail.gmail.com>
 <CAMZ6RqK=yxLwVnotZuGRiao4Vu4eFEfVXfPaZV1r4rEOmQARig@mail.gmail.com>
 <CAHp75VfS0wSB+5dXHvoYfQqe0qEW0dOXGChunqu7PX0BZ4orMA@mail.gmail.com> <CAMZ6Rq+Esmr4s6eTQPwEX3hjhCDTVgt-wDU=zTaE8gJxBZHg2g@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+Esmr4s6eTQPwEX3hjhCDTVgt-wDU=zTaE8gJxBZHg2g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Mar 2022 14:32:13 +0200
Message-ID: <CAHp75Vdb0-0vbh76JoRX7ov6F8vgODw1rS2Lp4XKpFA9xX-tVA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
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

On Tue, Mar 8, 2022 at 2:22 PM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Tue. 8 Mar 2022 at 01:33, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 7, 2022 at 4:06 PM Vincent MAILHOL
> > <mailhol.vincent@wanadoo.fr> wrote:
> > > On Mon. 7 Mar 2022 at 22:40, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > I do not understand why I should be forbidden to fix a W=2 in the
> > > file which I am maintaining on the grounds that some code to which
> > > I do not care still has some W=1.
> >
> > It's not forbidden. I said something different.
> >
> > Whatever, thank you for doing it, perhaps we will have less noise in W=2 case.
>
> Great! So does it mean you are withdrawing your NAK?
> Or do you still have concern on the patch itself?

I'm not stopping you from amending a commit message (including
dropping noise from it and leaving only a partial example of the
compiler complaint), Cc'ing a new version to the people from this and
the discussion mentioned previously.

-- 
With Best Regards,
Andy Shevchenko
