Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D125A7C00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiHaLJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHaLJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:09:54 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF510E0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661944191;
        bh=8XbdqaONtZ7pmuAJ5DQX8N6I8PArVUZF81z1ZRwruLg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eFRdaJVMKl8xAVHztJPif52LbxIx1i2fOFYxYXqKWIUc83IH/cQAlxpsVhJvrBuP9
         G4nvJxSj2uorsllgHVjC2mmEU7RSZVIqtMWGsm+RQYYoXXzJ2l4J5ZZp0l/3IJ/yAj
         rvtQrHZXd4UjqWnf0g6hL/riObYm6p5JVSkytoOk=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C6D8766841;
        Wed, 31 Aug 2022 07:09:49 -0400 (EDT)
Message-ID: <eb77b42f8ec4b67c1554dfac4a8efdfd8a4168c6.camel@xry111.site>
Subject: Re: [PATCH 1/1] LoongArch: Fixed loongarch kernel csr_xxx implicit
 declaration.
From:   Xi Ruoyao <xry111@xry111.site>
To:     =?gb2312?Q?=C0=EE=D3=EE=C5=F4?= <liyupeng@zbhlos.com>
Cc:     chenhuacai <chenhuacai@kernel.org>, kernel <kernel@xen0n.name>,
        "jiaxun.yang" <jiaxun.yang@flygoat.com>,
        loongarch <loongarch@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        caizp2008 <caizp2008@163.com>
Date:   Wed, 31 Aug 2022 19:09:47 +0800
In-Reply-To: <AGcAvgDYFKf5CnvlznsCy4ok.3.1661932466929.Hmail.liyupeng@zbhlos.com>
References: <feb773a8df5d30b8d9347d1c922997c9da1fd06a.camel@xry111.site>
         <AGcAvgDYFKf5CnvlznsCy4ok.3.1661932466929.Hmail.liyupeng@zbhlos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 15:54 +0800, =E6=9D=8E=E5=AE=87=E9=B9=8F wrote:
>=20
> thank you for your reply=E3=80=82
> I used the latest gcc tool on the official website of loongson,gcc-
> 8.3.0.
> http://www.loongnix.cn/zh/toolchain/GNU/

Vanilla kernel cannot work with Loongnix:

1. In Loongnix, GRUB loads pass the essential information to the kernel
following "Loongson Firmware-Kernel Interface Specification".  Vanilla
kernel does not support it and will never support it.
2. In Loongnix, the syscall numbers are different and the layout of some
data structures used in kernel UAPI is different.  Any Loongnix
application invoking a syscall will likely blow up immediately on a
vanilla kernel.

These two problems are very difficult.  There is some plan to insert
compatibility layers to work around them, but not even one line of code
has been written AFAIK.

So if you want to build a kernel for Loongnix, don't use the vanilla
kernel.  If you just want to build a vanilla kernel with a pre-built
cross toolchain, use the toolchain from
https://kernel.org/pub/tools/crosstool/.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
