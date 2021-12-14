Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E325474700
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhLNP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhLNP7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:59:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7EC061574;
        Tue, 14 Dec 2021 07:59:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83F66B8182B;
        Tue, 14 Dec 2021 15:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABABC34606;
        Tue, 14 Dec 2021 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639497552;
        bh=LQcpkftWc7lM97ZychQ8tAQB9LvgvXYvek6tydXa4sw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gCIIFPKhP6iRrKLDPH+GLLWjcp4ty7CSjgYxUf7hm3XUNX/ttlby2f/P0oCIjxHBp
         8eM2fSMbpjLW9chnByCZFeJDDUDnHuPoUcAkuMOWLM7v8CqmB2BDs87SQWV7RiDQXu
         awBuIWljOAWF5PnLKtBTMbzzk2bpeVulIHloX5+Zjj2rPkF2erY9Z0kb1DYX6PIcBy
         sUk0SlW0ci5/uxU2aJrJcIgB2TB35kSKHs36gxkVYBT2uVrZMJw5ENT1zhzT49ctX0
         ISRjKVBGSMHj/XZ1HcTx2u00MmFeqcfJ2eQUijs61S4nrE7Z1qJlxcFOAWG1Yg1UfR
         QxFGhBp8RieRw==
Received: by mail-ot1-f45.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so21284649otg.4;
        Tue, 14 Dec 2021 07:59:12 -0800 (PST)
X-Gm-Message-State: AOAM533UCtxCGMkNWMSkX1vQas8WpP3BnOmhEBbXCthecVshtRnztEge
        5Q95+xTnVebkuIDy7z7h8boTb62LgoqKB+HZ93Q=
X-Google-Smtp-Source: ABdhPJwgVPsCb58oAOUUXTKtHks6V8PtpHCkGhdjvRT9oefiwhIshwt6J0Ssjxf8qX/3Q1xSOfvyuJaAqynxCg+QwgA=
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr4927211otp.112.1639497551457;
 Tue, 14 Dec 2021 07:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20210923063027.166247-1-xiaokang.qian@arm.com>
 <YVK1u4BgVAa84fMa@sol.localdomain> <CAMj1kXHeJBUAzcLHRNYDbbUDe5vRS7Bxy_LKF5gdRLJca7TNRQ@mail.gmail.com>
 <20211213182918.GC12405@willie-the-truck> <PA4PR08MB60161CA378726A4D77F39216EE759@PA4PR08MB6016.eurprd08.prod.outlook.com>
In-Reply-To: <PA4PR08MB60161CA378726A4D77F39216EE759@PA4PR08MB6016.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Dec 2021 16:59:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEDJ=c-OkTDOu=5o+ic8LXpWA6R2zMBsngFSpiyGB--Ww@mail.gmail.com>
Message-ID: <CAMj1kXEDJ=c-OkTDOu=5o+ic8LXpWA6R2zMBsngFSpiyGB--Ww@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm64/gcm-ce - unroll factors to 4-way interleave
 of aes and ghash
To:     Xiaokang Qian <Xiaokang.Qian@arm.com>
Cc:     Will Deacon <will@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 at 02:40, Xiaokang Qian <Xiaokang.Qian@arm.com> wrote:
>
> Hi Will:
> I will post the update version 2 of this patch today or tomorrow.
> Sorry for the delay.
>

Great, but please make sure you run the extended test suite.

I applied this version of the patch to test the performance delta
between the old and the new version on TX2, but it hit a failure in
the self test:

[    0.592203] alg: aead: gcm-aes-ce decryption unexpectedly succeeded
on test vector "random: alen=91 plen=5326 authsize=16 klen=32
novrfy=1"; expected_error=-EBADMSG, cfg="random: inplace use_finup
src_divs=[100.0%@+3779] key_offset=43"

It's non-deterministic, though, so it may take a few attempts to reproduce it.

As for the performance delta, your code is 18% slower on TX2 for 1420
byte packets using AES-256 (and 9% slower on AES-192). In your
results, AES-256 does not outperform the old code as much as it does
with smaller key sizes either.

Is this something that can be solved? If not, the numbers are not as
appealing, to be honest, given the substantial performance regressions
on the other micro-architecture.

-- 
Ard.



Tcrypt output follows


OLD CODE

