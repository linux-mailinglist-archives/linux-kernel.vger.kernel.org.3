Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2355509F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376297AbiFVQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359847AbiFVQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:01:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46E3FDA8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:00:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf9so14908309ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLtKE1DbGNDAcHw+kGtoh0+pUA8+XW2olgnWv3dlEaI=;
        b=OH2byGIkD+olnkeI/3nZfvCKqy/63vjNAWe3lYUTBJh+R2Abgs5g9jETQS/ScCVUFH
         ryxF+tyQ41trfmgtRmC0vkovKtUUFWfRCZSO9FgSmnulWo4mpiGtZQFkCgg/V+3hE6qN
         tojlkpUyG+b0iOdJimNXIRIJIlvZITKDLhUZ7ibGitrEy7F1SpAfMdZI7mJR+I90abzg
         l3SzqeR51rfdBw1NjbEIQckyd8C27YxtR2fdEFiEajuK2Y6vvx5Ld2ruxZ2NNl2WFHtE
         AfGvRSYfbehIJRIYz4br1sl+IJ9h3jgWQOlr0oXHexWHa695Sbk2GPAjNCU/+YlNF8Oz
         7s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLtKE1DbGNDAcHw+kGtoh0+pUA8+XW2olgnWv3dlEaI=;
        b=sVxHeqcCaQG97uSdamfD6ikEkc0LfC07KEVqw1/dwNAd7wOjza5DuMZMdSnsjwBp5n
         OISUO2CZ7+C+jLE4ZSWJ4RJpApWtNt/xgw/N84DLmx6BStKhUxy5WXthetyeNvTK3nRp
         DIryKLzzk/yB2ifAlDhF7IhA9Haf9AiuWEEjP5bmzu9axVvsL82/IceyCkj4j0koMMuF
         OFdfHFtZtqlWOHwZzcYmQWjyxNUF3lqPVmCYaNKPnBZoeBUxs5f76/d8HHbXal+XQ/J2
         dv2DemQtzPvQgc5SEkHZtxhTL2ElBjbXkk3J1dIh0xDZPtvCSLNuND39xFkpxbboPRhC
         N8Ww==
X-Gm-Message-State: AJIora+nkX/CMmpgeW1mo3oTMVmEbep+vUGnnvWvEuB1Krs6E2zF61Ff
        JUuv858MH0yj+9oR2WPGQB95yyNqFia/i3pxC0Qaew==
X-Google-Smtp-Source: AGRyM1s+tUCZdxTA4kkpJZebZj70VgjXomAgb+8vKGcmBYJIxp5WftwRivkjrD18cLRA0q+DUPvvIkkr5GNr3LAMNuI=
X-Received: by 2002:a17:907:16a4:b0:711:c9a7:dc75 with SMTP id
 hc36-20020a17090716a400b00711c9a7dc75mr3679859ejc.542.1655913608169; Wed, 22
 Jun 2022 09:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220622035326.759935-1-davidgow@google.com>
In-Reply-To: <20220622035326.759935-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 22 Jun 2022 08:59:56 -0700
Message-ID: <CAGS_qxrW-Js69+21Q9nHj19_AWvKcfUvKLYXDCXdB5ZdRPirfA@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: tool: Enable virtio/PCI by default on UML
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 8:53 PM David Gow <davidgow@google.com> wrote:
>
> There are several tests which depend on PCI, and hence need a bunch of
> extra options to run under UML. This makes it awkward to give
> configuration instructions (whether in documentation, or as part of a
> .kunitconfig file), as two separate, incompatible sets of config options
> are required for UML and "most other architectures".
>
> For non-UML architectures, it's possible to add default kconfig options
> via the qemu_config python files, but there's no equivalent for UML. Add
> a new tools/testing/kunit/configs/arch_uml.config file containing extra
> kconfig options to use on UML.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> It's really ugly to have to type:
>         --kconfig_add CONFIG_VIRTIO_UML=y
>         --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> when running many tests under UML, particularly since it isn't required
> on other architectures.
>
> This came up in discussion with Daniel this morning, and while the
> ability to repeat the --kunitconfig flag would go some way to alleviate
> this, having to add:
>         --kunitconfig ./tools/testing/kunit/config/uml_pci.kunitconfig
> isn't all that much better.
>
> So it seems like adding something by default would be nice.
>
> This implementation is not perfect (in particular, there's no easy way
> of _disabling_ these options now, though [1] probably will help). The

I assume the missing link for [1] is
https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
Note that we'll have to update one of these patches depending on the
order they go in.

[1] had to change make_arch_qemuconfig() to ensure that arch/qemu
configs have *lower* priority than user-specified overrides.
So we'll either need to do the same here or update [1] for this to work out.

> 'arch_uml.config' filename can be bikeshedded, too.
>
> Thoughts?

I was initially against effectively hard-coding these in, but it feels
like making CONFIG_PCI=y work by default on UML is worth it.

We've talked about architecture-specific options in kunitconfig files
and it's only ever been about PCI. Nothing else has come up yet, so
this patch would eliminate that concern for now.
