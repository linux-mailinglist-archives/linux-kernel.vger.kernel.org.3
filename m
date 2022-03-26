Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600B4E847A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiCZVtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiCZVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:49:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8C6266
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:47:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s25so14517865lji.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NX7bAOmY7x0MoLl0kNG0UF4nmV2vnCe33qnopm43zcs=;
        b=U7NMOr062DlW2MKQ75/GkAHDH+7/F80SnVlTJLEWg0OklNDB9vTCcrOaYmlJdeKfkz
         8Jt0XRorb/+1SLb1HYJoeNF/W2OW8AB9hvUohjRgrGg5di5hnwpcjei+SBYBfmNCNl8V
         I1T/I3gSTD+2gZlS0kIkV1fW4gTjeh+X3tgxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NX7bAOmY7x0MoLl0kNG0UF4nmV2vnCe33qnopm43zcs=;
        b=oIBqFUkhtVeU3CuMUi17vyOxVWaH5xX0kuHNU30XLcn5f8cDcPVqXfC6jm/QX4KH1B
         E031ZYhu6yFx9Ft2fIc9P8r+mmNV+dl329txt6MHkh+iNGrQwafNa7hBgqmFc61gGbPo
         ojDaJabtnsfmv3LZ4CuxTGmdtaDIkTOSLHxhDwhUWbZK6603S7gOxY4b+rV5OIIQptUo
         YCyI20XaZm8ITGmuCysi7ljyaQv6LHjV8olN1uiiMojpOMsAotFVAlG1bRxGUDe3WT9g
         h4dUmnyBMc2H3tOOb5k3O3HCXMnbti2+XKXARSHtsZzV0JvXplB1IzbozlH5mF0oh6ug
         1t4w==
X-Gm-Message-State: AOAM531h/5ULHAQ9Jo+Vxufa9zV/fJjcrBWWroBZgnCmhR7hCci6X4Wa
        PUU2L6DbdIt9jpsfxhFg9C5JHymSrYu1qLKv/FY=
X-Google-Smtp-Source: ABdhPJzmFFpq/dauYinX5Azku5se3rvRUNGjeA9LdLXeCu613TqslOcQqfEjI4EPg2IeAqchf8hL0Q==
X-Received: by 2002:a2e:96d9:0:b0:249:8257:74ca with SMTP id d25-20020a2e96d9000000b00249825774camr13762611ljj.105.1648331275192;
        Sat, 26 Mar 2022 14:47:55 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g11-20020ac24d8b000000b0044a3454c858sm1182919lfe.81.2022.03.26.14.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 14:47:54 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q5so14499861ljb.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:47:54 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr54585ljn.358.1648331273760; Sat, 26 Mar
 2022 14:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 14:47:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh20x4=SCahsGyKT5QHRgSWn+mnxppVqZ64LsMh+85tpA@mail.gmail.com>
Message-ID: <CAHk-=wh20x4=SCahsGyKT5QHRgSWn+mnxppVqZ64LsMh+85tpA@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 5.18
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
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

On Wed, Mar 23, 2022 at 2:18 AM Jiri Kosina <jikos@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

I'm going through my merges to check which ones were signed tags and
which ones weren't, and this is on the latter short-list.

So just a note that I'd really like people to use signed tags. Yes,
yes, kernel.org has strict security policies and I don't require them,
but it would still be really nice..

             Linus
