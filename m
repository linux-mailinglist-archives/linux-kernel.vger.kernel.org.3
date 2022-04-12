Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B84FD61D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383551AbiDLIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356777AbiDLHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:20 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A164D52B32;
        Tue, 12 Apr 2022 00:10:13 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id e22so15455778qvf.9;
        Tue, 12 Apr 2022 00:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un7uuVJLSD5oo1I82UIYzEg0eG1oNWsHj8ZvVK3CntI=;
        b=L+hQHeYSmVigFt+b6xeULgFH4nuk9cg4I8asH7SB04/jw8SBFeK2zB6J0M6ov9Vcsd
         RKOO4dyxqAQcO1+PuL1LZpYPwoGc8+eyl4eSpuNaIMcrRzpYacUPsxfigUs/KxoYtGol
         Qsl6jXScFMlz3dIAd60qgGBIBOfEIkzsmgkEJHNp+sPRfA45XYfUfEYpSJr9wpOIvloH
         fdVxHlavV+n6uDIoWeC/i53bky0CMr8AnT8rMpvqbXPv/n2W/3nILainmXdjF5nzBMDx
         3SV+qg2KPx3kZ5VHB6LpnAZFYKOGgcnZ+NwJ5YM5DnpmGZ5GeT1VrDp2tBeAskvfGajo
         Z3Jw==
X-Gm-Message-State: AOAM5308p3o4/xg/krRis3Ems4A7m+3zIsg6M/2pOS6jHtEIB90V3nH5
        TkwpAQB6i974Mo1PxrklDjVznfrn9Av5qW3h
X-Google-Smtp-Source: ABdhPJxLBv5cJryliABFuSMeFqzI6FAkMvdmUBuPpxF87f7gHMxfjytV7n5g7KedxEeK3xmhc9gGlQ==
X-Received: by 2002:ad4:5f0f:0:b0:441:1e3a:dbc with SMTP id fo15-20020ad45f0f000000b004411e3a0dbcmr29779951qvb.99.1649747411863;
        Tue, 12 Apr 2022 00:10:11 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id y66-20020a37af45000000b0067dc0fc539fsm20767890qke.86.2022.04.12.00.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:10:11 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p65so13282791ybp.9;
        Tue, 12 Apr 2022 00:10:10 -0700 (PDT)
X-Received: by 2002:a25:29c2:0:b0:641:224f:17d6 with SMTP id
 p185-20020a2529c2000000b00641224f17d6mr10469449ybp.546.1649747410632; Tue, 12
 Apr 2022 00:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
 <20220411103528.2187797-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204111240560.38484@ramsan.of.borg>
 <87zgkrqyff.fsf@tynnyri.adurom.net>
In-Reply-To: <87zgkrqyff.fsf@tynnyri.adurom.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:09:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgdPBTwg8LN8x_sZRWWzdE9ZKytZuAna+qdKL1Ced5Vw@mail.gmail.com>
Message-ID: <CAMuHMdUgdPBTwg8LN8x_sZRWWzdE9ZKytZuAna+qdKL1Ced5Vw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc2
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
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

Hi Kalle,

On Mon, Apr 11, 2022 at 8:15 PM Kalle Valo <kvalo@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, 11 Apr 2022, Geert Uytterhoeven wrote:
> >> JFYI, when comparing v5.18-rc2[1] to v5.18-rc1[3], the summaries are:

> >   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_491' declared with attribute error: FIELD_PREP: mask is not constant:  => 352:38
> >   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_520' declared with attribute error: FIELD_PREP: mask is not constant:  => 352:38
> >
> > mipsel/mips-allmodconfig
> > arm64-gcc5.4/arm64-allmodconfig
> >
> > Actual error is:
> >
> >     /kisskb/src/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c: In function 'mt76x2e_probe':
> >     /kisskb/src/include/linux/compiler_types.h:352:38: error: call to '__compiletime_assert_520' declared with attribute error: FIELD_PREP: mask is not constant
>
> Does this commit fix it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=dbc2b1764734857d68425468ffa8486e97ab89df
>
> Or is this another issue?

I'm not in a position to verify this, but given both configs used gcc-5,
I assume this will fix the issue.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
