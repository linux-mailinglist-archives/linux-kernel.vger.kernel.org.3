Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1A53BCE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiFBQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiFBQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:53:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211302B2EAA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:53:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so11070268ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZ8UPU6ugki+PkwkthIYbz7oUO9hdXo6b9SQ7nkdwtM=;
        b=L/0QynMd8+v88ZZU+c9xvsS2+4IBAk0qnvPWUUmgZAkop0TG4KZxd99dk7jRpG2xjP
         KUc2tplVKuDgLdfIaBZhtckFNJvUhIHInGndmo36fHngmE8m6jBeiLD0zmlU+8/OdXH8
         9Mhv3pV/nWVpkGYnhijstSeCiN20370swxDcIslOPlNz0qlzwWzr80kwtbP2UAzr+X5t
         bT2vvDe3PqbnmNaxHJbmazQRDsxxA4Yh8PekOBHYmvau5bphFYS+zjlSYH/aafxUQ8Vo
         hECS/upWIjnqQOS5ZSqLfaFOUr/hiOcHh2H6Rf5rblMMuM7gC2MEZPcSyYtpMgzVgJI9
         7g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZ8UPU6ugki+PkwkthIYbz7oUO9hdXo6b9SQ7nkdwtM=;
        b=a1RwKaNZHHNQHajq+owJJ3N4cL10bzCW3vFQT+Jc+zvo+QCyqUC48GJLGPLib7+zA5
         6O3bBwMfOnDD6ztw2MnEZVt3IX/dEzX6X41OpMPe5KSozakK57I6y0RNmpsYjUfx/TSh
         fijC//PBfan85ZXyQDyZqUujbhidRhJLgyXioBW30rdg6cf/CV+JDAPAR8GyWm9OwG/Y
         yd3PsJZIsadsTWs0V3A4774utsfbTBCzr9frMzzGl9pshUOZGxlvnMqrFZaMiwGYvGK7
         bFsa8a5gNVc2JvyyMoOS5D9ggpDkRi1C1kZ93+Fdghy5q8Wb1km4bIdv2qSwaMEvDl2e
         SMug==
X-Gm-Message-State: AOAM533GyGFEK7nb5bPCLEVOOY2JxcieovcGpcxpqb9jkpYZzpbFwIi0
        qj3zy/vAxRp4tQ2zYJtGNvjlro/xA0XRRgrG8v+NvQ==
X-Google-Smtp-Source: ABdhPJye4s8o1On+/9V61ouTi9MALoHFgmdsjmdC8JHeouR+fU7woYtXknF+evLqmso/PBYsaCxmbQR4cCcPLIhgO8M=
X-Received: by 2002:a17:906:308f:b0:709:af33:9fa7 with SMTP id
 15-20020a170906308f00b00709af339fa7mr4961024ejv.369.1654188802902; Thu, 02
 Jun 2022 09:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com> <e26de140-afb7-7b1b-4826-6ac4f3a4fe02@redhat.com>
In-Reply-To: <e26de140-afb7-7b1b-4826-6ac4f3a4fe02@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 2 Jun 2022 09:53:10 -0700
Message-ID: <CAGS_qxpFO4ixW=08ZcdcD9J1kU=B3mwoBJkPW8AKu0sKs8aKfA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
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

On Thu, Jun 2, 2022 at 9:27 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> > +CFLAGS_drm_format_helper_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> >
>
> A comment on why this is needed would useful.

Ah, I think that should not be necessary anymore.
We added this to some tests to mitigate against compilers that didn't
optimize away stack-local structs used internally in KUNIT_EXPECT*.
Functions with ~30 or so EXPECTs could get flagged for excessively
large stack frames.

But in 5.18, I had some patches to reduce the naive stack usage from
[48..88] => [8..32] bytes per EXPECT.
I also have some RFC patches out to get it down to [0, 24] bytes.

So going forward, this should only be necessary if you have something
like 100s of EXPECTs in a single function (in which case you should
also consider splitting that function up).

Daniel
