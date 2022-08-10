Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936358E897
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHJITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiHJIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:18:59 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6483F3E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:18:57 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 02A623091F0;
        Wed, 10 Aug 2022 10:18:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660119536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+yQnLCiG0jbS71swkosyqiQn3pRJn0UQmrAJLLbqmM=;
        b=nTGYPE8IrWGhX/uSDFJkX4dYFjLwq03PZD/ZishAH69GDXWKpgzY15rKvIXqMaPesYrZ1Q
        hAzgLnfe+P1wXvABrWMiDUi6LzVS1JdeTjTPdi82S6xwveFhZ0lZ4NBwJ467fRJT7xxn19
        bUXFq4NpR1WZ5cfGI2hSCeTQqIiTaLAwe63OYFWupV1vhz6MzXXxWl6GdFQxYt8DW6BhIy
        VvNpZmeLYnZ9KISAllBvAWZ3xdNjb35c10ZeLI3iskKrA4ByedYU1Dl65beykfjgP//fNs
        84P8aBo8HneIBjLDOUfvYDLj1xjRmN653KymZ9Eu/19yZ1GGZc640DQw7ElBVQ==
Message-ID: <5640838e86add62f7e4bd811391fcc60b7ee42b1.camel@svanheule.net>
Subject: Re: [PATCH v1 1/5] lib/test_cpumask: drop cpu_possible_mask full
 test
From:   Sander Vanheule <sander@svanheule.net>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 10:18:55 +0200
In-Reply-To: <15acd7ab-e624-b2ee-cde5-100b69cf7206@riseup.net>
References: <cover.1660068429.git.sander@svanheule.net>
         <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
         <15acd7ab-e624-b2ee-cde5-100b69cf7206@riseup.net>
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

Hi Ma=C3=ADra,

On Tue, 2022-08-09 at 19:26 -0300, Ma=C3=ADra Canal wrote:
> On 8/9/22 15:08, Sander Vanheule wrote:
> > cpu_possible_mask is not necessarily completely filled.=C2=A0 That mean=
s
> > running a check on cpumask_full() doesn't make sense, so drop the test.
> >=20
> > Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> > Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73=
@riseup.net/
> > Reported-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
>=20
> Tested-by: Ma=C3=ADra Canal <mairacanal@riseup.net>

Thanks for testing again, and sorry for the trouble!

Best,
Sander

>=20
> > Cc: David Gow <davidgow@google.com>
> > ---
> > =C2=A0lib/test_cpumask.c | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> > index a31a1622f1f6..4ebf9f5805f3 100644
> > --- a/lib/test_cpumask.c
> > +++ b/lib/test_cpumask.c
> > @@ -54,7 +54,6 @@ static cpumask_t mask_all;
> > =C2=A0static void test_cpumask_weight(struct kunit *test)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test,=
 cpumask_empty(&mask_empty));
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test, cpum=
ask_full(cpu_possible_mask));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test,=
 cpumask_full(&mask_all));
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_EQ(test, 0=
, cpumask_weight(&mask_empty));
