Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141456798B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiGEVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiGEVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:51:26 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36795FC4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 265LoZui985421
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 5 Jul 2022 14:50:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 265LoZui985421
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1657057837;
        bh=7KDE2gFVvMSgPsHGHe9MxJdE6fru6CX4ADvVbzCKtT8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lMkaO2FbzS8H3Ku8woeLDFSXdgUMzhKC15vy7VQdtwYs91XormxkElNRd8Q0jV9i9
         eiuEeplg9WtLAgD8dk0P/U/FI2JDZFmhH/T8n6gsuHuQypPNaaPgdlm8lcT3IA826d
         UzDQl4+77Pv22WQfoIiMSzqQxzQqc1IuTgDtDrtFRoVtuIPrsj1cfJx2OaI3ruVEcd
         ATP70kCNxi2r3ncyjkBZdYQrBeDR5ggdHco/GkfmlGdkVPVp5wGkZcp5fbUDTgWEvA
         6N2BHP8z5Y/b0MLZ6XmVUItrHq/zFjRynAUVqUtBrK9SN/XxO0hSRnfBNnNNBVsgCi
         U/yxv4tY8favw==
Date:   Tue, 05 Jul 2022 14:50:34 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] random: remove CONFIG_ARCH_RANDOM and "nordrand"
User-Agent: K-9 Mail for Android
In-Reply-To: <YsSXkNBtB6Ciy9iN@zn.tnic>
References: <20220705190121.293703-1-Jason@zx2c4.com> <YsSStCQQf008hF2F@zn.tnic> <YsSUkapje04MP2a1@zx2c4.com> <YsSXkNBtB6Ciy9iN@zn.tnic>
Message-ID: <11C903CC-22A7-48EE-AD63-E71CC8D28B88@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 5, 2022 12:57:04 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Jul 05, 2022 at 09:44:17PM +0200, Jason A=2E Donenfeld wrote:
>> Oh, huh=2E Maybe in that case I should adjust the message to say "consi=
der
>> using `random=2Etrust_cpu=3D0`," which is the thing that would actually=
 make
>> a security difference=2E
>
>Why isn't that option documented in
>Documentation/admin-guide/kernel-parameters=2Etxt?
>
>> But actually, one thing that wasn't clear to me was: does `nordrand`
>> affect what userspace sees? While random=2Ec is okay in lots of
>> circumstances, I could imagine `nordrand` playing a role in preventing
>> userspace from using it, which might be desirable=2E Is this the case? =
If
>> so, I can remove the nordrand chunk from this patch for v2=2E If not, I=
'll
>> adjust the text to mention `random=2Etrust_cpu=3D0`=2E
>
>Unfortunately, it doesn't disable the instruction=2E It would be lovely i=
f
>we had a switch like that=2E=2E=2E
>
>That's why this message is supposed to be noisy so that people can pay
>attention at least=2E
>
>> In the sense that random=2Ec can handle mostly any input without making
>> the quality worse=2E So, you can't accidentally taint it=2E The only ri=
sk is
>> if it thinks RDRAND is good and trustable when it isn't, but that's wha=
t
>> `random=2Etrust_cpu=3D0` is for=2E
>
>And that's why I'm saying that if you detect RDRAND returning the
>same thing over and over again, you should simply stop using it=2E
>Automatically=2E Not rely on the user to do anything=2E
>

It's just math=2E The only variable is your confidence level, i=2Ee=2E at =
what level do you decide that the likelihood of pure chance is way smaller =
than the likelihood of hardware failure=2E For example, the likelihood of m=
 n-bit samples in a row being identical is 2^-(n*(m-3/2)), and the likeliho=
od of the CPU being destroyed by a meterorite in the same microsecond is ab=
out 2^-100=2E

