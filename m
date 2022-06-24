Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5355A295
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiFXUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFXUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:24:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428A7C875
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:24:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t5so6968866eje.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaqOm6r23E52n00DqSK54VWl2Yplfk1mrrUTg1NuA0Q=;
        b=TVZPEDxtfS05fPbh8C5E5tf1DF+QrfO2B4EhpbHdnJb7NHfSX8s+jM0td0YNOCim8Q
         3U2R1Tfe7es0drm9BXWVihEXLWf9kXLQd3By4K5WPPMF3Mr2EcVbUHX9FALfxYILOgbQ
         HmCjm86JoKw0r19/SI2xcExQPg3Y/Xj6RyB3JK/mf061FdBnO/aL8s6aV7fNoix9BLgK
         RQmS9nBAFyIC+ORoxBRAVDZQ08f/1hqfxXTCNHrCL8rfHlNEzXW3HqRjKcP3XB4TVFmX
         +XQyC5cH47V0ZYERMP8D5+MLQ5vQvVY1DKtNtnqOGGlM3ysw8PPlLqbeEPGAN/UafsKj
         iYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaqOm6r23E52n00DqSK54VWl2Yplfk1mrrUTg1NuA0Q=;
        b=MPUN3Zw1rlFPArdPeWvRkNXqrfG46E65eRzZQGn6d1oiOlYINrfsCirHW5Pqoi/rOR
         HQ+Z4ll1dry7B1G4TmDcKUSaWjSZrmEqL/jbJhbEziBlNVSWs9zbndqQ/dMDYHf/fWIY
         csf13xyTKjzXjA8GFMcVB8Hksq87AP1VEU8TaHajHvxbSQMMoyxpmx5po0QFyH4cRYfX
         KKkYQS68gRTjFvUXa1yGy6qgOUeydIvpahDFusSw9odnquyhBxvcB8PrdygvtvqpGik0
         zGMApGMVGzA3R0OH8ebA7ZckpVIaWIx0NOV95recTTW6Q8Qf2kSO11JH4jnTpSVfXNDO
         g5Sg==
X-Gm-Message-State: AJIora8py0uVnWabUwtd3YFDUPiflCTlDuh4C/D7iJZ8o07Ol50J/+ev
        clXYYT52uLEm4379wJ3xBGUFvxW1EleEQEXT7zQ4XA==
X-Google-Smtp-Source: AGRyM1vNee5xQDJkVdYHoGnCzUtSfDdB4v+8ZxXqhOTHxv64h/nNYhazQP4LUX+4OyQPvFFZvj5Om4PdUoVHIE/kQx4=
X-Received: by 2002:a17:906:308f:b0:709:af33:9fa7 with SMTP id
 15-20020a170906308f00b00709af339fa7mr736816ejv.369.1656102272733; Fri, 24 Jun
 2022 13:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220520224200.3764027-1-dlatypov@google.com> <CABVgOSkNpaY1HsygqkWC8LVO+XTqGwNxFNgne-ajoTiPqCnrkg@mail.gmail.com>
In-Reply-To: <CABVgOSkNpaY1HsygqkWC8LVO+XTqGwNxFNgne-ajoTiPqCnrkg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 24 Jun 2022 13:24:21 -0700
Message-ID: <CAGS_qxqQiWDRwOJcU+1X31SgdKGFMLT8tA7EJXN9JUmKOhYfxw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: refactor internal kconfig handling, allow overriding
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Fri, Jun 24, 2022 at 12:55 AM David Gow <davidgow@google.com> wrote:
> >
> > +       def set_diff(self, other: 'Kconfig') -> Set[KconfigEntry]:
> > +               return set(self._as_entries()) - set(other._as_entries())
> > +
>
> It took me a couple of goes to realise that this was looking at the
> difference between sets, not trying to set the difference. Maybe
> different_entries() or something like that'd be clearer, but I can't
> say it bothers me enough to be worth a new version.

Wdyt about `set_difference()`?
Or maybe adding a verb: `get_set_diff()`, `compute_set_diff()`?

But we do want to make it clear it has set (asymmetric) difference
semantics, see below.

>
> Then again (as noted below), the direct set difference isn't exactly
> what we want, it's more the equivalent of is_subset_of(). The
> follow-up repeated-kunitconfig patch adds differing_options(), which
> is closer to what we'd want, I think:
> https://lore.kernel.org/linux-kselftest/20220624001247.3255978-1-dlatypov@google.com/

differing_options() does not have the right semantics.
For this, we do explicitly want a set difference.

Context: This is the func used to print out these warnings:
$ .../kunit.py run --kconfig_add=CONFIG_PCI=y
...
Missing: CONFIG_PCI=y

That comes from
  invalid = self._kconfig.set_diff(validated_kconfig)
Using differing_options() to get our version of the configs:
  invalid = (want for want, got in
self._kconfig.differing_options(validated_kconfig))
we instead get an empty list.

The problem is that differing_options() only shows config options that
are explicitly to different values.

There's probably a way I can name these functions better to make the
difference more clear.
Or perhaps we should move set_diff() out of this class and have
kunit_kernel.py itself due the computation.

E.g.
  // make as_entries() "public", s/invalid/missing
  missing = set(self._kconfig.as_entries()) - set(validated_config.as_entries())

Thoughts?

Daniel
