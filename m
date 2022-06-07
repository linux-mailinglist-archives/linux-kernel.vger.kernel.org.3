Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16725540A00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350822AbiFGSOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiFGRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:52:44 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE2143870
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:39:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-edeb6c3642so24061065fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOLmJGIN9guUyt8uZRpdgsdWlDm3gDN/hKKZR/NyyLE=;
        b=hhmGhaXZ8JEqPJE8oGeb5qqgyVDKuVASsufWkfuUXzPiWSjD52OtjPooUpU6yY0W0P
         EjQbSklrxUuf5BCXKwpy/fXQIjnDpoe0DD8QsgKbl4S07oB9jYrsaYHUWS2iSalvWtMm
         zbuPagfbNyjbl7fPGJ1daKizv3T2MSjsOs+QuOIFvUZWJIOfhtagCsF7i097/Ya6Neo8
         YNti2y5Izvn0I4yORw202ZhZSXrqcNBIfmN45klr0V28BsJgMirFvTqcQ5+GbxT5A0hw
         M9EpyMwudONjPRWFPT/ryVla11afT68IpNrlhG0tvmMyyfF/REwoWhs3sjfblZaiwsTs
         UI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOLmJGIN9guUyt8uZRpdgsdWlDm3gDN/hKKZR/NyyLE=;
        b=l6nNCk80vRXkPijmSo7MdgDReZvqsHMTBOOWoD6DNs7qtGkK+hqZ9Ncy1Le6SRfz0H
         sheLqLjKRdYM/dkLrCYkyPcrQXzXS8cRXlpDSg/NmeUup7U1fOFoqRAmE9VMGH/HKzEc
         somfcoaulA5JVA8c7JzSMEVJ/nWxTEOyInLGFSBDLN1u+c0hV3fSylDUIL124/nEHjeV
         dEY1MByrUdII91DbKZxVIjNiPhKIe7LSQMWh804GiSQTuAAKDkX6U8WKoingg+EdRqf7
         kcD35os57mclQUA3UQr/6ZsfkMiLauhR1YlBluSE0+xmf77DXh9WvJkuPWxwl854EsEG
         yAaw==
X-Gm-Message-State: AOAM531FFYFufJxRYqZoG/wdkFH2WLqBuchbDiNxSSQ1p0KrbQDATYZy
        JyKDFrmzz/jzk4mzobXmRrbdzXT2MkjEnKh6Md2XFwh4
X-Google-Smtp-Source: ABdhPJxKfAnEuzcLeZETPvt+gNp6sO3pcYW0upjJip6wV6ZzZKmqo8N/GY28gE8vrhaneP84e+u5bhTvyipDEvhHxno=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr32588860oaa.200.1654623552888; Tue, 07
 Jun 2022 10:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com> <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com> <YodIquufXzK581gw@slm.duckdns.org>
 <8df16635-658b-b381-9a40-3544828910fc@amd.com> <Yp+HXowR9nTig331@slm.duckdns.org>
In-Reply-To: <Yp+HXowR9nTig331@slm.duckdns.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Jun 2022 13:39:01 -0400
Message-ID: <CADnq5_OquY8A_nMsCcwMxvDL3r0WzYAxFdrGNzYsKEP7q-Xg7g@mail.gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
To:     Tejun Heo <tj@kernel.org>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 1:14 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Sat, May 21, 2022 at 12:04:00AM -0400, Andrey Grodzovsky wrote:
> > From 78df30cc97f10c885f5159a293e6afe2348aa60c Mon Sep 17 00:00:00 2001
> > From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > Date: Thu, 19 May 2022 09:47:28 -0400
> > Subject: Revert "workqueue: remove unused cancel_work()"
> >
> > This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.
> >
> > amdpgu need this function in order to prematurly stop pending
> > reset works when another reset work already in progress.
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Applied to wq/for-5.19-fixes.

Could we take it through the drm tree so we can include it with
Andrey's patches that depend on it?

Alex


>
> Thanks.
>
> --
> tejun
