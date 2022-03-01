Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DA14C96F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiCAUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiCAUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:30:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB2A8ED1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:26:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b9so28877916lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0BgGo1ww1zXMv3icvmdb4s/nVhZf98/LvSTi+5q+FA=;
        b=G8b7GKJySDFW8nC9U9hYJDCHe3mjYX0MquQCoo12l0s+y49L2KB3HN/rflwOcI4KZX
         qXhr/Gp4DBTxALWsrb4zNl3feYAYvp7kuhoILb2i5neimafRo4oVwyo30eaJSe2XCIDr
         /E6qCHHQiT2jIFqGycIQLCLfBWIycJBdP1KNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0BgGo1ww1zXMv3icvmdb4s/nVhZf98/LvSTi+5q+FA=;
        b=THs22Woa96Kg2SeWT5VxjYVQFgen/dErrmADoQ1egQvAXYlPcpeLNV3KZVL0CdqqZw
         3B1uJ83SyXsECeB2PP+btF2/LeHTInkUKNo39Mn0tuHfRHkfkaQ9O2q8UWtW6efGzxSh
         6o3CEH2qhZIzJndjrAoLcTSaa4xbh7l7hnEUxG3cQbtrEl6pGi6xlmNet/cL2w/LE/qz
         3M5mi2NJ5rZ5Xa08bKLCWFWTi/zrwdBs4e/X+7IBTrkubpeaSNRYRdvINbrhA2US0V9Q
         ut2GlNoG2VXoTCjwHhXSVeIPtVcNqT0QFzvNZkbws7b+8dCZDQsNzSKnF6DeGaDGmRMG
         jD1A==
X-Gm-Message-State: AOAM533HMsvSN9RBdyhl2s5fY+6Z2PnzBSAKGUj+pPIv+yxkiHM3l89h
        d+xqhenMXhHMFHW1R0pMauYLN1fYKXGkuXLn6Ho=
X-Google-Smtp-Source: ABdhPJzdmOv5AvGHShFBBgMS+Y4kFtSLZjJx+u2TfooXckbYooEPRR3Ip4v84v+zq+bhzf/e4fNobw==
X-Received: by 2002:ac2:5f84:0:b0:445:b86d:d0ea with SMTP id r4-20020ac25f84000000b00445b86dd0eamr855729lfe.386.1646166394588;
        Tue, 01 Mar 2022 12:26:34 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x23-20020a056512047700b00445474c4b05sm1654884lfd.173.2022.03.01.12.26.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:26:34 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id y24so4431303ljh.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:26:33 -0800 (PST)
X-Received: by 2002:a2e:aa1f:0:b0:244:c2ea:7f20 with SMTP id
 bf31-20020a2eaa1f000000b00244c2ea7f20mr18290380ljb.164.1646166393330; Tue, 01
 Mar 2022 12:26:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
 <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
 <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
 <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
 <CANiq72k_PUBPVL1Fx4HLm_WO66RuSsi0oSsKRhssCYRNGbY84Q@mail.gmail.com>
 <dc52af7ebc044c94337e138f6e1ae807559b4825.camel@tugraz.at> <CANiq72mcuXDRM-xMDPuL7uDLUfXDhARTBJJsVj4fnR15T1v=TA@mail.gmail.com>
In-Reply-To: <CANiq72mcuXDRM-xMDPuL7uDLUfXDhARTBJJsVj4fnR15T1v=TA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 12:26:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+sjd8FT_FeJ2UOU2Ti7ws1i7hDweAW2gp8a-JpO-Tbg@mail.gmail.com>
Message-ID: <CAHk-=wi+sjd8FT_FeJ2UOU2Ti7ws1i7hDweAW2gp8a-JpO-Tbg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Martin Uecker <uecker@tugraz.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 5:50 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> But making it non-UB in the standard does not force a project to
> consider it "not an error", which is what actually matters for being
> able to use UBSan effectively or not.

Absolutely.

I think people should treat UBsan and friends a bit like "runtime lint".

"lint" traditionally doesn't necessarily check for just *incorrect* C.

It checks for things that can be confusing to humans, even if they are
100% completely conforming standard C.

Classic example: indentation. Having the wrong indentation is not in
any shape of form "undefined behavior" from a C standpoint, but it
sure is something that makes sense checking for anyway.

I think "integer overflow" should be considered the exact same thing.
It should *not* be treated as "undefined behavior", and it should not
give the compiler the option to generate code that doesn't match what
the programmer wrote.

But having a checking tool that says "This looks wrong - you just had
an integer overflow"? THAT makes 100% sense.

The C standard rules "undefined behavior" really is a problem in the standard.

                     Linus
