Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4020F584FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiG2LpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiG2LpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:45:18 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22131CB21
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659095111;
        bh=H8GNgBXKqA2DTQwH2JxXCeNpjsYFe/n4yg8c9Eu2la4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iB/7gdkVmEHsdQBBdvRH8dt+fLQzhg9QcCqMt2e0FShZcL+mnxkdbKS2+BXc0HiGV
         pdzZLYvgwDZWhYdNoldSRAXv6Ws4ANRCc9ZHHBlUXy9Sd2tyjBlHSrq/QPVw+I7cqp
         Gz73AwCyu2Lm7EL07IxivrZbwrnVjQgE4Q9TAi1o=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3F632667DC;
        Fri, 29 Jul 2022 07:45:09 -0400 (EDT)
Message-ID: <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>,
        Lulu Cheng <chenglulu@loongson.cn>
Date:   Fri, 29 Jul 2022 19:45:07 +0800
In-Reply-To: <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
         <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
         <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
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

On Fri, 2022-07-29 at 18:36 +0800, Xi Ruoyao wrote:

> The relocation against local percpu variable is broken up.=C2=A0 I'll try
> to fix it.

Hmm... The problem is the "addresses" of per-cpu symbols are faked: they
are actually offsets from $r21.  So we can't just load such an offset
with PCALA addressing.

It looks like we'll need to introduce an attribute for GCC to make an=20
variable "must be addressed via GOT", and add the attribute into
PER_CPU_ATTRIBUTES.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
