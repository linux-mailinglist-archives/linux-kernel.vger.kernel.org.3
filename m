Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7201B51B076
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiEDV2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiEDV21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:28:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7424EF62
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:24:49 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q130so3291687ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjGyI9MSGnU0qCNLMFpaviA7GndbKZ2IDx6hLyctHX4=;
        b=Hnh4NwCji3pL4qgEEYR/rp2EGQirIJ6TndAv3gfwVZ/JGytdR+O9QCKDEHVhGtvIFF
         9aRffXNypP8dkToBapQXAOdfXKU9mZIa3VfxkZr2nxb/u8IQj1Frzb2oFZRJ285d1XCi
         +bh+/hBYCHPvKxUswkWHNbsX+17jJWjNy8VKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjGyI9MSGnU0qCNLMFpaviA7GndbKZ2IDx6hLyctHX4=;
        b=s8/snZ8Ie9o9ZJaqWltHGs0394681GWnYMacJrTojIKmiYouHIzNiCvEJnhE7x5OAs
         3y2dKfJfXJvNbEiYP4LQuGobqVYlnELy5MVYeZT/1pof14YjBexEAyMCQnIiCqQLFV3L
         Gcbxf/XXc4j0pjWPem0pBjtHCNDY3nKZfp1woXeWGRFvegodaHH9M3cBu8dubVNFk2iQ
         Y/YQygLviU2RN/kXu9QwliCC2A6Qwovkk75b5xf7UASC0vqmryy/2UghEalm+UEDU30O
         zTXiW9Ntln7wmE2jeRVqD4K3EHJEv5W/I2PJ0+Hl6FZh+zjPHF2Aj7nvrONAlvr5kK1v
         +Xyw==
X-Gm-Message-State: AOAM531bZR6g5d9fBWYQS1JOPU5bm7MmbPna2Z7FIrpyTkRJtj+7N8Xm
        a/9uvOytZwLV2R097ANdinpVj1NkPsZGs6iqIHs=
X-Google-Smtp-Source: ABdhPJyWftAw9oV6aCm4cL0OGoI7Q6DVep8l2ifLv5EXanFNCzHova/jglbCJ5LTtoi3AXbkJUqFoQ==
X-Received: by 2002:a2e:93c8:0:b0:24e:eabd:bf6e with SMTP id p8-20020a2e93c8000000b0024eeabdbf6emr13268114ljh.347.1651699487685;
        Wed, 04 May 2022 14:24:47 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512390a00b0047255d211d2sm1307013lfu.257.2022.05.04.14.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:24:46 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id l19so3287227ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:24:45 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr13958171ljj.358.1651699485493; Wed, 04
 May 2022 14:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
 <CAHk-=wiaj8SMSQTWAx2cUFqzRWRqBspO5YV=qA8M+QOC2vDorw@mail.gmail.com>
 <CAHk-=witNAEG7rRsbxD0-4mxhtijRT8fwSc3QCi5HN1sR=0YcA@mail.gmail.com>
 <YnLeH7kBImX5XLNn@antec> <CAHk-=wj5UXrsLz3GzYWLaU1b=_dRQWqj1ZC-buf6MHmLrJF_Og@mail.gmail.com>
In-Reply-To: <CAHk-=wj5UXrsLz3GzYWLaU1b=_dRQWqj1ZC-buf6MHmLrJF_Og@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 14:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKEbppgxafYchqQ6X_VFa0d_vdtVmfqGQC6kQ+Hg9cAw@mail.gmail.com>
Message-ID: <CAHk-=wgKEbppgxafYchqQ6X_VFa0d_vdtVmfqGQC6kQ+Hg9cAw@mail.gmail.com>
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

On Wed, May 4, 2022 at 1:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Could be anywhere. Xfinity, Nest WiFi, or the cable router. They all
> are doing their own dns thing.
>
> Probably my cable box, since it's likely the oldest thing in the chain.

No, it seems to be my Nest WiFi router. I told it to use google DNS to
avoid Xfinity or the cable box, and it still shows the same behavior.

Not that I care much, since I consider those IDN names to be dangerous
anyway, but I think it would have been less sad if it had been some
old cable modem.

               Linus
