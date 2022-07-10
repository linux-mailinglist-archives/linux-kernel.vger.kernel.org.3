Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8068856CD92
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGJGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 02:51:16 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A8EE22
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 23:51:13 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0CB892F8502;
        Sun, 10 Jul 2022 08:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1657435870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUjZKZmWcCoAIk8YWWrP40B7FyMeMvjGz9n2xvdzI84=;
        b=6oDodAU7dfQY/ViwnHiTyqCPWwrWrZ5rhGb4zj7BdYEnfwhpPW0h3CxLhYmU68u9CmT/Zs
        K3zbPCIcUg+TnFB0UbxEGhFH6ciuK9N1QdDal6atTsGu1jPfWaaYCoCoG4C1UdF8kN2h8k
        V6bsedePFbZ6ms1BLEmGwV+TvZoPe0gJr0wBFkQVbtg2FbDWxTgPv1wqJyvTfizTUmv2co
        dgnVhTyik2nfk34cKOaPPITZyobpe/oUiytVuTXHv6LXTFoKMhdvTs1tutVL4QnE75/y3G
        6OwzrkEeMhlBuXPAk453wXeo3TP5dX0KO3icRb0YMUkBPMKV9lOesS1xWPWtnQ==
Message-ID: <f58ee2c553ea8ae991454a8e195dcbd2821f794c.camel@svanheule.net>
Subject: Re: [PATCH v4 0/5] cpumask: Fix invalid uniprocessor assumptions
From:   Sander Vanheule <sander@svanheule.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Sun, 10 Jul 2022 08:51:08 +0200
In-Reply-To: <20220703133921.6800bf1e7df3b00cb586a3c1@linux-foundation.org>
References: <cover.1656777646.git.sander@svanheule.net>
         <20220702133840.943817a7694406a135bb48a9@linux-foundation.org>
         <6a4ea3d21bfb4c692d257d3f38ba28c83f242dfc.camel@svanheule.net>
         <20220703133921.6800bf1e7df3b00cb586a3c1@linux-foundation.org>
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

Hi Andrew,

On Sun, 2022-07-03 at 13:39 -0700, Andrew Morton wrote:
> On Sun, 03 Jul 2022 09:50:51 +0200 Sander Vanheule <sander@svanheule.net>
> wrote:
>=20
> > On Sat, 2022-07-02 at 13:38 -0700, Andrew Morton wrote:
> > > On Sat,=C2=A0 2 Jul 2022 18:08:23 +0200 Sander Vanheule <sander@svanh=
eule.net>
> > > wrote:
> > >=20
> > > > On uniprocessor builds, it is currently assumed that any cpumask wi=
ll
> > > > contain the single CPU: cpu0. This assumption is used to provide
> > > > optimised implementations.
> > > >=20
> > > > The current assumption also appears to be wrong, by ignoring the fa=
ct
> > > > that users can provide empty cpumask-s. This can result in bugs as
> > > > explained in [1].
> > >=20
> > > It's a little unkind to send people off to some link to explain the
> > > very core issue which this patchset addresses!=C2=A0 So I enhanced th=
is
> > > paragraph:
> > >=20
> > > : The current assumption also appears to be wrong, by ignoring the fa=
ct
> > > that
> > > : users can provide empty cpumasks.=C2=A0 This can result in bugs as =
explained
> > > in
> > > : [1] - for_each_cpu() will run one iteration of the loop even when p=
assed
> > > : an empty cpumask.
> >=20
> > Makes sense to add this, sorry for the inconvenience.
> >=20
> > Just to make sure, since I'm not familiar with the process for patches =
going
> > through the mm tree,
>=20
> Patches enter -mm in quilt form and are published in the (rebasing)
> mm-unstable branch
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.=C2=A0 Once they ha=
ve
> stopped changing and have been stabilized, I move them into the
> non-rebasing mm-stable branch.
>=20
> > can I still send a v5 to move the last patch forward in the series, and=
 to
> > include Yury's tags?
>=20
> I already added Yury's ack.=C2=A0 Please tell me the specific patch order=
ing
> and I'll take care of that.
>=20

The updated patch order should be:
   x86/cacheinfo: move shared cache map definitions
   cpumask: add UP optimised for_each_*_cpu versions
   cpumask: fix invalid uniprocessor mask assumption
   lib/test: introduce cpumask KUnit test suite
   cpumask: update cpumask_next_wrap() signature

Reordering the patches on my tree didn't produce any conflicts.

Best,
Sander
