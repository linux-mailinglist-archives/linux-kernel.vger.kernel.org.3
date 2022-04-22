Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168E050C008
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiDVSxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiDVSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:53:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595D1FA51
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:46:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so15794357lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gs1lyGDE7+A7xavqOFG1B5XF/uB9DkKS+4Zz/DRp/RQ=;
        b=f9blmSpiCrZ4zmBvGGeHGSBZF8lDA69+NXIVkqHeg2EPAQqUP5e2SrYel1SNJ6vkKy
         vLazn76N9iNNnAv9WWOSz8+OHiQptaq8UdnhYq170F2u6zqQg2U5ElQxjd85O7Nb9gE2
         SFLmyIFXXkFiNRNJEED8FrI0b5Cn2ToNPw9UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gs1lyGDE7+A7xavqOFG1B5XF/uB9DkKS+4Zz/DRp/RQ=;
        b=TbrGRcyXIBfUxJETEwLWYkRe92Q1/11T+psxP5q9JRF8qVxPYytRAWOFWgQdEelWf2
         p1XI9NfkFkWpvSKYkBRdeIYxFHI0LZGMLSB9mft5OrtBHZ9IZzM7mje3wzuAz96PKGTt
         ajmsYDtUefTJ2vNxlWuNBV4gualC9ym/d75QMjFoE5cl9WrxUVuw1/vcEZT2TPM+9HHj
         P1HH7XtgYlDG9iKy/vG45Sx56huPBbv86apSmsmxzLN1cr6QzRB4ve8lZE8DhgoHeW0t
         DreWhqnHuSA1sa71Sz2pxF+34VHb+xapA4q+S+pn82QUY/D227k34G30sfCIbYgwWBCs
         6Ncw==
X-Gm-Message-State: AOAM5300Th8QKKFXYmRUmWc5nn4G/Tz0ycFH2Yzf7DiCSL71SEfUC457
        G0Wr+8TZhfBuEylcAvkWhETxXI71oi45wXqrUPA=
X-Google-Smtp-Source: ABdhPJyucUXXq3XL6Sdx0YACaZcoL+jwg63Y/8ITyKpl9U+1U/ocZ41yJheVF7kaBsEKZ+6KAtIXNA==
X-Received: by 2002:ac2:52b4:0:b0:445:ba75:7513 with SMTP id r20-20020ac252b4000000b00445ba757513mr4029213lfm.248.1650652917186;
        Fri, 22 Apr 2022 11:41:57 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 22-20020a05651c009600b0024db88fff1asm301409ljq.83.2022.04.22.11.41.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 11:41:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id bn33so10684110ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:41:54 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr3579356ljj.358.1650652914703; Fri, 22
 Apr 2022 11:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220422060107.781512-1-npiggin@gmail.com> <20220422060107.781512-3-npiggin@gmail.com>
 <CAHk-=wgFoWLCV9aPHkHe1Mpu0XqxYWaPkKLpe_hcsTS_Vx3aRA@mail.gmail.com>
In-Reply-To: <CAHk-=wgFoWLCV9aPHkHe1Mpu0XqxYWaPkKLpe_hcsTS_Vx3aRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 11:41:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whao=iosX1s5Z4SF-ZGa-ebAukJoAdUJFk5SPwnofV+Vg@mail.gmail.com>
Message-ID: <CAHk-=whao=iosX1s5Z4SF-ZGa-ebAukJoAdUJFk5SPwnofV+Vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP"
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="000000000000a114e105dd429420"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a114e105dd429420
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 22, 2022 at 10:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Just opt-in with the mappings that matter.

Actually, we could automatically opt-in a few common cases that we
know are fundamentally ok, because they already can't play protection
games.

In particular, kvmalloc().

So I think something like this patch - along with Song's patch to
enable it for alloc_large_system_hash() - would be fairly safe, and
avoid any nasty cases.

And probably catch quite a lot of the cases that matter that can grow large.

               Linus

--000000000000a114e105dd429420
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l2ary56k0>
X-Attachment-Id: f_l2ary56k0

IG1tL3V0aWwuYyB8IDExICsrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL3V0aWwuYyBiL21tL3V0aWwuYwpp
bmRleCA1NGU1ZTc2MWE5YTkuLjM0OTJhOWU4MWFhMyAxMDA2NDQKLS0tIGEvbW0vdXRpbC5jCisr
KyBiL21tL3V0aWwuYwpAQCAtNTkyLDggKzU5MiwxNSBAQCB2b2lkICprdm1hbGxvY19ub2RlKHNp
emVfdCBzaXplLCBnZnBfdCBmbGFncywgaW50IG5vZGUpCiAJCXJldHVybiBOVUxMOwogCX0KIAot
CXJldHVybiBfX3ZtYWxsb2Nfbm9kZShzaXplLCAxLCBmbGFncywgbm9kZSwKLQkJCV9fYnVpbHRp
bl9yZXR1cm5fYWRkcmVzcygwKSk7CisJLyoKKwkgKiBrdm1hbGxvYygpIGNhbiBhbHdheXMgdXNl
IFZNX0FMTE9XX0hVR0VfVk1BUCwKKwkgKiBzaW5jZSB0aGUgY2FsbGVycyBhbHJlYWR5IGNhbm5v
dCBhc3N1bWUgYW55dGhpbmcKKwkgKiBhYm91dCB0aGUgcmVzdWx0aW5nIHBvaW50ZXIsIGFuZCBj
YW5ub3QgcGxheQorCSAqIHByb3RlY3Rpb24gZ2FtZXMuCisJICovCisJcmV0dXJuIF9fdm1hbGxv
Y19ub2RlX3JhbmdlKHNpemUsIDEsIFZNQUxMT0NfU1RBUlQsIFZNQUxMT0NfRU5ELAorCQkJZmxh
Z3MsIFBBR0VfS0VSTkVMLCBWTV9BTExPV19IVUdFX1ZNQVAsCisJCQlub2RlLCBfX2J1aWx0aW5f
cmV0dXJuX2FkZHJlc3MoMCkpOwogfQogRVhQT1JUX1NZTUJPTChrdm1hbGxvY19ub2RlKTsKIAo=
--000000000000a114e105dd429420--
