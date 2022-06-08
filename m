Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB5542E03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiFHKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiFHKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:39:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA222C467;
        Wed,  8 Jun 2022 03:39:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so26455754edf.5;
        Wed, 08 Jun 2022 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AflYLC9Cqj0Sh7IAAdBilAnuAv8TaAYj4Q3b9HGi3LI=;
        b=j80tuK+ahAaKf2tOnjexak08mW2qPcSawqmqvdmh+AR+svs/ocLKqPxSN8BoX6dDHq
         93ky+2yLNg6R0jRT9oYrITbukQBudgVPuUQ8ag9dJc/JXXhX2rCDoJRCnigmAsvNN1CH
         MQkYtRtpkk7nAjy2SOQZrK4I1kot9x5ahABLvvhbuHFauZD6hbDZ6d+fOPh6kvktILIp
         eUysQSMsfgpKiLhhJW4Fs7chnLhbUhVDSgh2Zx11L41LsHJ4g7BhDF1/+v/mm9OK9l4V
         WKy5dkR7hBvo35NUv5Q9xZL6fU0p47buYzKSmrF0W46Pv/XAUCpBXiRlNBp/CPbhJXJ5
         +AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AflYLC9Cqj0Sh7IAAdBilAnuAv8TaAYj4Q3b9HGi3LI=;
        b=of2+3tFH05YgDrR65xNw7aTcbHzqJdREsSncrL4LHDjwQDnCykCTFGp11YTkbJWrgQ
         FSlNQgs5ExXplw4CEPT4IiJNwsvLpwUgscAdb9HWUVTIGR+cRwsn1ELW3m097vnldo3L
         E+eAbuijRVsdKoHqBd6GirhQO8NVsJgBkdbp5obxqHLpAY77G3IsHPn45xx3f7OOjufr
         JwGarQhR7JSgZ9CZtxxID/3ttjGogkIToquiLp/1uuotCDoqmKN7Kkju3+hrDMd936if
         6uaYbdl8ygkMKzZMXmzXMHHRvoT6PPcSFEGcRykgFy/WDVq8B3mFYf7sfvynCgO84out
         nODw==
X-Gm-Message-State: AOAM532ybEPDyoYRdm7jfNiJy1lT9UOsXRz3gEwF0BqPlzRf567DsG5g
        gDDan6j6WDAwkwymSv2OTeHIXgcIdObUN8zhMWw=
X-Google-Smtp-Source: ABdhPJz2XGURaDipUizHRf/IKPdud1SXAXIGH0SRdGA8M/4H7Tuqy/0lPrVk9C7d7d+wAy+2tc9EIjvnrFHnWXMcu4k=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr38552340edr.209.1654684766428; Wed, 08
 Jun 2022 03:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-16-jslaby@suse.cz>
 <8ad44d3b-449f-4a30-1a4c-dffd43bbbd1@linux.intel.com> <e9f35a26-8f5b-f585-2e8c-19690bf3c770@kernel.org>
In-Reply-To: <e9f35a26-8f5b-f585-2e8c-19690bf3c770@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 12:38:49 +0200
Message-ID: <CAHp75VfPi=BMzw4x2tTv2S5Wa0y6vvB3HUY6GyF3t_ddg_YUGA@mail.gmail.com>
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in con_get_unimap()
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jun 8, 2022 at 10:56 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 07. 06. 22, 16:19, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 7 Jun 2022, Jiri Slaby wrote:

...

> > Doesn't this fix something?
>
> If you mean a Fixes tag, this is pre-git.

You may use history.git [1] for pregit SHAs.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

--=20
With Best Regards,
Andy Shevchenko
