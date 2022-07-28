Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A85835FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiG1AXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiG1AW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:22:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214444B4BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:22:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c22so135153wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmEmeRZhd9Zjf3GjjylIGsA/lCIIeJ6jjo7QTxJzxvA=;
        b=ICGsuhAhunYr+r/GoO+4BHNivDMLZR5fvOwLh5HFkDDRz6EfC02ywECIWGFN71ODiB
         3LxXaj60PZEk9S9t5ZHy9PcgGbOX2Ff4/uR0n+FZBgj+oBEs+XUGLMjTqeOEJZsaeYVq
         lrQkcGUdHRgl0eQl3YnUoRvXLNV3rPzWu/zXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmEmeRZhd9Zjf3GjjylIGsA/lCIIeJ6jjo7QTxJzxvA=;
        b=buV73R/iwSaJ7fU5z0NYIpOXYPQPyQ89X1K2iBBnEgC/1QkLczOdWiogcodEKSKWOn
         z+LdmDira7z894iA2xI6Gzq0F/XE4/34YNlRr3xXQpftG2LivVkx6O/Y5WSLAzi60b47
         V4JeISzAFZwW8Aky0Hyhumn8adHXiFfaLFLx9BHiCovRvBRmDtYvERb2FEw/mpEaA8rC
         J5202cGizgwkHTvca91bEm4LEr4DhTFy6PxtKtvNQ2pDIBszwscZ9fNRYAhkDJcCPAQU
         PDhXq8tygrfIqq250HOf8bjn9b3AdTCWtxdsDxDJbkeWAIwtZWP2nce1+3jdGh8ZaM3c
         RrJw==
X-Gm-Message-State: AJIora+EJPmnjAB9en5H2VdZ+Nkmtbhr1/9e9aYtHuVCZBb+np0Jrr0M
        GnQe6WhJGeBN4KY58wuccGMi2uRrIMkxLYqzP67fbQ==
X-Google-Smtp-Source: AGRyM1t+gk2Xy/Rz+Hu8IN5+F/z5MXtLN24ReL9yKM1lsyxrotsmT/Zh2a+RN7wQ24QUJzRdJqi66T7ujHp2mlnt1oc=
X-Received: by 2002:a05:600c:a03:b0:39e:4f0c:938c with SMTP id
 z3-20020a05600c0a0300b0039e4f0c938cmr4621229wmp.145.1658967774472; Wed, 27
 Jul 2022 17:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org> <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org> <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
 <628a7302-1409-81f7-f72b-6b1645df9225@linaro.org> <CAODwPW-4i+idH8Nz6=EmNUXYWgWkoOHs3wOZ7BbrH5GwGDZ1Ww@mail.gmail.com>
 <1f3189ef-7d3f-27b3-a691-b9649090b650@linaro.org> <CAODwPW-GDkfyFaNSnEngpSfz8LSXRetu+xwp3QrFHP1rH1O06w@mail.gmail.com>
 <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
In-Reply-To: <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 27 Jul 2022 17:22:42 -0700
Message-ID: <CAODwPW_tcAAqKE66B+RbvMn-=favT07i3EK3TnAspVsWTAeJ4Q@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > By "use case" I mean our particular platform and firmware requirements
> > -- or rather, the realities of building devices with widely
> > multi-sourced LPDDR parts. One cannot efficiently build firmware that
> > can pass an exact vendor-and-part-specific compatible string to Linux
> > for this binding for every single LPDDR part used on such a platform.
>
> Why cannot? You want to pass them as numerical values which directly map
> to vendor ID and some part, don't they?

Yes, but the current compatible string format also requires the exact
part number, of which there are many thousands and it's impossible to
build a list in advance. Even for vendors, hardcoding 255 strings in a
tight firmware space would be an unnecessary burden. There's also an
update problem -- firmware may be built and signed and burned into ROM
long before the assembly of the final mainboard. Board manufacturers
want to be able to just drop-in replace a newly-sourced LPDDR part in
their existing production line without having to worry if the existing
(and possibly no longer changeable) firmware contains a string table
entry for this part.

If you just want the compatible string to be unique, encoding the
numbers like Doug suggested (e.g. jedec,lpddr3-ff-0100) would work for
us.

> If we talk about standard, then DT purpose is not for autodetectable
> pieces. These values are autodetectable, so such properties should not
> be encoded in DT.

But the DT is the only interface that we have to pass information from
firmware to kernel and userspace. Where else should these properties
be encoded? They are auto-detectable, but not for the kernel itself
(only for memory-training firmware running in SRAM). Maybe the usual
rules of thumb don't apply here, because unlike all other peripheral
controllers the memory controller is special in that the kernel cannot
simply reinitialize it and get the same information from the original
source again.
