Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D464C802F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiCABN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiCABNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:13:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805FF18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:12:40 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i11so24374377lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sPR5FUt6BL5vY4zH7orS+P13v54d72vP0e3RrfoSc8=;
        b=dNq4touzRtz7uHynhq2fJfbFKWoMp3PFbmT4jP+lWtA+XEV7MUTaj9Bwb0dDhwVCKm
         Q/BC42Z7ZY0u0gvdOMlG7LxxZ5h5HJ2Yte8aQDgGIv9cAV05D8AcjdgXO3040/xi0YYq
         UaAoEYAw2FUw8zaH6DSetc0Wr5+8+bf3j3dq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sPR5FUt6BL5vY4zH7orS+P13v54d72vP0e3RrfoSc8=;
        b=70AUXeQlfeXKEAEmRgJVHpmzgydSxPhA1sSx91rycBczN9WChfhQdnBxXy4cDMfwh9
         dy9hwPTKACu7V1dG9BZWfFcf4Vft9xK6CD8rwwwAWA3YVPBgRkH5cfDkcL9n9IHDjJ0F
         4LB972lrj85f9akpiq6vvy26b8oZfprBUjYBxT5n3T0k/DYKVOHm4KgA+Ln3ZY91DoWe
         vwGtN1+H/k/85UyE44iOUxHMIyHPhdC8GD175mQ1Y4SsnIi8pb9H0ChK9yF9riHj5hVE
         HzErHCeCLkOpVQ1TpH8ZxkTgRV+ZF0I857IAnQDh4RqRTN1SojBH4601UpqsFydj05gU
         aH7g==
X-Gm-Message-State: AOAM533QMjIvxpBEQ6pDSICGdedukVsw081zV4AM8fsOp5/BkfwATOeE
        FHCUWEAkTutSa5Z3mbPNTDEm9/qTyqZUq4V489g=
X-Google-Smtp-Source: ABdhPJw55j06SNaMRSG5MfG0P1llg05Uu0dAdU9q1shtyM0f/inOjphkR6VbM0MAZa+JPXMz6azQGw==
X-Received: by 2002:a05:6512:400d:b0:443:dcdb:bdff with SMTP id br13-20020a056512400d00b00443dcdbbdffmr14724084lfb.287.1646097158829;
        Mon, 28 Feb 2022 17:12:38 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r11-20020a19ac4b000000b00443d571f256sm1221251lfc.66.2022.02.28.17.12.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 17:12:37 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id m14so24350979lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:12:37 -0800 (PST)
X-Received: by 2002:ac2:4d91:0:b0:443:127b:558a with SMTP id
 g17-20020ac24d91000000b00443127b558amr14616139lfe.542.1646097157337; Mon, 28
 Feb 2022 17:12:37 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area> <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314> <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314> <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
In-Reply-To: <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 17:12:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
Message-ID: <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 3:26 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Indeed, qat has been disabled for dm-crypt since
>
> commit b8aa7dc5c7535f9abfca4bceb0ade9ee10cf5f54
> Author: Mikulas Patocka <mpatocka@redhat.com>
> Date:   Thu Jul 9 23:20:41 2020 -0700
>
>     crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY
>
> So this should no longer be an issue with an up-to-date kernel.

Ok, that commit message doesn't exactly make it clear that it also
fixes a major disk corruption issue.

It sounds like it was incidental and almost accidental that it fixed
that thing, and nobody realized it should perhaps be also moved to
stable.

Oh, except I think you *also* need commit cd74693870fb ("dm crypt:
don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY") that
actually reacts to that flag.

Which also wasn't marked for stable, and which is why 5.10 is ok, but
5.9 (which has that first commit, but not the second) is not ok.

Of course, maybe they got marked for stable separately and actually
have been back-ported, but it doesn't sound like that happened.. I
didn't actually check.

                  Linus
