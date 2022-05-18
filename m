Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73152BD51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiERNAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiERNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:00:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BC1115D;
        Wed, 18 May 2022 06:00:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F0A723A;
        Wed, 18 May 2022 06:00:42 -0700 (PDT)
Received: from [10.57.34.214] (unknown [10.57.34.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4134E3F73D;
        Wed, 18 May 2022 06:00:41 -0700 (PDT)
Message-ID: <8f6d8d1f-2872-15b9-d38b-1e8eb26f781b@foss.arm.com>
Date:   Wed, 18 May 2022 14:00:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     ardb@kernel.org
Cc:     davem@davemloft.net, giovanni.cabiddu@intel.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, qat-linux@intel.com,
        yoan.picchi@arm.com, andre.przywara@arm.com
References: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
Reply-To: yoan.picchi@arm.com
Content-Language: en-CA
From:   Yoan Picchi <yoan.picchi@foss.arm.com>
In-Reply-To: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 >> From: Yoan Picchi <yoan.picchi@arm.com>
 >>
 >> The QAT acceleration card can be very helpfull for some tasks like
 >> dealing with IPSEC but it is currently restricted to be used only on 
x86 machine.
 >> Looking at the code we didn't see any reasons why those drivers might
 >> not work on other architectures. We've successfully built all of them
 >> on x86, arm64, arm32, mips64, powerpc64, riscv64 and sparc64.
 >>
 >> We also have tested the driver with an Intel Corporation C62x Chipset
 >> QuickAssist Technology (rev 04) PCIe card on an arm64 server. After
 >> the numa patch, it works with the AF_ALG crypto userland interface,
 >> allowing us to encrypt some data with cbc for instance. We've also
 >> successfully created some VF, bound them to DPDK, and used the card
 >> this way, thus showing some real life usecases of x86 do work on 
arm64 too.
 >>
 >> Please let us know if we missed something that would warrants some
 >> further testing.
 >Thanks Yoan.
 >
 >Can you please confirm that you tested the driver on the platform you 
reported using a kernel with CONFIG_CRYPTO_MANAGER_DISABLE_TESTS not set 
and CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y and the self test >is passing?
 >You can check it by running
 >    $ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | 
sort This should report:
 >    driver       : qat_aes_cbc
 >    driver       : qat_aes_cbc_hmac_sha1
 >    driver       : qat_aes_cbc_hmac_sha256
 >    driver       : qat_aes_cbc_hmac_sha512
 >    driver       : qat_aes_ctr
 >    driver       : qat_aes_xts
 >    driver       : qat-dh
 >    driver       : qat-rsa
 >
 >Note that if you are using the HEAD of cryptodev-2.6 you will have to 
either revert 8893d27ffcaf6ec6267038a177cb87bcde4dd3de or apply
 >https://patchwork.kernel.org/project/linux-crypto/list/?series=639755 
as the algorithms have been temporarily disabled.
 >
 >Regards,
 >
 >--
 >Giovanni

Hi Giovanni.

Thanks for the instructions, I did not know of this test.
I rebuilt my kernel on arm64 with those parameter and I confirm I get 
the same output with
$ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | sort

Kindly,
Yoan

