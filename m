Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA77C535A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347136AbiE0HcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiE0HcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:32:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0016F68B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7L1UvtWzSeI1RAxfnE/3HtRDKWRdqRZ2oSzwia86H/U=;
        t=1653636733; x=1654846333; b=nnrMgrImbIVbCZEg3jsS/ZjfBbuDwIgSnaJCpugINo4Y4F4
        ryHeOD5AUw5brzunxa825n6o8A4phNnfpomLN9Pg7lC6mRci+WaNDDibycTiVRfrC9dX3lT71ckMf
        ilYgdtuxc8oIfIsOzI9biLsExJ8vSHKu8qiI7/o6ahjkYQR54MMQgpaypjjI3plpE92cOSsNryFor
        q3DAH/iFVX663qCUGN+/5ZjbPsCV87PQO/vhu70nyk1j/Qy8UmGgQhYsUFdcWDlN4Z7WfZnVyn5FA
        VI4TL7nYCA1tTpk0E4t2w1IGacy5a8WxqB/4jIgqPzW5sEW6ak4ayjz4piPzE3Og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuUS4-005xX2-LH;
        Fri, 27 May 2022 09:32:04 +0200
Message-ID: <1f0e79c925f79fba884ec905cf55a3eb7b602d48.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>, David Gow <davidgow@google.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Date:   Fri, 27 May 2022 09:32:03 +0200
In-Reply-To: <CACT4Y+a191xbPi_0w6imTAYHDeAoudrxbWiuERBOk41e5q_K_Q@mail.gmail.com>
References: <20220525111756.GA15955@axis.com>
         <20220526010111.755166-1-davidgow@google.com>
         <CACT4Y+a191xbPi_0w6imTAYHDeAoudrxbWiuERBOk41e5q_K_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 07:31 +0200, Dmitry Vyukov wrote:
> > - This doesn't seem to work when CONFIG_STATIC_LINK is enabled (because
> >   libc crt0 code calls memory functions, which expect the shadow memory
> >   to already exist, due to multiple symbols being resolved.
> >   - I think we should just make this depend on dynamic UML.
> >   - For that matter, I think static UML is actually broken at the
> >     moment. I'll send a patch out tomorrow.
>=20
> I don't know how important the static build is for UML.

Depends who you ask, I guess.

IMHO just making KASAN depend on !STATIC_LINK is fine, until somebody
actually wants to do what you describe:

> Generally I prefer to build things statically b/c e.g. if a testing
> system builds on one machine but runs tests on another, dynamic link
> may be a problem. Or, say, if a testing system provides binary
> artifacts, and then nobody can run it locally.
>=20
> One potential way to fix it is to require outline KASAN
> instrumentation for static build and then make kasan_arch_is_ready()
> return false until the shadow is mapped. I see kasan_arch_is_ready()
> is checked at the beginning of all KASAN runtime entry points.
> But it would be nice if the dynamic build also supports inline and
> does not add kasan_arch_is_ready() check overhead.

which sounds fine too, but ... trade-offs.

> > +       if (IS_ENABLED(CONFIG_UML)) {
> > +               __memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALL=
OC_INVALID, shadow_end - shadow_start);
>=20
> "kasan_mem_to_shadow((void *)addr)" can be replaced with shadow_start.

and then the memset line isn't so long anymore :)

>=20
>=20
> > +               return 0;
> > +       }
> > +
> > +       shadow_start =3D ALIGN_DOWN(shadow_start, PAGE_SIZE);
> >         shadow_end =3D ALIGN(shadow_end, PAGE_SIZE);
>=20
> There is no new fancy PAGE_ALIGN macro for this. And I've seen people

s/no/now the/ I guess, but it's also existing code.

johannes
