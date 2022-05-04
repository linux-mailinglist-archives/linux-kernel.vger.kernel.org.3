Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1966251AEC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbiEDUOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbiEDUOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:14:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1827A2714F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:10:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l19so3071853ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0/hKmkvb5BoU0+UFK3i+vBfCGj7h/+eV5+6M1+ExZM=;
        b=OzBXWUbjQ+080MWC14jdCnBvwXL5uDnkzacs7MfgTd/OEo/P0xDEmgLRYvFfLeTaQx
         JCb2df+pPiKnY5JtAeaEC8UDsr9bOvUNWpODCHqcjIQi993kY6I7kPmVvju01wuAsTcG
         +NgW70KB4OMXFfc8QJi6r5l0fzPSUGCZdartU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0/hKmkvb5BoU0+UFK3i+vBfCGj7h/+eV5+6M1+ExZM=;
        b=n9Uxn4eFuWCprJYfDTzOuJBzMqXk3CyjCk6qDh3zudZTVayVqSKEMKno6IFZOZoYNp
         sHl033gPDgM8Q0dvwui4zamBiglF6uBuSK1e7UK2Zvp1DGJgX3NjAW64WVigwF5AU+CH
         Xtu/soSm3W4gxElY75KMAZKwS2/MQcfQTLx9NA2u9RyiFiRC4qcuaWnNkheu3X7e+PG1
         w+619bYihqAa50NlUWNuiHqUXougQ3IZBmvbvhi01SqeLCYkyH0hbpuGgZI0wHNVKjtC
         76D6pw9vARkTRLslvlBPZA2xXW8OEN2TDKBqthPyB+b1GXZTlGm4HmgQ3peB7E76Mbn1
         k9Uw==
X-Gm-Message-State: AOAM531LRCLwMxHamxI8bOOQ9x+mRsD8Mn3HiG2QgcBivssP2PPX3ZXE
        sKdFcc7UamOAzVv3uly5bS0KyvC2C8lAxDnWBqk=
X-Google-Smtp-Source: ABdhPJx+zNSRmQlZSvCRLCJr8SGgVM8y0R6M1wrM63y6NeHnI+RB/zIUhRfqJD0qQW1Nd95Ee/NyZg==
X-Received: by 2002:a05:651c:513:b0:250:5d51:46d3 with SMTP id o19-20020a05651c051300b002505d5146d3mr7810150ljp.429.1651695021036;
        Wed, 04 May 2022 13:10:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25299000000b0047255d211b6sm1290639lfm.229.2022.05.04.13.10.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 13:10:20 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y19so3081453ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:10:20 -0700 (PDT)
X-Received: by 2002:a2e:914d:0:b0:24f:6374:3eba with SMTP id
 q13-20020a2e914d000000b0024f63743ebamr10017408ljg.506.1651695019712; Wed, 04
 May 2022 13:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com> <CAAfxs77yaLvWx9KnkDZX7E1eDm9N-NVJn5n8=mCK9BU-cSob=A@mail.gmail.com>
In-Reply-To: <CAAfxs77yaLvWx9KnkDZX7E1eDm9N-NVJn5n8=mCK9BU-cSob=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 13:10:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLRo-6PbhbvMUDojbMo=L+2jc5VpCYTyF-LGxZPhUngA@mail.gmail.com>
Message-ID: <CAHk-=wjLRo-6PbhbvMUDojbMo=L+2jc5VpCYTyF-LGxZPhUngA@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     Stafford Horne <shorne@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
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

On Wed, May 4, 2022 at 12:58 PM Stafford Horne <shorne@gmail.com> wrote:
>
> I have uploaded a diff I created here:
>   https://gist.github.com/54334556f2907104cd12374872a0597c
>
> It shows the same output.

In hex_to_bin itself it seems to only be a difference due to some
register allocation (r19 and r3 switched around).

But then it gets inlined into hex2bin and there changes there seem to
be about instruction and basic block scheduling, so it's a lot harder
to see what's going on.

And a lot of constant changes, which honestly look just like code code
moved around by 16 bytes and offsets changed due to that.

So I doubt it's hex_to_bin() that is causing problems, I think it's
purely code movement. Which explains why adding a nop or a fake printk
fixes things.

Some alignment assumption that got broken?

               Linus
