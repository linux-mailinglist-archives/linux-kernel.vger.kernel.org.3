Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33A5907DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiHKVJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiHKVJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:09:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F4A0336;
        Thu, 11 Aug 2022 14:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A8DBB82076;
        Thu, 11 Aug 2022 21:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445ECC433C1;
        Thu, 11 Aug 2022 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660252093;
        bh=5YoNnclwkL9ZEKqBXwozTmi5USJU6wLeQwMyu0umXvo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fAq5dnZCibGNARbJ3p4vwxnL2etCHVCUMFa/xsoQS2oGBF46i1cCpzxhoGIOTQ0Y6
         RtV+oG/vMCGCl6kqX1qJO5EwDYdZGdEoH8C4YSYp2KbT9r2XPbjAa/1AvZJPFFgabZ
         t5eOeNe1k5eRpiH0QLiiwaHkdtZGPL+Oi4w2VdoeOSJdC6lTJuvxBpOCJS2nyN3s+f
         strqRaiwYymSEi+ovJOmbJsSFccl6TvojVBgJlgSUdB0VRX0YCIEFiY9kw+lOe82ny
         inecNUU3mIXdSRtQYy0SfPaQNEU5FYB1pTn7mK8M/J6Z1C4RK3qzMh55i6iHS2fNQ1
         +mtvB7kp/utyA==
Message-ID: <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
From:   Jeff Layton <jlayton@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 11 Aug 2022 17:08:11 -0400
In-Reply-To: <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
References: <20220811152446.281723-1-idryomov@gmail.com>
         <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
         <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-11 at 22:55 +0200, Ilya Dryomov wrote:
> On Thu, Aug 11, 2022 at 10:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >=20
> > On Thu, Aug 11, 2022 at 8:25 AM Ilya Dryomov <idryomov@gmail.com> wrote=
:
> > >=20
> > >    [..] Several patches
> > > touch files outside of our normal purview to set the stage for bringi=
ng
> > > in Jeff's long awaited ceph+fscrypt series in the near future.  All o=
f
> > > them have appropriate acks and sat in linux-next for a while.
> >=20
> > What? No.
> >=20
> > I'm looking at the fs/dcache.c change, for example, and don't see the
> > relevant maintainers having acked it at all.
> >=20
> > The mmdebug.h file similarly seems to not have the actual maintainer
> > acks, and seems just plain stupid (why does it add that new folio
> > warning macro, when the existing folio warning macro
> > VM_WARN_ON_ONCE_FOLIO() is *better*?
> >=20
> > Those are some very core files, and while the changes seem harmless,
> > they sure don't seem obviously ok.
> >=20
> > What's the point of warning about bogus folios more than once? That's
> > a debug warning - if it hits even once, that's already "uhhuh,
> > something is bad". Showing the warning more than once is likely just
> > going to cause more problems, not give you more information.
>=20
> Xiubo and Jeff used it to track down some issues between netfs library
> and folio code that have been randomly plaguing our automated tests for
> a couple of releases.  We already knew that there were issues in that
> area and the actual occurrences mattered.  This was done in cooperation
> with Willy and, since he was involved and this is a no-impact change,
> I didn't think twice.
>=20
> >=20
> > And did somebody verify that d_same_name() is still inlined in the
> > place that truly *matters*?  Because from my quick test, that patch
> > broke it. Now __d_lookup() does a function call.
> >=20
> > And I _suspect_ it's all ok, because it turns out that
> > __d_lookup_rcu() is the *really* hot case, and that one has inlined it
> > all manually.
> >=20
> > But this kind of "we touch some *truly* core functionality, without
> > the acks from the maintainers, and then we *claim* to have relevant
> > acks" is really not even remotely ok.
>=20
> I raised the lack of a formal Acked-by from Al on the dcache change
> with Jeff a while ago and my understanding was that he reached out to
> Al and got the ack (after some ghosting on Al's behalf).  I apologize
> if I got that wrong -- all this happened in the middle of Jeff
> transitioning his maintainership duties.
>=20

Actually, I never got a formal ack from Al. I did send it repeatedly,
but I assume he has been too busy to respond. We've had it sitting in
linux-next for a couple of months, and he did suggest that approach in
the first place, but I too would also prefer to see his official ack on
it.


> >=20
> > I've pulled this because I suspect that d_same_name() thing is fine,
> > and I think the VM_WARN_ON_FOLIO() addition is completely wrong but
> > not horrendous.
> >=20
> > But you're on my tentative shit-list just for having claimed to have
> > appropriate acks and having been found wanting.
> >=20
> > Just for your information: fs/dcache.c is some of the most optimized
> > code in the kernel, and some of the subtlest. That RCU pathname lookup
> > is serious business. You don't make changes to pathname lookup just
> > willy nilly. There's a reason I start looking at individual patches
> > when I see it in the diffstat.
>=20
> Understood.
>=20
> Thanks,
>=20
>                 Ilya

--=20
Jeff Layton <jlayton@kernel.org>
