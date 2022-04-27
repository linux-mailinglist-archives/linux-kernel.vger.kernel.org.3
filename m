Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788EA511DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbiD0Ru4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiD0Ruu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:50:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D59944A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:47:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x33so4485410lfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCDyVJYCpFQImgtQWb5hjJokeHveyyypu0o328met1M=;
        b=bX0kfr9ZKjmeVebBzzle/1Y0lDXA3NfuBVKuDcUwqe1WBFhgB7r7/yboqLx3/q7q16
         gMArz3ke2tONs167vKwStCJkd27HOkgX4g/fRP6CcpZ4LiNB/ShaMKlhUcDKSWGi/sta
         Z5ao+qL0GzQxXj+9/B/q5VGt4MlcBLT/5xKqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCDyVJYCpFQImgtQWb5hjJokeHveyyypu0o328met1M=;
        b=zwHItFDxU8VN7DbqoIf30T2hM9K5kQmkMoW4DVvRKO628mYDuKf54kfrjoM2+pNx3n
         XqljDGsXijf6xf49OLQKMDeFlARYyqepjdCEDA9Ut/N/qgn9F3tHMqAdSe7e53qJjouJ
         wbSRn/n3wq1LepezcLdee5ps+FI1JjR8rk8R1mORluag9R66PyFzv4jhB8rX+15Vqjls
         AuJaqd6lwdYxxUPi8Xb7TFAUUJKDofATO/r2lltW55aNHWXeUDPY/0Xa5JsH9OGQeIw0
         6OM4Ja4QtaDf9XiVUGGeA8gxdSiXBZznyOb09qVPvsEgj0ytUXzWiEQEVl0Rigkfesg/
         axkA==
X-Gm-Message-State: AOAM532KtLNikmq3VjsAqVGCvgs56wsdp2SeUyvPvpoxZuUqM3TwWJAm
        W8lmv2zjIFWCSaIZKVHY9yABUksAqPRJYgvz3ZA=
X-Google-Smtp-Source: ABdhPJzQY76r+jaHQic85P9TsQYL49RV2xP8jOuzDJNw9+R7An2WSjgWujL8nWGP8wM4reuN/QXGxA==
X-Received: by 2002:a05:6512:10c5:b0:471:924f:1eed with SMTP id k5-20020a05651210c500b00471924f1eedmr21334753lfg.641.1651081656061;
        Wed, 27 Apr 2022 10:47:36 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b16-20020a196710000000b00471a47b13f3sm2117720lfc.255.2022.04.27.10.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 10:47:34 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 4so3609939ljw.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:47:33 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr18519334ljh.152.1651081653043; Wed, 27
 Apr 2022 10:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net>
In-Reply-To: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 10:47:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
Message-ID: <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
Subject: Re: NTFS3 driver is orphan already. What we do?
To:     Kari Argillander <kari.argillander@stargateuniverse.net>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sad state of affairs mostly edited out ]

On Tue, Apr 26, 2022 at 2:22 AM Kari Argillander
<kari.argillander@stargateuniverse.net> wrote:
>
> I also did suggest that I could co maintain this driver to take burden from
> Konstantin, but haven't got any replay.

If you are willing to maintain it (and maybe find other like-minded
people to help you), I think that would certainly be a thing to try.

And if we can find *nobody* that ends up caring and maintaining, then
I guess we should remove it, rather than end up with *two* effectively
unmaintained copies of NTFS drivers.

Not that two unmaintained filesystems are much worse than one :-p

           Linus
