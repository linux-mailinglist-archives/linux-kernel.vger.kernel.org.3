Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965C1585F13
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiGaNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGaNDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:03:02 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F12DFFA
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:03:00 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6BC91303E86;
        Sun, 31 Jul 2022 15:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659272576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VC6DI7m2uY4+K2c+gAL6sZo5EnNpwlelY0Mo7k3xGk=;
        b=WwqbGhSZYtGPueJUmbUc/eLxolJ2Z5jl00IxhZF61AQknb4GPTfWmAGChfbyvSWYZCG6uY
        f/BmZJ3ww6riCkBFJVr5KUVSsXWkZsEItWvwY1imcWIysR0l2q34yQc77zpM18edUo7JpI
        sFY60NH1kU9djvRXM9R5+oD/ab58EN3vtUBPRW3+E9aBDWRVD3ZZSXJ6CRZeJ9yFeVecuF
        SUymcqHFizjA/u8l4TYuq8fTN0ngnNP+vfDB1+wQD9CxiSaU0jZCcOZIF7QzMLSfhA8JJc
        MUpRc7pAJOZFn1ThMvqw9kUr1AtglCXRmoRAcYk+9VdJnrcsbLt1QK8UiQKFaA==
Message-ID: <a5b3bc76d48acb8fde00aa95c6a572d7922c050c.camel@svanheule.net>
Subject: Re: [PATCH v5 0/5] cpumask: fix invalid uniprocessor assumptions
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>
Date:   Sun, 31 Jul 2022 15:02:55 +0200
In-Reply-To: <YuV1J7Zt+NzkrWeV@yury-laptop>
References: <cover.1659077534.git.sander@svanheule.net>
         <YuV1J7Zt+NzkrWeV@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-30 at 11:15 -0700, Yury Norov wrote:
> On Fri, Jul 29, 2022 at 09:01:17AM +0200, Sander Vanheule wrote:
> > On uniprocessor builds, it is currently assumed that any cpumask will
> > contain the single CPU: cpu0. This assumption is used to provide
> > optimised implementations.
> >=20
> > The current assumption also appears to be wrong, by ignoring the fact
> > that users can provide empty cpumasks. This can result in bugs as
> > explained in [1] - for_each_cpu() will run one iteration of the loop
> > even when passed an empty cpumask.
> >=20
> > This series introduces some basic tests, and updates the optimisations
> > for uniprocessor builds.
> >=20
> > The x86 patch was written after the kernel test robot [2] ran into a
> > failed build. I have tried to list the files potentially affected by th=
e
> > changes to cpumask.h, in an attempt to find any other cases that fail o=
n
> > !SMP. I've gone through some of the files manually, and ran a few cross
> > builds, but nothing else popped up. I (build) checked about half of the
> > potientally affected files, but I do not have the resources to do them
> > all. I hope we can fix other issues if/when they pop up later.
> >=20
> > [1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule=
.net/
> > [2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/
> =C2=A0
> Hi Sander,
>=20
> I tried to apply it on top of bitmap-for next, and there are many conflic=
ts
> with already pulled patches. There's nothing really scary, just functions
> changed their prototypes and locations. Can you try your series on top of
> bitmap-for-next from git@github.com:/norov/linux.git (or just -next)?=20
>=20
> I'm asking you to do it instead of doing myself because I don't want to
> screwup your code accidentally and because many cpumask functions in -nex=
t
> are moved to the header, and it would be probably possible to avoid build=
ing=20
> cpumask.o in UP case.
>=20
> Briefly looking into the -next code, cpumask.c hosts=C2=A0 only cpumask_n=
ext_wrap()
> that is not overwritten by UP code, and in UP case it can be simplified.

Sure. I've rebased my patches and added a UP-version for cpumask_next_wrap(=
), so
cpumask.o doesn't have to be built anymore in that case.

How would you like to proceed with these patches? It's fine by me if you ta=
ke
them through your tree to avoid more merge conflicts with your changes, but=
 then
Andrew woud have to drop the series from mm-nonmm-stable.

Best,
Sander
