Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078C59E7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiHWQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245755AbiHWQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:49:26 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8DC128448
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:17:08 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-334dc616f86so377996947b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FTs5W/CsbRtqh/vi77RbH8WiK86F7dlns571CuGae0w=;
        b=QlDaspLdb9+BWzybPcHwBLL62/TeGED5WKU1iAfY060Z02rugnl0yYuoUiFi0uDWZz
         a5tl+tfml+dBuLz+bTRTjh8ZjhYHEXvxi++9nA1WMW/rfGMspc9BHS3Eu8je4DUWxT08
         60NB0UaEPc1ie28UKA+5DDT0e9usEzoCxIz/C1Ime/bm4Gnd09grip2rRXWasIztFePk
         irEvlW1PvBq1wfJq60mnGiPh17QcGMW8ngi1/LuyiqgUKU8SoC3yyWOFOIedD62HPNba
         vnX5r/YN2pN/FQ5XxFckcfvyt5KlvNaAvwh55jDN0jRihBR1jvBQWx/TuHbuz9LwmZ6V
         YKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FTs5W/CsbRtqh/vi77RbH8WiK86F7dlns571CuGae0w=;
        b=Le9+Nk2lSTxXx8MoUisvm64n2WIl6fAvKtGAZF0Qzlqy5a8YK/DRh86q+k/l+evFZ+
         jHrDKd8sFIWwa/GtebikdaJ1FUx4sow3fOMUgAm8MANGdmUseqbV9HRjyu72tI5DGUEe
         pU6QmTmvKlU5BQb68TPB+26O/U8GQ4xu0dlUCe4i6MH9bBhFFckzdbdmdDF7ku7Nl8Vn
         Chc9Hxmu0iurbyc4vww5d3QsRF7FX3mwK3A387B0bK9Inp/gvFeoBVh8g10fJi5rQEjM
         PWSGDQV/Rn+jp92B7JWcWI57mHv6CQOv1EIjgKoJNtJ9O+o/zaktceISiPuLsPbGljX6
         SQwA==
X-Gm-Message-State: ACgBeo2OxZNpRRZN/sTr88V6OlH6HRh+r66v3AWzDV61ToybYbjBpTbw
        97ZToLgbbYQxdio1TxFkbqoL5W1HBoHIgnKkbct9RA==
X-Google-Smtp-Source: AA6agR56wu7Il9bBNGqKJMHGme0hQw//Mh3YW9l/6XS4CTlFOhieFb23Gk/f2IzAAspaApiM8T9wR22GEypFP/lfYKs=
X-Received: by 2002:a0d:cc0f:0:b0:334:c52e:83c4 with SMTP id
 o15-20020a0dcc0f000000b00334c52e83c4mr24731437ywd.324.1661260627245; Tue, 23
 Aug 2022 06:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-7-kirill.shutemov@linux.intel.com> <CAG_fn=VnedgJL62cL2bvjsp1yrxc_ngbtRPoLXhY9JsJJhz+2w@mail.gmail.com>
In-Reply-To: <CAG_fn=VnedgJL62cL2bvjsp1yrxc_ngbtRPoLXhY9JsJJhz+2w@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 23 Aug 2022 15:16:30 +0200
Message-ID: <CAG_fn=XZEo00mBLUFzxMVEf0eKajkaDWj-ry3na_n5dzC_P_AA@mail.gmail.com>
Subject: Re: [PATCHv6 06/11] x86/mm: Provide arch_prctl() interface for LAM
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Aug 22, 2022 at 11:32 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 6:15 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Add a couple of arch_prctl() handles:
> >
> >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
> >    of tag bits. It is rounded up to the nearest LAM mode that can
> >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> >
> >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> >    bits located in the address.
> >
> >  - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
> >    Zero if LAM is not supported.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
And also:

Tested-by: Alexander Potapenko <glider@google.com>
