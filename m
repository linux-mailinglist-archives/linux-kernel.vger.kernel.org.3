Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDA513857
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbiD1Pbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349182AbiD1Pbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:31:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F81B6D1A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:28:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b5so2208944ile.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zmt/HybSZxPjdQpw7T2VvzfrhcZdhwr2P1u1idPPwIg=;
        b=Z/o1bp8J2CxNyPkfD0bNdMwfrKTJnVGI67o0Z9ewpEphoFQw+7EW3TivV3VyVy4Oz8
         togmpB1Regk1FPiIV7+JowaLfnnyq5N3jIgRpAFVsiseEdDeiDDeQWHvHBC1azbgk5ns
         sQ/eaHxlG2HmON9b56GZlmSxShfbaTCLqtfNB7lDF3Vyt9rGnZT9id5KB/h4II7lIRD/
         9ykEfNFVLpneu98OCUZAaj1cuqnl5/gkAPveztMGbCU9dvZ12T5hQ4bGiF8gdE9d9Pfx
         BJvcYyFGAPGNLBpbgYc9hxc0aOqSD86ZammNwSrpvuOLGPaSu9McS1USYxOTC0fOLFII
         gG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zmt/HybSZxPjdQpw7T2VvzfrhcZdhwr2P1u1idPPwIg=;
        b=cYM3SAqhXIw3wvKoTAazNCQ3nDgx2IF3yT+fSuzAMIzMPifSMAeYps206F1ExVVw51
         1Ig/T2uEPz2dtPRywzSdoYKHuEu2GSz/biUtQJIoRtKbToGOe1/1d3xmosyvgrmBaUeQ
         64gt7AQtsLtM5TYK37CczyxGmpKlHKn4C0oP/F5XpQ/ddKuskVFiPi+918kPgcj+9c5Z
         cwV+PCfmdeZ157oOuq7QuTdpG4Zwm9dfgT1mK4XcVTkspVTnKFZWc8PcYlqqcZY5GbYK
         p1gebdGi3MIuVJz170mhqQkyGzY2b7M9rQLxO7Wmh7sY20Me3fYoDIzHOkd56tz6zdyu
         KkJQ==
X-Gm-Message-State: AOAM532i4zwZEUREEaioRFZHH/2/d7+4b6Vam9EMwG6FEbB0vYYtCCI3
        WwbGtNz8b4jIIhK1+MdcjZxw2Wn0E3c0F4ljTlE=
X-Google-Smtp-Source: ABdhPJxIPrkF6NzQcPEXDMSZur47G8DsAopKIrUaKCtty7W9Kcf/BYPRfK4/pLE3eCaEMd1EsdgOkA4I8pagW17K2Pg=
X-Received: by 2002:a05:6e02:1c24:b0:2cd:96ad:8b8a with SMTP id
 m4-20020a056e021c2400b002cd96ad8b8amr8162420ilh.235.1651159703117; Thu, 28
 Apr 2022 08:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1643047180.git.andreyknvl@google.com> <20220428141356.GB71@qian>
In-Reply-To: <20220428141356.GB71@qian>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 28 Apr 2022 17:28:12 +0200
Message-ID: <CA+fCnZesRG_WLi2fEHtG=oNLt2oJ7RrZuwuCm_rQDPZLoZr-3g@mail.gmail.com>
Subject: Re: [PATCH v6 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 4:14 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> > SW_TAGS vmalloc tagging support is straightforward. It reuses all of
> > the generic KASAN machinery, but uses shadow memory to store tags
> > instead of magic values. Naturally, vmalloc tagging requires adding
> > a few kasan_reset_tag() annotations to the vmalloc code.
>
> I could use some help here. Ever since this series, our system starts to
> trigger bad page state bugs from time to time. Any thoughts?
>
>  BUG: Bad page state in process systemd-udevd  pfn:83ffffcd
>  page:fffffc20fdfff340 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x83ffffcd
>  flags: 0xbfffc0000001000(reserved|node=0|zone=2|lastcpupid=0xffff)
>  raw: 0bfffc0000001000 fffffc20fdfff348 fffffc20fdfff348 0000000000000000
>  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>  page_owner info is not present (never set?)

Hi Qian,

No ideas so far.

Looks like the page has reserved tag set when it's being freed.

Does this crash only happen with the SW_TAGS mode?

Does this crash only happen when loading modules?

Does your system have any hot-plugged memory?

Thanks!
