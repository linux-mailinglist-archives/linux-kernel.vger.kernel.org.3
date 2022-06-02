Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245353BD82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiFBRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiFBRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:45:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC22AE9FC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:45:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so7199358edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/j8ff/empoIVzIPqKgRJrZ1yf+Uabh8CB6phARQHw8=;
        b=pjj97zVwrM2CrMZNQ3YkjATsb+hGhtkoV0IpDJjgCaefeTLDdnSoin2KLI9/QKKmxO
         oA3TdT7FkZz2tbI4HStW8JyPCbfhVf0FHFBe6OppQ77QKTNmsKLy/hQckjF20VRrgdna
         WwLC6aH/+MnQQ7yWyEgjSOj1N779suPF85G7D73rEpHEoJwWe38490e8Ul2h9EviJOzQ
         dZsuwxUIzJbucpc5J+ygfZ8y4wx580vg1bv3nY1mJ+Ger3GGq95WzFb6ykyto88yD8av
         OchcgEkqmZiP0Sys7Ju/I+lMSWVVA4zu+08fZAJUvuParWjBk3U901h2VCPqXupCrG07
         4+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/j8ff/empoIVzIPqKgRJrZ1yf+Uabh8CB6phARQHw8=;
        b=2MFOZHVX0pNAaojAbKlvYccL2EbCUcs7LXt3nAwNCRK+GKyEjzEcg0La8F5d16myNI
         YpPl1/3J0hLUOLYjJ6n1N6K2pd8Iv4SfbkQ+dlWH7mYJMVkBze/1/m+Cwg7GFLd393Nf
         8akD7Xvl3opt1RhvR91nss+fQ/RcG6qRUlfFOEYZksSU3DwluDtGzbAuQ/2txTTeFGPf
         5e+KKnFED4r5iyylo+2PvQZFSoR1qjAKTfSuQfL1TEHFabX6GcnPGOi6dlyzJq5pi9fe
         yoIgU4WwnHcHtc5jJIPaz2RaCrobnJ4Vwmalo9snvp6d7B0QNT5OCoEyeKO4kv283/xb
         Gujg==
X-Gm-Message-State: AOAM530urSnN7ZDL0olcGYCOkcXUmdNjsfJ2QHEg5S+DuMXGANt9Eqe0
        Y/ItbtHmeBI7ihmzdGLane0lwnIIgwm35FpbIcQZ2Q==
X-Google-Smtp-Source: ABdhPJzvUvlqNLSSWFHR1VOLU0xd2hgNWjjf5TY1pOrfxuPXl16DBLKRH8bOnbtdyu7oiCDTr/0gmfUg7LVZaOjTtN0=
X-Received: by 2002:a05:6402:2806:b0:42b:67fc:8565 with SMTP id
 h6-20020a056402280600b0042b67fc8565mr6689418ede.230.1654191934879; Thu, 02
 Jun 2022 10:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com> <20220530131158.kqq2mohxoh52xpeg@penduick>
 <20220530162903.GA6546@elementary> <CABVgOSn8i=LO5p7830h2XU1Jgg0KrN0qTnxkOMhf1oTgxjaKKw@mail.gmail.com>
 <fea8f80a-939b-2c73-d94b-5179d1e65be9@redhat.com>
In-Reply-To: <fea8f80a-939b-2c73-d94b-5179d1e65be9@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 2 Jun 2022 10:45:23 -0700
Message-ID: <CAGS_qxqpiCim_sy1LDK7PLwVgWf-LKW+uNFTGM=T7ydk-dYcEw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        KUnit Development <kunit-dev@googlegroups.com>,
        tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 2, 2022 at 10:29 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> > Or, without the .kunitconfig:
> > ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_DRM=y
> > --kconfig_add CONFIG_DRM_FORMAR_HELPER_TEST=y --kconfig_add
> > CONFIG_VIRTIO_UML=y  --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> > 'drm-*'
> >
>
> I wonder if would make sense to have for example an arch/um/.kunitconfig
> with those symbols and maybe others and then the tests could also be run
> with something like:
>
> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig \
> --kunitconfig=arch/um/.kunitconfig

Yeah, this came up before.
It'd be nice to have
* --kunitconfig be repeatable (it isn't right now)
* a "uml_pci.config" with the magic needed to set CONFIG_PCI=y on UML

Another example where this would be useful, coverage on UML
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_GCOV=y

I did prototype the changes to support this but never sent anything
out since I had some concerns, namely:
1. we'd be blindly appending them, but that won't always work. Would
users be ok with that?
2. people are already confused about .kunitconfig. It seems like the
most confusing part to new people, especially those new to kernel
development. Would adding this make them even more lost? Perhaps
making the docs clearer on this would a good pre-req.
3. What conventions should there be around these partial configs? I
think the idea should be more generic than just kunit.
4. --kconfig_add now makes this possible, even if in a noisier way
than another --kunitconfig
5. we didn't have a good way of reporting options set to different
values. https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
would help by giving us an easier way to give clearer error messages.

That said, I'm willing to whip up another version based on the patch in #5.
I think we need a docs rewrite for #2, which I can take a stab at.
But I think we'll need some bikeshedding about naming (#3).

Daniel
