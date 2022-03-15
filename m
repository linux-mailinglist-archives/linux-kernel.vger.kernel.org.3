Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731284D978C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbiCOJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiCOJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:23:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FC4EA3D;
        Tue, 15 Mar 2022 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BxlumWetk2Xo+VDC17Zrv1T3K21sp4SlfqUSj0scssM=; b=TnY+yYi1PhmnYTT5+5/WX7TSr2
        rIFpYIGQJga+upkTuaL2WlO0mIiHhWV6JtCE/Mqiu3zZKg/o6h1yng7L2F68U7XUC3LuNLQOzk3Oe
        jUu34AFxKYOIDxoIhB18gJIvYGwkAXXoUyU1a9W+6Bgvipuj34EBCtHQFLpMSYjV1VOSEDwpNjhb1
        5PLwzET3PxgYWs7mQy0FGMbc519bl+S+4cC40nPvWKmdOAmktuqUKSIYbMxvCAOHPsTOO01eVYHfJ
        IDmbBmAJj0R6+JSZqxQOlztHnYUi5gvozIbQMCo4gvpZQSEfmrBCnG0NqoNjTQtaU14HZ3XnbZ96V
        NsiXJbfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU3Nl-001AdR-G6; Tue, 15 Mar 2022 09:22:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A1B498620D; Tue, 15 Mar 2022 10:22:19 +0100 (CET)
Date:   Tue, 15 Mar 2022 10:22:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20220315092219.GC8939@worktop.programming.kicks-ass.net>
References: <20220315140644.369d98d6@canb.auug.org.au>
 <20220315162327.53f7139f@canb.auug.org.au>
 <20220315163747.3e11ad15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315163747.3e11ad15@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:37:47PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Tue, 15 Mar 2022 16:23:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 15 Mar 2022 14:06:44 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > After merging the irqchip tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >=20
> > > arch/x86/kernel/cpuid.o: warning: objtool: file already has .orc_unwi=
nd section, skipping
> > > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/=
x86/kernel/cpuid.ko] Error 255
> > > arch/x86/kernel/msr.o: warning: objtool: file already has .orc_unwind=
 section, skipping
> > > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/=
x86/kernel/msr.ko] Error 255
> > > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already =
has .retpoline_sites, skipping
> > > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already =
has .ibt_endbr_seal, skipping
> > > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already =
has .orc_unwind section, skipping
> > > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/=
x86/events/intel/intel-uncore.ko] Error 255
> > >=20
> > > I couldn't see anything int the irqchip tree that would cause this,
> > > so I deleted my object directory and redid the build and this time
> > > it succeeded.
> > >=20
> > > I suspect some change in the tip tree has brought this on (it is merg=
ed
> > > just a bit before the irqchip tree). =20
> >=20
> > This time after the merging usb trees:
> >=20
> > drivers/phy/qualcomm/phy-qcom-usb-hs.o: warning: objtool: file already =
has .orc_unwind section, skipping
> > make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qc=
om-usb-hs.ko] Error 255
> > drivers/phy/qualcomm/phy-qcom-usb-hsic.o: warning: objtool: file alread=
y has .orc_unwind section, skipping
> > make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qc=
om-usb-hsic.ko] Error 255
> >=20
> > I just removed the drivers/phy/qualcomm directory from the object tree
> > and rebuilt.
> >=20
> > Then got this:
> >=20
> > drivers/phy/ti/phy-tusb1210.o: warning: objtool: file already has .orc_=
unwind section, skipping
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: drivers=
/phy/ti/phy-tusb1210.ko] Error 255
> >=20
> > So removed the drivers/phy/ti directory and rebuilt and the build
> > succeeded.
> >=20
> > I assume that something is being left around or reprocessed when it
> > should not be.
>=20
> Maybe commit
>=20
>   8856dadf7ad3 ("Kbuild: Allow whole module objtool runs")

Almost, it's this in combination with a follow up that uses it. I've
just managed to beat it into submission, will hopefully be cured for
tomorrow's build.
