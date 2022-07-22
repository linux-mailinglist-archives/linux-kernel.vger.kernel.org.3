Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43257E456
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiGVQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGVQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:28:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4B904DA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:28:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l23so9465868ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dd7o9NBeDh2R1TLf2E06wU4FmDlwMriYkeqayOgdQg=;
        b=On14FoAtGfENETFC+Oeapfn/2P5WZvzYW3nri40gW4AmLkhFI+Cx/SgaB/M64Vy4wy
         W4wkNi66d0EKN6lqu/ILa3UGQXa8rAutUOe6riL92TMQsyUEWWDr5XsdVklQqrlBgEPx
         bk0UWslW/CblGSDaXd5DJQYCqFUGG+0bXu+hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dd7o9NBeDh2R1TLf2E06wU4FmDlwMriYkeqayOgdQg=;
        b=6qOABskGgY9+hvVFf/2m74yNZnUyQDfQbW56QhEZy+Z1HWEz1By7ZqFFq0BKQSXD7z
         0REEKcyEn0wyPLGkUPozUFcfCTs7V3fBzsboWAvPRK1rVLFRLOInBT/Mv0xJvJ+4O7T4
         SZXmE0HkEKY+a8S0XE2MP+5MfXEVVG2VuG87NFMRDc4PJP3WVVyOiAm9Z1gBBGAya6gj
         BZZBrp6mnESM0ZsInb5kZ8R2dLBRtvW7Mfe2N2JJy1inzCnFRflP3r7rI4pa9R+Axmbg
         H2Ex/woN69zWXlvdO+1jWt5ecUtxIJXfzVXacwvtG1S53pscCrKK9F6sxXqd+50dXEn0
         9m4Q==
X-Gm-Message-State: AJIora8Ob/OpEouKbHhRPI75Gq9WcXvJZ/hQXAnlDSdTtJWQ6gTG4GJJ
        9kYN2eKldcK2T1jq6pfYxeLPFGL7GpjO/n68Ids=
X-Google-Smtp-Source: AGRyM1vd/vJj8nvg28r2+cnzcShQ5pwHaeTklO1cOFsAt5kCJZRbDKL3K6LOpVZi9N+qTWxHQ4l9jQ==
X-Received: by 2002:a17:906:a219:b0:6e4:86a3:44ea with SMTP id r25-20020a170906a21900b006e486a344eamr532177ejy.385.1658507293205;
        Fri, 22 Jul 2022 09:28:13 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id bt8-20020a0564020a4800b0043bba5ed21csm2779469edb.15.2022.07.22.09.28.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:28:12 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id a5so7183300wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:28:11 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr468958wrb.442.1658507291147; Fri, 22
 Jul 2022 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <YtpXh0QHWwaEWVAY@debian>
In-Reply-To: <YtpXh0QHWwaEWVAY@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jul 2022 09:27:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
Message-ID: <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
Subject: Re: mainline build failure due to b67fbebd4cf9 ("mmu_gather: Force
 tlb-flush VM_PFNMAP vmas")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f26f5605e4675143"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f26f5605e4675143
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 22, 2022 at 12:53 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> The latest mainline kernel branch fails to build for alpha allmodconfig
> with the error:

Gaah. It's the odd MMU_GATHER_NO_RANGE architectures - alpha, m68k,
microblaze, nios2 and openrisc.

We should probably get rid of that oddity, and force everybody to have
the ranged tlb flush functions, but for now the trivial patch is to
just remove the left-over dummy tlb_update_vma_flags() from that case,
I think.

Trivial patch attached. I don't have any cross-compiler for those
architectures on my machine, but I suspect I'll just commit it as-is
even without testing, since it can't be worse than what the situation
is right now with that "redefinition of 'tlb_update_vma_flags'"

But if you can verify, that would be lovely.

                    Linus

--000000000000f26f5605e4675143
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l5woep5b0>
X-Attachment-Id: f_l5woep5b0

IGluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmggfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaCBiL2luY2x1
ZGUvYXNtLWdlbmVyaWMvdGxiLmgKaW5kZXggY2IyMTY3Yzg5ZWVlLi40OTJkY2U0MzIzNmUgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgKKysrIGIvaW5jbHVkZS9hc20tZ2Vu
ZXJpYy90bGIuaApAQCAtMzY4LDkgKzM2OCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0bGJfZmx1
c2goc3RydWN0IG1tdV9nYXRoZXIgKnRsYikKIAkJZmx1c2hfdGxiX21tKHRsYi0+bW0pOwogfQog
Ci1zdGF0aWMgaW5saW5lIHZvaWQKLXRsYl91cGRhdGVfdm1hX2ZsYWdzKHN0cnVjdCBtbXVfZ2F0
aGVyICp0bGIsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKSB7IH0KLQogI2Vsc2UgLyogQ09O
RklHX01NVV9HQVRIRVJfTk9fUkFOR0UgKi8KIAogI2lmbmRlZiB0bGJfZmx1c2gK
--000000000000f26f5605e4675143--
