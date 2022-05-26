Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161F2534ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbiEZHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346399AbiEZHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B490980B5;
        Thu, 26 May 2022 00:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983BB619E3;
        Thu, 26 May 2022 07:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626BAC34119;
        Thu, 26 May 2022 07:30:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l5rXPhz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653550209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGNFSmd6UrNW5vLx94/KkA0heJuASamss4LkwJ+bkwQ=;
        b=l5rXPhz6nYlRAGrEEzjEiydqvlaxZhGlIihE9IHYZAwG1Dx+b+NtNmq0R2doKtmfU6F224
        IgioY7gn2vwO59492BkK1pgin15Lfzb2yC5bmwpSUlgk+crt5z3toyOBWhOjBJR8z9DSsp
        quGuhgDlvhBtyETKkxXsXUbkT1Cpua8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f27947a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 26 May 2022 07:30:09 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id y141so1497683ybe.13;
        Thu, 26 May 2022 00:30:08 -0700 (PDT)
X-Gm-Message-State: AOAM533ZFmVpK1DSHZxsfkyoqC3gtcQ8shtUelnY4S/FPkTEYR7qWyl8
        vXTkQzyhjpHZSZJj0Yym7T6OFhKW6vgGg09ayec=
X-Google-Smtp-Source: ABdhPJymXqBTlJEClVs2/eq7c6txZCBqc6dXaMm7YKIKaZBH9G6H9sY27qyh2cZG53ruLYnWJ96S/HtHB8Km7gYjL1s=
X-Received: by 2002:a25:7901:0:b0:64a:a1d9:43dd with SMTP id
 u1-20020a257901000000b0064aa1d943ddmr34064533ybc.271.1653550206257; Thu, 26
 May 2022 00:30:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Thu, 26 May 2022
 00:30:05 -0700 (PDT)
In-Reply-To: <Yo8rUkE1/hxum6gt@sol.localdomain>
References: <20220517033630.1182-1-gaochao49@huawei.com> <Yo8rUkE1/hxum6gt@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 26 May 2022 09:30:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9paRqTOT_fWHyeiDufWBcb2dc-M3sMQZaGduwjhsV4kjQ@mail.gmail.com>
Message-ID: <CAHmME9paRqTOT_fWHyeiDufWBcb2dc-M3sMQZaGduwjhsV4kjQ@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: Fix build error when CRYPTO_BLAKE2S_X86=m
 && CRYPTO_ALGAPI2=m && CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     gaochao <gaochao49@huawei.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Eric,

Thanks for CCing me into this.

On 5/26/22, Eric Biggers <ebiggers@kernel.org> wrote:
> How about just making CRYPTO_MANAGER_EXTRA_TESTS depend on CRYPTO_ALGAPI=y?

I think this would definitely be the best option, and probably best
represents what somebody debugging / running tests has in mind.

I can send a patch for this today if you'd like.

Jason
