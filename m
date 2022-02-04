Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD14A9835
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbiBDLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiBDLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:10:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:10:17 -0800 (PST)
Date:   Fri, 4 Feb 2022 12:10:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643973015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9MRTqB0n9ccPXPwZOj3EH+x5hdIJMCMAmpD+JN93Ng=;
        b=oc1hOTQRI9eJR1sii2obCVj4iRkVhy2ikIhKFz5DkqpsX6eKVH+6GLY7JPMJDo0nsCD4gc
        m4FUwFkitlIS+JU6xwXtabK3b23NZWh1TRLAvfNwWIjl5IWicWyZz4fRc/c4AlXRExB3+z
        NxZFkHL3ImhmCI0GG4OfJDxnO/Wy+VOEX0X5vOx5vXWhXzMFn9WZZ1Is1Mave7FVuMToWs
        7QoZNirJmnbYhAqeFsHCj40KDmS6zAp1ytdcvUqixmlR48NkouSOF+73SSvqmzIVq8PkJ4
        52uW1ldIcQs0T8e63UdcH5dK78OS++wYI98BvsjSerCVJGplh0ODhUqscxVfBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643973015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9MRTqB0n9ccPXPwZOj3EH+x5hdIJMCMAmpD+JN93Ng=;
        b=XLWZl/vD9OSiIFjekcSk4adN5cuzfH/mH/NgqeOAKV0EZ+6OxwhJnpgn4gYyy1WeynnmWc
        xTRYOBi3RBDEn7BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] random: remove batched entropy locking
Message-ID: <Yf0JlXf3ARsBpL9K@linutronix.de>
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com>
 <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 01:27:55 [+0100], Jason A. Donenfeld wrote:
> Hey Andy,
>=20
> Think I could bug you to review this patch? The general idea is based
> on your original patch, and I think this fits what we talked about on
> IRC. I figure we'll probably both page this out of our minds after
> another week or two of not thinking about it.
>=20
> It's here on cgit if that's easier to look at:
> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?h=
=3Djd/no-batch-lock

Please don't merge this:
- This splat only occurs with CONFIG_PROVE_RAW_LOCK_NESTING enabled.
  This option has this in its description:
  =E2=94=82 NOTE: There are known nesting problems. So if you enable this
  =E2=94=82 option expect lockdep splats until these problems have been ful=
ly
  =E2=94=82 addressed which is work in progress. This config switch allows =
to
  =E2=94=82 identify and analyze these problems. It will be removed and the
  =E2=94=82 check permanently enabled once the main issues have been fixed.

- The problem identified by the splat affects only PREEMPT_RT. Non-RT is
  not affected by this.

- This patch disables interrupts and invokes extract_crng() which leads
  to other problems.


If this patch is the way then it should be merged together with the
other outstanding issues.

> Thanks,
> Jason

Sebastian
