Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E051AF07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378014AbiEDUaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357166AbiEDUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:30:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B044F9E6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:26:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p12so4273974lfs.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmrVv14fPgXxwEi6qY3BXXY+CxBqDRKooA9FDuaSqV8=;
        b=DQgRC/EIfbWTO7QipnFt6qsWGushz/ykabQ4BikNPsBniuH7tmy2HqjGaM/O/TTfjR
         PeGmWoUZNVKcciqEeK9HLq+1xzjRzJpGjJ1eJXH5UuI8k7WRVZLn9WO5h3h+CUyKYLq9
         8CDVmr9R33re1VR4CQcJV26FFK5+hmaku/Sdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmrVv14fPgXxwEi6qY3BXXY+CxBqDRKooA9FDuaSqV8=;
        b=gCBaDYqtfdjsJ7oglh+rxWu5lEGn+bRXyJLjd4LcuYjHS6VL8wS+9hKrmUdK0BQV7E
         zlA9Zz4whel09CZY1H0e9h706e19lM0KCK9qzaMYCnM/mCGB1f6NEj0QcXc38E8L1Lg/
         nXgccmGFq/kcOciv73bfu/jUtQcc6dJfBEFjN/k7xXM3Qi+TWFv4A06EqbiDSkdVdWpA
         cR4uG3+dTVy3dG/LriUfWcTljQrA7H9t26lJc6qtuGYw+cx0hmZkh10O6F2+8PEwcbrL
         oSM0PBOFfOFzlc5cNM+hVFQj4KruoGqBU8R25HBD0uTiqbytJjRgS7DKd+H5snfnEt2+
         TYJg==
X-Gm-Message-State: AOAM532kx6ppne8JGED3d13svefiHNpO/tl5OIVO1HePRq+kkZLCFQSI
        nDB+SN3N/DMuY/PDs31QQKG0hWKQYqa555/g3Ts=
X-Google-Smtp-Source: ABdhPJxG9l4q23vjsBZqfh3GEQhWHIgBFHMm9vslv/eC1vbRamzu4oxOsntA2qELq0s954JIqrn3pw==
X-Received: by 2002:a19:fc0e:0:b0:471:ff7d:ab35 with SMTP id a14-20020a19fc0e000000b00471ff7dab35mr15247444lfi.345.1651695984569;
        Wed, 04 May 2022 13:26:24 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b0047255d211f7sm1291235lfc.294.2022.05.04.13.26.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 13:26:23 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w1so4277953lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:26:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr15722106lfv.27.1651695982340; Wed, 04
 May 2022 13:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
 <CAHk-=wiaj8SMSQTWAx2cUFqzRWRqBspO5YV=qA8M+QOC2vDorw@mail.gmail.com>
 <CAHk-=witNAEG7rRsbxD0-4mxhtijRT8fwSc3QCi5HN1sR=0YcA@mail.gmail.com> <YnLeH7kBImX5XLNn@antec>
In-Reply-To: <YnLeH7kBImX5XLNn@antec>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 13:26:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5UXrsLz3GzYWLaU1b=_dRQWqj1ZC-buf6MHmLrJF_Og@mail.gmail.com>
Message-ID: <CAHk-=wj5UXrsLz3GzYWLaU1b=_dRQWqj1ZC-buf6MHmLrJF_Og@mail.gmail.com>
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

On Wed, May 4, 2022 at 1:12 PM Stafford Horne <shorne@gmail.com> wrote:
>
> Which version of Fedora?

F35 here.

But looking further, it's not dnsmasq either. Yes, dnsmasq is built
with no-i18n, but as mentioned IDN2 does seem to be enabled, so I
think it's just "no i18n messages".

It seems to be the upstream dns server.

Using 8.8.8.8 explicitly makes it work for me, and that obviously
bypasses not just the local dns cache, but also the next dns server
hop.

Could be anywhere. Xfinity, Nest WiFi, or the cable router. They all
are doing their own dns thing.

Probably my cable box, since it's likely the oldest thing in the chain.

                Linus
