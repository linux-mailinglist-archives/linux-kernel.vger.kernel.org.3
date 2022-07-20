Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1257B1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiGTH1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGTH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:27:04 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB654CAF;
        Wed, 20 Jul 2022 00:27:03 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id l14so10399658qtv.4;
        Wed, 20 Jul 2022 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oI+lhuJP85REkq3gckr6T7bDGeRg2RVlq2lqlswzzQ=;
        b=kQXXLOsaKNXZFfmy7xcuFPM5KSkszC95Of8jLNiKA8lXsL4rgE0YOUof4qQ4n8WK1y
         zmDG5bDsXHh0ku0nzCGlob1AajewQ8oBoJ86nUqXovyEdKK9metiIKtc4Q+jEkhc0LIe
         rnB4mSgEb8y2x8Z6oez3rwfVtLIJK+rXVqF+qykswRU6lkGwHPExq9Y9nyIieaqsV1mU
         V+vKgUERt60naxE2FVi46dh2q63N3EYRF55rKYisKbN5NHCxaIpwrOjAnRnbbaD23TnL
         /wbCg22+A6nh04ptxuMO9XgSBt6mnOmj2NMi8q9gTX45pHvjV8cVqBtZF3fDZ54lsFsx
         VV3Q==
X-Gm-Message-State: AJIora+9lG5PKXhy7xI+FMhuV/z5Hb5Xq4z/bYeH3QwuCsauQSdxZen0
        E7Z/OsQbVIdJLhxryb7CnG/XEtBwnLookUIQ
X-Google-Smtp-Source: AGRyM1tRnM9BpZ5Ts94F2ZcXcruBOA8u4drAZsQXPzI1oVNq9r6QRB/e38E686hcietH3QxZ7bgOZg==
X-Received: by 2002:a05:622a:1210:b0:31e:e139:a6d4 with SMTP id y16-20020a05622a121000b0031ee139a6d4mr16422580qtx.160.1658302022166;
        Wed, 20 Jul 2022 00:27:02 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id cm17-20020a05622a251100b00304f3e320f2sm12643188qtb.4.2022.07.20.00.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 00:27:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31bf3656517so164311147b3.12;
        Wed, 20 Jul 2022 00:27:00 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr10579025ywf.384.1658302020370; Wed, 20
 Jul 2022 00:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg> <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
In-Reply-To: <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jul 2022 09:26:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
Message-ID: <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Bart,

On Tue, Jul 19, 2022 at 8:14 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 7/19/22 02:26, Geert Uytterhoeven wrote:
> > Thanks for your patch, which is now commit 88f1669019bd62b3 ("scsi: sd:
> > Rework asynchronous resume support") in scsi/for-next.
> >
> > On the Salvator-XS development board[1] with a SATA hard drive
> > connected, accessing the hard drive after resume from s2idle hangs.
> > I have bisected this to the aformentioned commit, and reverting this
> > commit fixes the issue.
> >
> > [1] arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts
>
> Thank you for having reported this. How about creating a bug report on
> https://bugzilla.kernel.org/ and attaching the kernel logs with and

I never created a bug report on bko before...

> without this patch? It's probably better to upload the kernel logs

Unfortunately the logs do not indicate anything went wrong.
I.e. no difference before/after.

> somewhere rather than to post these on the linux-scsi mailing list.

Lore links are great for after-the-fact reporting.  If you follow
the lore link in the buggy commit, you arrive in this thread ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
