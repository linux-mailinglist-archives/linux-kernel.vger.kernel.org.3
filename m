Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A099056CD97
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGJHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 03:08:00 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B631261E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 00:07:59 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C91812F8519;
        Sun, 10 Jul 2022 09:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1657436878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98eZSVAq1zDGzv3qQXiSN9bWKqJX1e7UtCrshS/cBJw=;
        b=HQuj5cM8WTNUM6V9zh3pHUHOSJr+wlh+UJjuviPbRwC3hGtYYOJ5JJS8mIeO7N74SdYgJ5
        BwDJoJsiZBeRk1Z2ze6wZnb+FwQ1kbhtL7kTltFb9SHJsZxRe98g3DxspPDyHVPwuX6xQA
        rrW5VkA6bZUUdsCbwV1YysYHBVWzlGpeA0I/zw/Ix/kRkywGZB2512xL9jEZZky/2uHa39
        uvF+G6jLNVKqut+vjktzyMeXmbkXjbBZbT7zsTePNh9tT6gfsZWyzYlSJLshgrEIt3fZvr
        h3NcnGVKlD2XJy76bDsfBM3fBEIR16SK5AMr5ZXiJW6Zo4dmAFp76cLcMpND/g==
Message-ID: <54caa91f8b430e03770854d916f6eae27a7d63f9.camel@svanheule.net>
Subject: Re: linux-next: manual merge of the mm tree with the bitmap tree
From:   Sander Vanheule <sander@svanheule.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Sun, 10 Jul 2022 09:07:56 +0200
In-Reply-To: <20220704172609.27ec5d8c@canb.auug.org.au>
References: <20220704165841.1637cfff@canb.auug.org.au>
         <20220704172609.27ec5d8c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, 2022-07-04 at 17:26 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Mon, 4 Jul 2022 16:58:41 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> >=20
> > Today's linux-next merge of the mm tree got a conflict in:
> >=20
> > =C2=A0 include/linux/cpumask.h
> >=20
> > between commits:
> >=20
> > =C2=A0 50e413c31800 ("lib/cpumask: change return types to unsigned")
> > =C2=A0 e32bd0390739 ("lib/cpumask: move one-line wrappers around find_b=
it to the
> > header")
> >=20
> > from the bitmap tree and commits:
> >=20
> > =C2=A0 2b0b9f2665b2 ("cpumask: Fix invalid uniprocessor mask assumption=
")
> > =C2=A0 284d22458843 ("cpumask: update cpumask_next_wrap() signature")
> >=20
> > from the mm tree.
> >=20
> > I fixed it up (I hope, see below) and can carry the fix as necessary. T=
his
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tre=
e
> > is submitted for merging.=C2=A0 You may also want to consider cooperati=
ng
> > with the maintainer of the conflicting tree to minimise any particularl=
y
> > complex conflicts.
>=20

Thanks for solving the conflicts, looks fine to me. I've asked Andrew to re=
order
my patches. The end result for the series should be the same though, and I =
don't
think my patches should require too many changes anymore.

If further merge conflicts arise with Yury's cpumask patches, I'm also fine=
 with
them being run as one series if that would make things easier.

Best,
Sander
