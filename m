Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9F5968AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiHQFiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiHQFiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:38:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880414CA31
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:38:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z16so14910968wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9BSWw6C7dasI4dQkCLgmz9qR7KfaoynjBECx1WdQL6Y=;
        b=fh3dIJJP0PwGt3mqHNzGrpg5iWB+nVY8s3yNAyZ8+cOTuVUSYEmaqHPvKyxd2U8jSg
         bwbhdVeBDs5ocVZLkoaYKD909yU1+plfBQs9YiiE46Tr4CtoO7fsS/lkjsiISap3nyiC
         3zNFBR4wwtjDq33w4TnMZA2fUx5arweYrf+MuMynWvtdvVxJtNBWATp+wpPYYSdxF6C8
         9UuISQ/r2Eh8TYdNq0BYGR7XwvUicXrfckxjiFfP4TprcOeQve0sxkBbHlbOgK5F3mOj
         TIkcukevMB3xW2pIoOLg45zBOEx6+bithxdEwMUcHAYb7O7sBfk+F0N92A3f36tBJ2QK
         yraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9BSWw6C7dasI4dQkCLgmz9qR7KfaoynjBECx1WdQL6Y=;
        b=bsUzWlPku9AUi91Dj6t9aY/t7pN5Fm38sa1SmmusINWeehB7JuEvYAvUhDa4bGFMII
         Puw4kNNTuI8fxO3LFNJx9Wbt09xmhOvfOmlESwXg45bE7pkoa5kiYTpjGlSjPYLrJyy1
         s1ko8+lisCCuPJJdFQlla+9xDiewvOgNr1n8FCWf2mlv9hbS5xiHFaGQ2GXfzv3Gf3Wm
         Wjda1pGKbuS6+lju9mU+cWewi0y9tNHzuVouRZVzQq0ppb6VIoqyuhx6+NzH7HpybKEO
         c9aix5nRgH7kftO2+9liK4x7okQMRYJ9FSb5GkS1Z1EMbI9G8SFKkTPFGlU2GgXW/sIG
         +XAg==
X-Gm-Message-State: ACgBeo2JiWtwpJpqZZxtJ3kx+VyFgBeU5wMSddBtbvEGAdm5/YaIefUc
        zDBHeYy6J7u+ppabN/2U8Tb552pWjA7931SaSve97Q==
X-Google-Smtp-Source: AA6agR6GmEj9vYzmsG2VKo1ANoF63KHItjlegZC0vUUzNCddh2am/awMdXkDploI/YxeX55K2+s5p0YUc884SaNx95w=
X-Received: by 2002:a5d:6705:0:b0:21f:1520:5095 with SMTP id
 o5-20020a5d6705000000b0021f15205095mr13057960wru.240.1660714725812; Tue, 16
 Aug 2022 22:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220805214734.1937451-1-eugenis@google.com> <875yj1x0k0.wl-maz@kernel.org>
 <CAFKCwrjVaOdrGktxVHLCDPyJSRjZ0B3FHTGsb3PXMULL=dw9rA@mail.gmail.com>
 <87v8r1uztz.wl-maz@kernel.org> <CAFKCwriq-Vh+fhxso=xqtKzkL95QkYOOkMR8XwTOJfeg1M-2qQ@mail.gmail.com>
 <CAMn1gO5Va0eVFqzoOLLLJ+C+x-5=cc4qXDTw0e9J7v0RpYWusA@mail.gmail.com> <YvtMk2cNDrrzVX3g@arm.com>
In-Reply-To: <YvtMk2cNDrrzVX3g@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 16 Aug 2022 22:38:34 -0700
Message-ID: <CAMn1gO4t1hGSTKE0fLCcJXmHGvH_zuzjqiBKp4G=SmKyx=R_-A@mail.gmail.com>
Subject: Re: [PATCH] mte: Follow arm64.nomte override in MMU setup.
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:51 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, Aug 09, 2022 at 06:24:23PM -0700, Peter Collingbourne wrote:
> > On Tue, Aug 9, 2022 at 10:29 AM Evgenii Stepanov <eugenis@google.com> wrote:
> > > On Tue, Aug 9, 2022 at 9:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > In which case what is the tag memory doing in the linear map?
> > > > Shouldn't it be marked as reserved, not mapped, and in general
> > > > completely ignored by the NS OS?
> > >
> > > That would be wasteful. The idea is to only reserve the parts of the
> > > tag memory that correspond to the TZ carveout and release the rest to
> > > the NS OS.
> >
> > More generally, one can imagine a system where *any* tagged memory
> > transaction can result in an SError because the MTE implementation was
> > not configured by an earlier bootloader phase, e.g. because the
> > bootloader was configured to disable MTE at runtime. On such systems,
> > the kernel must refrain from causing tagged memory transactions to be
> > issued via the linear map, and that's exactly what this patch does.
>
> The problem is that it doesn't. The 8.5 architecture allows any Normal
> Cacheable (even non-tagged) mapping to fetch tags. It may happen that on
> certain implementations setting MAIR to non-tagged works but that's not
> guaranteed and with the Linux kernel we tend to stick to the architected
> behaviour (with a few exceptions like PMU counters and errata).
>
> There is an ongoing discussion with the architects and partners on
> whether we can tighten the architecture as not to cause visible
> side-effects like SError but not sure whether that has been closed yet
> (just back from holiday).
>
> Until that's sorted, tag storage cannot be reused in an arm64-generic
> way in the kernel.

We can see how that discussion turns out, but let me take a shot at
persuading you that this is the right thing to do in any case.

Again, this isn't necessarily about reusing tag storage. It's about
whether the accesses via the linear map are expected to work at all.
As defined, the architecture gives EL2 the role of controlling whether
the system is deemed to implement, among other features, FEAT_MTE2, as
there is no capability for EL3 to trap accesses to the relevant ID
register. On the other hand, EL3 does to a large extent control
whether FEAT_MTE2 is implemented on a particular system, regardless of
whether the CPUs are capable of supporting it. Therefore, the kernel
has pragmatically defined arm64.nomte, together with other command
line arguments like arm64.nopauth, arm64.nobti and arm64.nosve, as
non-architectured means of overriding ID register bits. If the
relevant ID register bits for MTE as filtered through the command line
arguments are 0, this implies that FEAT_MTE2 is not implemented.

At this point we rejoin what is architected. Among the features
implied by FEAT_MTE2 is the ability to assign the Tagged Normal
attribute to pages via the MAIR. If the kernel were to use the Tagged
Normal attribute anyway, the behavior is defined to be UNPREDICTABLE.
Therefore, the kernel must not use this attribute in order to avoid
UNPREDICTABLE behavior. It is simply a bug that we are failing to
respect arm64.nomte when computing the MAIR.

Peter
