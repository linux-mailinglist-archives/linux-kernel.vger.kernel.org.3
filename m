Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECD583C97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiG1K5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiG1K5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:57:18 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E395C949
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659005833;
        bh=21Nfveu2ixaCZpF9J8Q8GYT3B0poeT4atOOmQ/hmP5s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bmTP22yWKXXdQoWhFRM23hIUecw7tphRF2bmCs+uE/Pgv3YnrgGvJQgVJvr1awSU0
         Ow9b/OQobTNk3VtXzkkJ7PdhoQCCp9QKFdWAs95xIxAFeYOrlOeL4mFfS/VXrju71l
         +ckxVSq90iEjSGOj7x6103x3E8sVm8sLVV+1bZ4g=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 9D40B667D6;
        Thu, 28 Jul 2022 06:57:12 -0400 (EDT)
Message-ID: <73f83b51eaf40ff1f173059e1f187182db47a1c6.camel@xry111.site>
Subject: Re: [PATCH 3/5] LoongArch: Support relocation against
 _GLOBAL_OFFSET_TABLE_
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 18:57:10 +0800
In-Reply-To: <caf8ec4b-f74d-e6ef-17f2-9e899d41b3a9@loongson.cn>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
         <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
         <10c1e0f9-8409-a0f4-9b18-a5f56dfb14e1@loongson.cn>
         <9a79a424a11339ae025539c38fe121104ff00804.camel@xry111.site>
         <caf8ec4b-f74d-e6ef-17f2-9e899d41b3a9@loongson.cn>
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

On Thu, 2022-07-28 at 17:14 +0800, Jinyang He wrote:
> Not sure but maybe re-align is needed here.
> Since '{BYTE(0)}' actually use 1byte. _GLOABL_OFFSET_TABLE_ may have
> difference with really GOT table entry. Have no machine and without=20
> test... :-(

BYTE(0) is only for preventing the linker from removing the section.=20
All we want from the linker is a slot for .got in the section table, and
the actual property (including size) will be filled at runtime by
module_frob_arch_sections.  The first GOT entry won't be "appended"
after one byte, it is wrote into the start of .got (at runtime).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
