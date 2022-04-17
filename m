Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D728504857
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiDQQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiDQQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:35:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900933E9C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:33:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y32so21099337lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EzHT4bjn+XF/AaUOpciq4qGv6/YksgSdEhZzkeKjcvo=;
        b=e+OYMo3kxvENVv8OuYHnr/PMfrf41QlQfF/zz3+oCdT1na1kGstke0S5ZPB63i3aYe
         2Zdz2IVdCpdVb1N2aJzO9JeInwOyzB2Xc1T0Bt7vPbCHdZTJmCxnSFtTChwTvo5HCSVC
         34j2qNKoVWR2I8SrPrj7Qef//KoRIa+hP7TXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EzHT4bjn+XF/AaUOpciq4qGv6/YksgSdEhZzkeKjcvo=;
        b=RtCxeaio6C3xHkkdCA7W2NC4Ug0HQNvbDgUIbaPOBWK9tc4D1uhPb3TETFiry2OPGf
         nUroe9wkR4myOX6mefKIjrhevTID18tDE1g3uiO6OR+xI5JgiQWeQ6mT/4ztu/WetbqM
         nIpmM8MvcxSG8NjyYGf+zZIS0eHjtG55yLKskLy3M/G+wwD/F6tDewh+abmAl78Ez/xV
         HIPzRVC1WgUPmQ9szyJK2b5Ysfy8qstWE9ZG2lS0IBsrK8FWGV8xlnmY0zF2PEf2RIMU
         TyGHd88WSC7kosz4moZdJ9YjoOr6nFyMBqvU26ug9CKDsFyGN7tx02XSplQ2D5dztLyA
         szsg==
X-Gm-Message-State: AOAM533r+MfvY8Ox4cW3GWi3X7umsF/BvGTvL5vyMzJmtnR+BBM8Lvb4
        tVrwazkKgY105LLoo3C0ynZZ4HgkS2AUMR0POls=
X-Google-Smtp-Source: ABdhPJz2Ydk+WrbhJq2GaId3tvsOWi8Ovj52ZoKSAr4dehwZfKnq+KkvuPM4bO/zRMkhshVXeDnUsw==
X-Received: by 2002:a05:6512:34d8:b0:46d:4a1e:7c9a with SMTP id w24-20020a05651234d800b0046d4a1e7c9amr5533675lfr.336.1650213186615;
        Sun, 17 Apr 2022 09:33:06 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y9-20020a2e4b09000000b0024db73ee9e6sm278871lja.66.2022.04.17.09.33.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:33:05 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y32so21099212lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:33:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr5562738lfb.435.1650213183288; Sun, 17
 Apr 2022 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <YluC7rAj5syHOYWi@shikoro>
In-Reply-To: <YluC7rAj5syHOYWi@shikoro>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Apr 2022 09:32:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbEOBMSUkCRc+0dhRWrzJ1=2UsTLxNm=jW+u8Sc-n7Aw@mail.gmail.com>
Message-ID: <CAHk-=whbEOBMSUkCRc+0dhRWrzJ1=2UsTLxNm=jW+u8Sc-n7Aw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for v5.18
To:     Wolfram Sang <wsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Sat, Apr 16, 2022 at 8:01 PM Wolfram Sang <wsa@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

Can I ask for signed tags, please?

I've pulled this, but I'd be happier if everything I pulled was signed.

                 Linus
