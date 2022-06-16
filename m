Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178A254E893
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378287AbiFPRUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378285AbiFPRTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:19:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326504CD57
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:19:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so4002147eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHjV6+d1wPcbJIXXueZ8eXPKto8w1sGcbUP/nhry+Lc=;
        b=fZLZmEgXFFCbwyUw1zXJ5JL28E/ey7iqcZSqht9lq7kKmvINuMARA0+Ulb4FJDUsty
         hAgz7ZM0rJIjo1enFtWyVxi8pMFilkYjG+n1yIzkefLHxUTnJEm9Z7JzL0MpVfkVVr0k
         /IPzEpcZksaPiymRJXKfSMDmYfFX1gnvZoDKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHjV6+d1wPcbJIXXueZ8eXPKto8w1sGcbUP/nhry+Lc=;
        b=Mz4OUlfn7Am621spY6TBAJbdm7Eu3R5LvqmLYXb9YjmTJ8LTtwNiZiAq2TT6LQUbLG
         Ihc0W55s0d1ty+eVMf2L7miX+p1UofgUYiCISTf46wrSCMVET7qI/7tXpijMCnI41r2u
         Ut9FA+eN/nl1zhlXR2wm9Dw4xTJzIL/T1mauVsHI3EWwjX5Gr3BVzIyB3RTCfFviTCae
         IMKnM5OkWY4n73Qk1a45UkcWUo4edIyKIT11MHeIwdY+47rplmxxTLnmBKtQ11XRlEvJ
         1H+Z6dkca3xEb4kBS9bnLuY7AZ/Lg4WgOf0CSy6fFv/IhcrBW2GVJ5uiqskyRam/5BO4
         wWzA==
X-Gm-Message-State: AJIora/2BZ0XU0EMBtWcWww/EU5/BuRR1MehmS76R8GSKNXbShr/6Ddi
        gWGAKUeHMcq/wTVSRs0qroPWqvrQ81EQG9yV9JTbKQ==
X-Google-Smtp-Source: AGRyM1vE8prXPyyX2KZN3XXldr/y6R0KwwEZo+KVjq+te8IczQ+4jeOKiFUFoM9AGnEq4B+OLELhdnvfnwrsQXYLabg=
X-Received: by 2002:a17:906:4fd6:b0:70c:9284:cc01 with SMTP id
 i22-20020a1709064fd600b0070c9284cc01mr5513350ejw.553.1655399992619; Thu, 16
 Jun 2022 10:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613202852.447738-1-mortonm@chromium.org> <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
 <202206131643.4FB2340C43@keescook> <CAJ-EccN92u8y46j+h1Vg8tzFfRDynMM=1zRF6zGjx_4qKJ=AbQ@mail.gmail.com>
In-Reply-To: <CAJ-EccN92u8y46j+h1Vg8tzFfRDynMM=1zRF6zGjx_4qKJ=AbQ@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 16 Jun 2022 10:19:41 -0700
Message-ID: <CAJ-EccMGXZ_-eQsqwFEbxXs-ZBah5q4okBVL9cf8Qx+0nuLs7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy handling
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:36 AM Micah Morton <mortonm@chromium.org> wrote:
>
> On Mon, Jun 13, 2022 at 4:46 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 02:00:03PM -0700, Micah Morton wrote:
> > > On Mon, Jun 13, 2022 at 1:28 PM Micah Morton <mortonm@chromium.org> wrote:
> > > [...]
> > > > +static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       /* Do nothing if there are no setgid restrictions for our old RGID. */
> > > > +       if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
> > > > +               return 0;
> > > > +
> > > > +       get_group_info(new->group_info);
> > > > +       for (i = 0; i < new->group_info->ngroups; i++) {
> > > > +               if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
> > >
> > > Oops, should be:
> > >
> > > !id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)
> > >
> > > Guess I won't send a whole new patch just for that one line
> >
> > This begs the question: are there self-tests for this LSM somewhere?
> > It'd be really nice to add them to tool/testing/selftests ...
>
> There actually is tools/testing/selftests/safesetid/ but I haven't
> updated it since v1 of SafeSetID that only accommodated UIDs. I've
> been relying on integration testing we have out of tree on the Chrome
> OS side but I suppose its reasonable to bring the selftest up to date
> as well :)
>
> Also both patches are a couple lines off from the ones I was finished
> developing/testing with.. some kind of screw up happened when I copied
> from my dev machine to another where I could get git-send-email
> working properly. I'll just resend these 2 patches along with the
> update to the selftest.

Just sent the updated patches and selftest patch.

>
> Thanks
>
> >
> > --
> > Kees Cook
