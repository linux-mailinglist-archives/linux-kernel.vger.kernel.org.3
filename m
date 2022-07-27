Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832D25829FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiG0Puf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiG0Pud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:50:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BB1CFDA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:50:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b10so16743808pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m4nF36YaK6LuqWRuy/TneJFnRjNXCUdWKIq1pbaAqBw=;
        b=T34Qw0WA0QGxl8jJTXdBHMds0kjs75oQlUd3VOYhqSDzN/NjbE2DQAQHimsmpbGAF0
         g7LMjVYznfIp+nr8KGAonbUU6ypCmr8jjpTJBio1u12hpemoXkRlNypjkFbXQRnCMT50
         J09+P81VKiCqEdf/uGSCpXTVIHMOWVQVZ8V1BeXm7ddLvAEUwkzkMI62f5CIribdmIwA
         X2GEEZEIWHnI/hjmFUbI9QV3+M9WueiaYOdOLa2IwP/hnO44tEha1cNaqsvf4joRngy7
         hYNiiOmxBWleCO2cKLKWvmzN3TRpVGYLlbv9/jigv1IMapsybURfVdCHKDYWp0n5J2Q1
         GGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m4nF36YaK6LuqWRuy/TneJFnRjNXCUdWKIq1pbaAqBw=;
        b=gpyDDwu8c3jyoo6SCZbfRYaYRdxufvn7oyYPqLcWUgE59p75WP4ngMG4+XKxOjoKYf
         AvN49UMaDjmvRT7y4wCxI9USmY1LGjc0bzW0UCIFDFe7V0ACTL0gzhcePv0UT6i26Rvi
         C48RjjFyFVJ2NTzoJ9el4eCwM3fdJlqBw9xbBi0EGYDhvY2beTl3JTB2BzyrhQxprmEs
         146hpQy7H69xsSO3DIUgp3jjX5EPZf6DlPAjig680rgCW9m6yyssyde0EuOVIwWHRO+9
         Yfk9eUGltiAtQt63PYKYer1vYUivRZ2euvzlqwGsM7ioWErSjTAxTGvy+prlV6bXb4qb
         hNTg==
X-Gm-Message-State: AJIora8bRLaUc6tsQd5/l5YKVWBMhQhFMb0Af/aVxkooRgY17BVsRH5J
        Md3rndiAguVtrMizHl7da1Y4Fiy4VFnbEgEqxB0=
X-Google-Smtp-Source: AGRyM1uh/CR06xUphU6/6hPWuZMCI/hGpzlCLGO/mAeoZhXnLqevWfE+F9NLSu3Dl4K61tq7j2OOgn6mjrCTZ2r8ETY=
X-Received: by 2002:a17:90b:1b42:b0:1f0:447f:995c with SMTP id
 nv2-20020a17090b1b4200b001f0447f995cmr5209612pjb.200.1658937028973; Wed, 27
 Jul 2022 08:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220727090700.3238-1-tujinjiang@bytedance.com> <YuFPKDx90+R3Qc6v@dhcp22.suse.cz>
In-Reply-To: <YuFPKDx90+R3Qc6v@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 27 Jul 2022 08:50:16 -0700
Message-ID: <CAHbLzkpu91gEDzep76iRT+yFxLFaTf4fn3=bmP-fs-UP4i3NEg@mail.gmail.com>
Subject: Re: [PATCH] vmscan: fix potential arbitrary pointer passed to kfree
 in unregister_shrinker
To:     Michal Hocko <mhocko@suse.com>
Cc:     tujinjiang@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 7:43 AM Michal Hocko <mhocko@suse.com> wrote:
>
> [Cc Yang Shi]

Thanks, Michal.

> On Wed 27-07-22 17:07:00, tujinjiang@bytedance.com wrote:
> > From: Jinjiang Tu <tujinjiang@bytedance.com>
> >
> > when shrinker is registered with SHRINKER_MEMCG_AWARE flag,
> > register_shrinker will not initialize shrinker->nr_deferred,
> > but the pointer will be passed to kfree in unregister_shrinker
> > when the shrinker is unregistered. This leads to kernel crash
> > when the shrinker object is dynamically allocated.
>
> Is this a real life problem? I thought shrinkers were pre-zeroed
> already. Not that we should be relying on that but it would be good to
> mention whether this is a code fortification or something that we should
> be really worried about.

Yes, all memcg aware shrinkers are actually pre-zeroed. The fs
shrinkers (embedded in super_block) are allocated by kzalloc, all
other shrinkers are static declared. So I don't think it will cause
any crash in real life.

>
> > To fix it, this patch initialize shrinker->nr_deferred at the
> > beginning of prealloc_shrinker.
>
> It would be great to add
> Fixes: 476b30a0949a ("mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers")
>
> > Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
> > ---
> >  mm/vmscan.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f7d9a683e3a7..06ab5a398971 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -613,6 +613,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
> >       unsigned int size;
> >       int err;
> >
> > +     shrinker->nr_deferred = NULL;
> >       if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> >               err = prealloc_memcg_shrinker(shrinker);
> >               if (err != -ENOSYS)
>
> You should be able to move it under SHRINKER_MEMCG_AWARE branch, no?
>
> --
> Michal Hocko
> SUSE Labs
