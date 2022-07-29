Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8A584E94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiG2KSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiG2KSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:18:23 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB468DF2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659089900;
        bh=KTD+hOXV53+Vm7VyZi5mdmQmq245NjO2gJj8raifSeA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DVdAy30HDrYidW+ADVQd6MJzvrrCzEbvI22x4+zmfTXOpZNnKdLQWdmU8uSWtA897
         guungx2GvRIt72PjkFVT6Cf2DoiFi5GgCZb4DEmQtZThC7CvsW7XYDzCJeKlTpDok7
         iVGo+lLBtfUpIVsGWLhtio/TC4CAl7j1K+5/UbCE=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id D523866A01;
        Fri, 29 Jul 2022 06:18:18 -0400 (EDT)
Message-ID: <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 18:18:16 +0800
In-Reply-To: <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-29 at 17:49 +0800, Youling Tang wrote:
> Hi, Ruoyao
>=20
> Tested this series of patches v3 on a CLFS 5.5 system, using the new
> cross toolchain,
> $ dmesg | head
> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.19.0-rc7new-toolchain+ (loo=
ngson@linux)
> (loongarch64-unknown-linux-gnu-gcc (GCC) 13.0.0 20220726 (experimental)=
=20
> [master revision=20
> cf7eac5805e:1e0611b64d8:3fb68f2e666d9de7e0326af9f43b12c9e98f19a6], GNU
> ld (GNU Binutils) 2.39.50.20220726) #1 SMP PREEMPT Fri Jul 29 05:24:15
> EDT 2022
>=20
> Relocation error when manually loading nf_tables.ko module,
> $ sudo modprobe nf_tables
> odprobe: ERROR: could not insert 'nf_tables': Exec format error
>=20
> $ dmesg
> [=C2=A0=C2=A0 61.506737] kmod: module nf_tables: PCALA offset =3D 0x90007=
ffffed8c000=20
> does not fit in 32-bit signed and is unsupported by kernel! dangerous=20
> apply_r_larch_pcala_hi20 (71) relocation
>=20
> Do you have the same problem over there?

I can reproduce it with "modprobe x_tables".  Will try to debug...
