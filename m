Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75C3575C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiGOH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGOH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:26:35 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FE979EFD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:26:34 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id v5so3157079qvq.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlQWMuQP9i7JA/10N1xXkOOHrioXOIiFbLtTV9MnWc8=;
        b=vpmsTh3ocugDDo4XpuN9koedStYhbIaICbPSWYvrF/0+jsNqfaB5Q9s7iLGiGWbxn+
         gvtrm4XbYjG7Ui1yjXUTdoKlRKd7iPlCEF4qzqM3vpH2QX0Quge+9Dcj9jBmhMdduYvh
         U3T/Omwk7yT7MkhKE6f10qWAbavzAeMQ1DW7mLfXr8U+IRwhaTwqxT2sTS6POv04si+Y
         pd3jU4nUcgDm3JvqGJqpp9l/TUfvi9VKIeuul3l4AtvLOX5QFo0JGz3CR5arA13TYQQ7
         4uXl/M7WTmlKAtzxHZXOTtMwbyldtsGOWFneCoqgx8lC00Wgj1HbAlvQ5M7gQlBtpbQv
         nVPw==
X-Gm-Message-State: AJIora8X9QWArfNs9rMPOp9tcgStP4ibk7/rHrYJD+eoysPqGcLDrWPJ
        yH+H6tPJLT/PjmOQ5TLYOoGQmksIo3lxSw==
X-Google-Smtp-Source: AGRyM1s99C2byyJtXZS3eOshnqgiXeYpiB6lAd/61+GwGQdqFQy1iUyXq5203H07ud2qPiDA7f95aQ==
X-Received: by 2002:a05:6214:d82:b0:473:132:facc with SMTP id e2-20020a0562140d8200b004730132faccmr10780698qve.107.1657869992813;
        Fri, 15 Jul 2022 00:26:32 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bn40-20020a05620a2ae800b006a6af4b40b1sm3055897qkb.73.2022.07.15.00.26.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:26:32 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31d85f82f0bso39236047b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:26:32 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr14363430ywg.383.1657869991832; Fri, 15
 Jul 2022 00:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com> <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
In-Reply-To: <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jul 2022 09:26:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4Srd=WTGvtGoWhatEb8No7WUhrAYEmjX2+E11PnMVeg@mail.gmail.com>
Message-ID: <CAMuHMdX4Srd=WTGvtGoWhatEb8No7WUhrAYEmjX2+E11PnMVeg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Thu, Jul 14, 2022 at 7:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/14/22 09:48, Linus Torvalds wrote:
> > And some look positively strange. Like that
> >
> >    drivers/mfd/asic3.c: error: unused variable 'asic'
> > [-Werror=unused-variable]:  => 941:23
> >
> > which is clearly used three lines later by
> >
> >          iounmap(asic->tmio_cnf);
> >
> > and I can't find any case of 'iounmap()' having been defined to an
> > empty macro or anything like that to explain it. The error in
> > drivers/tty/serial/sh-sci.c looks to be exactly the same issue, just
> > with ioremap() instead of iounmap().
> >
> > It would be good to have some way to find which build/architecture it
> > is, because right now it just looks bogus.
> >
> > Do you perhaps use some broken compiler that complains when the empty
> > inline functions don't use their arguments? Because that's what those
> > ioremap/iounmap() ones look like to me, but there might be some
> > magical architecture / config that has issues that aren't obvious.
> >
> > IOW, I'd love to get those fixed, but I would also want a little bit more info.
> >
> Geert gave the necessary hint - it looks like sh-nommu used defines
> for iomap() and iounmap(), which made the variable unused. According
> to Geert that was fixed a couple of days ago.

Yes, post-rc6 should be fine, as the fix went in... for the third time.
Combine people that keep on switching back to macros without reading
a file's history with unresponsive maintainers...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
