Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB757889E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiGRRkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiGRRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:40:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DED248D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:39:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i14so22170711yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QSlcDSCxlZGcTMOiekNXhcAWY0zL73OCKnEnPAkYA8=;
        b=iISCVsANHbfhrOhsm+kukh5DAnsfNo4J8I4Ont1ZwLvXUJ7gx7zzdJ2n3TEnyUf7A/
         7LDnajzeIB2s+7Um1eeAh/i2Y8yFrji2Y7fPHtX8wf4Dkjh/43+gZWcHCyq95qVyr9hx
         HG/F4+Ohqi9uyPRnfUTcyS+2vZd+bL/gz4D03lSLomKQzRwy2VFv5pHm5vELs2VYRCun
         +XGfzGPMDj3XTFU1nbQoPvz2Yv/2IT0xJi1u/HJ9zW4awqCrxnvF2QYGPB/tHbQDbc1/
         SE6spqd3o9U0fTV9NM7CiVjtoppRRKefJ06w//WEDmzdDq7OaVM16oU0rStve5ai0YXU
         3B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QSlcDSCxlZGcTMOiekNXhcAWY0zL73OCKnEnPAkYA8=;
        b=3IHJeFD4lLckNLi0P7qsu+/wREVS263/mg0YYgcZTL6YUqv8/z1uyqg+h7wW0qEDfq
         qnnc05DRqfYIZf6hZos4X2/VdULUO3vb66EpBG83GYHjv5AxvmFPIVzW3j/b7ldZSxfl
         /gksPv31Mhcqf/LT+itCvuk5Qc9YygIIp42pnmDMslfZRBczQjKAv9hqAQ8EH42/QCRz
         ZrqWGZzlO5DodWC7TVS7lypfGR/K2FU56MG41C+EDlZJhtATPky1DPOQo8t0GOoT2KwR
         oCn8MD5918xg2qFJo9m6OxhHK1zCvdoywnVP0G9gVPWGAyVBcRc8us6zK1gOE7eGU5+5
         xXWw==
X-Gm-Message-State: AJIora98QC+3upkT0Smdfm2qmIMM7jKqFjQ2brbFd1EeQmZDwJDrrUiy
        +BWWzUgkcZwUSA+P6OIY6401QMNdzifOqUKqFERXOA==
X-Google-Smtp-Source: AGRyM1vV/bBcSPgDuXWjyYgoxUCR/wDJIcC7hW/FP0qx+/ZQz7D8lkglc65iqZGpPKusaPzX6bc9k+WeBtegqtRQSm8=
X-Received: by 2002:a25:6847:0:b0:66e:b676:834c with SMTP id
 d68-20020a256847000000b0066eb676834cmr28349753ybc.5.1658165998681; Mon, 18
 Jul 2022 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jul 2022 19:39:22 +0200
Message-ID: <CAG_fn=WR3s3UMh76+bibN0nUpZk9AS_M18=oxP+pc_vtqKt34A@mail.gmail.com>
Subject: Re: [PATCHv5 00/13] Linear Address Masking enabling
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The patchset brings support for LAM for userspace addresses.
>
> LAM_U48 enabling is controversial since it competes for bits with
> 5-level paging. Its enabling isolated into an optional last patch that
> can be applied at maintainer's discretion.

I believe having optional patches will put unnecessary burden on
distro maintainers.
Soon after landing U48 support other changes will start piling on top
of it, and it will be impossible to maintain a kernel with this patch
removed.
It also won't make any difference for the upstream, where this patch
will be always present.

We'd better decide now whether we need U48 or not, and either keep it
or delete it.
