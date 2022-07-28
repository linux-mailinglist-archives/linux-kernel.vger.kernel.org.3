Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC185583FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiG1NKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiG1NKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:10:41 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17E32BBA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659013838;
        bh=i9d4o6t0mhJMAsILy/hKFYjulyc2V0jBY92Uw7RPIbI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B4rECBn32cVv0aeGLiUQ6s/l2IZ1gpYKN8JxTAv/PgTjEPHZqGznbe7ggZHZJuLxE
         5bPQ9O7LG8n7mWCkPZ3Njl0BMBytp8IZ4gG4SY1ItIn9GqDeqfr6FmlP3Vqs4DmoWR
         xe2P50xBtMKuLih+Un/Cb0pmNBr4qjfz5qs/4rNw=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0037066805;
        Thu, 28 Jul 2022 09:10:36 -0400 (EDT)
Message-ID: <615b5bc79c9e48409361bde1af9374cacb06ec9c.camel@xry111.site>
Subject: Re: [PATCH v2 3/4] LoongArch: Stop using undocumented assembler
 options
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Thu, 28 Jul 2022 21:10:34 +0800
In-Reply-To: <CAAhV-H5nuP2xYREtZuJnq3Sr+JpVbOzLDw+N1ep5yFSUd1+nFQ@mail.gmail.com>
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
         <e95cfe70e2e5faa5b9cdc9452bdb3ab8d664aff0.camel@xry111.site>
         <CAAhV-H5nuP2xYREtZuJnq3Sr+JpVbOzLDw+N1ep5yFSUd1+nFQ@mail.gmail.com>
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

On Thu, 2022-07-28 at 20:25 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Thu, Jul 28, 2022 at 8:03 PM Xi Ruoyao <xry111@xry111.site> wrote:
> >=20
> > Now we can handle GOT and GOT-based relocations properly, remove the
> > undocumented `-Wa,-mla-{global,local}-with-{pcrel,abs}` assembler
> > hacks.
> I think "-Wa,-mla-{global,local}-with-{pcrel,abs}" may be regular
> options rather than "hacks". If I'm right, the title and commit
> message should be updated. And we can send patches to binutils to make
> them "documented".

How about changing the message to:

   GCC 13 no longer generates la.global and la.local in assembly, but
   produces explicit PC-relative relocations to local symbols and GOT
   entries for global symbols instead.  As the result, -Wa,-mla-* are no
   longer sufficient to control the code generation for symbol address
   loading.  As now we can handle GOT and GOT-based relocations
   properly, remove those options to use GOT for global symbol address
   consistently.
