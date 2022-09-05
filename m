Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40685ADA55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIEUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:40:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6C5C9E1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:40:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a15so6915735qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0ypgvZx184oYWrPx4/BvTiSUQeZ6xUOF0aM/4U4hfak=;
        b=Hw2xlQvvPezvVyxfPxdnOm6BVP0INvcJBZ80TdNzoTEFHZDDFcSIpu5mI87YXUvb00
         bT20dOT9Km+rhURvLSflJTYCoiT9EAfi2/ghDXo5X1PDfVMC9xTJXYERAtpd+x5b2VSa
         UnxSC/OhKcpcKcgnm2ojkTibqmvNalxK13+BksspjBIknC50aBz/6gfPPYes2Cts56DZ
         s/b3lhRRM5tSrtLWQTBW1CHGggv0ZdaXnBJ+WzQKGPpk9/jD+KKST3Yp6WMORX6+eYtn
         2BGeQ7Kf9RlrKnAD5Tb8BAOuoB+wwEnxlhkian0jpgYU3xPvaG+hp3FE8+eHCNN7mYkd
         6AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0ypgvZx184oYWrPx4/BvTiSUQeZ6xUOF0aM/4U4hfak=;
        b=3qksho/mhYJu6DfJyLLyiQw/dVcog7j0pffbwkZJdiEk7K23wuazUo+u2Pn6SRKBU1
         ZaLvllxS5V1i2i04x37k5wDxMeAO5YxlSfvdt5kYuA6xm3OZ8LLTJ2F+kTlcTN2Xe3mV
         jl6MWxuTxesqXoCQRuV177SwhpsseTDBOY7whcPolIpYfSFfwBeaY066aas5trUAL1T5
         CAC/gWzKeRd0qK35BSm1AlgmWzMsvxgL9leVbWNSYM6utpuuAh3pRez94ph/IbRcsOi4
         4mpduNRGBmYO3L4ZY1syzYRu66Pd/5ot/X/uLHpKEl7gmqJ/9ikoj4G/g7zo7kfkKIYb
         UMGw==
X-Gm-Message-State: ACgBeo0jjky/XRkJvB+csNc33ZVMTho4JBvowkeP0rIdkVMivt8eaPcb
        sGKysdAExCoge/lmw6mUn7vjIVFm8Fm2Hkv2bdA=
X-Google-Smtp-Source: AA6agR4VoTTQ9yAD7gDLrY+LwJ/yPs0WqHPudFH1zKDeMLs5RG5Kx8s8lYckgN3uyI8O8eQ348FRTTug0GJCd7/56xg=
X-Received: by 2002:a05:620a:843:b0:6be:86a8:4099 with SMTP id
 u3-20020a05620a084300b006be86a84099mr28516707qku.386.1662410429360; Mon, 05
 Sep 2022 13:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658189199.git.andreyknvl@google.com> <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
 <CANpmjNMrwXxU0YCwvHo59RFDkoxA-MtdrRCSPoRW+KYG2ez-NQ@mail.gmail.com>
 <CA+fCnZcT2iXww90CfiByAvr58XHXShiER0x0J2v14hRzNNFe9w@mail.gmail.com>
 <CA+fCnZfU5AwAbei9NqtN+FstGLJYkRe7cZrYZN1wtcGbPkqVZQ@mail.gmail.com> <CANpmjNPk13ib57zFzL1rmWiuhZVvS4bmD-yfoMJOYVWT1FdynQ@mail.gmail.com>
In-Reply-To: <CANpmjNPk13ib57zFzL1rmWiuhZVvS4bmD-yfoMJOYVWT1FdynQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Sep 2022 22:40:18 +0200
Message-ID: <CA+fCnZcGM9_H4LJAKj0QSKQ3qX-vF=V_rL_C8xVmaTvW15c6iw@mail.gmail.com>
Subject: Re: [PATCH mm v2 30/33] kasan: implement stack ring for tag-based modes
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 10:29 PM Marco Elver <elver@google.com> wrote:
>
> > Does your "The rest looks fine now" comment refer only to this patch
> > or to the whole series? If it's the former, could you PTAL at the
> > other patches?
>
> I just looked again. Apart from the comments I just sent, overall it
> looks fine (whole series).

Great, thanks! I'll put your Reviewed-by on all patches except the
ones I will change in v3.

> Does test_kasan exercise the ring wrapping around? One thing that
> might be worth doing is adding a multi-threaded stress test, where you
> have 2+ threads doing lots of allocations, frees, and generating
> reports.

There's probably not a lot of sense in adding this test: this part is
tested during kernel boot. Even with defconfig, the stack ring
overflows multiple times.

I will, however, add a test for a complicated use-after-free scenario
to make sure that KASAN points at the right kmalloc/kfree calls.
Before I get to implementing [1], the report contents will have to be
checked manually though.

Thanks!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212203