testing speed of gcm(aes) (gcm-aes-ce) encryption
test 0 (128 bit key, 16 byte blocks): 2023626 operations in 1 seconds
(32378016 bytes)
test 1 (128 bit key, 64 byte blocks): 2005175 operations in 1 seconds
(128331200 bytes)
test 2 (128 bit key, 256 byte blocks): 1408367 operations in 1 seconds
(360541952 bytes)
test 3 (128 bit key, 512 byte blocks): 1011877 operations in 1 seconds
(518081024 bytes)
test 4 (128 bit key, 1024 byte blocks): 646552 operations in 1 seconds
(662069248 bytes)
test 5 (128 bit key, 1420 byte blocks): 490188 operations in 1 seconds
(696066960 bytes)
test 6 (128 bit key, 4096 byte blocks): 204423 operations in 1 seconds
(837316608 bytes)
test 7 (128 bit key, 8192 byte blocks): 105149 operations in 1 seconds
(861380608 bytes)
test 8 (192 bit key, 16 byte blocks): 1924506 operations in 1 seconds
(30792096 bytes)
test 9 (192 bit key, 64 byte blocks): 1944413 operations in 1 seconds
(124442432 bytes)
test 10 (192 bit key, 256 byte blocks): 1337001 operations in 1
seconds (342272256 bytes)
test 11 (192 bit key, 512 byte blocks): 941146 operations in 1 seconds
(481866752 bytes)
test 12 (192 bit key, 1024 byte blocks): 590614 operations in 1
seconds (604788736 bytes)
test 13 (192 bit key, 1420 byte blocks): 443363 operations in 1
seconds (629575460 bytes)
test 14 (192 bit key, 4096 byte blocks): 182890 operations in 1
seconds (749117440 bytes)
test 15 (192 bit key, 8192 byte blocks): 93813 operations in 1 seconds
(768516096 bytes)
test 16 (256 bit key, 16 byte blocks): 1886970 operations in 1 seconds
(30191520 bytes)
test 17 (256 bit key, 64 byte blocks): 1893574 operations in 1 seconds
(121188736 bytes)
test 18 (256 bit key, 256 byte blocks): 1245478 operations in 1
seconds (318842368 bytes)
test 19 (256 bit key, 512 byte blocks): 865507 operations in 1 seconds
(443139584 bytes)
test 20 (256 bit key, 1024 byte blocks): 537822 operations in 1
seconds (550729728 bytes)
test 21 (256 bit key, 1420 byte blocks): 401451 operations in 1
seconds (570060420 bytes)
test 22 (256 bit key, 4096 byte blocks): 164378 operations in 1
seconds (673292288 bytes)
test 23 (256 bit key, 8192 byte blocks): 84205 operations in 1 seconds
(689807360 bytes)


NEW CODE

testing speed of gcm(aes) (gcm-aes-ce) encryption
test 0 (128 bit key, 16 byte blocks): 1894587 operations in 1 seconds
(30313392 bytes)
test 1 (128 bit key, 64 byte blocks): 1910971 operations in 1 seconds
(122302144 bytes)
test 2 (128 bit key, 256 byte blocks): 1360037 operations in 1 seconds
(348169472 bytes)
test 3 (128 bit key, 512 byte blocks): 985577 operations in 1 seconds
(504615424 bytes)
test 4 (128 bit key, 1024 byte blocks): 569656 operations in 1 seconds
(583327744 bytes)
test 5 (128 bit key, 1420 byte blocks): 462129 operations in 1 seconds
(656223180 bytes)
test 6 (128 bit key, 4096 byte blocks): 215284 operations in 1 seconds
(881803264 bytes)
test 7 (128 bit key, 8192 byte blocks): 115459 operations in 1 seconds
(945840128 bytes)
test 8 (192 bit key, 16 byte blocks): 1825915 operations in 1 seconds
(29214640 bytes)
test 9 (192 bit key, 64 byte blocks): 1836850 operations in 1 seconds
(117558400 bytes)
test 10 (192 bit key, 256 byte blocks): 1281626 operations in 1
seconds (328096256 bytes)
test 11 (192 bit key, 512 byte blocks): 913114 operations in 1 seconds
(467514368 bytes)
test 12 (192 bit key, 1024 byte blocks): 504804 operations in 1
seconds (516919296 bytes)
test 13 (192 bit key, 1420 byte blocks): 405749 operations in 1
seconds (576163580 bytes)
test 14 (192 bit key, 4096 byte blocks): 183999 operations in 1
seconds (753659904 bytes)
test 15 (192 bit key, 8192 byte blocks): 97914 operations in 1 seconds
(802111488 bytes)
test 16 (256 bit key, 16 byte blocks): 1776659 operations in 1 seconds
(28426544 bytes)
test 17 (256 bit key, 64 byte blocks): 1781110 operations in 1 seconds
(113991040 bytes)
test 18 (256 bit key, 256 byte blocks): 1206511 operations in 1
seconds (308866816 bytes)
test 19 (256 bit key, 512 byte blocks): 846284 operations in 1 seconds
(433297408 bytes)
test 20 (256 bit key, 1024 byte blocks): 424405 operations in 1
seconds (434590720 bytes)
test 21 (256 bit key, 1420 byte blocks): 331558 operations in 1
seconds (470812360 bytes)
test 22 (256 bit key, 4096 byte blocks): 143821 operations in 1
seconds (589090816 bytes)
test 23 (256 bit key, 8192 byte blocks): 75641 operations in 1 seconds
(619651072 bytes)
