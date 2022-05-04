Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11151AE61
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377706AbiEDTzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiEDTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:55:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294864E384
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:52:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p12so4140252lfs.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ruflxs9cgYtfpu+uYRY9OHjS7xb2bTFhKtX7f5MDGy0=;
        b=diBNaFT6RJQyFbUyjS0yj1S62NtDgDQ/oqU4vbBO3+GpjfpqNEy69JLlmTmH19CK0x
         tHpOFu35+fkkKowJQ9Uw2Zkc6+DoiqPCJ6FKhYalmvF+3p43xvtmvaN4BIa5DwkTyjVt
         awUxmk/s7sd/YUL1z68Hl375tvBz/uTcAf4Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ruflxs9cgYtfpu+uYRY9OHjS7xb2bTFhKtX7f5MDGy0=;
        b=Nm2SlOZMu8Kif5IkQBcNi9ZjK/rE+GaR9LV+U0peFob+cEVouuoTSvmPtTQGiJBe7i
         IpUyzk1C1e2AEmTjvTngfzOHflSgavhBMdQg9fDq2wj6iUJsyHtbb8mnguNASW54EUbV
         8KsPclQ/1CgFNt7QKF+I/PYh69FYz9jd+gvU6Hh4JTFRbAmmWe1wp3ElgOLQGGbvCc06
         /jjKX01wPj2I2yfnC2xvsTj36fGnOEw7X5JqW6m/Enfc/84FhEIVqmQO7Dpi3qcjIX+l
         TGCnsWWU36F3FAP2Mezza7l/Kesnh2vP8Eq/WBG9cbPPBjvZ9h0v0KdE4/HgzPTmmj19
         jxVA==
X-Gm-Message-State: AOAM532q10mH5QCFo3jguwaE/Lx+eCNWmYvc5xl9fXt2UsGKVi2mBaAl
        LxJ/puXaLow/BgBfsll1nYttSQhIC8bhp1qyZfc=
X-Google-Smtp-Source: ABdhPJyPpQ8mD4YzpJrmPtnewNWH/2jWJKajT/ByycZ6jXGAb93DwR5Ce5mM9z9p2NlrcEgDDDMgHQ==
X-Received: by 2002:a05:6512:321c:b0:46b:b7fd:1eca with SMTP id d28-20020a056512321c00b0046bb7fd1ecamr15114200lfe.481.1651693928140;
        Wed, 04 May 2022 12:52:08 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u16-20020ac243d0000000b0047255d21116sm1289781lfl.69.2022.05.04.12.52.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 12:52:06 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m23so3045353ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:52:05 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr13338399ljh.152.1651693925440; Wed, 04
 May 2022 12:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com> <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
In-Reply-To: <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 12:51:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaj8SMSQTWAx2cUFqzRWRqBspO5YV=qA8M+QOC2vDorw@mail.gmail.com>
Message-ID: <CAHk-=wiaj8SMSQTWAx2cUFqzRWRqBspO5YV=qA8M+QOC2vDorw@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Stafford Horne <shorne@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 12:43 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> =D7=90.cc is correct. If you can't load it, your browser or something in
> your stack is broken.

It's just google-chrome.

And honestly, the last thing I want to ever see is non-ASCII URL's.

Particularly from a security person. It's a *HORRIBLE* idea with
homoglyphs, and personally I think any browser that refuses to look it
up would be doing the right thing.

But I don't think that it's the browser, actually. Even 'nslookup'
refuses to touch it with

   ** server can't find =D7=90.cc: SERVFAIL

and it seems it's literally the local dns caching (dnsmasq?)

> Choosing a non-ASCII domain like that clearly a
> bad decision because people with broken stacks can't load it?

No. It's a bad idea. Full stop. Don't do it.

               Linus
