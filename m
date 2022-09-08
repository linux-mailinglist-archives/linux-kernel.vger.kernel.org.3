Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C055B1109
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIHA1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHA13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:27:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB4A6C72
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:27:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MNKhC0m8Vz4xGG;
        Thu,  8 Sep 2022 10:27:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662596844;
        bh=5ove+5VwWAQ5AMLZQbbF24PafDZgzxX6ZGM0226lFkY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IXhfa81v7lWARgyj9MztAPbvgQz9Pn3u0Xdy4UYJ0UAU66a4cUX91jR/A5/cdLCBn
         sVOv/0cFvrcQ5XCgp2qktd6GFd33ErdPhcvYV3iKnKtfRpujukJR5lgZMIp0+cGijU
         8sU1F3/JcsvjEb/GPH7kNqsGsSxoDYIkD2feul2+5dgorxPliCDlyLKAOVSoM+RENw
         pfRtYJr6gO2z7mPT7TUWrchJ9vQe+y07ew6kVNG6MPlJlboc9yYME8QVGZn4p3KHkw
         FSBoZ7ujJj1ry7YldiAbw2vrIoKu/TZWuP6z9p7OlNUHXhGp53H1ZhJyeEOBzph9oM
         uLOwn13/NEl1g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mathieu Malaterre <malat@debian.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/lib/xor_vmx: Relax frame size for clang
In-Reply-To: <7cb1285a-42e6-2b67-664f-7d206bc9fd80@csgroup.eu>
References: <20190621085822.1527-1-malat@debian.org>
 <7cb1285a-42e6-2b67-664f-7d206bc9fd80@csgroup.eu>
Date:   Thu, 08 Sep 2022 10:27:19 +1000
Message-ID: <87v8pyemmw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 21/06/2019 =C3=A0 10:58, Mathieu Malaterre a =C3=A9crit=C2=A0:
>> When building with clang-8 the frame size limit is hit:
>>=20
>>    ../arch/powerpc/lib/xor_vmx.c:119:6: error: stack frame size of 1200 =
bytes in function '__xor_altivec_5' [-Werror,-Wframe-larger-than=3D]
>>=20
>> Follow the same approach as commit 9c87156cce5a ("powerpc/xmon: Relax
>> frame size for clang") until a proper fix is implemented upstream in
>> clang and relax requirement for clang.
>
> With Clang 14 I get the following errors, but only with KASAN selected.
>
>    CC      arch/powerpc/lib/xor_vmx.o
> arch/powerpc/lib/xor_vmx.c:95:6: error: stack frame size (1040) exceeds=20
> limit (1024) in '__xor_altivec_4' [-Werror,-Wframe-larger-than]
> void __xor_altivec_4(unsigned long bytes,
>       ^
> arch/powerpc/lib/xor_vmx.c:124:6: error: stack frame size (1312) exceeds=
=20
> limit (1024) in '__xor_altivec_5' [-Werror,-Wframe-larger-than]
> void __xor_altivec_5(unsigned long bytes,
>       ^

That's a 32-bit build?

> Is this patch still relevant ?

The clang issue was closed because a different change fixed the issue:

  https://github.com/ClangBuiltLinux/linux/issues/563

> Or should frame size be relaxed when KASAN is selected ? After all the=20
> stack size is multiplied by 2 when we have KASAN, so maybe the warning=20
> limit should be increased as well ?

Yeah that would make some sense.

On 64-bit the largest frame in that file is 1424, which is below the
default 2048 byte limit.

So maybe just increase it for 32-bit && KASAN.

What would be nice is if the FRAME_WARN value could be calculated as a
percentage of the THREAD_SHIFT, but that's not easily doable with the
way things are structured in Kconfig.

cheers
