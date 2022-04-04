Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9FD4F1400
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376492AbiDDLs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376455AbiDDLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:48:25 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029273D1EF;
        Mon,  4 Apr 2022 04:46:30 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id j21so7466948qta.0;
        Mon, 04 Apr 2022 04:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vrtxx97wpbMiIv6dqlYr09ni3VUiuon0GQZYjngD7U=;
        b=Y4yaAmm3bSfP7/yoAfy7Ex0tI04wuGvwDBxTEIj5sr1nMU/oAcYBs+GLAnT6SfMCmf
         PGaQLyYVn+vV2xoIRDc6S8digk6hJLpfjA3+L8XfjDc/evZkXHL9SKFVoANvQTjJ6wji
         L+ZUe2gyKR/VRhVDSuQdt9duwHNioSwquWB+JF/6fhmJHV/J3yDvH15rsDnzcVPMdUdK
         41oL/l2fFN1tquVqvDJ7u1c7Qexn/ZXM+aU3F9Fw+HjOqiRl3y5PJXY27ZGmrKERrJP2
         WwI9fU0+n/9b6/Z3Qhs1cbSS25aK9A5I0DZmeLWlhyq1PNAneb42+77alcZsPKMQj2ok
         6Mag==
X-Gm-Message-State: AOAM533ofFBGwiPsJMXN/oETRkDjF9BVzc7l6qCBtbYOrSk/EElHCveG
        vbNqMrRk2wRfxAyazxwgWarPgAhbs579KQ==
X-Google-Smtp-Source: ABdhPJz2ewvGsYibxNfE7bXjCReetrEhDdrHZe8K30OJ33aDtA4KVrpgTnhxm/BQbAUOm818Erjc0Q==
X-Received: by 2002:a05:622a:1051:b0:2e1:eb06:ecc2 with SMTP id f17-20020a05622a105100b002e1eb06ecc2mr16957921qte.171.1649072788539;
        Mon, 04 Apr 2022 04:46:28 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm7840681qtw.7.2022.04.04.04.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 04:46:28 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2eb43ad7909so44370057b3.2;
        Mon, 04 Apr 2022 04:46:27 -0700 (PDT)
X-Received: by 2002:a81:5c2:0:b0:2e5:e4eb:c3e7 with SMTP id
 185-20020a8105c2000000b002e5e4ebc3e7mr22191370ywf.62.1649072787360; Mon, 04
 Apr 2022 04:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjmFhqTLBscHHVZ1VTSqrJBT1VEevA+KkjY+y9_ZtdRkMg@mail.gmail.com>
 <631f03bd-0fdf-9cc8-bf37-89235fb84162@gmx.de>
In-Reply-To: <631f03bd-0fdf-9cc8-bf37-89235fb84162@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 13:46:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiEo8q9x0C0x5zOM=ax1=S06=s0JjcJvZYD4aMGLmEaQ@mail.gmail.com>
Message-ID: <CAMuHMdUiEo8q9x0C0x5zOM=ax1=S06=s0JjcJvZYD4aMGLmEaQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtCVUddIGZiZGV2OiBpNzQwZmI6IERpdmlkZSBlcnJvciB3aGVuIOKAmHZhci0+cA==?=
        =?UTF-8?B?aXhjbG9ja+KAmSBpcyB6ZXJv?=
To:     Helge Deller <deller@gmx.de>
Cc:     Zheyu Ma <zheyuma97@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Helge,

On Sun, Apr 3, 2022 at 5:41 PM Helge Deller <deller@gmx.de> wrote:
> On 4/3/22 13:26, Zheyu Ma wrote:
> > I found a bug in the function i740fb_set_par().
>
> Nice catch!
>
> > When the user calls the ioctl system call without setting the value to
> > 'var->pixclock', the driver will throw a divide error.
> >
> > This bug occurs because the driver uses the value of 'var->pixclock'
> > without checking it, as the following code snippet show:
> >
> > if ((1000000 / var->pixclock) > DACSPEED8) {
> >      dev_err(info->device, "requested pixclock %i MHz out of range
> > (max. %i MHz at 8bpp)\n",
> >          1000000 / var->pixclock, DACSPEED8);
> >     return -EINVAL;x
> > }
> >
> > We can fix this by checking the value of 'var->pixclock' in the
> > function i740fb_check_var() similar to commit
> > b36b242d4b8ea178f7fd038965e3cac7f30c3f09, or we should set the lowest
> > supported value when this field is zero.
> > I have no idea about which solution is better.
>
> Me neither.
> I think a solution like commit b36b242d4b8ea178f7fd038965e3cac7f30c3f09
> is sufficient.
>
> Note that i740fb_set_par() is called in i740fb_resume() as well.
> Since this doesn't comes form userspace I think adding a check for
> the return value there isn't necessary.
>
> Would you mind sending a patch like b36b242d4b8ea178f7fd038965e3cac7f30c3f09 ?

When passed an invalid value, .check_var() is supposed to
round up the invalid to a valid value, if possible.

Commit b36b242d4b8ea178 ("video: fbdev: asiliantfb: Error out if
'pixclock' equals zero") does not do that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
