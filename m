Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146A4E340B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiCUXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiCUXWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:22:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CD4B1EF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:15:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so15056540lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJ9Cb5knxaydut4A69DGxHwlprGSZbckXL16qciG47U=;
        b=JJSzV91d6Mz09E35tlZODBUUR1INh/MgMi3TieAJqFtFVS46iVh9M1Q49i70AEnbaj
         hnmR0WUYT/+Qc4/tV3cWzDoNkvKrbUlLG6REkoGBt3sE1lc0NnSvCRqRwqnkbFgm1Ozw
         o5oyBE7O+2JdYVnmizZrwHmHk7Pj0fup2zIs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJ9Cb5knxaydut4A69DGxHwlprGSZbckXL16qciG47U=;
        b=IEAiOBR2DUmBwsB4hiHz50GuNd64Me4iBuzVdEMQXvPPMWGgrl0SiWh/CXJktHQ7In
         aEGAEMncy1veZaUeXl7M7HbQReLTjgq0hVuXqfX4bO2F7yZDTZck76/7ilVPBS2uMCsA
         2vvfkE3mRUk3rviZsUa44Ii2+KySIfZG1wI7sheP7PBohO8EH0eZJtvQLxk2lGWoT4Dp
         d3Fz3jYkP21VDxgL1nm4LkKOyEk5wxCOemSx6mH8SjiG+oq7NaadT9JajSn49UuFOTay
         72YZUEUJbpGwgsYetDVJs0Zb7l6jzQED6EuZaAM0JOFmUM5e4vIrLQaFzd9+LliJ8qWH
         qIzw==
X-Gm-Message-State: AOAM531sT30wShZqbu21cdNPwocauqkercmZrKL1OYe2Jv7MC4r2rYcD
        8xhrIR6TZuMJAZade/LVpk2WjiKyFVtmqtggO1k=
X-Google-Smtp-Source: ABdhPJyT1e6bsFDZxIlmALSHeweuu3Wqqe/V8ia18fxkh2DAh5LkGu6/5LE/is4TpqfIik1dlGUNrw==
X-Received: by 2002:a05:6512:3f0d:b0:443:5f35:6360 with SMTP id y13-20020a0565123f0d00b004435f356360mr16049364lfa.661.1647904506970;
        Mon, 21 Mar 2022 16:15:06 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z1-20020a195e41000000b00448ac0a351csm1949136lfi.211.2022.03.21.16.15.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 16:15:06 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d5so7849637lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:15:06 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr16519280lfj.449.1647904506069; Mon, 21
 Mar 2022 16:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200803044024.GA6429@gondor.apana.org.au> <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au> <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au> <20210628110050.GA12162@gondor.apana.org.au>
 <20210830082818.GA30921@gondor.apana.org.au> <20211102035201.GA23331@gondor.apana.org.au>
 <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au> <Yje766s7fIqYg1Tk@gondor.apana.org.au>
In-Reply-To: <Yje766s7fIqYg1Tk@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 16:14:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix0F2nwk8v2Hmo-x6Yr0PEji9=oMTewk6YhL+ATM2fVg@mail.gmail.com>
Message-ID: <CAHk-=wix0F2nwk8v2Hmo-x6Yr0PEji9=oMTewk6YhL+ATM2fVg@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 5.18
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
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

On Sun, Mar 20, 2022 at 4:42 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

So perhaps somewhat ironically, the crypto tree is now the first tree
I'm merging in this merge window that doesn't have a signed tag.

I don't require signed tags for kernel.org pulls, but I really do
heavily prefer them, and they aren't that hard to do.

I'm sure there are several other non-signed pull requests waiting in
the queue, but still, your pull request stands out as being the first
one - out of 27 so far - that didn't have it.

Can I prod you in the direction of making signed tags a part of your
workflow? The tag can contain the details of the pull - in which case
git request-pull will populate the pull request with it - or it can be
just some dummy message and you write the details separately in the
pull request email like you do now.

I know you have a pgp key, because I have one in my keyring from you
going all the way back to 2011. And if you have lost sight of that one
and need to create a new one, that still better going forward than not
signing your pull requests at all..

            Linus
