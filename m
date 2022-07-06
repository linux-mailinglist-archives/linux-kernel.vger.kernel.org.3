Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5440568F75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiGFQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiGFQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:43:31 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600CEAA;
        Wed,  6 Jul 2022 09:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 266Ggp781236933
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 6 Jul 2022 09:42:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 266Ggp781236933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1657125775;
        bh=zQoEvTxnDh6zWBd1c1ezKVw870QaKisAdMJsMEZ0XiI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=uod/87KmlxnlFtaMoLSH+a3zy87aEMycqPjViqWSmbrvXTDJePOvAvh4NdfmXjyOo
         /nZjEuDksvqEeMFeyvv3nNTJaLGMHrWkIQZOgcNcM3isnB2T3CVCzQYI731tr8Huo6
         7H2oEO54ACpyb6iUmo0L2mcfUpp9aQvoLhDCxBbnm5v+FW3EtXCUH3XJpeWQHzzhV/
         eulgCmnqbY02rNDoS+WZNu79Fosli2i61lGLIGLfx3DdGltUdPqnFp6O9bBcgBWMam
         2PXfzTFX5aQgK0eGmJfiwxbYGBVaUAWny3Ktqh+1F919S48/9ocINv7En1vi36fb0T
         n+NARfx8eOcGg==
Date:   Wed, 06 Jul 2022 09:42:49 -0700
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
In-Reply-To: <YsV+w77z8iSM7dJQ@zn.tnic>
References: <20220705190121.293703-1-Jason@zx2c4.com> <YsSStCQQf008hF2F@zn.tnic> <YsSUkapje04MP2a1@zx2c4.com> <YsSXkNBtB6Ciy9iN@zn.tnic> <11C903CC-22A7-48EE-AD63-E71CC8D28B88@zytor.com> <YsS0ZLQw+QFA7XdJ@zn.tnic> <805B66CB-D847-4547-B6EE-C4FB72B75765@zytor.com> <YsV+w77z8iSM7dJQ@zn.tnic>
Message-ID: <0A608F00-CDC0-494E-AC57-69BA0E3F547F@zytor.com>
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

On July 6, 2022 5:23:31 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Jul 05, 2022 at 04:11:45PM -0700, H=2E Peter Anvin wrote:
>> What I'm wondering is if we shouldn't be simply instrument *every*
>> invocation, and set the trust to zero if we ever trip it=2E
>
>I guess you can add some logic to rdrand_long() to sanity-check what it
>returns=2E=2E=2E
>
>But would that be worth the effort?
>

I think doing it centrally, as non-arch-specific code, and letting it subs=
ume ad hoc checks for known failure conditions could be a win=2E
