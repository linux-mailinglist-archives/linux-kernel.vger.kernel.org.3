Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486454E8B45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 02:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiC1Ajc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 20:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiC1Aj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 20:39:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036014ECD5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:37:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e16so22054191lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRo9b3MUkbZre2OxOOlq/WFZn88JngO4mNALahdqLLo=;
        b=LOyMW3j2NDs+H2edr432o6t72bJ9rAAidtE6uQtKka0v04jJxIfLU52bcaFDLDlYM/
         JetNnRKqVZGNI5IDhgLZasSqq5nol47bGRc3ngtiYDkZguPV/FKkhqaz+XAlXyUCnfUj
         hkQqnDJ74mGQw+89wAM/GMeJRvAJS7NceW9Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRo9b3MUkbZre2OxOOlq/WFZn88JngO4mNALahdqLLo=;
        b=Iwnk6e5GTqOCEN95AvEl8Nr5FRym8f/qjMw0y9uUJJo2qJjHdD5ExqxWOqg28PzPHK
         YUvTetgxMLUpPH6vq6crkifYqjuYjzNZNVomeRxkHDzIUMq7L2FpoKi9KECXghw8KKfy
         pQMVL4smA57miGGXHHgTzvLKA3T8vwHbMlY2BCi5CJkfhUaae1ESTt8t7jstpRCQnPIk
         B4K6jU89KtxO9zr0zdNFxmrtsQcs39r2udSuphjtKWpYJCK7Y/xw4tTh9MF+mCaTSywa
         dT0H3CTM/gwmDzxXH/PHnsHwbFOZJg8vYMReDyWRTdVb3y3f3M5jrXVYhXfDVvOt0+C4
         pxqA==
X-Gm-Message-State: AOAM531adJGTRkwCX+7d86DgX0mQKjpipi3/VA6OftgNNp6p+6MJmbNi
        IqKdtHRb/FWI9hNPyUfVN3avYGKVTW2Qog+glYA=
X-Google-Smtp-Source: ABdhPJzf+J9Hd5LBnCJf99NpSG6bBsUw64lKpR3wnE7VOgu8I3gHOXcZdDn3UuOKMOsEKszJlP5kZA==
X-Received: by 2002:a05:6512:3f86:b0:448:9448:5561 with SMTP id x6-20020a0565123f8600b0044894485561mr17419163lfa.489.1648427866059;
        Sun, 27 Mar 2022 17:37:46 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m24-20020a197118000000b00448bb0df9ffsm1488390lfc.140.2022.03.27.17.37.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 17:37:44 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p10so16230128lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:37:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr17468965lfv.52.1648427861326; Sun, 27
 Mar 2022 17:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com> <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
 <20220328013731.017ae3e3.pasic@linux.ibm.com>
In-Reply-To: <20220328013731.017ae3e3.pasic@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 17:37:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whScWZnR_DZ12grwOcH_WnU1hJ_YXFmU5GNqrBkhiKgPQ@mail.gmail.com>
Message-ID: <CAHk-=whScWZnR_DZ12grwOcH_WnU1hJ_YXFmU5GNqrBkhiKgPQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Maxime Bizon <mbizon@freebox.fr>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Olha Cherevyk <olha.cherevyk@gmail.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
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

On Sun, Mar 27, 2022 at 4:37 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
>
> For the record, I believe that the partial revert proposed here
> https://www.spinics.net/lists/linux-wireless/msg222300.html
> would have been a wiser choice, than a complete revert of commit
> aa6f8dcbab47 ("swiotlb: rework "fix info leak with DMA_FROM_DEVICE"").

Yeah, the revert is basically my standard "this doesn't work,
discussion is still ongoing" thing.

I agree that the revert then brought back that DMA_ATTR_SKIP_CPU_SYNC
complexity.

So that part of commit aa6f8dcbab47 was probably all good.

I somehow missed that Oleksandr had a tested-by for that smaller change too.

              Linus
