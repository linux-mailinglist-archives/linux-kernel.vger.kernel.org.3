Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3306A50C15A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiDVV4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiDVVz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:55:57 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918522A3247
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:12 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id b128so8480344vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Nnz4Zst0bPhyG4+bPpJ1xif7BM4/fGW7NbRucrhml4=;
        b=luurb7sSi/ydYptLRDsPmPwgsj6ufhuQqTdkq2XihF24gSb2V7bQpiYml/6vCKS/nV
         RNwz6hd7Kv0zPgYslUtDlapSgocvuQiiW5DxU24L5e1VOHPqVsiYVaevTmMy9HlS3nnY
         Typdh3lq3/ajCM5q9+iqANcP4SdwcVj9PZge1oo/k5CxmS4whtxk+O4A0uWX/ed1vK/S
         n14AT1JOExIKMY9XX7X/X1aOMAc5ewYRjXPDcwH1xf2p1kdrLWPyIv3LT/50eAI1Iby0
         0q/7W/WJTnTDcGs3HzyiJ8fvNJWC7ekuTAynzua6W4tXY7u2i7sJMPJ9Nm9AkKfaKj/4
         PrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Nnz4Zst0bPhyG4+bPpJ1xif7BM4/fGW7NbRucrhml4=;
        b=bS9LNfPQrTRFdalxP5tv9iT2CMy8TYjMtVErnL1yrTYjNh4u5/bKHbLGIdqn1X4Hd+
         GBQNX2y8UgA4Np7Ev32sFlwhkz/JG1EtkXicEcUoOj+BINxw3fyWuTIXMwOL5RgGG63U
         hoKQ3vQagiyX8mIXGGUywBed/btvY5d5zRvradEuJNGG4OIsgTaC0iLorWgak5e0qSx0
         IPhBI1i1g3j5LmCjnTbTS/kj+I2XYXvp2gjeCNwZPi/jT5Awm6GkHzFTAvBWqLFIbZgH
         IK9MwpAoRY0YXyujqDp1Yi2qw6hUc2uaDOlaplvFC0osFF6hjPQ9q8IgDSFtgEa53w1B
         HsjA==
X-Gm-Message-State: AOAM530Vsbu6/3wzSVii3jtgJEZHfMPYbVmHF+RZXnV38zgz2IwmAtNN
        yrdp/V4QNzm2h/NtxbehCU5JiPF22KN7BNCJcLtYaA==
X-Google-Smtp-Source: ABdhPJwF0+upByX+DdZ/72pi7fzsHrXNgmXb7HtLilh8tuy0NH6tPuc0QIJCs/OUzOAwlkvo93PFjdq+Q5ZyWCRAAF0=
X-Received: by 2002:a67:2f44:0:b0:32a:27a3:7319 with SMTP id
 v65-20020a672f44000000b0032a27a37319mr2012915vsv.49.1650659372631; Fri, 22
 Apr 2022 13:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220404211858.968452-1-pcc@google.com> <Ykv39KMpKXb2Mr6p@sirena.org.uk>
 <YmKwrs3dJ09ybBJa@arm.com>
In-Reply-To: <YmKwrs3dJ09ybBJa@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 22 Apr 2022 13:29:21 -0700
Message-ID: <CAMn1gO7Drzj-sXy5qyCAzm01aFZx8QXHQ8F5C5=BDaDNuap_Dw@mail.gmail.com>
Subject: Re: [PATCH] arm64: document the boot requirements for MTE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 6:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 05, 2022 at 09:04:04AM +0100, Mark Brown wrote:
> > On Mon, Apr 04, 2022 at 02:18:58PM -0700, Peter Collingbourne wrote:
> >
> > > +  For CPUs with the Memory Tagging Extension feature:
> > > +
> > > +  - If EL3 is present:
> > > +
> > > +    - SCR_EL3.ATA (bit 26) must be initialised to 0b1.
> > > +
> > > +  - If the kernel is entered at EL1 and EL2 is present:
> > > +
> > > +    - HCR_EL2.ATA (bit 56) must be initialised to 0b1.
> >
> > Very nitpicky but this is only required for FEAT_MTE2 and above, plain
> > FEAT_MTE doesn't have these traps.  I don't know that this is a thing
> > that anyone's actually implemented
>
> I think that's a valid point. CPUs may implement FEAT_MTE2 but downgrade
> it to FEAT_MTE if the SoC does not provide allocation tag storage. So we
> should make it clear here that only from FEAT_MTE2 we should set those
> bits (ID_AA64PFR1_EL1.MTE >= 2), otherwise they should be 0 or
> hyp/firmware risks the OS triggering random external aborts.
>
> > and from v8.7 on it's not permitted but the above isn't strictly true
> > if someone did for some reason have the most basic version.
>
> The wording is tricky: "This feature is mandatory from Armv8.7 when
> FEAT_MTE2 is implemented". So one can still implement FEAT_MTE (or none
> at all).

Okay, I changed it in v2 to explicitly say FEAT_MTE2.

Peter
