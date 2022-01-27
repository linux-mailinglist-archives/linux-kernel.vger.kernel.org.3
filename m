Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE9049D6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiA0AkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiA0AkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:40:01 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E1C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:40:01 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o10so1288901qkg.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwlNx81LiyFXyY2iciGppDMPGoQO0US7JaL+W5wXP58=;
        b=FXix/soSwU5v3gDBYEnHIbcLiXjS+z0b2IBt1TlYAQo0DYeI+gqpxsTbKUZkHtZor8
         kW43pCeC0nP0416RbhbheeDsWkcndx6ktLU0kiQAZlB1C/xdBdlG+WvHZqciDNDlDbXK
         mnqKMdtgjxtcjBEf9c/9P2rRNKh0wcIYu+SlTZjj/TvzydH4I6ji7BNn0dWCLntMxEoH
         AGh5qBdHvW7mQvH5vwouZCB0BTXncXA7u1U5phyfIYC3EZCufC2ZAvtzaYaYrSdxyCxR
         4xHG86igYNCGA3T1zpMWsMa5IddRXhhWMzGkCtRi/qOmkc/Wvdmm4IddVrCU93nRVwGX
         xtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwlNx81LiyFXyY2iciGppDMPGoQO0US7JaL+W5wXP58=;
        b=PZNtwXJAPtfc7OxOAaza7n3mPMXrB3bDMKwMEB44QKqF5SYvP1NQlKu0FsNv9Xxddf
         atR2yuEFMh5wPZExLLbVed4tgzBOos23nruAJ1DzjyM7rjI/YkeRLrcxEIUbybwF6jOx
         h7E0806qVBQiKnziig0nXttU0a6N+CpDOTe/R0mleFVwzGLt6marEoFPtinGMt+xr5NM
         vNp2CUIbe/OaxvbMk53wjQ4tJSYJfKJt/8B2VwCSZel7s8Q+dhIgDxknxim4fzaYB+Yh
         WphVjI80f35nkEjxC3v6dJL3z7kSeeGyD54krTbbqjbUr50CB5B4RI6xoCQRZLi+3Q5x
         DwZQ==
X-Gm-Message-State: AOAM532L2uszyApA7mQ3fW4KRLDjxu00kJ7QLBY4uNtXLxWF82JoQ5Lz
        Y46frI35b1C8k+jIMC1wNFrA3E75VjdXf+orVbbZtQ==
X-Google-Smtp-Source: ABdhPJxoJIaDg64lKmnPqG5v33p5Dj2sAajlkAuYc2b76Z34AsFMlB48cJqznS8KGBD+3fj8q2AfDNHyu/oJBJykz6k=
X-Received: by 2002:a05:620a:1511:: with SMTP id i17mr1071037qkk.77.1643244000582;
 Wed, 26 Jan 2022 16:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20211123161038.48009-1-mlevitsk@redhat.com> <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
 <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
 <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
 <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com> <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
In-Reply-To: <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Thu, 27 Jan 2022 00:39:49 +0000
Message-ID: <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 at 10:12, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Great, your system does seem to support GA log
> (but a patch to check if, other that assume blindly that it is supported is
> something that should be done).
>
> So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?
>
> (that code should be rewritten to time based wait and not just blindly loop like that,
> I also can prepare a patch for that as well).
>
> Best regards,
>         Maxim Levitsky
>

Hi

I've done quite a few restarts with the LOOP_TIMEOUT increased and
I've not seen the issue since

Cheers

Mike
