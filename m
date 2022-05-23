Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663CD530F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiEWMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiEWMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:00:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ED522C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA7F1B810A0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51336C385A9;
        Mon, 23 May 2022 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653307197;
        bh=XMM+gZxt/O8CGFXGNvsrf7e/cybuiv+KJKYDEiG8+bU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ivi36bA6eYIXk7PRoQIyV7k2sQj0d/c8m1HvZvXjQmaPG8j5yQmHyhsEmwtpPvoqZ
         Rjenqc4aQeLtsZsBc+UWWwtA5h+iPa9LwA0FZ0VnG2Ie32HA43t44BDF8OP7jUeRCn
         /eeLxvG/YQUUIj+CAIsxDpTmQbR6553z3PVPP0+4hu/I9VP1tS0W95D66uBUopMy2D
         695MZJ59Q3qFswE7QX4/3jx7ioKS8Oth52z8vIi4q3rjWWQqAmcSP193NEZgHEI3dI
         kRHdebof/rNsl6nzR06sCCOJRGrifemy9xpvSQJJj0WI+Ss7bhtsysdMZy6QzikxLD
         Rr8qOL/6C2a9A==
Message-ID: <3dd156e4de15693f76cbad1cd8980aee827b2f20.camel@kernel.org>
Subject: Re: [PATCH 20/21] context_tracking: Convert state to atomic_t
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 23 May 2022 13:59:48 +0200
In-Reply-To: <20220519143738.GA612967@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
         <20220503100051.2799723-21-frederic@kernel.org>
         <372364b33b8d4b93908c3822e18f7d295de2ede9.camel@kernel.org>
         <20220519143738.GA612967@lothringen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 16:37 +0200, Frederic Weisbecker wrote:
> On Wed, May 18, 2022 at 05:09:55PM +0200, nicolas saenz julienne wrote:
> > On Tue, 2022-05-03 at 12:00 +0200, Frederic Weisbecker wrote:
> >=20
> > [...]
> >=20
> > > +/**
> > > + * ct_state() - return the current context tracking state if known
> > > + *
> > > + * Returns the current cpu's context tracking state if context track=
ing
> > > + * is enabled.  If context tracking is disabled, returns
> > > + * CONTEXT_DISABLED.  This should be used primarily for debugging.
> > > + */
> > > +static __always_inline int ct_state(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!context_tracking_enabled())
> > > +		return CONTEXT_DISABLED;
> > > +
> > > +	preempt_disable();
> > > +	ret =3D __ct_state();
> > > +	preempt_enable();
> > > +
> > > +	return ret;
> > > +}
> > > +
> >=20
> > I can't see any use for this function with preemption enabled. You can'=
t trust
> > the data due to CPU migration and it could be a source of bugs in the f=
uture.
> > Wouldn't it make more sense to move the burden into the callers? They a=
ll DTRT,
> > plus, this_cpu_ptr() will spew warnings if someone shows up and doesn't=
 comply.
>=20
> I believe syscall_exit_to_user_mode_prepare() has preemption enabled.
> Then it's ok if we are scheduled away right before the check, it still ap=
plies
> on any CPU.

Fair enough.

--=20
Nicol=C3=A1s S=C3=A1enz
