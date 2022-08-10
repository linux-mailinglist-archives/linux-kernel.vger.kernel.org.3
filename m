Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F458E8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiHJImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiHJIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:42:41 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BACE13DE7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:42:40 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id F1DD2309210;
        Wed, 10 Aug 2022 10:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660120959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnZEy9foVYLvu3RCIC82eHmY+OjNMagAgcp4aiqsDQ8=;
        b=iyCjAHcyrxF+ZYlCgF2k3qGU2b7o49YprR35iar5QjfyDyeUF+W3vnQ/jetZ4ts1GMplj7
        bKvRkZBWWmTHQjhrCL+1zz/hVUwEnTejmFsYH5ySj5Si/Ougo0SfaGYX+iP+KRbYv+oq6w
        q4PFG/69Nx+tlAxT6hjQf3tzrxDsSKOTpzsI4BrmHEbIkQH/2tHYZYHNSpglDYGZtJEZto
        QMXPB9UYE63mIHEyr64j4wU08Z1n6+g5l2vdMlI4K/3R9DdTQk0lwnfb08jKMejknzJwYW
        9NW0tVcNybwN2R4cJkS+FX9SDUTUV8YfYItu7lVoZcaEch3weLSmh5k8BYZRqw==
Message-ID: <04eee9167a9ad5e5bf9a03db1ede005ae9e3710c.camel@svanheule.net>
Subject: Re: [PATCH v1 0/3] cpumask: UP optimisation fixes follow-up
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 10:42:38 +0200
In-Reply-To: <YvNu0HvXkseAAr7D@yury-laptop>
References: <cover.1660066581.git.sander@svanheule.net>
         <YvM6LjJCMK4ZKrxK@yury-laptop>
         <b723f2a292e92a792df95b912404e8d8e8e5e5f4.camel@svanheule.net>
         <YvNu0HvXkseAAr7D@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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



On Wed, 2022-08-10 at 01:39 -0700, Yury Norov wrote:
> On Wed, Aug 10, 2022 at 10:18:09AM +0200, Sander Vanheule wrote:
> > On Tue, 2022-08-09 at 21:55 -0700, Yury Norov wrote:
> > > On Tue, Aug 09, 2022 at 07:36:32PM +0200, Sander Vanheule wrote:
> > > > As an older version of the UP optimisation fixes was merged, not al=
l
> > > > review feedback has been implemented.=C2=A0 These patches implement=
 the
> > > > feedback received on the merged version [1], and the respin [2], fo=
r
> > > > changes related to include/linux/cpumask.h and lib/cpumask.c.
> > > >=20
> > > > [1] https://lore.kernel.org/lkml/cover.1656777646.git.sander@svanhe=
ule.net/
> > > > [2] https://lore.kernel.org/lkml/cover.1659077534.git.sander@svanhe=
ule.net/
> > > >=20
> > > > Sander Vanheule (3):
> > > > =C2=A0 cpumask: align signatures of UP implementations
> > > > =C2=A0 lib/cpumask: add inline cpumask_next_wrap() for UP
> > > > =C2=A0 lib/cpumask: drop always-true preprocessor guard
> > >=20
> > > Acked-by: Yury Norov <yury.norov@gmail.com>
> > >=20
> > > Applying at bitmap-for-next, after some testing.
> >=20
> > Thanks! Any chance to get this in for 6.0? I would rather avoid buildin=
g cpumask.o only on 6.0,
> > but
> > otherwise I don't think anything is functionally wrong with what is cur=
rently merged.
>=20
> Functionally not, but something is still wrong, right? :)
>=20
> I think -rc2 would be our best option for this, because this series is
> a fix to v4, and because it will let this spend some time in -next.
>=20
> Are you OK with this?

Sounds perfect!

Thanks,
Sander
