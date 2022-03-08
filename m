Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485D4D15EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiCHLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbiCHLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:12:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E847562
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:11:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCXhf24X2z4xvN;
        Tue,  8 Mar 2022 22:11:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646737906;
        bh=iOnNOIqgLPTazq0S8O+41ZSz/Qp62x8qyJNjvWgvGLc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EEwodP8VRsJMZ4ffsI9EmVSQOs8C3WFFNy4JpJ6ZToIS0d6cxIC1Czn6mE6bo0br8
         arsIVqYL/xPOLwfAB7vNYXmexnJdv8b/68+doGciVv8nwb/zURT2fuW4gP3SP0Vee+
         Vpc4xOU9bKu9WdHhvT9gCzs2sj96SOVW3FPUfoGoBu6nYn8NpmL2D+tJxD7gysi8of
         NVzPZaNTWijzxT5IYegCP7NxggqUHAQ6IvOb4HPbNbieTHP6eExQsFmWMwfvmZf/Jz
         CaT1h8vA4elOL7fHFbFd771g/6/6oqC9JzXXrjx3Wv7Cu5gjDxu1MfGqB7gHggdUqI
         u6c4eutuIm0tA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1 1/4] powerpc: Cleanup asm-prototypes.c
In-Reply-To: <d8a91ad9-328f-d0cb-1112-7ddccd8873d4@csgroup.eu>
References: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
 <d8a91ad9-328f-d0cb-1112-7ddccd8873d4@csgroup.eu>
Date:   Tue, 08 Mar 2022 22:11:45 +1100
Message-ID: <87y21kn1fy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 04/03/2022 =C3=A0 18:04, Christophe Leroy a =C3=A9crit=C2=A0:
>> Last call to sys_swapcontext() from ASM was removed by
>> commit fbcee2ebe8ed ("powerpc/32: Always save non volatile GPRs at
>> syscall entry")
>>=20
>> sys_debug_setcontext() prototype not needed anymore since
>> commit f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch
>> to SYSCALL_DEFINE")
>>=20
>> sys_switch_endian() prototype not needed anymore since
>> commit 81dac8177862 ("powerpc/64: Make sys_switch_endian() traceable")
>>=20
>> _mount() prototype is already in asm/ftrace.h
>>=20
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>
> I see this series in next-test branch.
>
> Can you #include <asm/ftrace.h> in asm/asm-prototypes.h so that=20
> _mcount() still gets versionned.

I just left the existing _mcount() prototype in asm-prototypes.h.

I've run that through some build tests, and want to push it for
tomorrow's next, so I'd rather not change it now.

Send me a follow-up patch to add the include of ftrace.h and drop the
_mcount() prototype.

cheers
