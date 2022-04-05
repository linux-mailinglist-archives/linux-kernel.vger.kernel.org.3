Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01C4F23B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiDEGy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiDEGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:54:44 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85FE8EB4A;
        Mon,  4 Apr 2022 23:52:46 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id c4so9733926qtx.1;
        Mon, 04 Apr 2022 23:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xS9sh+p2XRsClxVSPRroc3YnRbOn46SzHPHvIsqLwCM=;
        b=2KMJt+uLfxx28f7xoSxHe52Np4I4DM95EoIPkeYev4LUgYR/ecfIqR7WDnGVxEsXDY
         tr5dNWlgif8+9mq03g5LW7f65LVkrQlLraM/YV3AUof5tPsNoWe6ZejwqaJH806fkTE1
         fcci/qKc4q0jXPz+mZvjWbcPxuTrtHroWj9sV5FMHjQd/X/QN1sCodf2xxn8HUBmCkt1
         V/81PbPk8Q1f5z002j34SNnptz1zSNlmv9zJ45iEW9E+UvwlAYV1Mydl25j52tcnbUoT
         MIgVAt6eNjwIIiNYodp31s7gKLFfKiYMfamHDnObXol3580GPbVPSzPYRLSBoTGnEamG
         lH7w==
X-Gm-Message-State: AOAM533J4U4Gsb1sak6CDTR6MBDo7ymFQLBE6618AYQntZEQqsKWXhyC
        7l7Dzl87bccje37g0SG9rGjpACPgJKRA9Q==
X-Google-Smtp-Source: ABdhPJzVZGDwj9D3KVfVsQcRSyefQUUMXYe8wYI+bv2lEQWARdBnlOyY+XfqrkX240qATZLtI6SyuA==
X-Received: by 2002:a05:622a:12:b0:2eb:871f:cdc2 with SMTP id x18-20020a05622a001200b002eb871fcdc2mr1739505qtw.352.1649141565107;
        Mon, 04 Apr 2022 23:52:45 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm11019959qta.40.2022.04.04.23.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:52:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id f23so21677678ybj.7;
        Mon, 04 Apr 2022 23:52:44 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr1478959ybq.342.1649141564401; Mon, 04
 Apr 2022 23:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjmFhqTLBscHHVZ1VTSqrJBT1VEevA+KkjY+y9_ZtdRkMg@mail.gmail.com>
 <631f03bd-0fdf-9cc8-bf37-89235fb84162@gmx.de> <CAMuHMdUiEo8q9x0C0x5zOM=ax1=S06=s0JjcJvZYD4aMGLmEaQ@mail.gmail.com>
 <a564f6af-31fa-79a2-72c3-578f2c095b23@gmx.de>
In-Reply-To: <a564f6af-31fa-79a2-72c3-578f2c095b23@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 08:52:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=r+TEJmgdnuM+0Mxa0jQ4HjtKT1jzkw_2R+1v9K_9RQ@mail.gmail.com>
Message-ID: <CAMuHMdU=r+TEJmgdnuM+0Mxa0jQ4HjtKT1jzkw_2R+1v9K_9RQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Tue, Apr 5, 2022 at 8:34 AM Helge Deller <deller@gmx.de> wrote:
> On 4/4/22 13:46, Geert Uytterhoeven wrote:
> > On Sun, Apr 3, 2022 at 5:41 PM Helge Deller <deller@gmx.de> wrote:
> >> On 4/3/22 13:26, Zheyu Ma wrote:
> >>> I found a bug in the function i740fb_set_par().
> >>
> >> Nice catch!
> >>
> >>> When the user calls the ioctl system call without setting the value to
> >>> 'var->pixclock', the driver will throw a divide error.
> >>>
> >>> This bug occurs because the driver uses the value of 'var->pixclock'
> >>> without checking it, as the following code snippet show:
> >>>
> >>> if ((1000000 / var->pixclock) > DACSPEED8) {
> >>>      dev_err(info->device, "requested pixclock %i MHz out of range
> >>> (max. %i MHz at 8bpp)\n",
> >>>          1000000 / var->pixclock, DACSPEED8);
> >>>     return -EINVAL;x
> >>> }
> >>>
> >>> We can fix this by checking the value of 'var->pixclock' in the
> >>> function i740fb_check_var() similar to commit
> >>> b36b242d4b8ea178f7fd038965e3cac7f30c3f09, or we should set the lowest
> >>> supported value when this field is zero.
> >>> I have no idea about which solution is better.
> >>
> >> Me neither.
> >> I think a solution like commit b36b242d4b8ea178f7fd038965e3cac7f30c3f09
> >> is sufficient.
> >>
> >> Note that i740fb_set_par() is called in i740fb_resume() as well.
> >> Since this doesn't comes form userspace I think adding a check for
> >> the return value there isn't necessary.
> >>
> >> Would you mind sending a patch like b36b242d4b8ea178f7fd038965e3cac7f30c3f09 ?
> >
> > When passed an invalid value, .check_var() is supposed to
> > round up the invalid to a valid value, if possible.
>
> I don't disagree.
> The main problem probably is: what is the next valid value?
> This needs to be analyzed on a per-driver base and ideally tested.
> Right now a division-by-zero is tiggered which is probably more worse.
>
> That said, currently I'd prefer to apply the zero-checks patches over
> any untested patches. It's easy to revert such checks if a better solution
> becomes available.
>
> Thoughts?

Fair enough. And you're the maintainer ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
