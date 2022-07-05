Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC2567A93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGEXM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiGEXM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:12:27 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C518654D;
        Tue,  5 Jul 2022 16:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 265NBnGE1003711
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 5 Jul 2022 16:11:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 265NBnGE1003711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1657062712;
        bh=Y98dqt5En+kS/P/7IMzby9wcUq/7fVTjOsj4m2LkPGI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=KoHiZKsEicJF3HWW8BYUbNDtijdyk2YC30lpGok5A71WKH5jN4kSF+1k/ILd0x9By
         qt8xe3MS+M3LxdPaft1n7lcyMixtVdJ5SQYbrobuHAXvXZD91dHJDhsiyrj0xX6oEB
         UzBMdQKEXifwQOtQj+6um92/xSJJMJAJk/eweAx0I6RYNd0HPoR17l0lZTdhk7AUif
         NSyyZN5L500jyETF72C6IrByv8jv42HDJSrxzOzuSo6byDKD6nExbO6sf5LLBoXwBl
         hJl0pswjsA5H80PdAU7gimYJT6uwlh8+RWtIOHDI250cjEOA3EOFzWqjhIcySx1ZiD
         mZSs9tkVChZvA==
Date:   Tue, 05 Jul 2022 16:11:45 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel@lists.infradead.org,
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
In-Reply-To: <YsS0ZLQw+QFA7XdJ@zn.tnic>
References: <20220705190121.293703-1-Jason@zx2c4.com> <YsSStCQQf008hF2F@zn.tnic> <YsSUkapje04MP2a1@zx2c4.com> <YsSXkNBtB6Ciy9iN@zn.tnic> <11C903CC-22A7-48EE-AD63-E71CC8D28B88@zytor.com> <YsS0ZLQw+QFA7XdJ@zn.tnic>
Message-ID: <805B66CB-D847-4547-B6EE-C4FB72B75765@zytor.com>
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

On July 5, 2022 3:00:04 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Jul 05, 2022 at 02:50:34PM -0700, H=2E Peter Anvin wrote:
>> It's just math=2E The only variable is your confidence level, i=2Ee=2E =
at
>> what level do you decide that the likelihood of pure chance is way
>> smaller than the likelihood of hardware failure=2E
>
>That might be but the likelyhood of certain BIOSes dropping the ball
>after resume is 100%:
>
>7879fc4bdc75 ("x86/rdrand: Sanity-check RDRAND output")
>

What I'm wondering is if we shouldn't be simply instrument *every* invocat=
ion, and set the trust to zero if we ever trip it=2E
