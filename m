Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160A536B13
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 08:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiE1GTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 02:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 02:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556442CE0A;
        Fri, 27 May 2022 23:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA15760ABD;
        Sat, 28 May 2022 06:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B03C34114;
        Sat, 28 May 2022 06:19:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dcxzb1A5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653718750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcatFLxLEDkqwGfbzqMdWU9Nhg9xUpLbAL1L8Q5uIOg=;
        b=Dcxzb1A5hE14Sb1CGI1rDpsRmZPhQlcQUc2AUUR748F/e+dlym6GwlpY1l6d4GugZ0kwAH
        oPp9zpkzlifZeXde3gL/9fQdKghuht6IIvSq65c/AtcGqoPOmUCrto/4Sn61Ur7k5gIeWX
        jEdEceDnRey7EcBRgTlXy0D1+GfBQd0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc6b639f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 28 May 2022 06:19:10 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-30c143c41e5so8686277b3.3;
        Fri, 27 May 2022 23:19:10 -0700 (PDT)
X-Gm-Message-State: AOAM531nG/ztd32s7XBtdMf3i4pRAt1ouq26pRuZx2/2AwZE20xYBbVc
        upxwi9vzXqFfH/73fa3Ey/NSK0cf/adpXkcftOw=
X-Google-Smtp-Source: ABdhPJxdstrbygSzyr3pf79qP3cy6V/OSM7xSmwBrQkFaF1jIhRuYDxTKOu5Z2fYsfa9CoOxUv6GIcQXSVcrTvMoC/U=
X-Received: by 2002:a0d:cd04:0:b0:300:4784:caa3 with SMTP id
 p4-20020a0dcd04000000b003004784caa3mr19109952ywd.231.1653718749409; Fri, 27
 May 2022 23:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Fri, 27 May 2022
 23:19:09 -0700 (PDT)
In-Reply-To: <20220528013318.1621047-1-zhengbin13@huawei.com>
References: <20220528013318.1621047-1-zhengbin13@huawei.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 28 May 2022 08:19:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9rWfUnUmHR5xo_+WdS0Wgv8yXQb+LqAo24XdoQQR4Wn8w@mail.gmail.com>
Message-ID: <CAHmME9rWfUnUmHR5xo_+WdS0Wgv8yXQb+LqAo24XdoQQR4Wn8w@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: curve25519 - Fix build error when
 CRYPTO_MANAGER_DISABLE_TESTS!=y && CRYPTO=m
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        gaochao49@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/22, Zheng Bin <zhengbin13@huawei.com> wrote:
> If CRYPTO_MANAGER_DISABLE_TESTS!=y, CRYPTO=m, bulding fails:
>
> lib/crypto/curve25519-selftest.o: In function `curve25519_selftest':
> curve25519-selftest.c:(.init.text+0x60): undefined reference to
> `__crypto_memneq'
> curve25519-selftest.c:(.init.text+0xec): undefined reference to
> `__crypto_memneq'
> curve25519-selftest.c:(.init.text+0x114): undefined reference to
> `__crypto_memneq'
> curve25519-selftest.c:(.init.text+0x154): undefined reference to
> `__crypto_memneq'
>
> Add depends for CRYPTO_LIB_CURVE25519 to fix this.

In this case, the bug isn't caused by the tests exactly but by the
curve25519.h inline usage here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/crypto/curve25519.h#n43

Probably the solution for this one is to move crypto_memneq into lib/crypto.

Jason
