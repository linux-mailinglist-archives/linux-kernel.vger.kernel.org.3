Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF359F15A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiHXCQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHXCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:16:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE45E313
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:16:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z2so20278599edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3+hdlF3hB3h/pHIzH0+yZJG6pH4XDSypdwQb2JyeSz8=;
        b=PevKA+8gHurXl3ranYVDTKlmYi1h/l/iZAM5MKwf2JUzUeUpAPMWROM846a/iBmGY6
         3LiFEXjKsguJwAyru/3SBBmZasG718v0El42mcwq9kNYjEXK8VlHz11Bav+S71MFrk76
         OzWoYKNB3z7eDZYV68FHK/4adgvAF+ReBkExY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3+hdlF3hB3h/pHIzH0+yZJG6pH4XDSypdwQb2JyeSz8=;
        b=y/2ciNd2YPPBmKnkg8pMIfchJePL9/Lw911ucEV0oCBs30Nm+nG0mirxQYyZP9AQrk
         +14CusLMQzojk/2I2SNnB/WJJ0/VioiQxB1OokoEZdRSA/Zsl1ZBDz20AUw9Y9uEJZaK
         Io7YxsUchVgXc8DD4+Bnol30h8s3doy0y0PMWknEDEyTP4ZEoErxVBFpqxNiMxXSpFQ4
         MlLHUZixG1qacMcU1tyG1v/Ejdve1rvBotRGAguEMIuz6ZuFWwWLhfCvA6g/AB9f9tIn
         xX6mvkbx6IClhcaIE8a196own+vzwda7K7rzXKcK3iqyYz8+8G4N33suOHU+zAgDgTMC
         0FcA==
X-Gm-Message-State: ACgBeo2BqkEaN5bOOdiHmznqbFcfDrg7mXsOX2ELu4DtuuicA42xmMnQ
        hjYgcbGYmw3ZbTdvd58o6+wJXGG9rppc3g9+
X-Google-Smtp-Source: AA6agR7nkWT7ha7EYu5y7iJwrfCtm32RSeK7Q47XodF1Y5TlECai3YMrPo4NRL8cccLmrXA7TixvLg==
X-Received: by 2002:a50:fc17:0:b0:446:861b:ee10 with SMTP id i23-20020a50fc17000000b00446861bee10mr5994478edr.251.1661307390849;
        Tue, 23 Aug 2022 19:16:30 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b0073c37199b86sm534260ejb.159.2022.08.23.19.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 19:16:30 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u14so19032131wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:16:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr13917274wri.442.1661307389420; Tue, 23
 Aug 2022 19:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com> <YwWIQ/3BDQHOiTek@ZenIV>
In-Reply-To: <YwWIQ/3BDQHOiTek@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 19:16:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjskbRYLW9MdSbiumhs4stYY_evRvdSkaHKtrf3mqpF7g@mail.gmail.com>
Message-ID: <CAHk-=wjskbRYLW9MdSbiumhs4stYY_evRvdSkaHKtrf3mqpF7g@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 7:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'll take a look, but there's an unrelated problem:
>         ANY ordered comparisons should spew warnings on bitwise

In the general case, absolutely.

But we have two special values that are the same in any bit ordering:
-1 and 0 (all bits set and no bits set). And yes, my patch verifies
that.

See commit 18f17cde ("allow restricted ordered compares with
unrestricted values") in that same tree.

That said, even those are strictly speaking only well-defined in
*unsigned* compares, so I guess we should add that - if you have a
*signed* bitwise thing, even those aren't well-defined to compare
against.

Now, I don't think signed bitwise types make much sense, and I
certainly hope we don't have them in the kernel, but yes, it is
probably worth adding that check too.

Of course, that check then depends on getting the signedness right for
bitwise types, which is exactly the problem I wanted you to look at ;)

                  Linus
