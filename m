Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBB5A3E89
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiH1QUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1QUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:20:47 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0EC6451
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661703646;
        bh=MM4kZt3DF3iUsC6WPEgD9Pjm4dL3TvvdfqjeUSZUeuM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mLE9WzxSyCHbCXy4QfBtNAgpy2Qeqm54dnpDUxN19nTigzsxWL3JKZNWpbqU+XMSE
         gf7ZNt3WV1TxAjb+/BRjFdcZZaHmqP4uM/zZWeJUpyQQXexm+G2LY2rGs9LYkBC3Bh
         Uqr7N6K6zE0NLBX9PuVh8BmMdBl/U+v3Uup3qamI=
Received: from [IPv6:240e:358:111c:cf00:dc73:854d:832e:4] (unknown [IPv6:240e:358:111c:cf00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E13EC65AA9;
        Sun, 28 Aug 2022 12:20:41 -0400 (EDT)
Message-ID: <fbbcf45a1f54333e8abfea3c121f37ad56651dbc.camel@xry111.site>
Subject: Re: [PATCH 1/8] LoongArch: Add CONFIG_CC_HAS_EXPLICIT_RELOCS
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Mon, 29 Aug 2022 00:20:37 +0800
In-Reply-To: <CAAhV-H7-MNd9WsnB3r2kxRN7LveixGwQZ=qTVHB_XvW+uU9q4Q@mail.gmail.com>
References: <20220827175436.156464-1-xry111@xry111.site>
         <20220827175436.156464-2-xry111@xry111.site>
         <CAAhV-H7-MNd9WsnB3r2kxRN7LveixGwQZ=qTVHB_XvW+uU9q4Q@mail.gmail.com>
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

On Sun, 2022-08-28 at 22:15 +0800, Huacai Chen wrote:
> > +config CC_HAS_EXPLICIT_RELOCS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def_bool $(cc-option,-mexplicit-r=
elocs) && $(as-
> > instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
> Is it possible that we only change the Makefile and not touch Kconfig?

I guess we can, but if we'll introduce objtool we can

  select HAVE_OBJTOOL if CC_HAS_EXPLICIT_RELOCS

then.=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
